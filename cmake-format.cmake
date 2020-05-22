# Regex-filter a git repository's files.
function (filter_files)
  cmake_parse_arguments("" "" "GIT_REPOSITORY_DIR;OUTPUT_LIST;REGEX" "" ${ARGN})
  execute_process(COMMAND ${GIT_PROGRAM} ls-files --cached --exclude-standard WORKING_DIRECTORY ${_GIT_REPOSITORY_DIR} OUTPUT_VARIABLE all_files)
  cmake_policy(SET CMP0007 NEW)
  string(REPLACE "\n" ";" filtered_files "${all_files}")
  list(FILTER filtered_files INCLUDE REGEX ${_REGEX})
  set(${_OUTPUT_LIST} ${filtered_files} PARENT_SCOPE)
endfunction()

filter_files(GIT_REPOSITORY_DIR ${CMAKE_SOURCE_DIR} OUTPUT_LIST CMAKE_FILES REGEX "\\.cmake$|(^|/)CMakeLists\\.txt$")

if (CMAKE_FORMAT_TARGET STREQUAL fix-cmake-format)
  execute_process(COMMAND ${CMAKE_FORMAT_PROGRAM} -i ${CMAKE_FILES})
  return()
endif()

if (CMAKE_FORMAT_TARGET STREQUAL check-cmake-format)
  set(OUTPUT_QUIET OUTPUT_QUIET)
endif()

set(formatted_cmake_file ${BINARY_DIR}/formatted.cmake)
foreach(cmake_file IN LISTS CMAKE_FILES)
  set(source_cmake_file ${CMAKE_SOURCE_DIR}/${cmake_file})
  execute_process(COMMAND ${CMAKE_COMMAND} -E copy ${source_cmake_file} ${formatted_cmake_file})
  execute_process(COMMAND ${CMAKE_FORMAT_PROGRAM} -i ${formatted_cmake_file})
  execute_process(COMMAND ${GIT_PROGRAM} diff --no-index -- ${source_cmake_file} ${formatted_cmake_file}
    RESULT_VARIABLE result
    ${OUTPUT_QUIET})
  if (OUTPUT_QUIET AND result)
    message(FATAL_ERROR "${cmake_file} needs to be reformatted")
  endif()
endforeach()
