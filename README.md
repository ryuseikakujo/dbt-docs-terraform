# dbt Docs Hosting with Terraform

This is Terraform code for hosting dbt Docs using S3 and CloudFront. Lambda@Edge is utilized with CloudFront to enable Basic authentication.

## Directory Structure

```
.
├── README.md
├── backend.tf
├── cloudfront.tf
├── iam.tf
├── lambda.tf
├── lambda_edge
│   └── index.py
├── lambda_edge_archive
├── provider.tf
├── s3.tf
└── variables.tf
```

## Lambda@Edge

Lambda@Edge is a service provided by AWS that allows you to run AWS Lambda functions at the AWS edge locations, which are closer to your users. In the context of AWS CloudFront, Lambda@Edge enables you to execute custom code in response to CloudFront events, such as when a viewer (user) makes a request to CloudFront or when CloudFront is preparing to respond to a viewer request.

In this case. the Lambda@Edge is used for basic authentication.

You can change user and password by modifying the code at `lambda_edge/index.py`.

```python
def authenticate(user, password):
    return user == "admin" and password == "passW0rd"
```
