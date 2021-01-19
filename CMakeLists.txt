cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(UANTLR VERSION 0.2.1)
message(STATUS "[Project] ${PROJECT_NAME}")

include(cmake/InitUCMake.cmake)
Ubpa_InitUCMake(VERSION 0.6.4)

Ubpa_InitProject(CXX_STANDARD 17)

Ubpa_DownloadZip(
  https://cdn.jsdelivr.net/gh/Ubpa/UData@master/UANTLR/antlr4_runtime_20201113.zip
  antlr4_runtime_20201113.zip
  SHA256 906DBEC5957DA4A39910E97A95B9019DEED03BF686B21A36F9781243311FC2D3
)

Ubpa_DownloadZip(
  https://cdn.jsdelivr.net/gh/Ubpa/UData@master/UANTLR/antlr4_cpp14_20201115.zip
  antlr4_cpp14_20201115.zip
  SHA256 125868CE7FCEED283F7C41687B408067AD19AA33FDFC9ECA432456867250AD26
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
