#!/bin/bash

if [ "$1" != "feature" ] && [ "$1" != "custom_feature" ] || [ "$2" -lt 1 ] 2> /dev/null || [ "$2" -gt 7 ] 2> /dev/null || [[ $2 != ?(-)+([0-9]) ]] ; then
    echo "Usage:"
    echo "  ./Project01/project_analyze feature/custom_feature feature#"

# Usage
elif [ "$1" == "feature" ] && [ "$2" == 1 ] ; then
    echo "Usage:"
    echo "  ./Project01/project_analyze feature/custom_feature feature#"

# Feature 2
elif [ "$1" == "feature" ] && [ "$2" == 2 ] ; then
    if [[ -e  Project01/fixme.log ]] ; then
        echo -n >  Project01/fixme.log
    fi
    grep -wRl "#FIXME" ~/private/CS1XA3 | while read -r file; do
          lastline=`tail -1 "$file"` 2> /dev/null
          if [[ "$lastline" == *"#FIXME"*  ]] ; then
             echo "$file" >>  Project01/fixme.log
          fi
    done
    echo "File fixme.log was successfully created in Project01 directory."

# Feature 3
elif [ "$1" == "feature" ] && [ "$2" == 3 ] ; then
    first=`git log --oneline --graph | grep -i "merge" | head -1`
    if [ "${first:0:1}" = "*" ] && [ "${first:2:1}" = "|" ] ; then
        commit="${first:4:7}"
    elif [ "${first:0:1}" = "|" ] && [ "${first:2:1}" = "*" ] ; then
        commit="${first:4:7}"
    elif [ "${first:0:1}" = "*" ] && [ "${first:2:1}" = " " ] ; then
        commit="${first:4:7}"
    elif [ "${first:0:1}" = "*" ] ; then
        commit="${first:2:7}" 
    fi
    if [[ -n "$commit" ]] ; then 
        git checkout "$commit"
    fi

# Feature 4
elif [ "$1" == "feature" ] && [ "$2" == 4 ] ; then 
    ls ~/private/CS1XA3 -aRlh | grep '^-' | sort -k 5 -rh | awk 'BEGIN {  print "Size Filename" 
                                                                          print "---- --------" } 
                                                                       {  print $5, $9 }'

# Feature 5
elif [ "$1" == "feature" ] && [ "$2" == 5 ] ; then
    read -p "Enter a file extention (i.e. sh, txt, py): " ext
    grep -Rl --include=\*.${ext} ""   | wc -l

# Feature 6
elif [ "$1" == "feature" ] && [ "$2" == 6 ] ; then
    read -p "Enter a TAG (i.e Any single word): " tag
    if [[ -n $tag ]] ; then 
        if [[ -e  Project01/${tag}.log ]] ; then
            echo -n >  Project01/${tag}.log
        else
            touch  Project01/${tag}.log
        fi
        
        printed="false"
        grep -Rh --include=\*.py '^#'   | while read -r line; do
            if [[ "$line" == *"$tag"*  ]] ; then
                echo "$line" >>  Project01/${tag}.log
                if [ $printed != "true" ] ; then
                    echo "File ${tag}.log was successfully created in the Project01 directory."
                    printed="true"
                fi
            fi
        done
    fi
    if [[ ! -s  Project01/${tag}.log ]] ; then
        rm  Project01/${tag}.log
    fi

