*** Settings ***
Library          SeleniumLibrary

Suite Setup     Open Browser    https://example.com    chrome
Suite Teardown  Close Browser

*** Variables ***
${LOGIN URL}     https://practicetestautomation.com/practice-test-login/
${VALID USER}    student
${VALID PASS}    Password123
${INVALID USER}  wrongUser
${INVALID PASS}  wrongPass

*** Test Cases ***

Valid Login Should Succeed
    Input Text     id:username      ${VALID USER}
    Input Text     id:password      ${VALID PASS}
    Click Button   id:submit
    Wait Until Location Contains   logged-in-successfully
    Page Should Contain           Congratulations
    Page Should Contain Button    Log out

Invalid Username Should Show Error
    Input Text     id:username      ${INVALID USER}
    Input Text     id:password      ${VALID PASS}
    Click Button   id:submit
    Page Should Contain           Your username is invalid!

Invalid Password Should Show Error
    Input Text     id:username      ${VALID USER}
    Input Text     id:password      ${INVALID PASS}
    Click Button   id:submit
    Page Should Contain           Your password is invalid!

