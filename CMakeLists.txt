cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(UANTLR VERSION 0.0.1)
message(STATUS "[Project] ${PROJECT_NAME}")

include(FetchContent)
message(STATUS "find package: UCMake 0.5.3")
find_package(UCMake 0.5.3 QUIET)
if(NOT UCMake_FOUND)
  message(STATUS "UCMake 0.5.3 not found")
  set(_address "https://github.com/Ubpa/UCMake")
  message(STATUS "fetch: ${_address} with tag 0.5.3")
  FetchContent_Declare(
  UCMake
  GIT_REPOSITORY ${_address}
  GIT_TAG "0.5.3"
  )
  FetchContent_MakeAvailable(UCMake)
  message(STATUS "UCMake 0.5.3 build done")
endif()

Ubpa_InitProject()

# ref: ANTLR4 c++ runtime
if(MSVC)
  set(ANTLR_CXX_WARNING_FLAGS "  /W4")
else()
  set(ANTLR_CXX_WARNING_FLAGS "  -Wall -pedantic -W")
endif()

set(CMAKE_CXX_FLAGS                  "${CMAKE_CXX_FLAGS} ${MY_CXX_WARNING_FLAGS}")
if(MSVC_VERSION)
  set(CMAKE_CXX_FLAGS_DEBUG          "${CMAKE_CXX_FLAGS_DEBUG} /Od /Zi /MP ${MY_CXX_WARNING_FLAGS}")
  set(CMAKE_CXX_FLAGS_MINSIZEREL     "${CMAKE_CXX_FLAGS_MINSIZEREL} /O1 /Oi /Ob2 /Gy /MP /DNDEBUG ${MY_CXX_WARNING_FLAGS}")
  set(CMAKE_CXX_FLAGS_RELEASE        "${CMAKE_CXX_FLAGS_RELEASE} /O2 /Oi /Ob2 /Gy /MP /DNDEBUG ${MY_CXX_WARNING_FLGAS}")
  set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} /O2 /Oi /Ob2 /Gy /MP /Zi ${MY_CXX_WARNING_FLAGS}")
else()
  set(CMAKE_CXX_FLAGS_DEBUG          "${CMAKE_CXX_FLAGS_DEBUG} -O0 -g ${MY_CXX_WARNING_FLAGS}")
  set(CMAKE_CXX_FLAGS_MINSIZEREL     "${CMAKE_CXX_FLAGS_MINSIZEREL} -Os -DNDEBUG ${MY_CXX_WARNING_FLAGS}")
  set(CMAKE_CXX_FLAGS_RELEASE        "${CMAKE_CXX_FLAGS_RELEASE} -O3 -DNDEBUG ${MY_CXX_WARNING_FLGAS}")
  set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} -O2 -g ${MY_CXX_WARNING_FLAGS}")
endif()

# Compiler-specific C++11 activation.
if("${CMAKE_CXX_COMPILER_ID}" MATCHES "GNU" OR "${CMAKE_CXX_COMPILER_ID}" MATCHES "Intel")
  execute_process(
    COMMAND ${CMAKE_CXX_COMPILER} -dumpversion OUTPUT_VARIABLE GCC_VERSION)
  # Just g++-5.0 and greater contain <codecvt> header. (test in ubuntu)
  if(NOT (GCC_VERSION VERSION_GREATER 5.0 OR GCC_VERSION VERSION_EQUAL 5.0))
    message(FATAL_ERROR "${PROJECT_NAME} requires g++ 5.0 or greater.")
  endif ()
elseif ("${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang" AND ANDROID) 
	# Need -Os cflag and cxxflags here to work with exception handling on armeabi.
	# see  https://github.com/android-ndk/ndk/issues/573
	# and without -stdlib=libc++ cxxflags
elseif ("${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang" AND APPLE)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++")
elseif ("${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang" AND ( CMAKE_SYSTEM_NAME MATCHES "Linux" OR CMAKE_SYSTEM_NAME MATCHES "FreeBSD") )
  execute_process(
    COMMAND ${CMAKE_CXX_COMPILER} -dumpversion OUTPUT_VARIABLE CLANG_VERSION)
  if(NOT (CLANG_VERSION VERSION_GREATER 4.2.1 OR CLANG_VERSION VERSION_EQUAL 4.2.1))
    message(FATAL_ERROR "${PROJECT_NAME} requires clang 4.2.1 or greater.")
  endif()
  # You can use libc++ to compile this project when g++ is NOT greater than or equal to 5.0.
  if(WITH_LIBCXX)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
  endif()
elseif(MSVC_VERSION GREATER 1800 OR MSVC_VERSION EQUAL 1800)
  # Visual Studio 2012+ supports c++11 features 
elseif(CMAKE_SYSTEM_NAME MATCHES "Emscripten")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++")
else()
  message(FATAL_ERROR "Your C++ compiler does not support C++11.")
endif()

if(CMAKE_C_COMPILER_ID MATCHES "MSVC")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -wd4996")
endif()

Ubpa_AddSubDirsRec(src)

# install
Ubpa_PackageName(package_name)

configure_package_config_file(
  config/antlr4-generator.cmake.in
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}GeneratorConfig.cmake"
  INSTALL_DESTINATION "${package_name}/cmake"
  NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO )

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}GeneratorConfigVersion.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMinorVersion )

install(FILES
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}GeneratorConfig.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}GeneratorConfigVersion.cmake"
  "config/Antlr4Package.md"
  "config/README.md"
  "config/_deps/antlr-4.8-complete.jar"
  DESTINATION "${package_name}/cmake"
)

Ubpa_Export(DIRECTORIES "include")
