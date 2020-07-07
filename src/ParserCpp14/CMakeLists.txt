Ubpa_GetTargetName(runtime "${PROJECT_SOURCE_DIR}/src/runtime")

if(MSVC)
  set(c_options -wd4251)
else()
  set(c_options -Wno-overloaded-virtual)
endif()

Ubpa_AddTarget(
  MODE STATIC
  SOURCE
    "${PROJECT_SOURCE_DIR}/include/UANTLR/ParserCpp14"
  INC_INTERFACE
    "${PROJECT_SOURCE_DIR}/include"
  INC_PRIVATE
    "${PROJECT_SOURCE_DIR}/include/UANTLR/ParserCpp14"
  C_OPTION
    ${c_options}
  LIB
    ${runtime}
)
