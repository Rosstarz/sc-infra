#!/bin/bash

echo hi

temp_path=/tmp/myrandomfiles

for file in "$temp_path"/*;do
    file=$(basename "$file")
    echo $temp_path/$file
done