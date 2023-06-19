cmake_minimum_required(VERSION 3.15)

project(dmg2img C)

option(HAVE_LZFSE "HAVE_LZFSE" OFF)

find_package(ZLIB REQUIRED)
find_package(BZip2 REQUIRED)
find_package(OpenSSL REQUIRED)

set(dmg2img_HEADERS
    src/adc.h
    src/base64.h
    src/dmg2img.h
    src/gpt.h
    src/mntcmd.h
    src/platform.h)

set(dmg2img_SOURCES
    src/adc.c
    src/base64.c
    src/dmg2img.c)

add_executable(dmg2img
    ${dmg2img_HEADERS}
    ${dmg2img_SOURCES})

if (HAVE_LZFSE)
    target_compile_definitions(dmg2img PRIVATE
        HAVE_LZFSE)
endif()

target_link_libraries(dmg2img PRIVATE
    ZLIB::ZLIB
    BZip2::BZip2)

set_source_files_properties(${dmg2img_HEADERS} PROPERTIES
    HEADER_FILE_ONLY TRUE)

set(vfdecrypt_HEADERS
    src/vfdecrypt.h)

if (WIN32)
    set(vfdecrypt_HEADERS ${vfdecrypt_HEADERS}
        src/win/getopt.h)
endif()

set(vfdecrypt_SOURCES
    src/vfdecrypt.c)

if (WIN32)
    set(vfdecrypt_SOURCES ${vfdecrypt_SOURCES}
        src/win/getopt.c)
endif()

add_executable(vfdecrypt
    ${vfdecrypt_HEADERS}
    ${vfdecrypt_SOURCES})

if (WIN32)
    target_include_directories(vfdecrypt PRIVATE
        src/win)

    target_link_libraries(vfdecrypt PRIVATE
        ws2_32)
endif()

target_link_libraries(vfdecrypt PRIVATE
    OpenSSL::Crypto)

set_source_files_properties(${vfdecrypt_HEADERS} PROPERTIES
    HEADER_FILE_ONLY TRUE)
