*** Settings ***
#https://rpaframework.org/libdoc/RPA_Windows.html#Windows%20Search
Library  RPA.Windows
Library  RPA.Desktop
Library  OperatingSystem


*** Variables ***
${TESSERACT_PATH}    C:\\Program Files\\Tesseract-OCR
${folder}=    Recomendation_steam

*** Tasks ***
Get all recomendation
    Set Environment Variable    PATH    %{PATH}${:}${TESSERACT_PATH}
    ${app}=  Windows Search   stea
    Sleep    1s
    ${store}=    Get Element    name:STORE   
    RPA.Windows.Click    ${store}
    Sleep    1s
    ${featured}=    Get Element    name:Featured   
    RPA.Windows.Click    ${featured}
    Sleep    7s

    ${recomendation}=    RPA.Desktop.Find Element    ocr:"Featured & Recommended"
    RPA.Desktop.Move Mouse    ${recomendation}
    RPA.Desktop.Click
    FOR    ${i}    IN RANGE    10
        RPA.Desktop.Press Keys    down
    END
    Sleep    2s
    ${passagems}=    RPA.Desktop.Find Elements    image:passagem.png   
    ${count}=    Get Length    ${passagems}

    Log To Console    Total de elementos encontrados: ${count}

    #${button}=    RPA.Desktop.Find Element    image:button_right.png    
    ${exists}=    Run Keyword And Return Status    Directory Should Exist    ${folder}
    Run Keyword If    not ${exists}    Create Directory    ${folder}
    FOR    ${i}    IN RANGE      6
        RPA.Desktop.Take Screenshot    path=${folder}/recomendation_${i}.png
        RPA.Desktop.Click    ${}
        Sleep    1s
    END
    FOR    ${i}    IN RANGE    10
        RPA.Desktop.Press Keys    up
    END
    #Close Window    name:Steam
    #Print Tree    log_as_warnings=${True}