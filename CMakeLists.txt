
find_program(CLANG_FORMAT_PROGRAM clang-format)

if (CLANG_FORMAT_PROGRAM)
  set(CLANG_FORMAT_COMMAND python ${CMAKE_CURRENT_LIST_DIR}/git-clang-format.py --binary=${CLANG_FORMAT_PROGRAM})
  set(GIT_EMPTY_TREE_HASH 4b825dc642cb6eb9a060e54bf8d69288fbee4904)

  add_custom_target(format
    COMMAND ${CLANG_FORMAT_COMMAND} --diff ${GIT_EMPTY_TREE_HASH}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  )

  add_custom_target(check-format
    COMMAND ${CLANG_FORMAT_COMMAND} --ci ${GIT_EMPTY_TREE_HASH}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  )

  add_custom_target(fix-format
    COMMAND ${CLANG_FORMAT_COMMAND} ${GIT_EMPTY_TREE_HASH} -f
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  )
else()
  message(STATUS "clang-format not found: adding dummy Format.cmake targets")

  set(CLANG_FORMAT_NOT_FOUND_COMMAND_ARGS
    COMMAND ${CMAKE_COMMAND} -E echo "cannot run Format.cmake: clang-format not found"
    COMMAND ${CMAKE_COMMAND} -E false
  )

  add_custom_target(format ${CLANG_FORMAT_NOT_FOUND_COMMAND_ARGS})
  add_custom_target(check-format ${CLANG_FORMAT_NOT_FOUND_COMMAND_ARGS})
  add_custom_target(fix-format ${CLANG_FORMAT_NOT_FOUND_COMMAND_ARGS})
endif()

include(FindGit)
find_program(CMAKE_FORMAT_PROGRAM cmake-format)

if (Git_FOUND AND CMAKE_FORMAT_PROGRAM)
  function (add_cmake_format_target name)
    add_custom_target(${name}
      COMMAND ${CMAKE_COMMAND} -DGIT_EXECUTABLE=${GIT_EXECUTABLE} -DCMAKE_FORMAT_PROGRAM=${CMAKE_FORMAT_PROGRAM}
        -DCMAKE_FORMAT_TARGET=${name} -DCMAKE_MODULE_PATH="${CMAKE_MODULE_PATH}"
        -P ${CMAKE_CURRENT_LIST_DIR}/cmake-format.cmake
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )
  endfunction()

  add_cmake_format_target(cmake-format)
  add_cmake_format_target(check-cmake-format)
  add_cmake_format_target(fix-cmake-format)
else()
  message(STATUS "cmake-format or git not found: adding dummy Format.cmake targets")

  set(CMAKE_FORMAT_NOT_FOUND_COMMAND_ARGS
    COMMAND ${CMAKE_COMMAND} -E echo "cannot run Format.cmake: cmake-format or git not found"
    COMMAND ${CMAKE_COMMAND} -E false
  )

  add_custom_target(cmake-format ${CMAKE_FORMAT_NOT_FOUND_COMMAND_ARGS})
  add_custom_target(check-cmake-format ${CMAKE_FORMAT_NOT_FOUND_COMMAND_ARGS})
  add_custom_target(fix-cmake-format ${CMAKE_FORMAT_NOT_FOUND_COMMAND_ARGS})
endif()
