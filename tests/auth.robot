*** Settings ***
Library    RequestsLibrary

Suite Setup     Create Session    httpbin    https://httpbin.org

*** Variables ***
${BASIC_OK}    Basic dXNlcjpwYXNzd2Q=      # base64("user:passwd")
${BASIC_BAD}   Basic dXNlcjpXUk9ORw==      # base64("user:WRONG")

*** Test Cases ***
Login Success (Basic Auth)
    ${headers}=    Create Dictionary    Authorization=${BASIC_OK}
    ${resp}=       GET On Session    httpbin    /basic-auth/user/passwd    headers=${headers}
    Status Should Be    200    ${resp}
    ${body}=       Set Variable    ${resp.json()}
    Should Be Equal    ${body["user"]}    user
    Should Be True     ${body["authenticated"]}

Login Negative (Wrong Creds)
    ${headers}=    Create Dictionary    Authorization=${BASIC_BAD}
    # expected_status=any — не бросать ошибку при 401/403
    ${resp}=       GET On Session    httpbin    /basic-auth/user/passwd    headers=${headers}    expected_status=any
    Should Be True    ${resp.status_code} in [401, 403]
