import os
from botocore.vendored import requests
import time
import jinja2
import boto3
import json

ses_client = boto3.client('ses')

templateLoader = jinja2.FileSystemLoader(searchpath="./")
templateEnv = jinja2.Environment(loader=templateLoader)
TEMPLATE_FILE = "template.html"
template = templateEnv.get_template(TEMPLATE_FILE)
EMAIL_SOURCE = 'Daily Weather Report <' + os.environ['FROM_EMAIL'] + '>'


def render(data):
    return template.render({'results': data})


def lambda_handler(event, context):
    url = 'http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/' + os.environ['LOCATION_ID'] + '?apikey=' + \
          os.environ['API_KEY']

    result = requests.get(url).json()

    final_result = []
    for data in result:
        result_object = {
            'time_org': data['DateTime'],
            'time': time.strftime('%Y-%m-%d %I:%M %p', time.localtime(data['EpochDateTime'])),
            'icon_phrase': data['IconPhrase'],
            'reception': data['PrecipitationIntensity'] + ' ' + data['PrecipitationType'] if data[
                                                                                                 'HasPrecipitation'] == True else '',
            'probability': data['PrecipitationProbability'],
            'icon': 'https://developer.accuweather.com/sites/default/files/' + "{:02}".format(data['WeatherIcon']) + '-s.png'
        }

        final_result.append(result_object)

    emails = os.environ.get('EMAILS').split(",")
    result = ses_client.send_email(
            Destination={
                'ToAddresses': emails,
            },
            Message={
                'Body': {
                    'Html': {
                        'Charset': 'UTF-8',
                        'Data': render(final_result),
                    },
                },
                'Subject': {
                    'Charset': 'UTF-8',
                    'Data': 'Today\'s Weather',
                },
            },
            Source=EMAIL_SOURCE,
        )

    return {
        'statusCode': 200,
        'body': json.dumps(result)
    }


if __name__ == '__main__':
    lambda_handler({}, {})