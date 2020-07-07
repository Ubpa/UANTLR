set(Ubpa_ANTLR4_JAR_LOCATION "${CMAKE_CURRENT_LIST_DIR}/_deps/antlr-4.8-complete.jar"
  CACHE FILEPATH "path to antlr-x.x-complete.jar"
)

FIND_PACKAGE(Java COMPONENTS Runtime REQUIRED)

function(Ubpa_ANTLR4Generate)
  cmake_parse_arguments(
    "ARG"                      # prefix
	"GEN_LISTENER;GEN_VISITOR" # option
	"NAMESPACE;MODE;G4;DIR"    # value
	""                         # list
	${ARGN}                    # input
  )
  
  # [option]
  # GEN_LISTENER : generate listener
  # GEN_VISITOR  : generate visitor
  # [value]
  # DIR          : default ${CMAKE_CURRENT_SOURCE_DIR}
  # NAMESPACE
  # MODE         : LEXER / PARSER / BOTH (default)
  # G4           : input file
  # [return]
  # * base_name    : G4's NAME_WE
  # INCLUDE_DIR_${base_name}
  # SRC_FILES_${base_name}
  # TOKEN_DIRECTORY_${base_name}
  # TOKEN_FILES_${base_name}
  
  
  if("${ARG_G4}" STREQUAL "")
    message(FATAL_ERROR "[G4] parameter must not be empty")
  endif()
  if("${ARG_MODE}" STREQUAL "")
    set(ARG_MODE "BOTH")
  endif()
  if("${ARG_DIR}" STREQUAL "")
    set(ARG_DIR ${CMAKE_CURRENT_SOURCE_DIR})
  endif()

  get_filename_component(base_name ${ARG_G4} NAME_WE)
  
  set(GeneratorStatusMessage "")
  list(APPEND GeneratorStatusMessage "Common Include-, Source- and Tokenfiles" )

  if("${ARG_MODE}" STREQUAL "LEXER")
    set(LexerBaseName "${base_name}")
    set(ParserBaseName "")
  elseif("${ARG_MODE}" STREQUAL "PARSER")
    set(LexerBaseName "")
    set(ParserBaseName "${base_name}")
  elseif("${ARG_MODE}" STREQUAL "BOTH")
    set(LexerBaseName "${base_name}Lexer")
    set(ParserBaseName "${base_name}Parser")
  else()
    message(FATAL_ERROR "MODE parameter must be LEXER, PARSER or BOTH")
  endif()

  # Prepare list of generated targets
  list(APPEND GeneratedTargets "${ARG_DIR}/${base_name}.tokens" )
  list(APPEND GeneratedTargets "${ARG_DIR}/${base_name}.interp" )
  list(APPEND DependentTargets "${ARG_DIR}/${base_name}.tokens" )

  if ( NOT ${LexerBaseName} STREQUAL "" )
    list(APPEND GeneratedTargets "${ARG_DIR}/${LexerBaseName}.h" )
    list(APPEND GeneratedTargets "${ARG_DIR}/${LexerBaseName}.cpp" )
  endif ()

  if ( NOT ${ParserBaseName} STREQUAL "" )
    list(APPEND GeneratedTargets "${ARG_DIR}/${ParserBaseName}.h" )
    list(APPEND GeneratedTargets "${ARG_DIR}/${ParserBaseName}.cpp" )
  endif ()

  if(ARG_GEN_LISTENER)
    set(BuildListenerOption "-listener")

    list(APPEND GeneratedTargets "${ARG_DIR}/${base_name}BaseListener.h" )
    list(APPEND GeneratedTargets "${ARG_DIR}/${base_name}BaseListener.cpp" )
    list(APPEND GeneratedTargets "${ARG_DIR}/${base_name}Listener.h" )
    list(APPEND GeneratedTargets "${ARG_DIR}/${base_name}Listener.cpp" )

    list(APPEND GeneratorStatusMessage ", Listener Include- and Sourcefiles" )
  else()
    set(BuildListenerOption "-no-listener")
  endif ()
  
  if(ARG_GEN_VISITOR)
    set(BuildVisitorOption "-visitor")

    list(APPEND GeneratedTargets "${ARG_DIR}/${base_name}BaseVisitor.h" )
    list(APPEND GeneratedTargets "${ARG_DIR}/${base_name}BaseVisitor.cpp" )
    list(APPEND GeneratedTargets "${ARG_DIR}/${base_name}Visitor.h" )
    list(APPEND GeneratedTargets "${ARG_DIR}/${base_name}Visitor.cpp" )

    list(APPEND GeneratorStatusMessage ", Visitor Include- and Sourcefiles" )
  else()
    set(BuildVisitorOption "-no-visitor")
  endif()
  
  if(NOT "${ARG_NAMESPACE}" STREQUAL "")
    set(NamespaceOption "-package;${ARG_NAMESPACE}")

    list(APPEND GeneratorStatusMessage " in Namespace ${ARG_NAMESPACE}" )
  else()
    set(NamespaceOption "")
  endif()

  if(NOT Java_FOUND)
    message(FATAL_ERROR "Java is required to process grammar or lexer files! - Use 'FIND_PACKAGE(Java COMPONENTS Runtime REQUIRED)'")
  endif()

  if(NOT EXISTS "${Ubpa_ANTLR4_JAR_LOCATION}")
    message(FATAL_ERROR "Unable to find antlr tool. Ubpa_ANTLR4_JAR_LOCATION:${Ubpa_ANTLR4_JAR_LOCATION}")
  endif()

  message(STATUS "Antlr4 ${base_name} - Building " ${GeneratorStatusMessage})

  # The call to generate the files
  execute_process(
    # Remove target directory
    COMMAND
    ${CMAKE_COMMAND} -E remove_directory ${ARG_DIR}
    # Create target directory
    COMMAND
    ${CMAKE_COMMAND} -E make_directory ${ARG_DIR}
    COMMAND
    # Generate files
    "${Java_JAVA_EXECUTABLE}" -jar "${Ubpa_ANTLR4_JAR_LOCATION}" -Werror -Dlanguage=Cpp ${BuildListenerOption} ${BuildVisitorOption} -o "${ARG_DIR}" ${NamespaceOption} "${ARG_G4}"
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
  )

  # set output variables in parent scope
  set(INCLUDE_DIR_${base_name} ${ARG_DIR} PARENT_SCOPE)
  set(SRC_FILES_${base_name} ${GeneratedTargets} PARENT_SCOPE)
  set(TOKEN_FILES_${base_name} ${DependentTargets} PARENT_SCOPE)
  set(TOKEN_DIRECTORY_${base_name} ${ARG_DIR} PARENT_SCOPE)

  # export generated cpp files into list
  foreach(generated_file ${GeneratedTargets})
    if(NOT CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
      set_source_files_properties(
        ${generated_file}
        PROPERTIES
        COMPILE_FLAGS -Wno-overloaded-virtual
      )
    endif ()

    if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
      set_source_files_properties(
        ${generated_file}
        PROPERTIES
        COMPILE_FLAGS -wd4251
      )
    endif()
  endforeach()
endfunction()
