# robot-ocr-my-pdf
Example Robot that does OCR for *.pdf files in Robocorp Cloud work item

This Robot converts scanned PDF files to text based PDF files, allowing them to be searched or copy-pasted. The text contents of PDF files are also added to the Work Item as text.

## Example
You can use Robocorp Cloud to convert scanned PDF file to text by creating a process with two steps.

### Step 1 - Attach scanned PDF file to Work Item

Example:

```
*** Settings ***
Library    RPA.Robocloud.Items

*** Task ***
Attach File
    Add Work Item File  image.pdf
```

### Step 2 - Use robot-ocr-my-pdf to extract text

Configure second step by selecting the robot and <Convert PDFs from Work Item> -task. It will attach to work item: 
 - a text PDF file with name <out-filename.pdf> 
 - the text as a variable with name <filename.txt>   

```
"payload": {
  "variables": {
    "image.txt": "IDRH Non-text-searchable PDF This is an example of a non-text-searchable PDF. Because it was created from an image rather than a text document, it cannot be rendered as plain text by the PDF reader. Thus, attempting to select the text on the page as though it were a text document or website will not work, regardless of how neatly it is organized. "
  }
}
```

### Step 3 - Continue the processing

Example:

    *** Settings ***
    Library    RPA.Robocloud.Items
    
    *** Task ***
    Attach File
        ${text}=    Get Work Item Variable    image.txt
        Log    ${text}
