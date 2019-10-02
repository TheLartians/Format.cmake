cmake_minimum_required(VERSION 3.14)

add_custom_target(format
  COMMAND python ${CMAKE_CURRENT_LIST_DIR}/git-clang-format.py --diff 4b825dc642cb6eb9a060e54bf8d69288fbee4904 |  grep -q 'clang-format did not modify any files'
)

add_custom_target(fix-format
  COMMAND python ${CMAKE_CURRENT_LIST_DIR}/git-clang-format.py 4b825dc642cb6eb9a060e54bf8d69288fbee4904
)
