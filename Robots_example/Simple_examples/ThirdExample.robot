*** Settings ***
Library    pokemonapi.py
Library    Collections
Library    OperatingSystem


*** Variables ***
${number_pokemon}    1
${name_pokemon}    bulbasaur

*** Tasks ***
Check Pokemon
    ${result}    Get Pokemon    id=1
    ${has_name}    Run Keyword And Return Status    Dictionary Should Contain Key    dictionary=${result}    key=name
    IF    ${has_name}
        ${name}    Get From Dictionary    dictionary=${result}    key=name
        Should Be Equal    first=${name}    second=${name_pokemon}
    ELSE
        Fail    Variables are NOT equal
    END
    
