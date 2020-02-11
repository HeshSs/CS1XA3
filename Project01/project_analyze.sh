#!/bin/bash

if [ "$1" != "feature" ] || [ "$2" -lt 1 ] 2> /dev/null || [ "$2" -gt 10 ] 2> /dev/null || [[ $2 != ?(-)+([0-9]) ]] ; then
    echo "Usage:"
    echo "  ./CS1XA3/Project01/project_analyze feature feature#"
elif [ "$2" == 1 ] ; then
    echo "Yay, feature 1 works"
elif [ "$2" == 2 ] ; then
    if [[ -e ~/private/CS1XA3/Project01/fixme.log ]] ; then
        echo -n > ~/private/CS1XA3/Project01/fixme.log
    fi
    grep -wRl "#FIXME" ~/private/CS1XA3 | while read -r file; do
          echo "file = $file"
          tail -1 "$file"
          lastline=`tail -1 "$file"`
          if [[ "$lastline" == *"#FIXME"*  ]] ; then
             echo "$file" >> ~/private/CS1XA3/Project01/fixme.log
          fi
    done
elif [ "$2" == 3 ] ; then
    echo "Feature 3"
elif [ "$2" == 4 ] ; then 
    echo "Feature 4"
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
