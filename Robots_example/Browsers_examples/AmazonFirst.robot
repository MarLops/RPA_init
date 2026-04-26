*** Settings ***
Library    Browser
Library    OperatingSystem


*** Variables ***
${SEARCH_TERM}    laptop

*** Tasks ***
Open Amazon and Search
    ${file_name}=    Set Variable    ${SEARCH_TERM}_amazon.html
    New Browser    chromium    headless=False 
    New Page    https://www.amazon.com/
    Sleep    5 seconds
    Wait For Load States
    Sleep    5 seconds
    Fill Text    id=twotabsearchtextbox    ${SEARCH_TERM}
    Press Keys    id=twotabsearchtextbox    Enter
    Wait For Load State
    ${html}=    Get Page Source
    Create File    path=${file_name}    content=${html}
    Close Browser
    
    