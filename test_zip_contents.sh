#!/bin/bash

TOTAL_FILES=0
TOTAL_DIRS=0

check_file ()
{
    local file_name=$(realpath "$1" 2>/dev/null)

    if [ -e ${file_name} ]; then
        echo "     - File Found: $1"
        let TOTAL_FILES=TOTAL_FILES+1
        return 0
    else
        echo "     - File Not Found: $1"
        return 1
    fi
}

check_dir ()
{
    local dir_name=$(realpath "$1" 2>/dev/null)

    if [ -d ${dir_name} ]; then
        echo "  - Directory Found: $1"
        let TOTAL_DIRS=TOTAL_DIRS+1
        return 0
    else
        echo "  - Directory Not Found: $1"
        return 1
    fi
}

check_all ()
{
    echo "Checking Directory: echo"
    if check_dir "echo"; then
        check_file "echo/echo.asm"
    fi

    echo "Summary --------------------------------------------------------"
    echo "Got ${TOTAL_DIRS} out of 1 expected directories"
    echo "Got ${TOTAL_FILES} out of 1 expected files"
}

check_unwanted ()
{
    local count=`find . -type f | xargs -I {} file --mime-type {} | grep -v -E "text" | wc -l`
    local out=`find . -type f | xargs -I {} file --mime-type {} | grep -v -E "text"`

    if [ $count -gt 0 ]; then
        printf "Warining: ${count} unexpected files found:\n${out}\n"
    fi
}

run_test ()
{
    local zip_file=$(realpath "$1")
    local unzip_dir="unzip_$(date +%s)"

    mkdir -p ${unzip_dir}
    pushd ${unzip_dir} 1>/dev/null

    unzip ${zip_file} 1>/dev/null
    check_all
    check_unwanted

    popd 1>/dev/null
    rm -r ${unzip_dir}
}

if [ "$#" -ne 1 ]; then
    echo "Usage: ./test_my_name.sh </path/to/your/submission.zip>"
    exit 1
fi

if [ -e "$1" ]; then
    run_test "$1"
else
    echo "File $1 does not exist"
    exit 1
fi

