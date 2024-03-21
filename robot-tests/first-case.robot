*** Settings ***
Library    OperatingSystem
Library    Collections

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

*** Variables ***
${MySecret}			ThisIsNotReallyIt

When Triggering GitHub Action workflow
    [Documentation]    Triggers the GitHub Action workflow
    # In this example, we'll simulate triggering the workflow by making an HTTP request to the GitHub API
    
    ${response}=    Set Variable    HTTP Request    https://api.github.com/repos/bhanuraina/test_nodejs/actions/workflows/ci.yml/dispatches    POST    headers=Authorization: token ${MySecret}    data={"ref": "main"}
    ${status}=    Set Variable    ${response.status_code}
    Should Be Equal As Numbers    ${status}    204

Then GitHub Action workflow is triggered successfully
    [Documentation]    Verifies that the GitHub Action workflow is triggered successfully
    # You might want to add additional checks here to verify the workflow status or any other indicators of successful triggering
    Log    GitHub Action workflow is triggered successfully

