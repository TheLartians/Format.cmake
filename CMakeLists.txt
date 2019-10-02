cmake_minimum_required(VERSION 3.14)

set(CLANG_FORMAT_COMMAND python ${CMAKE_CURRENT_LIST_DIR}/git-clang-format.py)

add_custom_target(format
  COMMAND ${CLANG_FORMAT_COMMAND} --diff 4b825dc642cb6eb9a060e54bf8d69288fbee4904
)

add_custom_target(check-format
  COMMAND ${CLANG_FORMAT_COMMAND} --diff 4b825dc642cb6eb9a060e54bf8d69288fbee4904 |  grep -q 'clang-format did not modify any files'
)

add_custom_target(fix-format
  COMMAND ${CLANG_FORMAT_COMMAND} 4b825dc642cb6eb9a060e54bf8d69288fbee4904
)
