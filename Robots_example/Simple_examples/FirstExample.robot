*** Settings ***
Documentation    Set library
Library    String


*** Keywords ***
#    Create tasks as function
LogHello
    [Documentation]    This keyword prints a message to console
    Log To Console    Hello keyword

LogUpperCase
    [Documentation]    Converts text to uppercase and logs it
    [Arguments]    ${text}
    ${upper}=   String.Convert To Uppercase   ${text}
    Log To Console    ${upper}
    
    

*** Variables ***
#    Create variables
${test_variable}    'test_variable'


*** Tasks ***
MainTask
    Log To Console    message='init main'
    LogHello
    LogUpperCase    text=${test_variable}
