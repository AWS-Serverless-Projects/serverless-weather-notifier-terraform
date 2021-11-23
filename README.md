# Weather Notifier (Deploy with Terraform)

Serverless application to receive weather notification via email for a specific location.

### Services Used
* Lambda
* CloudWatch Events
* SES
* Accuweather API

### Prerequisites
* Terraform installed and configured with your CLI in your local machine.
* Verified SES email address to send email.
* Register Accuweather and get APIKey.
* Find LocationId from Accuweather **[here](https://developer.accuweather.com/accuweather-locations-api/apis/get/locations/v1/cities/geoposition/search)** where you need to get the weather information

### Usage
1. Clone the repository.

2. Add required variable values to `terraform.tfvars`

3. Change permission of deploy.sh
    ````bash
    chmod 775 deploy.sh
    ```` 
4. Run
    ```bash
    ./deploy.sh
    ```

5. This will download necessary packages and prompts to continue creating resources in AWS.