*** Settings ***
Library         Process
Library         String
Library         RPA.Robocorp.WorkItems
Library         RPA.FileSystem
Library    OperatingSystem

*** Keyword ***
Convert
    ${paths}=    Get work item files    *.pdf
    Create Output Work Item

    FOR  ${path}  IN  @{paths}
        ${path}=  Get Filename  ${path}
        ${txt}=  Replace string  ${path}  .pdf  .txt
        
        Run Process  ocrmypdf  --sidecar  out-${txt}  ${path}  %{ROBOT_ARTIFACTS}/out-${path}
        File Should Exist  %{ROBOT_ARTIFACTS}/out-${path}
        Add Work Item File  %{ROBOT_ARTIFACTS}/out-${path}  name=${path}
        
        ${text_content}=  Read File  out-${txt}
        Set Work Item Variable    ${txt}    ${text_content}
    END

    Save Work Item

*** Task ***
Demo
    Add Work Item File  image.pdf
    Convert

*** Task ***
Convert PDFs from Work Item
    Convert
