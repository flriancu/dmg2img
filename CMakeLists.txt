cmake_minimum_required(VERSION 3.20)

if (WIN32)
    if (NOT DEFINED VCPKG_ROOT)
        set(VCPKG_ROOT "$ENV{userprofile}/vcpkg")
    endif()
    set(CMAKE_TOOLCHAIN_FILE "${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" CACHE STRING "")
endif()

project(dmg2img C)

option(HAVE_LZFSE "HAVE_LZFSE" OFF)

if (WIN32)
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
    set(VCPKG_PACKAGES_DIR "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}")
endif()

find_package(ZLIB REQUIRED)
find_package(BZip2 REQUIRED)
find_package(OpenSSL REQUIRED)

if (HAVE_LZFSE)
    find_package(Lzfse REQUIRED)
endif()

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

    target_link_libraries(dmg2img PRIVATE
        Lzfse::Lzfse
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
