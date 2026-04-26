*** Settings ***
#https://rpaframework.org/libdoc/RPA_Windows.html#Windows%20Search
Library  RPA.Windows
Library  RPA.Desktop
Library  OperatingSystem


*** Variables ***
${folder}=    Recomendation_steam

*** Tasks ***
Get all recomendation

    ${app}=  Windows Search   stea
    Sleep    1s
    ${store}=    Get Element    name:STORE   
    RPA.Windows.Click    ${store}
    Sleep    1s
    ${featured}=    Get Element    name:Featured   
    RPA.Windows.Click    ${featured}
    Sleep    3s
    ${recomendation}=    RPA.Desktop.Find Element    image:featured.PNG
    RPA.Desktop.Move Mouse    ${recomendation}
    RPA.Desktop.Click
    FOR    ${i}    IN RANGE    10
        RPA.Desktop.Press Keys    down
    END
    Sleep    2s
    ${button}=    RPA.Desktop.Find Element    image:button_right.PNG    
    ${exists}=    Run Keyword And Return Status    Directory Should Exist    ${folder}
    Run Keyword If    not ${exists}    Create Directory    ${folder}
    FOR    ${i}    IN RANGE      6
        RPA.Desktop.Take Screenshot    path=${folder}/recomendation_${i}.png
        RPA.Desktop.Click    ${button}
        Sleep    1s
    END
    FOR    ${i}    IN RANGE    10
        RPA.Desktop.Press Keys    up
    END
    #Close Window    name:Steam
    #Print Tree    log_as_warnings=${True}