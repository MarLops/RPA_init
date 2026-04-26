*** Settings ***
Library    OperatingSystem



*** Tasks ***
ListFiles
    ${files}=    List Files In Directory    path=${CURDIR}

    ${file_count}=    Get Length    ${files}

    Log To Console    Current path: ${CURDIR}
    Log To Console    Files: ${file_count}


ListFolders
    [Documentation]    List folder
    ${dirs}=     List Directories In Directory    path=${CURDIR}
    ${dir_count}=     Get Length    ${dirs}
    Log To Console    Current path: ${CURDIR}
    Log To Console    Folders: ${dir_count}