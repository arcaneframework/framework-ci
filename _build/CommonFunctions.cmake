set(RUNNER_TEMP "$ENV{RUNNER_TEMP}")
message(STATUS "Setup configuration. CMake version is '${CMAKE_VERSION}'. RUNNER_TEMP=${RUNNER_TEMP}")

# Répertoire temporaire ajouté à $PATH pour mettre les binaires télécharger
set(LOCAL_BIN_DIR "${RUNNER_TEMP}/local_bin_dir")
set(LOCAL_BIN_DIR_BIN "${LOCAL_BIN_DIR}/bin")
file(MAKE_DIRECTORY "${LOCAL_BIN_DIR}")
file(MAKE_DIRECTORY "${LOCAL_BIN_DIR_BIN}")

function(do_command command_name)
  set(options        )
  set(oneValueArgs   WORKING_DIRECTORY)
  set(multiValueArgs )

  cmake_parse_arguments(ARGS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
  message(STATUS "WORKING_DIRECTORY=${ARGS_WORKING_DIRECTORY}")
  if (NOT ARGS_WORKING_DIRECTORY)
    set(ARGS_WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
  endif()

  message(STATUS "TRY COMMAND COMMAND=${command_name} WORKING_DIRECTORY=${ARGS_WORKING_DIRECTORY} ARGS=${ARGS_UNPARSED_ARGUMENTS}")

  execute_process(
    COMMAND ${command_name} ${ARGS_UNPARSED_ARGUMENTS}
    RESULT_VARIABLE RET_VALUE
    WORKING_DIRECTORY ${ARGS_WORKING_DIRECTORY}
    )
  message(STATUS "RET_VALUE=${RET_VALUE}")
  if (NOT RET_VALUE EQUAL 0)
    message(FATAL_ERROR "Bad return value R=${RET_VALUE}")
  endif()
endfunction()

if (NOT WIN32)
  set(MONO_EXEC "mono")
endif()
if (NOT NUGET_COMMAND)
  if (WIN32)
    set(NUGET_COMMAND "nuget.exe")
  else()
    set(NUGET_COMMAND "${LOCAL_BIN_DIR_BIN}/nuget.exe")
  endif()
endif()
