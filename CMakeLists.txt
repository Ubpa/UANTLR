cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(UANTLR VERSION 0.3.0)
message(STATUS "[Project] ${PROJECT_NAME}")

include(cmake/InitUCMake.cmake)
Ubpa_InitUCMake(VERSION 0.6.4)

Ubpa_InitProject()

Ubpa_DownloadZip(
  http://home.ustc.edu.cn/~ustczt/resources/UANTLR/antlr4_runtime_20210509.zip
  antlr4_runtime_20210509.zip
  SHA256 7F69653FA851323AE547882F7328730DB74959732FD01D928049AB8D7B6EF230
)

Ubpa_DownloadZip(
  http://home.ustc.edu.cn/~ustczt/resources/UANTLR/antlr4_cpp14_20210327.zip
  antlr4_cpp14_20210327.zip
  SHA256 F90B543EC368A2253126640EAA67F4693D06A9CA24939023BF6AC5D10BCEBBA8
)
# name in antlr4_cpp14_20201115.zip is wrong, so change it here
if(EXISTS "${PROJECT_SOURCE_DIR}/include/UANTLR/ParserCPP14")
  file(RENAME "${PROJECT_SOURCE_DIR}/include/UANTLR/ParserCPP14" "${PROJECT_SOURCE_DIR}/include/UANTLR/ParserCpp14")
endif()

Ubpa_AddSubDirsRec(include)
Ubpa_AddSubDirsRec(src)

Ubpa_PackageName(package_name)

Ubpa_Export(
  TARGET
  DIRECTORIES
    "include"
	  "cmake"
)
