@onboard @regression
Feature: Onboard user to Converge via API

  Background: :
    * url baseUrl

  Scenario: Onboard Single User
    #Generate Token
    * def rand = Java.type(randomGeneratorPath)
    * def randomEmail = rand.getRandomEmail()
    * def generateToken =
                    """
                      {
                          "data": [
                              {
                                  "key": "email",
                                  "value": #(randomEmail)
                              }
                          ]
                      }
                    """
    Given path '/exp-bff-mfe-service/retail/user'
    * configure headers = { 'Content-Type': 'application/json','usage': 'test' }
    When request generateToken
    And method POST
    Then status 200
    And match response == '#object'
    And match response.uniqueId == randomEmail

    #Validate Email
    * def validateEmail =
                    """
                      {
                        "requestId": #(randomEmail),
                        "value": "999999"
                      }
                    """
    Given path '/exp-bff-mfe-service/retail/mfa/validate'
    * configure headers = { 'Content-Type': 'application/json' }
    When request validateEmail
    And method POST
    Then status 200
    And match response == '#object'
    And match response.status == 'VALIDATED'

    #Create User Identity
    * def createIdentity =
                    """
                      {
                        "userName": #(randomEmail),
                        "password": "Hasher@123"
                      }
                    """
    Given path '/exp-bff-mfe-service/retail/user/identity'
    * configure headers = { 'Content-Type': 'application/json', 'parentFlowId':'#(randomEmail)' }
    When request createIdentity
    And method POST
    Then status 200
    And match response == '#object'
    And match response.status == 'CREATED'

    #Initiate Mobile MFA
    * def initiateMobileMFA =
                    """
                     {
                      "contactInfo": {
                          "phoneNumbers": [
                              {
                                  "countryCode": "+91",
                                  "phoneNo": "8529841941",
                                  "phoneType": "Work",
                                  "index": 0
                              }
                          ]
                      }
                    }
                    """
    Given path '/exp-bff-mfe-service/retail/initiate-mobile-mfa'
    * configure headers = { 'Content-Type': 'application/json', 'parentFlowId':'#(randomEmail)', 'usage': 'test' }
    When request initiateMobileMFA
    And method POST
    Then status 200
    And match response == '#object'
    And match response.uniqueId == randomEmail
    And match response.status == 'MFA GENERATED'

    #Verify Mobile MFA
    * def validateMobileMFA =
                    """
                      {
                          "requestId": #(randomEmail),
                          "value": "999999"
                      }
                    """
    Given path '/exp-bff-mfe-service/retail/mfa/validate'
    * configure headers = { 'Content-Type': 'application/json', 'parentFlowId':'#(randomEmail)' }
    When request validateMobileMFA
    And method POST
    Then status 200
    And match response == '#object'
    And match response.requestId == randomEmail
    And match response.status == 'VALIDATED'

    #Register User
    * def registerUser =
                    """
                    {
                        "userInfo": {
                            "firstName": "cams",
                            "lastName": "personal",
                            "ssn": "000111201",
                            "userName": #(randomEmail),
                            "dateOfBirth": "2006-01-02",
                            "password": "Hasher@123",
                            "contactInfo": {
                                "addresses": [
                                    {
                                        "city": "Cebu City",
                                        "zipCode": "6000",
                                        "state": "NJ",
                                        "street": "Street Fighter",
                                        "street2": "NJ",
                                        "country": "US",
                                        "type": "Work"
                                    }
                                ],
                                "emailIds": [
                                    {
                                        "emailAddress": "#(randomEmail)",
                                        "index": 0
                                    }
                                ],
                                "phoneNumbers": [
                                    {
                                        "countryCode": "+63",
                                        "phoneNo": "1234567891",
                                        "phoneType": "Work",
                                        "index": 0
                                    }
                                ]
                            }
                        },
                        "communicationViaEmail": true,
                        "communicationViaPhone": true
                    }
                    """
    Given path '/exp-bff-mfe-service/retail/register-user'
    * configure headers = { 'Content-Type': 'application/json', 'onboardingId':'#(randomEmail)' }
    When request registerUser
    And method POST
    Then status 200
    And match response == '#object'
    * def getCustomerId = response.userInfoResponse.customerId
    * def getIdToken = response.loginResponse.id_token
    * print getIdToken

     #Create Account
    * def createAccount =
                    """
                    {
                      "accountType": "Sole_Proprietorship",
                      "accountTitle": "Karate Account",
                      "productName": "Personal_Checking",
                      "currencyCode": "USD",
                      "relationshipType": "AUTHORIZED_SIGNER",
                      "documentSignature": {
                          "docId": 3114,
                          "customerIdentification": #(getCustomerId),
                          "signedBy": "John Redwood",
                          "geolocation": "",
                          "ip": ""
                      }
                    }
                    """
    Given path '/exp-bff-mfe-service/retail/account'
    * configure headers = { 'Content-Type': 'application/json', 'Authentication':'#(getIdToken)' }
    When request createAccount
    And method POST
    Then status 200
    And match response == '#object'
    * def getAccountId = response.accountIdentification
    * print getAccountId

