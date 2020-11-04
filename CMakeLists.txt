cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(UANTLR VERSION 0.2.0)
message(STATUS "[Project] ${PROJECT_NAME}")

include(cmake/InitUCMake.cmake)
Ubpa_InitUCMake()

Ubpa_InitProject()

Ubpa_DownloadZip(
  https://cdn.jsdelivr.net/gh/Ubpa/UData@master/UANTLR/antlr4_20201103.zip
  antlr4_20201103.zip
  SHA256 82ee041bff477a0e167fdd0c390f52ee1342c34d613d3e8adf2ecca830505e37
)

Ubpa_AddSubDirsRec(include)
Ubpa_AddSubDirsRec(src)

Ubpa_PackageName(package_name)

Ubpa_Export(
  TARGET
  DIRECTORIES
    "include"
	  "cmake"
)
