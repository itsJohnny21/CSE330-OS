## CSE330 Project-2 Kernel Module and System Call

In this directory, there are two scripts available for student testing convenience.

### [test_my_name.sh](https://github.com/visa-lab/CSE330-OS/blob/project-2/test_my_name.sh)

This script can be used to test your kernel module. It will do the following:

1. Compile your kernel module
2. Run `insmod my_name.ko` on the resulting kernel object, providing arguments for `intParameter` and `charParameter`
3. Examine the output by running `dmesg` and looking for the expected output
4. Remove your kernel module and ensure the module unloaded gracefully

Once the script is done running, it will inform you of your total point count out of 50 for the `my_name` section of the rubric.

#### Usage and expected output:

Usage:
```bash
./test_my_name.sh <path to directory containing my_name.c and Makefile>
```

Expected Output:
```
Loading kernel module with module params: charParameter="Fall" intParameter=2024
 - expected dmesg output: [ 2377.841074] Hello, I am Linus Torvalds, a student of CSE330 Fall 2024.
Removing kernel module
Final Score (my_name): 50 / 50
```

Note: This does not show complete grade points for the project . Please refer to the project document for more details.


### [test_zip_contents.sh](https://github.com/visa-lab/CSE330-OS/blob/project-2/test_zip_contents.sh)

This script can be used to ensure your final submission adheres to the directory structure specified in the project document. It will do the following:

1. Unzip your submission into a directory `unzip_<unix timestamp>/`
2. The script will check for all of the expected directories
3. The script will check for all of the expected files within each directory
4. The script will ensure you did not include any binaries or kernel objects
5. The script will remove the directory it created `unzip_<unix timestamp>/`

Once the script is done running, it will inform you of the correctness of your directory structure by showing how many expected files and directories it was able to locate.

#### Usage and expected output:

Usage:
```bash
./test_zip_contents.sh <path to Project-2-ASUID.zip>
```

Expected Output:
```
Checking Directory: kernel_module
  - Directory Found: kernel_module
     - File Found: kernel_module/my_name.c
     - File Found: kernel_module/Makefile
Checking Directory: kernel_syscall
  - Directory Found: kernel_syscall
     - File Found: kernel_syscall/my_syscall.c
     - File Found: kernel_syscall/Makefile
Checking Directory: userspace
  - Directory Found: userspace
     - File Found: userspace/syscall_in_userspace_test.c
Checking Directory: screenshots
  - Directory Found: screenshots
     - File Found: screenshots/syscall_output.png
Summary --------------------------------------------------------
Got 4 out of 4 expected directories
Got 6 out of 6 expected files
```

## Note: 
- Please do not make any changes in provided test code to pass the test cases.
- You can use print statements in case you want to debug and understand the logic of the test code.
- Please get in touch with the TAs if you face issues in using the test scripts.
