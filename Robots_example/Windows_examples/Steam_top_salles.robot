*** Settings ***
#https://rpaframework.org/libdoc/RPA_Windows.html#Windows%20Search
Library  RPA.Windows
Library  RPA.Desktop
Library  OperatingSystem
Library    DateTime
Library    RPA.recognition
Library    JSONLibrary
Library    MyTableParser.py    WITH NAME    MyTableParser


*** Variables ***
${TESSERACT_PATH}    C:\\Program Files\\Tesseract-OCR
${folder}=    Top_sales_brazil

*** Tasks ***
Get all recomendation
    Set Environment Variable    PATH    %{PATH}${:}${TESSERACT_PATH}
    ${app}=  Windows Search   stea
    Sleep    1s
    ${window}=    Control Window   name:Steam
    Maximize Window    
    Wait Until Keyword Succeeds    60s    1s     Get Element    name:STORE 
    ${store}=    Get Element    name:STORE   
    RPA.Windows.Click    ${store}
    Sleep    1s
    ${featured}=    Get Element    name:Featured   
    RPA.Windows.Click    ${featured}
    ${window}=    Control Window   name:Steam
    Print Tree    ${window}
    Wait Until Keyword Succeeds    60s    1s    RPA.Desktop.Find Elements     ocr:"Browse"
    ${browser_check}=  RPA.Desktop.Find Element   ocr:"Browse"
    RPA.Desktop.Move Mouse    ${browser_check}
    RPA.Desktop.Click
    Wait Until Keyword Succeeds    30s    2s    RPA.Desktop.Find Elements   ocr:"TOP SELLERS"
    ${top_sales}=    RPA.Desktop.Find Element    ocr:"TOP SELLERS"
    RPA.Desktop.Move Mouse    ${top_sales}
    RPA.Desktop.Click
    Sleep    5s
    #${current_country}=    Get Attribute    ${box_select_country}    Name
    ${table}=    Get Element     type:Document > type:Table
    ${tree}=    Print Tree    type:Document > type:Table    return_structure=True
    ${games}=    MyTableParser.Parse Table Tree    ${tree}
    ${country}=   RPA.Desktop.Find Element   image:"country_button.png"
    ${today}=      Get Current Date    result_format=%Y_%m_%d
    ${country_name}=    Set Variable    brazil
    ${filename}=    Set Variable    top_games_${country_name}_${today}.json
    ${json}=    Evaluate    json.dumps($games, indent=4)    modules=json
    Create File    ${filename}    ${json}
    RPA.Desktop.Move Mouse    ${country}
    RPA.Desktop.Click 
    Sleep    1s
    Close Window    ${window}