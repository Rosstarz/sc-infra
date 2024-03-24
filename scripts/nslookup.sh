#!/bin/bash

inputfile="/tmp/ips.txt"

cat >$inputfile <<!
109.74.196.225
91.189.90.40
94.176.99.133
192.189.99.99
!

func_nslookup() {
    regex="name = (([a-zA-Z0-9\-]+).([a-zA-Z0-9\-]+).([a-zA-Z0-9\-]+).([a-zA-Z0-9\-]*).([a-zA-Z0-9\-]*).)"
    lookup="$(nslookup $1)"
    # echo $lookup
    if [[ $lookup =~ $regex ]]; then
        # echo $BASH_REMATCH
        # echo all: "${BASH_REMATCH[0]}"
        echo "${BASH_REMATCH[1]}"
        # echo "${BASH_REMATCH[2]}"
        # echo "${BASH_REMATCH[3]}"
        # echo "${BASH_REMATCH[4]}"
        # echo "${BASH_REMATCH[5]}"
        # echo "${BASH_REMATCH[6]}"
    else
        return 0
    fi
}

# cat $inputfile

while read -r line; do
    # echo $line
    # func_nslookup $line
    result=$(func_nslookup $line)
    # echo $result
    if [[ -z $result ]];then
        echo "IP: $line - Did not resolve"
    else
        echo "IP: $line - Name: $result"
    fi
done <$inputfile

# echo DONE
