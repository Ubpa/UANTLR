Ubpa_GetTargetName(parser "${PROJECT_SOURCE_DIR}/src/ParserCpp14")

Ubpa_AddTarget(
  CXX_STANDARD 17
  TEST
  MODE EXE
  LIB
    ${parser}
)
