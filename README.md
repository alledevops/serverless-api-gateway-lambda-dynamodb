# serverless-api-gateway-lambda-dynamodb

# Project Title
Building a Serverless API with Amazon API Gateway, AWS Lambda, and DynamoDB

## Project Summary
Our goal is to **create a powerful serverless API that interacts with DynamoDB to perform CRUD operations** and supports additional operations for testing. The API will be backed by an AWS Lambda function, which will handle incoming requests and interact with the DynamoDB table based on the payload. This project aims to showcase how to build a scalable and cost-efficient serverless API using AWS services.

## Technologies Used
- **Amazon API Gateway**
- **AWS Lambda**
- **AWS DynamoDB**
- **AWS IAM**
- **Postman**

## Project Architecture
The project consists of three main components:
1. **Amazon API Gateway:** Serves as the frontend for the API, routing HTTP requests to the appropriate Lambda function.
2. **AWS Lambda:** A Python 3.7 Lambda function acts as the backend, handling various operations and interacting with the DynamoDB table.
3. **DynamoDB:** The NoSQL database service stores data, and we create a table with a primary key for efficient data retrieval.

![High-Level Design](https://cdn.hashnode.com/res/hashnode/image/upload/v1690899236087/dd4f2db8-6930-4c67-819a-599a0db1e97e.png)

## Deployment and Infrastructure as Code (IaC)
To implement the deployment of the project, we use **Infrastructure as Code (IaC)** principles with **AWS CloudFormation**. The CloudFormation template is available in the `infra` folder of the project directory, and it defines all the necessary resources, including the Lambda function, API Gateway, and DynamoDB table. You can customize the template to suit your specific requirements.

## Continuous Integration and Continuous Deployment (CI/CD)
For continuous integration and deployment, we have decided not to set up a CI/CD pipeline for this version of the project. Instead, manual deployment to the selected environment is performed. This decision was made considering the simplicity of the project and the scope of the portfolio.

## Monitoring and Alerting
To monitor the application and infrastructure health, we use AWS CloudWatch. CloudWatch gathers and displays performance metrics, logs, and events. By analyzing these metrics and logs, we can identify potential issues and performance bottlenecks.

## Security and Compliance
Security is a top priority in our project. We implement fine-grained access control using IAM roles and policies. Additionally, we encrypt sensitive data at rest and in transit. Our infrastructure follows AWS security best practices to ensure compliance with industry standards.

## Implementation Guide

To implement the project step by step using the AWS Management Console, you can follow this comprehensive guide in our blog post: https://alledevops.com/scalable-serverless-api-amazon-api-gateway-aws-lambda

The guide provides detailed instructions on how to set up the serverless API with Amazon API Gateway, AWS Lambda, and DynamoDB. It covers everything from creating the necessary AWS resources to deploying the CloudFormation stack and testing the API endpoints.

## Lessons Learned and Challenges
During the development of the project, we encountered a few challenges related to the AWS API Gateway setup. Specifically, we faced issues with sending POST requests using Postman, receiving "missing authentication token" and "internal server error" messages. After careful investigation, we found that the API Gateway required a valid API key or authentication settings to accept requests. Once we added the necessary authentication settings, the issues were resolved.

## Conclusion
Building a serverless API with Amazon API Gateway, AWS Lambda, and DynamoDB provides a scalable and cost-efficient solution for modern applications. By following this project's principles and best practices, developers can create robust and maintainable serverless applications that scale effortlessly with user demands.

## References
- GitHub Repository: [link-to-github-repo]
- AWS Documentation: [link-to-aws-docs]
- Blog Post: [link-to-blog-post]