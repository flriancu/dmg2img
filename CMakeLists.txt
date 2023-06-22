cmake_minimum_required(VERSION 3.20)

project(dmg2img C)

option(HAVE_LZFSE "HAVE_LZFSE" OFF)

find_package(ZLIB REQUIRED)
find_package(BZip2 REQUIRED)
find_package(OpenSSL REQUIRED)

#-------------------------------------------------------------------------------
#   dmg2img
#-------------------------------------------------------------------------------

add_executable(dmg2img)

target_sources(dmg2img PRIVATE
    src/adc.h
    src/base64.h
    src/dmg2img.h
    src/gpt.h
    src/mntcmd.h
    src/platform.h
    src/adc.c
    src/base64.c
    src/dmg2img.c
)

target_link_libraries(dmg2img PRIVATE
    ZLIB::ZLIB
    BZip2::BZip2
)

if (HAVE_LZFSE)
    target_compile_definitions(dmg2img PRIVATE
        HAVE_LZFSE
    )
endif()

#-------------------------------------------------------------------------------
#   vfdecrypt
#-------------------------------------------------------------------------------

add_executable(vfdecrypt)

target_sources(vfdecrypt PRIVATE
    src/vfdecrypt.h
    src/vfdecrypt.c
)

target_link_libraries(vfdecrypt PRIVATE
    OpenSSL::Crypto
)

if (WIN32)
    target_sources(vfdecrypt PRIVATE
        src/win/getopt.h
        src/win/getopt.c
    )

    target_include_directories(vfdecrypt PRIVATE
        src/win
    )

    target_link_libraries(vfdecrypt PRIVATE
        ws2_32
    )
endif()
