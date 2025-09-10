cmake_minimum_required(VERSION 3.18)
project(mod_audio_fork
        VERSION 1.0.0
        DESCRIPTION "Audio fork module for FreeSWITCH."
        HOMEPAGE_URL "https://github.com/mdslaney/drachtio-freeswitch-modules")

include(GNUInstallDirs)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_SHARED_LIBRARY_PREFIX "")
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -g")

# Nếu freeswitch cài ở /usr/local thì set PKG_CONFIG_PATH
set(ENV{PKG_CONFIG_PATH} "/usr/local/freeswitch/lib/pkgconfig:$ENV{PKG_CONFIG_PATH}")

find_package(PkgConfig REQUIRED)
find_package(OpenSSL REQUIRED)
find_package(ZLIB REQUIRED)

pkg_check_modules(FreeSWITCH REQUIRED IMPORTED_TARGET freeswitch)
pkg_get_variable(FS_MOD_DIR freeswitch modulesdir)
message(STATUS "FreeSWITCH modules dir: ${FS_MOD_DIR}")

add_library(mod_audio_fork SHARED
    mod_audio_fork.c
    mod_audio_fork.h
    audio_pipe.cpp
    audio_pipe.hpp
    parser.cpp
    parser.hpp
    lws_glue.cpp
    lws_glue.h
    base64.hpp
)

set_property(TARGET mod_audio_fork PROPERTY POSITION_INDEPENDENT_CODE ON)

target_link_libraries(mod_audio_fork PRIVATE PkgConfig::FreeSWITCH pthread websockets ssl z)

install(TARGETS ${PROJECT_NAME}
        COMPONENT ${PROJECT_NAME}
        DESTINATION ${FS_MOD_DIR})
