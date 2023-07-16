#   Locate the lzfse library.
#
#   This module optionally takes as input the root path of the lzfse directory.
#   This root path can be specified by setting a cmake variable called LZFSE_DIR.

if (NOT LZFSE_DIR)
    set(LZFSE_DIR "" CACHE PATH "lzfse directory")
endif()

find_path(Lzfse_INCLUDE_DIR
    NAMES           lzfse.h
    HINTS           ${LZFSE_DIR}
    PATH_SUFFIXES   include
)

find_library(Lzfse_LIBRARY
    NAMES           lzfse.lib
    HINTS           ${LZFSE_DIR}/lib
    NO_DEFAULT_PATH
)

find_file(Lzfse_LIBRARY_SHARED
    NAMES           lzfse.dll
    HINTS           ${LZFSE_DIR}/bin
    NO_DEFAULT_PATH
)

find_package_handle_standard_args(Lzfse
    REQUIRED_VARS   Lzfse_INCLUDE_DIR Lzfse_LIBRARY Lzfse_LIBRARY_SHARED
)

if (Lzfse_FOUND)
    mark_as_advanced(Lzfse_INCLUDE_DIR)
    mark_as_advanced(Lzfse_LIBRARY)
endif()

if (Lzfse_FOUND AND NOT TARGET Lzfse::Lzfse)
    add_library(Lzfse::Lzfse IMPORTED SHARED)

    set_target_properties(Lzfse::Lzfse PROPERTIES
        IMPORTED_IMPLIB ${Lzfse_LIBRARY}
        IMPORTED_LOCATION ${Lzfse_LIBRARY_SHARED}
    )

    target_include_directories(Lzfse::Lzfse
        INTERFACE ${Lzfse_INCLUDE_DIR})
endif()
