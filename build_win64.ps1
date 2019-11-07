New-Item -path . -name build -itemtype directory

# change to the build directory
Set-Location .\build

# generate the build files
cmake .. -DCMAKE_TOOLCHAIN_FILE=d:\vcpkg\scripts\buildsystems\vcpkg.cmake -DVCPKG_TARGET_TRIPLET=x64-windows

# run msbuild to build the library
# see https://github.com/Microsoft/vswhere/wiki/Find-MSBuild
# and https://github.com/microsoft/vswhere/wiki/Installing
# for finding msbuild using vswhere (and installing vswhere if does not exist)
$msbuildExe = vswhere -latest -requires Microsoft.Component.MSBuild -find "MSBuild\**\Bin\MSBuild.exe"

&$msbuildExe vcpkg_libarchive_issue_8839.sln

# go back to parent directory
Set-Location ..