set(c_options "")

if(MSVC)
  list(APPEND c_options "/wd4996")
endif()

set(c_options_private "")
if(MSVC)
  list(APPEND c_options_private "/MP")
elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
  #
elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
  #
endif()

Ubpa_AddTarget(
  CXX_STANDARD 17
  MODE STATIC
  SOURCE
    "${PROJECT_SOURCE_DIR}/include/_deps/antlr4" 
  INC
    "${PROJECT_SOURCE_DIR}/include/_deps/antlr4"
  INC_PRIVATE
	"${PROJECT_SOURCE_DIR}/include/_deps/antlr4/atn"
	"${PROJECT_SOURCE_DIR}/include/_deps/antlr4/dfa"
	"${PROJECT_SOURCE_DIR}/include/_deps/antlr4/misc"
	"${PROJECT_SOURCE_DIR}/include/_deps/antlr4/support"
	"${PROJECT_SOURCE_DIR}/include/_deps/antlr4/tree"
	"${PROJECT_SOURCE_DIR}/include/_deps/antlr4/tree/pattern"
	"${PROJECT_SOURCE_DIR}/include/_deps/antlr4/tree/xpath"
  DEFINE
    ANTLR4CPP_STATIC
  C_OPTION
    ${c_options}
  C_OPTION_PRIVATE
    ${c_options_private}
)
