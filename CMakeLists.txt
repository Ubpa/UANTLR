cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(UANTLR VERSION 0.0.4)
message(STATUS "[Project] ${PROJECT_NAME}")

include(cmake/InitUCMake.cmake)
Ubpa_InitUCMake()

Ubpa_InitProject()

Ubpa_DownloadZip(
  https://cdn.jsdelivr.net/gh/Ubpa/UData@master/UANTLR/antlr4_20200520.zip
  antlr4_20200520.zip
  SHA256 d7aed9ced7e34dbc3655470f03dccf185d12f3dc44b5ed05019a6acce98c4f98
)

if(Ubpa_BuildTest_UANTLR)
  include(cmake/UANTLRGenerator.cmake)
endif()

Ubpa_AddSubDirsRec(src)

# install
Ubpa_PackageName(package_name)

install(FILES
  "config/Antlr4Package.md"
  "config/README.md"
  DESTINATION "${package_name}/cmake"
)

Ubpa_Export(DIRECTORIES "include;cmake")
