cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(UANTLR VERSION 0.0.3)
message(STATUS "[Project] ${PROJECT_NAME}")

include(FetchContent)
set(UCMake_VERSION 0.5.4)
message(STATUS "find package: UCMake ${UCMake_VERSION}")
find_package(UCMake ${UCMake_VERSION} QUIET)
if(NOT UCMake_FOUND)
  message(STATUS "UCMake ${UCMake_VERSION} not found")
  set(_address "https://github.com/Ubpa/UCMake")
  message(STATUS "fetch: ${_address} with tag ${UCMake_VERSION}")
  FetchContent_Declare(
  UCMake
  GIT_REPOSITORY ${_address}
  GIT_TAG ${UCMake_VERSION}
  )
  FetchContent_MakeAvailable(UCMake)
  message(STATUS "UCMake ${UCMake_VERSION} build done")
endif()

Ubpa_InitProject()

Ubpa_DownloadZip(
  https://cdn.jsdelivr.net/gh/Ubpa/UData@master/UANTLR/antlr4_20200520.zip
  antlr4_20200520.zip
  SHA256 d7aed9ced7e34dbc3655470f03dccf185d12f3dc44b5ed05019a6acce98c4f98
)

if(Ubpa_BuildUANTLRTest)
  include(cmake/UANTLRGenerator.cmake)
endif()

Ubpa_AddSubDirsRec(src)
Ubpa_AddSubDirsRec(test)

# install
Ubpa_PackageName(package_name)

install(FILES
  "config/Antlr4Package.md"
  "config/README.md"
  DESTINATION "${package_name}/cmake"
)

Ubpa_Export(DIRECTORIES "include;cmake")