# Feature 7
elif [ "$1" == "feature" ] && [ "$2" == 7 ] ; then
    files=`grep -Rl --include=\*.sh ""  `
    read -p "Type 'Change' if you wanna change permissions of the script files or 'Restore' if you want to restore their old permissions (without the quotes): " switch
    # Change
    if [[ "$switch" == "Change" ]] ; then
        if [[ ! -e  Project01/permissions.log ]] ; then
            echo -n >  Project01/permissions.log
        fi
        while read -r file; do
            getfacl "$file" 2> /dev/null | while read -r line; do
                if [[ "$line" == *"# file"* ]] ; then
                    current="$line"
                    grep -q "$line"  Project01/permissions.log
                    exit_status=$?
                    if [[ $exit_status == 0 ]] ; then
                        lineNum=`grep -n "$line"  Project01/permissions.log | head -n 1 | cut -d: -f1`
                        continue
                    fi
                    echo "$line" >>  Project01/permissions.log
                elif [[ "$line" == *"user::"* ]] ; then
                    if [[ $exit_status == 0 ]] ; then
                        sed -i "$(( $lineNum+1 ))s|.*|${line}|"  Project01/permissions.log
                        if [[ "$line" == *"w"* ]] ; then
                            chmod u+x "$file"
                        else 
                            chmod u-x "$file"
                        fi
                        continue
                    fi
                    echo "$line" >>  Project01/permissions.log
                    if [[ "$line" == *"w"* ]] ; then
                        chmod u+x "$file"
                    else 
                        chmod u-x "$file"
                    fi
                elif [[ "$line" == *"group::"* ]] ; then
                    if [[ $exit_status == 0 ]] ; then
                        sed -i "$(( $lineNum+2 ))s|.*|${line}|"  Project01/permissions.log
                        if [[ "$line" == *"w"* ]] ; then
                            chmod g+x "$file"
                        else 
                            chmod g-x "$file"
                        fi
                        continue
                    fi
                    echo "$line" >>  Project01/permissions.log
                    if [[ "$line" == *"w"* ]] ; then
                        chmod g+x "$file"
                    else
                        chmod g-x "$file"
                    fi
                elif [[ "$line" == *"other::"* ]] ; then
                    if [[ $exit_status == 0 ]] ; then
                        sed -i "$(( $lineNum+3 ))s|.*|${line}|"  Project01/permissions.log
                        if [[ "$line" == *"w"* ]] ; then
                            chmod o+x "$file"
                        else 
                            chmod o-x "$file"
                        fi
                        continue
                    fi
                    echo "$line" >>  Project01/permissions.log
                    if [[ "$line" == *"w"* ]] ; then
                        chmod o+x "$file"
                    else
                        chmod o-x "$file"
                    fi
                fi
            done 
        done <<< "$files"
        echo "Permissions Changed."
    # Restore
    elif [[ "$switch" == "Restore" ]] ; then
        if [[ -e  Project01/permissions.log ]] ; then
            while read -r rline; do
                if [[ "$rline" == *"# file"* ]] ; then
                    filename="${rline:8:${#rline}}"
                elif [[ "$rline" == *"user::"* ]] ; then
                    chmod "u=${rline:6:${#rline}}" "$filename"
                elif [[ "$rline" == *"group::"* ]] ; then
                    chmod "g=${rline:7:${#rline}}" "$filename"
                elif [[ "$rline" == *"other::"* ]] ; then
                    chmod "o=${rline:7:${#rline}}" "$filename"
                fi
            done <<< `cat  Project01/permissions.log`
            echo "Permissions Restored."
        else
            echo "File permissions.log doesn't exist in Project01 directory."
        fi
    else 
        echo "Usage: "
        echo "Change   -> To Change the permissions."
        echo "Restore  -> To Restore the permissions."
    fi

# Custom Feature 1
elif [ "$1" == "custom_feature" ] && [ "$2" == 1 ] ; then
    read -p "Enter the text file's url: " url
    wget -O file.txt "$url" 2>&1 | grep -i "error" > error.log
    while [[ -s error.log ]] ; do
        read -p "Not a valid file or link, Ctrl-C to exit or Re-enter url: " url
        wget -O file.txt "$url" 2>&1 | grep -i "error" > error.log
    done
    read -p "Enter the word that you wanna search in the file: " word
    if [[ -e  Project01/${word}.log ]] ; then
        echo -n >  Project01/${word}.log
    fi
    while read -r line; do
        if [[ "$line" == *"$word"* ]] ; then
            echo "$line" >>  Project01/${word}.log
        fi
    done <<< `cat file.txt`
    rm error.log
    rm file.txt
    echo "File ${word}.log was created successfully in the Project01 directory."

# Custom Feature 2
elif [ "$1" == "custom_feature" ] && [ "$2" == 2 ] ; then
    read -p "Type Add, Remove, Show or Save to add a TODO, remove a TODO, show the TODO list or save the TODO list into TODO.txt: " option
    # Add
    if [[ "$option" == "Add" ]] ; then
        if [[ ! -e  Project01/TODO.log ]] ; then
            echo -n >  Project01/TODO.log
        fi 
        read -p "Enter your TODO's message here: " message
        hash=`echo "$message" | md5sum`
        echo "${hash} $message" >>  Project01/TODO.log
        echo "TODO's Hash number = ${hash:0:32}"
    # Remove
    elif [[ "$option" == "Remove" ]] ; then
        read -p "Enter your TODO's Hash number here: " number
        sed -i -e "/${number}/d"  Project01/TODO.log
        echo "TODO with Hash number ${number} was removed."
    # Show
    elif [[ "$option" == "Show" ]] ; then
        cat  Project01/TODO.log
    # Save
    elif [[ "$option" == "Save" ]] ; then
        counter=1
        while read -r line; do
            echo "${counter} ${line:34:${#line}}" >>  Project01/TODO.txt
            counter=$(( counter+1 ))
        done <<< `cat  Project01/TODO.log`
        echo "File TODO.txt was successfully created in the Project01 directory."
    else 
        echo "Usage: "
        echo "Add    -> to Add a TODO to the list. Prompts for TODO's message. "
        echo "Remove -> to Remove a TODO from the list. Prompts for TODO's Hash number. "
        echo "Show -> Shows all the current TODOs and their Hash numbers."
        echo "Save   -> to Save all the TODO's into TODO.txt in the Project01 directory."
    fi
fi
