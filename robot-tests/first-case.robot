*** Settings ***
Library    OperatingSystem
Library    Collections
Library    RequestsLibrary


*** Variables ***
${my_secret}     my_value
${data}    ref=master

*** Test Cases ***
Test GitHub Action Trigger
    [Documentation]    Test that GitHub Action workflow is triggered
    [Tags]    trigger
    Given GitHub Action workflow is configured
    When Triggering GitHub Action workflow
    Then GitHub Action workflow is triggered successfully

*** Keywords ***
Given GitHub Action workflow is configured
    [Documentation]    Ensures that the GitHub Action workflow is configured properly
    # In this example, we'll assume that the workflow file exists in a specific directory
    ${workflow_path}=    Set Variable    .github/workflows/ci.yml
    File Should Exist    ${workflow_path}
    # You might want to add additional checks to ensure the workflow file is configured correctly

When Triggering GitHub Action workflow
    [Documentation]    Triggers the GitHub Action workflow
    # In this example, we'll simulate triggering the workflow by making an HTTP request to the GitHub API
    # RequestsLibrary.Create Session  hook    https://api.github.com/repos/bhanuraina/test_nodejs/actions/workflows/ci.yml  verify=${True}
    ${headers}=    Create Dictionary    Authorization    token ${my_secret}    Accept    application/vnd.github.v3+json
    ${data}=    Create Dictionary    ref=main
    ${response}=    Set Variable    HTTP Request    https://api.github.com/repos/bhanuraina/test_nodejs/actions/workflows/ci.yml/dispatches    POST    headers=${headers} json=${data}
    Status Should Be    204    ${response}

Then GitHub Action workflow is triggered successfully
    [Documentation]    Verifies that the GitHub Action workflow is triggered successfully
    # You might want to add additional checks here to verify the workflow status or any other indicators of successful triggering
    Log    GitHub Action workflow is triggered successfully

