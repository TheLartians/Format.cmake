
find_program(CLANG_FORMAT_PROGRAM clang-format${CMAKE_EXECUTABLE_SUFFIX})

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
  message(STATUS "clang-format not found: not adding Format.cmake targets")
endif()
