set(target_dir "${PROJECT_SOURCE_DIR}/include/UANTLR/ParserCpp14")
if(NOT EXISTS ${target_dir})
  Ubpa_ANTLR4Generate(
    GEN_VISITOR
	GEN_LISTENER
	G4 "${PROJECT_SOURCE_DIR}/data/CPP14.g4"
	NAMESPACE Ubpa
	DIR ${target_dir}
  )
  
  file(GLOB_RECURSE cpp_files
    RELATIVE ${target_dir}
    ${target_dir}/*.cpp
  )
  
  foreach(cpp_file ${cpp_files})
    file(RENAME
      "${target_dir}/${cpp_file}"
      "${PROJECT_SOURCE_DIR}/src/ParserCpp14/${cpp_file}"
    )
  endforeach()
endif()
