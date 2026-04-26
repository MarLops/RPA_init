*** Settings ***
##robot --variable number_pokemon:100 --variable  name_pokemon:gengar .\Robots_example\Simple_examples\ThirdExample.robot
Library    pokemonapi.py
Library    Collections
Library    OperatingSystem


*** Variables ***
${number_pokemon}    
${name_pokemon}

*** Tasks ***
Check Pokemon
    ${result}    Get Pokemon    id=${number_pokemon}
    ${has_name}    Run Keyword And Return Status    Dictionary Should Contain Key    dictionary=${result}    key=name
    IF    ${has_name}
        ${name}    Get From Dictionary    dictionary=${result}    key=name
        Should Be Equal    first=${name}    second=${name_pokemon}
    ELSE
        Fail    Variables are NOT equal
    END
    
