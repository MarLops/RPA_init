*** Settings ***
#    https://robotframework-browser.org/    https://docs.robotframework.org/docs/different_libraries/database
Library    Browser
Library    DatabaseLibrary
Library    Collections
Library    brasileiraoutil.py    WITH NAME    BrasileiraoUtil
Suite Setup     New Browser    chromium    headless=False 
Suite Teardown    Close Browser


*** Keywords ***
Connect Open
    Connect To Database    db_module=sqlite3    database=./my_database.db

Connect Close
    Disconnect From Database

Save to Database
    [Arguments]    ${data}

    ${sql}=    Set Variable    CREATE TABLE IF NOT EXISTS positions (posicao TEXT,nome TEXT,pontos TEXT,jogos TEXT,vitoria TEXT)

    DatabaseLibrary.Execute Sql String    ${sql}

    DatabaseLibrary.Execute Sql String    DELETE FROM positions
    FOR    ${row}    IN    @{data}

        ${posicao}=    Get From Dictionary    ${row}    posicao
        ${nome}=       Get From Dictionary    ${row}    nome
        ${pontos}=     Get From Dictionary    ${row}    pontos
        ${jogos}=      Get From Dictionary    ${row}    jogos
        ${vitorias}=   Get From Dictionary    ${row}    vitoria

        DatabaseLibrary.Execute Sql String    INSERT INTO positions (posicao, nome, pontos, jogos, vitoria) VALUES ("${posicao}", "${nome}", "${pontos}", "${jogos}", "${vitorias}")

    END


*** Tasks ***
Get Positions
    New Page    url=https://ge.globo.com/futebol/brasileirao-serie-a/    wait_until=domcontentloaded
    Sleep    time_=20
    ${html}=    Get Page Source
    ${response}=    BrasileiraoUtil.Get Positions    html=${html}
    Connect Open
    Save to Database    data=${response}
    Connect Close
    ${first}=    Get From List    ${response}    0
    ${nome_primeiro}=    Get From Dictionary    ${first}    nome
    Log To Console    Time em primeiro lugar:${nome_primeiro}
