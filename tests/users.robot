*** Settings ***
Resource    ../resources/keywords.robot

Suite Setup     Create API Session

*** Test Cases ***
Create User
    ${payload}=    Create Dictionary    name=Alex    job=QA
    ${resp}=       Post To JSON API    /users    ${payload}
    Status Should Be    201    ${resp}
    Should Be True      isinstance(${resp.json()}, dict)

Get Users
    ${resp}=       Get From JSON API    /users
    Status Should Be    200    ${resp}
    ${items}=      Set Variable    ${resp.json()}
    Should Be True    isinstance(${items}, list) and len(${items}) > 0

Update User
    ${payload}=    Create Dictionary    name=Alex2    job=Senior QA
    ${resp}=       Put To JSON API     /users/1    ${payload}
    Status Should Be    200    ${resp}
    Should Contain      ${resp.text}    Alex2

Delete User
    ${resp}=       Delete From JSON API    /users/1
    Should Be True      ${resp.status_code} in [200, 204]
