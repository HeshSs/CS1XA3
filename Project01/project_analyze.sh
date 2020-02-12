#!/bin/bash

if [ "$1" != "feature" ] || [ "$2" -lt 2 ] 2> /dev/null || [ "$2" -gt 10 ] 2> /dev/null || [[ $2 != ?(-)+([0-9]) ]] ; then
    echo "Usage:"
    echo "  ./Project01/project_analyze feature feature#"
elif [ "$2" == 2 ] ; then
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
elif [ "$2" == 3 ] ; then
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
elif [ "$2" == 4 ] ; then 
    ls ~/private/CS1XA3 -aRlh | grep '^-' | sort -k 5 -rh | awk 'BEGIN {  print "Size Filename" 
                                                                          print "---- --------" } 
                                                                       {  print $5, $9 }'
elif [ "$2" == 5 ] ; then
    echo "Feature 5"
elif [ "$2" == 6 ] ; then
    echo "Feature 6"
elif [ "$2" == 3 ] ; then
    echo "Feature 7"
elif [ "$2" == 8 ] ; then
    echo "Feature 8"
elif [ "$2" == 9 ] ; then
    echo "Feature 9"
elif [ "$2" == 10 ] ; then
    echo "Feature 10"
fi
