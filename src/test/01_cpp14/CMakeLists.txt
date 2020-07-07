Ubpa_GetTargetName(parser "${PROJECT_SOURCE_DIR}/src/ParserCpp14")

Ubpa_AddTarget(
  TEST
  MODE EXE
  LIB
    ${parser}
)
