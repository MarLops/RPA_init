*** Settings ***
# robot --outputdir results test.robot https://docs.robotframework.org/docs/examples/insurance
Library    Browser

*** Variables ***
${BROWSER}    chromium
${HEADLESS}    false

*** Test Cases ***
Create Quote for Car
    Open Insurance Application
    Enter Vehicle Data for Automobile
    Enter Insurant Data
    Enter Product Data
    Select Price Option
    Send Quote
    End Test

*** Keywords ***
Open Insurance Application
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Page    http://sampleapp.tricentis.com/
    Sleep    3 seconds

Enter Vehicle Data for Automobile
    Click    div.main-navigation >> "Automobile"
    Sleep    5 seconds
    Select Options By    id=make    text    Audi
    Fill Text    id=engineperformance    110
    Fill Text    id=dateofmanufacture    06/12/1980
    Select Options By    id=numberofseats    text    5
    Select Options By    id=fuel    text    Petrol    
    Fill Text    id=listprice    30000
    Fill Text    id=licenseplatenumber    DMK1234
    Fill Text    id=annualmileage   10000
    Sleep    2 seconds
    Click    section[style="display: block;"] >> text=Next »

Enter Insurant Data
    [Arguments]    ${firstname}=Max    ${lastname}=Mustermann
    Sleep    2 seconds
    Fill Text    id=firstname    Max
    Fill Text    id=lastname    Mustermann
    Fill Text    id=birthdate    01/31/1980
    Check Checkbox    *css=label >> id=gendermale
    Fill Text    id=streetaddress    Test Street
    Select Options By    id=country    text    Germany
    Fill Text    id=zipcode    40123
    Fill Text    id=city    Essen
    Select Options By    id=occupation    text    Employee
    Click    text=Cliff Diving
    Sleep    2 seconds
    Click    section[style="display: block;"] >> text=Next »

Enter Product Data
    Sleep    2 seconds
    Fill Text    id=startdate    06/01/2027
    Select Options By    id=insurancesum    text    7.000.000,00
    Select Options By    id=meritrating    text    Bonus 1
    Select Options By    id=damageinsurance    text    No Coverage
    Check Checkbox    *css=label >> id=EuroProtection
    Select Options By    id=courtesycar    text    Yes
    Sleep    2 seconds
    Click    section[style="display: block;"] >> text=Next »

Select Price Option
    [Arguments]    ${price_option}=Silver
    Sleep    2 seconds
    Click    *css=label >> css=[value=${price_option}]
    Sleep    2 seconds
    Click    section[style="display: block;"] >> text=Next »

Send Quote
    Sleep    2 seconds
    Fill Text    "E-Mail" >> .. >> input    max.mustermann@example.com
    Fill Text    "Phone" >> .. >> input    0049201123456
    Fill Text    "Username" >> .. >> input    max.mustermann
    Fill Text    "Password" >> .. >> input    SecretPassword123!
    Fill Text    "Confirm Password" >> .. >> input    SecretPassword123!
    Fill Text    "Comments" >> .. >> textarea    Some comments
    Sleep    2 seconds
    ${promise}=     Promise To    Wait For Response     matcher=http://sampleapp.tricentis.com/101/tcpdf/pdfs/quote.php     timeout=10
    Sleep    2 seconds
    Click    "« Send »"
    Sleep    6 seconds
    Wait For Elements State    "Sending e-mail success!"
    Click    "OK"

End Test
    Close Context
    Close Browser