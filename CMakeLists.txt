cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(UANTLR VERSION 0.1.4)
message(STATUS "[Project] ${PROJECT_NAME}")

include(cmake/InitUCMake.cmake)
Ubpa_InitUCMake()
include(cmake/UbpaANTLR4Generator.cmake)

Ubpa_InitProject()

Ubpa_DownloadZip(
  https://cdn.jsdelivr.net/gh/Ubpa/UData@master/UANTLR/antlr4_20200910.zip
  antlr4_20200910.zip
  SHA256 5DEA841B94C717862B8872DE05F50C981F4CAD7632D8B29826117AADC8E45B6E
)

Ubpa_AddSubDirsRec(include)
Ubpa_AddSubDirsRec(src)

Ubpa_PackageName(package_name)

install(FILES
  "config/Antlr4Package.md"
  "config/README.md"
  DESTINATION "${package_name}/cmake"
)

Ubpa_Export(
  TARGET
  DIRECTORIES
    "include"
	"cmake"
)
