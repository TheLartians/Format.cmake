
set(CLANG_FORMAT_COMMAND python ${CMAKE_CURRENT_LIST_DIR}/git-clang-format.py)
set(GIT_EMPTY_TREE_HASH 4b825dc642cb6eb9a060e54bf8d69288fbee4904)

add_custom_target(format
  COMMAND ${CLANG_FORMAT_COMMAND} --diff ${GIT_EMPTY_TREE_HASH}
)

add_custom_target(check-format
  COMMAND ${CLANG_FORMAT_COMMAND} --ci ${GIT_EMPTY_TREE_HASH}
)

add_custom_target(fix-format
  COMMAND ${CLANG_FORMAT_COMMAND} ${GIT_EMPTY_TREE_HASH} -f
)
