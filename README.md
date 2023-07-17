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

    dmg2img [-l] [-p N] [-s] [-v] [-V] [-d] <input.dmg> [<output.img>]
    dmg2img -i <input.dmg> -o <output.img>

### Notes

-   An equivalent command under Mac OS X would be:

        hdiutil convert <input.dmg> -format UDTO -o <output.img>

-   Under Linux, the image disk file can be mounted with the commands:

        modprobe hfsplus
        mount -t hfsplus -o loop <output.img> /mnt

-   Windows users can open the image disk file as follows:
    -   For pre-10 versions, with UltraISO
    -   For 10 and newer, directly


## Build

### Windows and Linux via vcpkg

-   Get vcpkg:
    ```
    git clone https://github.com/microsoft/vcpkg
    ```

-   Install vcpkg:
    -   Windows:
        ```
        .\vcpkg\bootstrap-vcpkg.bat
        ```
    -   Linux:
        ```
        ./vcpkg/bootstrap-vcpkg.sh
        ```

-   Build the project:
    -   Windows:
        ```
        cmake -S . -B build-windows -D VCPKG_ROOT=<...>
        cmake --build build-windows --config Release
        ```
        Note: you can skip `-D VCPKG_ROOT=<...>` if vcpkg is installed in `%userprofile%`
    -   Linux:
        ```
        cmake -S . -B build-linux -D CMAKE_BUILD_TYPE=Release -D VCPKG_ROOT=<...>
        cmake --build build-linux
        ```
        Note: you can skip `-D VCPKG_ROOT=<...>` if vcpkg is installed in `$HOME`


### Linux

-   Install the following dependencies:
    ```
    libssl-dev zlib1g-dev libbz2-dev
    ```

-   Build the project:
    ```
    cmake -S . -B build-linux -D CMAKE_BUILD_TYPE=Release
    cmake --build build-linux
    ```


### Additional options

-   LZFSE decompression support requires the lzfse library. To build the application with LZFSE support:

    -   If not using vcpkg, install the library manually:
        ```
        git clone https://github.com/lzfse/lzfse
        cd lzfse
        sudo make install
        ```
    -   Add the following to the cmake generation step:
        ```
        -D HAVE_LZFSE=ON
        ```

-   To build the application with Address Sanitizer for debugging purposes:
    -   Add the following to the cmake generation step:
        ```
        -D CMAKE_C_COMPILER=clang -D HAVE_ASAN=ON
        ```
