#   CS 1XA3 Project01 - <salehh6> *salehh6* 

## Usage
Execute this script from project repo root with:

    chmod +x Project01/project_analyze.sh
    ./Project01/project_analyze.sh arg1 arg2 ...
   
With possible arguments:
  * arg1: feature or custom_feature
  * arg2: feature# - where feature# is an integer from 2 to 10 and it is the feature number
    
For example:
   `./Project01/project_analyze.sh feature 2`
            runs the script for Feature 2
            
Note:
  - arg1 is always feature or custom_feature
    
## Feature 2 - FIXME log
Description: Finds every file in CS1XA3 repo that contains the string "#FIXME" and adds the path of the file in a new line in CS1XA3/Project01/fixme.log

Execution: 
   `./Project01/project_analyze.sh feature 2`
   
Reference: some code was taken from 
[how to read line by line from file](https://www.cyberciti.biz/faq/unix-howto-read-line-by-line-from-file/)
    
Success Message:    "File fixme.log was successfully created in Project01 directory."

## Feature 3 - Checkout latest merge
Description: Finds the most recent commit that has the word merge in its message, and then checksout into that commit(Detached head mode).

Execution: 
    `./Project01/project_analyze.sh feature 3`

Reference: some code was taken from 
[Bash cheat sheet](https://devhints.io/bash)

Success Message:    A message by Git that says you are currently in detached head state.

## Feature 4 - File Size List
Description: Finds all the hidden and non-hidden regular files in the repo and prints the filesize (human readable e.g. KB, MB etc.) and filename.

Execution: 
   `./Project01/project_analyze.sh feature 4`

Reference: some code was taken from 
[how to list all files ordered by size](https://unix.stackexchange.com/questions/53737/how-to-list-all-files-ordered-by-size)

Success Message: The list of files and their size

## Feature 5 - File Type Count
Description: Prompts the user for a file extension (i.e. txt, pdf, py) and outputs the number of files in the repo with that file extension.

Execution: 
   `./Project01/project_analyze.sh feature 6`

Reference: some code was taken from 
[Grep only certain file extensions](https://stackoverflow.com/questions/12516937/grep-but-only-certain-file-extensions)

Success Message: A natural number, that represents the number of files in the repo with that file extension.

## Feature 6 - Find Tag
Description: Prompts the user for a TAG (i.e. any single word) and from each python (.py) file, copies every line that begins with a comment (#) and contains the TAG into a file named TAG.log (where TAG is replaced by the actual TAG that was inputted by the user.

Execution: 
   `./Project01/project_analyze.sh feature 6`

Reference: some code was taken from 

[Grep Command in Linux](https://linuxize.com/post/how-to-use-grep-command-to-search-files-in-linux/)

[Bash cheat sheet](https://devhints.io/bash)

Success Message: File TAG.log was successfully created in the Project01 directory.

## Feature 7 - Switch to Executable
Description: Prompts the user for to choose from 2 options:

1. Change:
    * For every shell script in the repo saves the current permissions of the file in a file named permissions.log in the Project01 directory and then for any one who has the right to write to the shell scripts will gain the right to execute it as well, if they don't have the right to write, then they lose their right to execute it as well.

2. Restore:
    * For every shell script that was logged in the permission.log file, restores it's permission to it's old (logged in permissions.log) permissions.
    * If the permissions.log file doesn't exist, it throws an error.
    
Execution: 
   `./Project01/project_analyze.sh feature 7`

Reference: some code was taken from 

[Using bash to find line number of a string in file](https://stackoverflow.com/questions/20026370/using-bash-script-to-find-line-number-of-string-in-file)

[How do you do file permissions](https://askubuntu.com/questions/528411/how-do-you-view-file-permissions)
 
[How to check if a file contains a string](https://stackoverflow.com/questions/11287861/how-to-check-if-a-file-contains-a-specific-string-using-bash)

[How to replace an entire line in a file by line number](https://stackoverflow.com/questions/11145270/how-to-replace-an-entire-line-in-a-text-file-by-line-number/11145362)

Success Message: 

* If permissions change successfully:
    `Permissions Changed.`
    
* If permissions restored successfully:
    `Permissions Restored.`

* If the permission.log doesn't exist when trying to change permissions:
    `File permissions.log doesn't exist in Project01 directory.`

## Custom Feature 1 - Online Word Search
Description: Prompts user for a url (Preferably a .html or .txt) and then prompts for a word that user wants to be searched in that file. 
* If the url or the file is invalid, it keeps reprompting until a valid url is inputted or CTRL-C is pressed.

Then, it downloads the file from web given url (prompt 1) and finds all the lines with occurences of the word (prompt 2) and saves them into a file named WORD.log, where WORD is replaced by the inputted word in the Project01 directory.

Executation: 
   `./Project01/project_analyze.sh custom_feature 1`

Reference: some code was taken from 

[wget output document and headers to stdout](https://stackoverflow.com/questions/12120935/wget-output-document-and-headers-to-stdout)

[how to download a file from a website via terminal](https://askubuntu.com/questions/207265/how-to-download-a-file-from-a-website-via-terminal)

[wget to print errors but nothing otherwise](https://serverfault.com/questions/70889/wget-to-print-errors-but-nothing-otherwise)

Success Message: File WORD.log was created successfully in the Project01 directory.

## Custom Feature 2 - My TODO List
Description: Given an option Add, Remove or Save (arg3) and Message (arg4) keeps track of my TODO list in a file named TODO.log
  - Has 3 options:
    * Add - Adds a new TODO to my todo list and returns the TODO's number
    * Remove - Given a TODO's number, removes it from the TODO list
    * Save - Saves all the TODO items to a file named TODO.txt, overwrites it if it exits
    
Executation: 
   `./Project01/project_analyze.sh custom_feature 2 option 'TODO message in quotes'`

Reference: 
    N/A
Success Message: N/A

