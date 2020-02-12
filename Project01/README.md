#   CS 1XA3 Project01 - <salehh6> *salehh6* 
## Usage
    Execute this script from project repo root with:
        `chmod +x Project01/project_analyze.sh`
        `./Project01/project_analyze.sh arg1 arg2 ...`
    With possible arguments:
        arg1: feature or custom_feature
        arg2: feature# - where feature# is an integer from 2 to 10 and it is the feature number
    For example:
        `./Project01/project_analyze.sh feature 2`
            runs the script for Feature 2
    Note:
        - arg1 is always feature or custom_feature
## Feature 2 - FIXME log
    Description: Finds every file in CS1XA3 repo that contains the string "#FIXME" and adds the path of the file in a new line in CS1XA3/Project01/fixme.log
    Execution: `./Project01/project_analyze.sh feature 2`
    Reference: some code was taken from [how to read line by line from file](https://www.cyberciti.biz/faq/unix-howto-read-line-by-line-from-file/)
    Success Message:    "File fixme.log was successfully created in Project01 directory."
## Feature 3 - Checkout latest merge
    Description: Finds the most recent commit that has the word merge in its message, and then checksout into that commit(Detached head mode).
    Execution: `./Project01/project_analyze.sh feature 3`
    Reference: some code was taken from [Bash cheat sheet](https://devhints.io/bash)
    Success Message:    A message by Git that says you are currently in detached head state.
## Feature 4 - File Size List
    Description: Finds all the hidden and non-hidden regular files in the repo and prints the filesize (human readable e.g. KB, MB etc.) and filename.
    Execution: `./Project01/project_analyze.sh feature 4`
    Reference: some code was taken from [how to list all files ordered by size](https://unix.stackexchange.com/questions/53737/how-to-list-all-files-ordered-by-size)
    Success Message: The list of files and their size
## Custom Feature 1 - Online Word Search
    Description: Downloads a file from web given the url (arg3) and finds all the lines with occurences of a word (arg4) and saves them into a file named (arg4).txt
    Executation: `./Project01/project_analyze.sh custom_feature 1 url word`
    Reference: N/A
    Success Message: N/A
## Custom Feature 2 - My TODO List
    Description: Given an option Add, Remove or Save (arg3) and Message (arg4) keeps track of my TODO list in a file named TODO.log
    Has 3 options:
        * Add - Adds a new TODO to my todo list and returns the TODO's number
        * Remove - Given a TODO's number, removes it from the TODO list
        * Save - Saves all the TODO items to a file named TODO.txt, overwrites it if it exits
    Executation: `./Project01/project_analyze.sh custom_feature 2 option 'TODO message in quotes'`
    Reference: N/A
    Success Message: N/A

