# vcpkg_libarchive_issue_8839

This repo has a cmake build to compile and link a libarchive example. The example is taken verbatim from the libarchive docs -> [libarchive: a basic write example](https://github.com/libarchive/libarchive/wiki/Examples#A_Basic_Write_Example)

## Pre-requisites

### Windows
* Install vcpkg and then libarchive:x64-windows
### Linux
* Install vcpkg and then libarchive using vcpkg
* Also for comparision install libarchive-dev (on debian based distro, or equivalent on others)

## Windows build (Works)
1. Edit build_win64.ps1, and change path to vcpkg toolchain
2. run ./build_win64.ps1
3. You should have a successful build with 0 warnings and 0 errors

## Linux build

### Without vcpkg (Works)
0. Ensure libarchive-dev is installed.
1. run ./build_linux_with_pkgconfig.sh
2. Build is successful.

### With vcpkg (FAILS)
0. Delete build directory if exists.
1. Edit build_linux_with_vcpkg.sh and change path to vcpkg toolchain
2. run ./build_linux_with_vcpkg.sh
3. See error during linking

```console
~/code/vcpkg_libarchive_issue_8839$ ./build_linux_with_vcpkg.sh
-- The C compiler identification is GNU 8.3.0
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features
-- Detecting C compile features - done
-- Configuring done
-- Generating done
-- Build files have been written to: /home/abhishek/code/vcpkg_libarchive_issue_8839/build
Scanning dependencies of target vcpkg_libarchive_issue_8839
[ 50%] Building C object CMakeFiles/vcpkg_libarchive_issue_8839.dir/main.c.o
[100%] Linking C executable vcpkg_libarchive_issue_8839
/usr/bin/ld: /home/abhishek/code/vcpkg/installed/x64-linux/debug/lib/libarchive.a(archive_write_add_filter_gzip.c.o): in function `archive_compressor_gzip_open':
/home/abhishek/code/vcpkg/buildtrees/libarchive/src/fa3b23efe3-1e0b785ee8/libarchive/archive_write_add_filter_gzip.c:212: undefined reference to `crc32'
/usr/bin/ld: /home/abhishek/code/vcpkg/buildtrees/libarchive/src/fa3b23efe3-1e0b785ee8/libarchive/archive_write_add_filter_gzip.c:242: undefined reference to `deflateInit2_'
/usr/bin/ld: /home/abhishek/code/vcpkg/installed/x64-linux/debug/lib/libarchive.a(archive_write_add_filter_gzip.c.o): in function `archive_compressor_gzip_write':
/home/abhishek/code/vcpkg/buildtrees/libarchive/src/fa3b23efe3-1e0b785ee8/libarchive/archive_write_add_filter_gzip.c:290: undefined reference to `crc32'
/usr/bin/ld: /home/abhishek/code/vcpkg/installed/x64-linux/debug/lib/libarchive.a(archive_write_add_filter_gzip.c.o): in function `archive_compressor_gzip_close':
/home/abhishek/code/vcpkg/buildtrees/libarchive/src/fa3b23efe3-1e0b785ee8/libarchive/archive_write_add_filter_gzip.c:333: undefined reference to `deflateEnd'
/usr/bin/ld: /home/abhishek/code/vcpkg/installed/x64-linux/debug/lib/libarchive.a(archive_write_add_filter_gzip.c.o): in function `drive_compressor':
/home/abhishek/code/vcpkg/buildtrees/libarchive/src/fa3b23efe3-1e0b785ee8/libarchive/archive_write_add_filter_gzip.c:374: undefined reference to `deflate'
collect2: error: ld returned 1 exit status
make[2]: *** [CMakeFiles/vcpkg_libarchive_issue_8839.dir/build.make:85: vcpkg_libarchive_issue_8839] Error 1
make[1]: *** [CMakeFiles/Makefile2:73: CMakeFiles/vcpkg_libarchive_issue_8839.dir/all] Error 2
make: *** [Makefile:84: all] Error 2
```