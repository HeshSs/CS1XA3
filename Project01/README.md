#   CS 1XA3 Project01 - <salehh6>
## Usage
    Execute this script from project repo root with:
        chmod +x Project01/project_analyze.sh
        ./Project01/project_analyze.sh arg1 arg2 ...
    With possible arguments:
        arg1: feature
        arg2: feature# - where feature# is an integer from 1 to 10 and it is the feature number
    For example:
        ./Project01/project_analyze.sh feature 1
            runs the script for feature 1
    Note:
        - arg1 is always feature
        - If a feature was run successfully it will output:
            Feature # was run successfully.
## Feature 01
    Description: This is the feature that makes this script interactive.
    Execution: ./Project01/project_analyze.sh feature 1
    Reference: some code was taken from [[https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash]]
## Feature 02
    Description: Finds every file in CS1XA3 repo that contains the string "#FIXME" and adds the name of the file in a new line in CS1XA3/Project01/fixme.log
    Execution: ./Project01/project_analyze.sh feature 2
    Reference: some code was taken from [[https://www.cyberciti.biz/faq/unix-howto-read-line-by-line-from-file/]]
## Feature 03
    Description: Finds the most recent commit that has the word merge in its message, and then checksout into that commit(Detached head mode).
    Execution: ./Project01/project_analyze.sh feature 3
    Reference: some code was taken from [[https://devhints.io/bash]]

