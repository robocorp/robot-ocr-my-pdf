*** Settings ***
Library         Process
Library         String
Library         RPA.Robocloud.Items
Library         RPA.FileSystem

*** Keyword ***
Convert
    ${paths}=    Get work item files    *.pdf
    FOR  ${path}  IN  @{paths}
        ${path}=  Get Filename  ${path}
        ${txt}=  Replace string  ${path}  .pdf  .txt
        Run Process  ocrmypdf  --sidecar  out-${txt}  ${path}  output/out-${path}
        Add Work Item File  output/out-${path}
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
