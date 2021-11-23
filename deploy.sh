#!/usr/bin/env bash
cd ./lambda
pip install -r requirements.txt -t .
rm -f ../lambda.zip
zip -r ../lambda.zip *
cd ..
terraform apply