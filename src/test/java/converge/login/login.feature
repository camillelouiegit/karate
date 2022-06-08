@login @regression
Feature: Login to Converge via API

  Background:
    * def preRequisite =  callonce read(onboardingFeature)
    * url baseUrl
    * def loginSchema = loginSchemaPath
    * def schemaUtil = schemaUtilPath
    * def password = pass
    * def login =
          """
          {
            "username": #(preRequisite.randomEmail),
            "password": #(password)
          }
          """

  Scenario: User is able to login into the App via API
    Given path '/exp-bff-mfe-service/auth/login'
    When request login
    And method POST
    Then status 200
    And match response == '#object'
    * string jsonSchemaExpected = read(loginSchema)
    * string jsonResponseData = response
    * def SchemaUtils = Java.type(schemaUtil)
    * assert SchemaUtils.isValid(jsonResponseData, jsonSchemaExpected)
    * def id_token = response.id_token
    * print id_token
    * print username