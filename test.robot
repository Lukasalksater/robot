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
${customer-mail1}    1@gmail.se
${customer-firstname1}    Jane
${customer-lastname1}    Doe
${customer-city1}    London

*** Test Cases ***

Scenario: User logs in to Automationplayground
    Given User Is On Automationplayground Login Site
    When User Logs In With Email '${email}' And With Password '${password}'
    Then User Should Be Logged In
    
Scenario: Create new customer
    Given User is logged in    ${email}    ${password}
    And User creates new customer
    When All necessary data is being submitted    ${customer-mail1}    ${customer-firstname1}    ${customer-lastname1}    ${customer-city1}
    Then User has been created

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
    
User is logged in
    [Documentation]    User logs in to https://automationplayground.com/crm/
    [Tags]    login
    [Arguments]    ${admin-mail}    ${admin-password}
    Click Link    //a[@id='SignIn']
    Input Text    //input[@id='email-id']    text=${admin-mail}
    Input Password    //input[@id='password']    ${admin-password}
    Click Element    //button[@id='submit-id']
    Wait Until Page Contains    text=Sign Out    timeout=10s

User creates new customer
    [Documentation]    User clicks 'new-customer' link
    [Tags]    customer-creation
    Click Link    //a[@id='new-customer']
    Wait Until Page Contains    text=Add Customer   timeout=10s

All necessary data is being submitted
    [Documentation]    User fills in all customer data
    [Tags]    customer-creation
    [Arguments]   ${customer-mail}    ${customer-firstname}    ${customer-lastname}    ${customer-city}
    Input Text    //input[@id='EmailAddress']    text=${customer-mail}
    Input Text    //input[@id='FirstName']    text=${customer-firstname}
    Input Text    //input[@id='LastName']    text=${customer-lastname}
    Input Text    //input[@id='City']    text=${customer-city}
    Select From List By Index    //select[@id='StateOrRegion']    1
    Click Element   //input[@value='female']
    Select Checkbox    //input[@name='promos-name']
    Checkbox Should Be Selected    //input[@name='promos-name']
    
User has been created
    [Documentation]    User clicks clicks 'submit' and success text is shown
    [Tags]    customer-creation
    Click Element   //button[normalize-space()='Submit']
    Wait Until Page Contains     text=New customer added.    timeout=10s
    Close Window