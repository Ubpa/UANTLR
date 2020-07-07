set(target_dir "${CMAKE_CURRENT_SOURCE_DIR}/_deps/DemoParser")
if(NOT EXISTS ${target_dir})
  Ubpa_ANTLR4Generate(
    GEN_VISITOR
	GEN_LISTENER
	G4 "${PROJECT_SOURCE_DIR}/data/CPP14.g4"
	NAMESPACE Ubpa
	DIR ${target_dir}
  )
endif()

Ubpa_AddTarget(
  TEST
  MODE EXE
  SOURCE
     "${ANTLR4_SRC_FILES_${parserName}}"
  LIB
    Ubpa::UANTLR_runtime
)
