#!/bin/bash
set
if [ $# -ge 2 ]; then
    if [ -e $1.tar ]; then
        read -p "Name of this archive already exists. Do you want to overwrite? [y/n]: " answer

        if [[ $answer == "y" ]]; then
            echo "Ok, let's go."
        else
            echo "Ok, let's try again."
            exit 0
        fi
    fi
    archive_name=$1
    shift
    data=$@
    archive=${archive_name}.tar
    echo "Data for archivisation: ${data}"
    tar -cf ${archive} ${data}
    read -p "Please choose tool for compression: gzip - type 0, bzip - type 1 [0/1]" answer
        if [[ $answer == 0 ]]; then
            gzip ${archive}
        elif [[ $answer == 1 ]]; then
            bzip2 ${archive}
        else
            echo "Ups... something went wrong. Let's try again."
            exit 1
        fi
    echo "Process of archivisation and compression was successfully finished."

else
    echo "You've forgot type list of files/folders for archivisation."
    exit 0

fi