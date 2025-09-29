*** Settings ***
Library    RequestsLibrary
Library    Collections

Suite Setup     Create Session    jsonplaceholder    https://jsonplaceholder.typicode.com

*** Test Cases ***
Create User
    ${data}=    Create Dictionary    name=Alex    job=QA
    ${resp}=    POST On Session    jsonplaceholder    /users    json=${data}
    Status Should Be    201    ${resp}
    ${body}=    Set Variable    ${resp.json()}
    Should Be True    isinstance(${body}, dict)

Get Users
    ${resp}=    GET On Session    jsonplaceholder    /users
    Status Should Be    200    ${resp}
    ${items}=   Set Variable    ${resp.json()}
    Should Be True    isinstance(${items}, list) and len(${items}) > 0

Update User
    ${data}=    Create Dictionary    name=Alex2    job=Senior QA
    ${resp}=    PUT On Session    jsonplaceholder    /users/1    json=${data}
    Status Should Be    200    ${resp}
    Should Contain      ${resp.text}    Alex2

Delete User
    ${resp}=    DELETE On Session    jsonplaceholder    /users/1
    Should Be True      ${resp.status_code} in [200, 204]
