#!/bin/bash

# !!! DO NOT MOVE THIS FILE !!!
source utils.sh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

run_test ()
{
    local zip_file=$(realpath "$1")
    local unzip_dir="unzip_$(date +%s)"

    mkdir -p ${unzip_dir}
    pushd ${unzip_dir} 1>/dev/null
    unzip ${zip_file} 1>/dev/null
    echo "Unzipping to \"${unzip_dir}\""

    if check_resubmission; then
        echo "[P1 Resubmit]: Passed"
    else
        echo -e "[P1 Resubmit]: failed because:${RESUBMIT_ERR}"
    fi

    popd 1>/dev/null
    rm -r ${unzip_dir}
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

echo "NOTE: This script is only meant for testing P1 resubmission"

if [ "$#" -ne 1 ]; then
    echo "Zip using this command: zip -r Project-2-ASUID.zip kernel_module/ kernel_syscall/ userspace/ screenshots/ Project1/"
    echo "Run the script using this command: ./test_resubmission.sh /path/to/your/submission.zip"
    exit 1
fi

if [ -e "$1" ]; then
    run_test "$1"
else
    echo "File $1 does not exist"
    exit 1
fi
