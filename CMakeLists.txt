cmake_minimum_required(VERSION 3.22)

#-------------------------------------------------------------------------------
#   vcpkg setup
#-------------------------------------------------------------------------------

if (NOT DEFINED VCPKG_ROOT)
    if (WIN32)
        set(VCPKG_ROOT "$ENV{userprofile}/vcpkg")
    else()
        set(VCPKG_ROOT "$ENV{HOME}/vcpkg")
    endif()
endif()

if (EXISTS "${VCPKG_ROOT}")
    set(VCPKG_TOOLCHAIN_FILE "${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")

    if (EXISTS "${VCPKG_TOOLCHAIN_FILE}")
        set(CMAKE_TOOLCHAIN_FILE "${VCPKG_TOOLCHAIN_FILE}" CACHE STRING "")
        message("-- Using vcpkg")
    endif()
endif()

#-------------------------------------------------------------------------------
#   project setup
#-------------------------------------------------------------------------------

project(dmg2img C)

option(HAVE_LZFSE "HAVE_LZFSE" OFF)
option(HAVE_ASAN "HAVE_ASAN" OFF)

find_package(ZLIB REQUIRED)
find_package(BZip2 REQUIRED)
find_package(OpenSSL REQUIRED)

if (HAVE_LZFSE)
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
    find_package(Lzfse REQUIRED)
endif()

#-------------------------------------------------------------------------------
#   target dmg2img
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

if (HAVE_ASAN)
    target_compile_options(dmg2img PRIVATE
        -fsanitize=address
    )

    target_link_options(dmg2img PRIVATE
        -fsanitize=address
    )
endif()

if (HAVE_LZFSE)
    target_compile_definitions(dmg2img PRIVATE
        HAVE_LZFSE
    )

    target_link_libraries(dmg2img PRIVATE
        Lzfse::Lzfse
    )
endif()

#-------------------------------------------------------------------------------
#   target vfdecrypt
#-------------------------------------------------------------------------------

add_executable(vfdecrypt)

target_sources(vfdecrypt PRIVATE
    src/vfdecrypt.h
    src/vfdecrypt.c
)

target_link_libraries(vfdecrypt PRIVATE
    OpenSSL::Crypto
)

if (HAVE_ASAN)
    target_compile_options(vfdecrypt PRIVATE
        -fsanitize=address
    )

    target_link_options(vfdecrypt PRIVATE
        -fsanitize=address
    )
endif()

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
