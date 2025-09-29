*** Settings ***
Resource    ../resources/keywords.robot
Library     Collections

Suite Setup     Create Auth Session

*** Test Cases ***
Login Success (FakeStore)
    ${payload}=    Create Dictionary    username=mor_2314    password=83r5^_
    ${resp}=       Auth Login    ${payload}
    Should Be True    ${resp.status_code} in [200, 201]
    ${body}=       Set Variable    ${resp.json()}
    Dictionary Should Contain Key    ${body}    token

Login Negative (Missing Password)
    ${payload}=    Create Dictionary    username=mor_2314
    ${resp}=       Auth Login    ${payload}
    Should Be True    ${resp.status_code} in [400, 401, 403]
