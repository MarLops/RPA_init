*** Settings ***
Library    Browser
Library    OperatingSystem


*** Variables ***
#${SEARCH_TERM}    laptop

*** Tasks ***
Open Amazon and Search
    New Browser    chromium    headless=False 
    New Page    https://www.amazon.com/
    Sleep    5 seconds
    Wait For Load State
    Fill Text    id=twotabsearchtextbox    laptop
    Press Keys    id=twotabsearchtextbox    Enter
    Wait For Load State
    ${html}=    Get Page Source
    Create File    path=laptop_amazon.html    content=${html}
    Close Browser
    
    