cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(UANTLR VERSION 0.2.0)
message(STATUS "[Project] ${PROJECT_NAME}")

include(cmake/InitUCMake.cmake)
Ubpa_InitUCMake()

Ubpa_InitProject()

Ubpa_DownloadZip(
  https://cdn.jsdelivr.net/gh/Ubpa/UData@master/UANTLR/antlr4_runtime_20201113.zip
  antlr4_runtime_20201113.zip
  SHA256 906DBEC5957DA4A39910E97A95B9019DEED03BF686B21A36F9781243311FC2D3
)

Ubpa_DownloadZip(
  https://cdn.jsdelivr.net/gh/Ubpa/UData@master/UANTLR/antlr4_cpp14_20201113.zip
  antlr4_cpp14_20201113.zip
  SHA256 0AF88CE2B015FEB20F0539B70539BDB129A21817CFCBA90F6243564429F4770D
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
