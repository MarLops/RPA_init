*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
#Run with variable robot --variable pokemon_number:25 test.robot
${url_base}         https://pokeapi.co/api/v2/pokemon/
${pokemon_number}   1

*** Tasks ***
Get Pokemon
    # concat URL
    ${url}=    Set Variable    ${url_base}${pokemon_number}

    # request
    ${response}=    RequestsLibrary.GET    ${url}

    # validate status
    Should Be Equal As Integers    ${response.status_code}    200

    # get json
    ${json}=    Set Variable    ${response.json()}

    # check if has key "name"
    ${has_key_name}=    Run Keyword And Return Status    Dictionary Should Contain Key    ${json}    name

    IF    ${has_key_name}
        ${name}=    Get From Dictionary    ${json}    name
        Log To Console    Nome do Pokemon: ${name}
    ELSE
        Fail    Chave 'name' não encontrada
    END


Get Pokemon Fail
    # concat URL
    ${url}=    Set Variable    ${url_base}${pokemon_number}

    # request
    ${response}=    RequestsLibrary.GET    ${url}

    # validate status
    Should Be Equal As Integers    ${response.status_code}    200

    # get json
    ${json}=    Set Variable    ${response.json()}

    # check if has key "name"
    ${has_key_name}=    Run Keyword And Return Status    Dictionary Should Contain Key    ${json}    name

    IF    ${has_key_name}
        ${name}=    Get From Dictionary    ${json}    name
        Should Be Equal    ${name}    'bulbasauro'
    ELSE
        Fail    Chave 'name' não encontrada
    END