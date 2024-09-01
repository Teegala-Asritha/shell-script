#!/bin/bash

# Check if a file name is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 filename"
  exit 1
fi

# Read the file and transpose its content
awk '
{
    for (i = 1; i <= NF; i++)  {
        a[NR,i] = $i
    }
    if(NF>p) 
        p = NF
}
NF>0 {r = NR}
END {
    for(i = 1; i <= p; i++) {
        for(j = 1; j <= r; j++) {
            printf("%s ", a[j,i])
        }
        print ""
    }
}' $1
