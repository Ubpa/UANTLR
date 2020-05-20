if("${CMAKE_CXX_COMPILER_ID}" MATCHES "MSVC")
  set(coptions -wd4996)
else()
  set(coptions "")
endif()

Ubpa_AddTarget(
  MODE STATIC
  SOURCE
    "${PROJECT_SOURCE_DIR}/include" 
  INC
    "include/_deps/antlr4"
  INC_PRIVATE
	"include/_deps/antlr4/atn"
	"include/_deps/antlr4/dfa"
	"include/_deps/antlr4/misc"
	"include/_deps/antlr4/support"
	"include/_deps/antlr4/tree"
	"include/_deps/antlr4/tree/pattern"
	"include/_deps/antlr4/tree/xpath"
  DEFINE
    ANTLR4CPP_STATIC
  C_OPTION
    ${coptions}
)
