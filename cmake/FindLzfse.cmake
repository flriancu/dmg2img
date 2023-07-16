#   Locate the lzfse library.
#
#   This module optionally takes as input the root path of the lzfse directory.
#   This root path can be specified by setting a cmake variable called LZFSE_DIR.

if (NOT LZFSE_DIR)
    set(LZFSE_DIR "" CACHE PATH "lzfse directory")
endif()

find_path(Lzfse_INCLUDE_DIR
    NAMES lzfse.h
    HINTS ${LZFSE_DIR} /usr/local "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}"
    PATH_SUFFIXES include
)

find_library(Lzfse_LIBRARY
    NAMES lzfse.lib liblzfse.a
    HINTS ${LZFSE_DIR} /usr/local "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}"
    PATH_SUFFIXES lib
    NO_DEFAULT_PATH
)

if (WIN32)
    find_file(Lzfse_LIBRARY_SHARED
        NAMES lzfse.dll
        HINTS ${LZFSE_DIR} "${VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}"
        PATH_SUFFIXES bin
        NO_DEFAULT_PATH
    )
    find_package_handle_standard_args(Lzfse
        REQUIRED_VARS Lzfse_INCLUDE_DIR Lzfse_LIBRARY Lzfse_LIBRARY_SHARED
    )
else()
    find_package_handle_standard_args(Lzfse
        REQUIRED_VARS Lzfse_INCLUDE_DIR Lzfse_LIBRARY
    )
endif()

if (Lzfse_FOUND)
    mark_as_advanced(Lzfse_INCLUDE_DIR)
    mark_as_advanced(Lzfse_LIBRARY)
    if (WIN32)
        mark_as_advanced(Lzfse_LIBRARY_SHARED)
    endif()
endif()

if (Lzfse_FOUND AND NOT TARGET Lzfse::Lzfse)
    if (WIN32)
        add_library(Lzfse::Lzfse
            IMPORTED SHARED
        )
        set_target_properties(Lzfse::Lzfse PROPERTIES
            IMPORTED_IMPLIB ${Lzfse_LIBRARY}
            IMPORTED_LOCATION ${Lzfse_LIBRARY_SHARED}
        )
    else()
        add_library(Lzfse::Lzfse
            IMPORTED STATIC
        )
        set_target_properties(Lzfse::Lzfse PROPERTIES
            IMPORTED_LOCATION ${Lzfse_LIBRARY}
        )
    endif()

    target_include_directories(Lzfse::Lzfse
        INTERFACE ${Lzfse_INCLUDE_DIR}
    )
endif()
