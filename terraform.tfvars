API_KEY="" # API Key from Accuweather
EMAILS="" # Comma separated email addressses to send the notification
FROM_EMAIL="" # From address for the notification email. This must be verified in SES
LOCATION_ID="" # location id from Accuweather
EVENT_SCHEDULE="35 5,12 * * ? *" #Cloudwatch event scheudler cron expression as per: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html#CronExpressions
