*** Settings ***
Library    Browser
Library    OperatingSystem


*** Tasks ***
Open Amazon and Search
    New Browser    firefox    headless=False 
    New Page    https://www.amazon.com/
    Sleep    10 seconds
    Wait For Load State
    ${continue_button}=    Get Element Count    text=Continue to shopping
    IF    ${continue_button} > 0
        Click    text=Continue to shopping
        Wait For Load State
        Sleep    5 seconds
    END
    Fill Text    id=twotabsearchtextbox    laptop
    Press Keys    id=twotabsearchtextbox    Enter
    Wait For Load State
    ${html}=    Get Page Source
    Create File    path=laptop_amazon.html    content=${html}
    Close Browser
    
    