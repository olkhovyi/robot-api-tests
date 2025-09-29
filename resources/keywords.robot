*** Settings ***
Library    RequestsLibrary

*** Variables ***
${JSON_BASE}    https://jsonplaceholder.typicode.com
${AUTH_BASE}    https://fakestoreapi.com

*** Keywords ***
Create API Session
    Create Session    json_api    ${JSON_BASE}

Get From JSON API
    [Arguments]    ${endpoint}
    ${resp}=    GET On Session    json_api    ${endpoint}    expected_status=any
    RETURN    ${resp}

Post To JSON API
    [Arguments]    ${endpoint}    ${payload}
    ${resp}=    POST On Session    json_api    ${endpoint}    json=${payload}    expected_status=any
    RETURN    ${resp}

Put To JSON API
    [Arguments]    ${endpoint}    ${payload}
    ${resp}=    PUT On Session    json_api    ${endpoint}    json=${payload}    expected_status=any
    RETURN    ${resp}

Delete From JSON API
    [Arguments]    ${endpoint}
    ${resp}=    DELETE On Session    json_api    ${endpoint}    expected_status=any
    RETURN    ${resp}

Create Auth Session
    Create Session    auth_api    ${AUTH_BASE}

Auth Login
    [Arguments]    ${payload}
    ${resp}=    POST On Session    auth_api    /auth/login    json=${payload}    expected_status=any
    RETURN    ${resp}
