#!/bin/bash

temp_path=/tmp/myrandomfiles
match=" "
replace="_"

help() {
    echo "Usage: cutspace.sh [OPTION].. [ARGUMENT].."
    echo "Options:"
    echo " -d, --default               use deafult path $temp_path"
    echo " -f, --folder                specify path to temp folder"
    # echo " -m, --match                 specify match string"
    # echo " -r, --replace               specify replace string"
}

# Checking input arguments
if [ "$#" -eq 0 ]; then
    echo -e "\aNo path to temp folder specified!"
    help
    exit 1
fi

# Checking input argument - temp folder specific
if [ "$1" == "-f" ]; then
    if [ ! -d "$2" ]; then
        echo -e "\aSpecified path is not a valid directory!"
        exit 1
    else
        temp_path="$2"
    fi
fi

#####################################

renamefiles() {
    echo "Renaming files.."
    for file in "$temp_path"/*; do
        if [[ -e $file ]]; then
            # Get base filename from path (so we dont match and replace strings in full path)
            filename=$(basename "$file")
            # Match and replace strings in filename
            newname=$(echo "$filename" | sed "s/${match}/${replace}/g")
            newfile="$temp_path/$newname"
            mv "$file" "$newfile"
            echo "- $newfile"
        fi
    done
    echo "Successfully renamed all files"
}

displayfiles() {
    read -p "Do you want to display the files? (y/n) " yn

    case $yn in
    y)
        echo "Output of 'ls -al $temp_path':"
        ls -al "$temp_path"
        ;;
    *) ;;
    esac
}

removefolder() {
    read -p "Do you want to remove the folder now? (y/n) " yn

    case $yn in
    y)
        rm -r "$temp_path"
        echo "Successfully removed all files"
        ;;
    *) echo "Not removing" ;;
    esac
}

#####################################
# Script START

renamefiles
displayfiles
removefolder

# Script END
#####################################
# echo DONE
