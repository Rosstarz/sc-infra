#!/bin/bash

temp_path=/tmp/myrandomfiles
file_amount=10
max_filename_length=6

checkexist() {
    if [[ -d "${temp_path}" ]];then
        return 0
    else
        return 1
    fi
}

createfolder() {
    echo "Creating temporary folder.."
    # Find available folder to create
    while checkexist "${temp_path}" ;do
        # echo "exists"
        temp_path="${temp_path}_1"
    done
    mkdir $temp_path
    echo "Folder created at $temp_path"
}

createfiles() {
    echo "Creating $file_amount random files.."
    for (( i=1; i<=$file_amount; i++ )); do
        # Create files with random length between 2 and $max_filename_length
        length=$(( $RANDOM % $max_filename_length + 2 ))
        filename="$temp_path/"
        for (( j=0; j<=$length; j++ )); do
            if [[ $j == $length ]];then
                filename="$filename$RANDOM"
            else
                filename="$filename$RANDOM "
            fi
        done
        echo "- $filename"
        touch "$filename"
    done
    echo "Successfully created $file_amount files"
}

#####################################
# Script START

createfolder
createfiles
echo "Temp folder: $temp_path"

# Script END
#####################################
# echo "DONE"