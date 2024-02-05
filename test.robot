*** Settings ***
Documentation    test for logging in to automationplayground
Library    SeleniumLibrary
Suite Setup    setup


*** Variables ***
${url}    https://automationplayground.com/crm/
${email}    bosse@gmail.se
${password}    12345
${usernameLoginPath}    //input[@id='email-id']
${passwordLoginPath}    //input[@id='password']


*** Test Cases ***
Scenario: User logs in to Automationplayground
    Given User Is On Automationplayground Login Site
    When User Logs In With Email '${email}' And With Password '${password}'
    Then User Should Be Logged In
Scenario: Users creates new user
    Given User is logged in on automationplayground
    When User clicks new user button
    Then User should be able to input information

*** Keywords ***
setup
    [Documentation]    setup for starting browser and going to website
    [Tags]    setup
    Open Browser    browser=chrome
    Maximize Browser Window
    Go To    ${url}
User Is on Automationplayground Login Site
    [Documentation]    clicking sign in link
    [Tags]    login
    Click Link    //a[@class='nav-link']
    
User Logs In With Email '${email}' and with password '${password}'
    [Documentation]    inputting information and clicking log in
    [Tags]    login
    Input Text    ${usernameLoginPath}    ${email}
    Input Password    ${passwordLoginPath}    ${password}
    Click Button    //button[@id='submit-id']

User Should Be Logged In
    [Documentation]    checking if page after logging in contains enw customer button
    [Tags]    login
    Page Should Contain Element    //a[@id='new-customer']
User is logged in on automationplayground
    [Documentation]    logging in to automationplayground
    [Tags]    creatingNewUser
    Click Link    //a[@class='nav-link']
    Input Text    ${usernameLoginPath}    ${email}
    Input Password    ${passwordLoginPath}    ${password}
    Click Button    //button[@id='submit-id']


User clicks new user button
    [Documentation]    clicking new user button
    [Tags]    creatingNewUser
    Click Link    //a[@id='new-customer']

User should be able to input information
    Page Should Contain Element    //input[@id='EmailAddress']







    
