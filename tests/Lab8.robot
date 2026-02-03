*** Settings ***
Library          SeleniumLibrary

Suite Setup     Open Browser To Login Page
Suite Teardown  Close Browser

*** Variables ***
${LOGIN URL}     https://practicetestautomation.com/practice-test-login/
${VALID USER}    student
${VALID PASS}    Password123
${INVALID USER}  wrongUser
${INVALID PASS}  wrongPass

*** Keywords ***
Open Browser To Login Page
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()    sys
    Call Method   ${options}    add_argument    --headless
    Open Browser  ${LOGIN URL}    firefox    options=${options}

*** Test Cases ***

Valid Login Should Succeed
    Input Text     id:username      ${VALID USER}
    Input Text     id:password      ${VALID PASS}
    Click Button   id:submit
    Wait Until Location Contains   logged-in-successfully
    Page Should Contain           Congratulations student. You successfully logged in!

Invalid Username Should Show Error
    Go To          ${LOGIN URL}
    Input Text     id:username      ${INVALID USER}
    Input Text     id:password      ${VALID PASS}
    Click Button   id:submit
    Page Should Contain           Your username is invalid!

Invalid Password Should Show Error
    Go To          ${LOGIN URL}
    Input Text     id:username      ${VALID USER}
    Input Text     id:password      ${INVALID PASS}
    Click Button   id:submit
    Page Should Contain           Your password is invalid!

