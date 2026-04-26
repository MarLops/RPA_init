*** Settings ***
Library    Browser
Library    OperatingSystem
Suite Setup     New Browser    chromium    headless=False 
Suite Teardown    Close Browser


*** Variables ***
${product}    laptop dell
${folder}    Amazon_product

*** Keywords ***
Open Amazon and Search First Page
    [Arguments]    ${product}
    New Page    https://www.amazon.com/
    Sleep    5 seconds
    Wait For Load State
    Sleep    5 seconds
    Fill Text    id=twotabsearchtextbox    txt=${product}
    Press Keys    id=twotabsearchtextbox    Enter
    Wait For Load State
    Browser.Scroll By    vertical=50%
    
    

Get Next Search Page Amazon
    Wait For Elements State    css=a.s-pagination-next    visible    timeout=10s
    Sleep    2s
    Click    css=a.s-pagination-next
    Wait For Load State
    Browser.Scroll By    vertical=50%
    Sleep    2s
    Wait For Elements State    css=[data-component-type="s-search-results"]    visible
    
    
Save Page
    [Arguments]    ${folder}    ${file_name}
    ${exists}=    Run Keyword And Return Status    Directory Should Exist    ${folder}
    Run Keyword If    not ${exists}    Create Directory    ${folder}
    ${html}=    Get Page Source
    ${file_path}=    Catenate    SEPARATOR=/
    ...    ${folder}/${file_name}.html
    Create File    ${file_path}    ${html}


Load And Save Until Page
    [Arguments]    ${product}    ${folder}    ${total_page}
    FOR    ${i}    IN RANGE    ${total_page}
        TRY
            Get Next Search Page Amazon
            Save Page    folder=${folder}    file_name=${product}_${i}.html
            Sleep    2s
        EXCEPT
            Log To Console    Failed at page ${i}, stopping
            EXIT FOR LOOP
        END
    END

Load All Page and Save
    [Arguments]    ${product}    ${folder}
    ${i}=    Set Variable    2
    WHILE    True
        TRY
            Get Next Search Page Amazon
            Save Page    folder=${folder}    file_name=${product}_${i}.html
            Sleep    1s
            ${i}=    Evaluate    ${i} + 1

        EXCEPT
            Log To Console    Failed at page ${i}, stopping
            EXIT FOR LOOP
        END
    END

*** Tasks ***
Search and Save
    Open Amazon and Search First Page    product=${product}
    Save Page    folder=${folder}    file_name=${product}_1.html
    Load And Save Until Page    product=${product}    folder=${folder}    total_page=3

