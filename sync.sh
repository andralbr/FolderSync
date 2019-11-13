#!/bin/bash

echo Hello World

FILES=`find . -name "*.cpp"`

SyncFolder="../folder1"

syncOnlyIfNewer=true

FILETYPES=".cpp .h .txt"


for type in ${FILETYPES}
do
    echo ------------------------------
    echo Synchronizing "$type" - files
    echo ------------------------------
    FINDCOMMAND="find . -name \"*${type}\""
    FILES=$(eval "$FINDCOMMAND")
    #echo $FILES

    for file in ${FILES}
    do
        filename=`basename $file`
        SyncFile=`find $SyncFolder -name $filename`

        # calculating number of files in sync find pattern
        myString="cool string"
        SyncCount=( $SyncFile )
        numberFiles=${#SyncCount[@]}
        #echo the number of files is $numberFiles

        if [ "$syncOnlyIfNewer" = true ]
        then
            if [ "$numberFiles" = 1 ] 
            then
                if [ "$SyncFile" -nt "$file" ]
                then
                    echo [updated] "$filename"
                else
                    echo [no newer file] "$filename"
                fi
            elif [ "$numberFiles" = 0 ]
            then
                echo [no sync file] "$filename"    
            else
                echo [multiple matches] "$filename"
            fi
        fi 
    done

done

