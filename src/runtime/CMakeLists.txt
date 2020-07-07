set(c_options "")

if(MSVC)
  list(APPEND c_options /wd4996)
endif()

Ubpa_AddTarget(
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
)
