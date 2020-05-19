# Regex-filter a git repository's files.
function (filter_files)
  cmake_parse_arguments("" "" "GIT_REPOSITORY_DIR;OUTPUT_LIST;REGEX" "" ${ARGN})
  execute_process(COMMAND ${GIT_EXECUTABLE} ls-files --cached --others --exclude-standard WORKING_DIRECTORY ${_GIT_REPOSITORY_DIR} OUTPUT_VARIABLE all_files)
  cmake_policy(SET CMP0007 NEW)
  string(REPLACE "\n" ";" filtered_files "${all_files}")
  list(FILTER filtered_files INCLUDE REGEX ${_REGEX})
  set(${_OUTPUT_LIST} ${filtered_files} PARENT_SCOPE)
endfunction()

filter_files(GIT_REPOSITORY_DIR ${WORKING_DIRECTORY} OUTPUT_LIST CMAKE_FILES REGEX "\\.cmake$|(^|/)CMakeLists\\.txt$")

# Scan modules' cmake-format configs
separate_arguments(CMAKE_MODULE_PATH)
foreach (dir IN LISTS CMAKE_MODULE_PATH WORKING_DIRECTORY)
  filter_files(GIT_REPOSITORY_DIR ${dir} OUTPUT_LIST modules_configs REGEX "(^|/)\\.?cmake-format\\.(yaml|json|py)$")
  foreach (cfg IN LISTS modules_configs)
    list(APPEND MODULES_CONFIGS ${dir}/${modules_configs})
  endforeach()
endforeach()

if (CMAKE_FORMAT_TARGET STREQUAL cmake-format)

elseif (CMAKE_FORMAT_TARGET STREQUAL check-cmake-format)

elseif (CMAKE_FORMAT_TARGET STREQUAL fix-cmake-format)
  execute_process(COMMAND ${CMAKE_FORMAT_PROGRAM} --config-files ${MODULES_CONFIGS} -i ${CMAKE_FILES})
endif()
