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
    if [[ -e ~/private/CS1XA3/Project01/fixme.log ]] ; then
        echo -n > ~/private/CS1XA3/Project01/fixme.log
    fi
    grep -wRl "#FIXME" ~/private/CS1XA3 | while read -r file; do
          lastline=`tail -1 "$file"` 2> /dev/null
          if [[ "$lastline" == *"#FIXME"*  ]] ; then
             echo "$file" >> ~/private/CS1XA3/Project01/fixme.log
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
    grep -Rw --include=\*.$ext "" ~/private/CS1XA3/ | wc -l

# Feature 6
elif [ "$1" == "feature" ] && [ "$2" == 6 ] ; then
    read -p "Enter a TAG (i.e Any single word): " tag
    if [[ -n $tag ]] ; then 
        echo "--$tag--"
        if [[ -e ~/private/CS1XA3/Project01/${tag}.log ]] ; then
            echo -n > ~/private/CS1XA3/Project01/${tag}.log
        fi
        
        printed="false"
        grep -Rh --include=\*.py '^#' ~/private/CS1XA3/ | while read -r line; do
            if [[ "$line" == *"$tag"*  ]] ; then
                echo "$line" >> ~/private/CS1XA3/Project01/${tag}.log
                if [ $printed != "true" ] ; then
                    echo "File ${tag}.log was successfully created in the Project01 directory."
                    printed="true"
                fi
            fi
        done
    fi

# Feature 7
elif [ "$1" == "feature" ] && [ "$2" == 7 ] ; then
    echo "Feature 7"

# Custom Feature 1
elif [ "$1" == "custom_feature" ] && [ "$2" == 1 ] ; then
    echo "Custom Feature 1"

# Custom Feature 2
elif [ "$1" == "custom_feature" ] && [ "$2" == 2 ] ; then
    echo "Custom Feature 2"
fi
