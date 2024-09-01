#Write a script that reads a text file and counts the occurrences of each word, display the top 5 most frequent words along with their counts.
#!/bin/bash

# Check if a file name is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 filename"
  exit 1
fi

# Read the file and count the occurrences of each word
# Convert all words to lowercase, remove punctuation, sort them, count occurrences, and sort by frequency
awk '{ 
    for(i=1;i<=NF;i++) { 
        word=tolower($i); 
        gsub(/[^a-zA-Z0-9]/, "", word); 
        if (length(word) > 0) 
            print word 
    } 
}' "$1" |
sort |
uniq -c |
sort -nr |
head -n 5
