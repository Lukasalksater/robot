*** Settings ***
Documentation    Robot framework test + github
Library    SeleniumLibrary
Suite Setup    Go to https://automationplayground.com/crm/ in Chrome

*** Variables ***
${url}    https://automationplayground.com/crm/
${admin-mail}    bosse@gmail.se
${admin-password}    12345
${customer-mail1}    1@gmail.se
${customer-firstname1}    Jane
${customer-lastname1}    Doe
${customer-city1}    London

*** Test Cases ***
Fill in user information
    Given User is logged in    ${admin-mail}    ${admin-password}
    And User creates new customer
    When All necessary data is being submitted    ${customer-mail1}    ${customer-firstname1}    ${customer-lastname1}    ${customer-city1}
    Then User has been created

*** Keywords ***
Go to https://automationplayground.com/crm/ in Chrome
    Open Browser    browser=Chrome
    Maximize Browser Window
    Go To    ${url}

User is logged in
    [Tags]    login
    [Arguments]    ${mail}    ${password}
    Click Link    //a[@id='SignIn']
    Input Text    //input[@id='email-id']    text=${mail}
    Input Password    //input[@id='password']    ${password}
    Click Element    //button[@id='submit-id']

User creates new customer
    [Tags]    customer-creation
    Click Link    //a[@id='new-customer']

All necessary data is being submitted
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
    Click Element   //button[normalize-space()='Submit']
    
User has been created    
    [Tags]    customer-creation
    Wait Until Page Contains     text=New customer added.    timeout=10s
    Close Window