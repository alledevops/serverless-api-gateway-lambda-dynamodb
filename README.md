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
To implement the deployment of the project, we use **Infrastructure as Code (IaC)** principles with **AWS CloudFormation**. We define the necessary resources, such as the Lambda function, IAM role, and API Gateway, in a CloudFormation template. This ensures a consistent and reproducible infrastructure setup.

```yml
AWSTemplateFormatVersion: 2010-09-09
Description: >-
  CloudFormation template for Serverless API with Amazon API Gateway, AWS Lambda, and DynamoDB

# Parameters section to make the template customizable
Parameters:
  TableName:
    Type: String
    Description: Name of the DynamoDB table to create
    Default: lambda-apigateway

# Resources section where we define the AWS resources
Resources:
  # DynamoDBTable resource to create the DynamoDB table
  DynamoDBTable:
    Type: 'AWS::DynamoDB::Table'
    Properties:
      TableName: !Ref TableName
      AttributeDefinitions:
        - AttributeName: id
          AttributeType: S
      KeySchema:
        - AttributeName: id
          KeyType: HASH
      ProvisionedThroughput:
        ReadCapacityUnits: 5
        WriteCapacityUnits: 5

  # LambdaRole resource to create the IAM role for Lambda function
  LambdaRole:
    Type: 'AWS::IAM::Role'
    Properties:
      RoleName: lambda-apigateway-role
      AssumeRolePolicyDocument:
        Version: 2012-10-17
        Statement:
          - Effect: Allow
            Principal:
              Service:
                - lambda.amazonaws.com
            Action:
              - 'sts:AssumeRole'
      Policies:
        - PolicyName: LambdaDynamoDBPolicy
          PolicyDocument:
            Version: 2012-10-17
            Statement:
              - Effect: Allow
                Action:
                  - 'dynamodb:DeleteItem'
                  - 'dynamodb:GetItem'
                  - 'dynamodb:PutItem'
                  - 'dynamodb:Query'
                  - 'dynamodb:Scan'
                  - 'dynamodb:UpdateItem'
                Resource: '*'
              - Effect: Allow
                Action:
                  - 'logs:CreateLogGroup'
                  - 'logs:CreateLogStream'
                  - 'logs:PutLogEvents'
                Resource: '*'

  # LambdaFunction resource to create the AWS Lambda function
  LambdaFunction:
    Type: 'AWS::Lambda::Function'
    Properties:
      FunctionName: LambdaFunctionOverHttps
      Runtime: python3.7
      Handler: index.lambda_handler
      Role: !GetAtt LambdaRole.Arn
      Code:
        ZipFile: |
          # Sample Python Code for the Lambda Function
          # ... (Python code is provided in the template)

  # ApiGateway resource to create the Amazon API Gateway
  ApiGateway:
    Type: 'AWS::ApiGateway::RestApi'
    Properties:
      Name: DynamoDBOperations

  # ApiResource resource to create the resource in the API Gateway
  ApiResource:
    Type: 'AWS::ApiGateway::Resource'
    Properties:
      RestApiId: !Ref ApiGateway
      ParentId: !GetAtt ApiGateway.RootResourceId
      PathPart: DynamoDBManager

  # ApiMethod resource to create the method (POST) for the API Gateway
  ApiMethod:
    Type: 'AWS::ApiGateway::Method'
    Properties:
      RestApiId: !Ref ApiGateway
      ResourceId: !Ref ApiResource
      HttpMethod: POST
      AuthorizationType: NONE
      Integration:
        Type: AWS_PROXY
        IntegrationHttpMethod: POST
        Uri: !Sub >-
          arn:aws:apigateway:${AWS::Region}:lambda:path/2015-03-31/functions/${LambdaFunction.Arn}/invocations

  # ApiDeployment resource to deploy the API Gateway
  ApiDeployment:
    Type: 'AWS::ApiGateway::Deployment'
    DependsOn:
      - "ApiMethod"
    Properties:
      RestApiId: !Ref ApiGateway

  # ApiStage resource to create the stage for the API Gateway
  ApiStage:
    Type: 'AWS::ApiGateway::Stage'
    Properties:
      RestApiId: !Ref ApiGateway
      DeploymentId: !Ref ApiDeployment
      StageName: Prod

# Outputs section to provide information after stack creation
Outputs:
  # ApiEndpoint output to display the endpoint URL of the deployed API
  ApiEndpoint:
    Value: !Sub >-
      https://${ApiGateway}.execute-api.${AWS::Region}.amazonaws.com/Prod/DynamoDBManager
    Description: Endpoint URL of the deployed API

```

## Continuous Integration and Continuous Deployment (CI/CD)
For continuous integration and deployment, we have decided not to set up a CI/CD pipeline for this version of the project. Instead, manual deployment to the selected environment is performed. This decision was made considering the simplicity of the project and the scope of the portfolio.

## Monitoring and Alerting
To monitor the application and infrastructure health, we use AWS CloudWatch. CloudWatch gathers and displays performance metrics, logs, and events. By analyzing these metrics and logs, we can identify potential issues and performance bottlenecks.

## Security and Compliance
Security is a top priority in our project. We implement fine-grained access control using IAM roles and policies. Additionally, we encrypt sensitive data at rest and in transit. Our infrastructure follows AWS security best practices to ensure compliance with industry standards.

## Lessons Learned and Challenges
During the development of the project, we encountered a few challenges related to the AWS API Gateway setup. Specifically, we faced issues with sending POST requests using Postman, receiving "missing authentication token" and "internal server error" messages. After careful investigation, we found that the API Gateway required a valid API key or authentication settings to accept requests. Once we added the necessary authentication settings, the issues were resolved.

## Conclusion
Building a serverless API with Amazon API Gateway, AWS Lambda, and DynamoDB provides a scalable and cost-efficient solution for modern applications. By following this project's principles and best practices, developers can create robust and maintainable serverless applications that scale effortlessly with user demands.

## References
- GitHub Repository: [link-to-github-repo]
- AWS Documentation: [link-to-aws-docs]
- Blog Post: [link-to-blog-post]