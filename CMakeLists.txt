cmake_minimum_required ( VERSION 3.9 )

project ( vcpkg_libarchive_issue_8839 C )

# Set the project source dir (just convention)
set( VCPKG_LIBARCHIVE_ISSUE_8839_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR} )
set( VCPKG_LIBARCHIVE_ISSUE_8839_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR} )

# It's useful to setup the current version of our code in the build system
# using a `semver` style
set ( VCPKG_LIBARCHIVE_ISSUE_8839_VERSION_MAJOR 1 )
set ( VCPKG_LIBARCHIVE_ISSUE_8839_VERSION_MINOR 0 )
set ( VCPKG_LIBARCHIVE_ISSUE_8839_VERSION_PATCH 0 )

# Lists
# Setup the list of source files
set( VCPKG_LIBARCHIVE_ISSUE_8839_SOURCES
  main.c
)

option(ENABLE_PKG_CONFIG_FOR_LINUX "Use pkg-config for linux instead of vcpkg toolchain" OFF)

if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux" AND ENABLE_PKG_CONFIG_FOR_LINUX)
	message(STATUS ">>> Linux, using pkg-config since vcpkg is broken")
	find_package(PkgConfig REQUIRED)
	pkg_check_modules(archive REQUIRED IMPORTED_TARGET libarchive)
endif()

add_executable( ${PROJECT_NAME} ${VCPKG_LIBARCHIVE_ISSUE_8839_SOURCES} )

set_property(TARGET ${PROJECT_NAME} PROPERTY C_STANDARD 11)

if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux" AND ENABLE_PKG_CONFIG_FOR_LINUX)
	target_link_libraries(${PROJECT_NAME} PUBLIC archive)
else()
	# To find and use libarchive, as the vcpkg build does not have cmake config
	find_path(LIBARCHIVE_INCLUDE_DIR archive.h)
	find_library(LIBARCHIVE_LIBRARY archive)
	include_directories(${LIBARCHIVE_INCLUDE_DIR})
	target_link_libraries(${PROJECT_NAME} PUBLIC ${LIBARCHIVE_LIBRARY})
endif()