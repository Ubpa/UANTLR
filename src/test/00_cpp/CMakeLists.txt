if(${Ubpa_Build${PROJECT_NAME}Test})
  set(ANTLR4_GENERATED_SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/_deps")
  
  set(parserName "DemoParser")
  
  antlr4_generate(
    ${parserName}
    ${CMAKE_CURRENT_SOURCE_DIR}/CPP14.g4
    BOTH
    TRUE
    TRUE
    Ubpa
  )
endif()

Ubpa_AddTarget(
  TEST
  MODE EXE
  SOURCE "${ANTLR4_SRC_FILES_${parserName}}"
  LIB Ubpa::UANTLR_runtime
)
