# dmg2img

## Introduction

`dmg2img` is a tool which allows converting Apple compressed dmg
archives to standard (hfsplus) image disk files.

This tool handles zlib, bzip2, and LZFSE compressed DMG images.

The original author is vu1tur, <http://vu1tur.eu.org/dmg2img>. This Git
repository is maintained by Peter Wu at <https://github.com/Lekensteyn/dmg2img>
based on imported tarballs. It includes bug and security fixes and further
enhancements.


## Usage

See the [USAGE.md](USAGE.md) file for usage and platform-specific instructions to
open or mount the resulting output file.


## Building

### Windows

The Windows build requires vcpkg, which you can install as follows:

    git clone https://github.com/microsoft/vcpkg
    .\vcpkg\bootstrap-vcpkg.bat

You can then build the application as follows:

    cmake -S . -B build-windows -D VCPKG_ROOT=<...>
    cmake --build build-windows --config Release

You can skip `-D VCPKG_ROOT=<...>` if vcpkg is installed in `%userprofile%` .


### Linux

Install the following dependencies:

    libssl-dev zlib1g-dev libbz2-dev

You can then build the application as follows:

    cmake -S . -B build-linux -D CMAKE_BUILD_TYPE=Release
    cmake --build build-linux


### Additional options

-   LZFSE decompression support requires the LZFSE library which can be found at
<https://github.com/lzfse/lzfse/>. As this library is not widely available on
Linux distributions, it is not enabled by default.

    To build the application with LZFSE support, add the following to the cmake generation step:

        -D HAVE_LZFSE=ON

-   To build the application with Address Sanitizer for debugging purposes, add the following to the cmake generation step:

        -D CMAKE_C_COMPILER=clang -D HAVE_ASAN=ON
