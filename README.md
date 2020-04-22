[![Actions Status](https://github.com/TheLartians/Format.cmake/workflows/Unix/badge.svg)](https://github.com/TheLartians/Format.cmake/actions)
[![Actions Status](https://github.com/TheLartians/Format.cmake/workflows/Windows/badge.svg)](https://github.com/TheLartians/Format.cmake/actions)

# Format.cmake

clang-format for CMake

## About

Format.cmake adds three additional targets to your CMake project.

- `format` Shows which files are affected by clang-format
- `check-format` Errors if files are affected by clang-format (for CI integration)
- `fix-format` Applies clang-format to all affected files

To run the targets, invoke CMake with `cmake --build <build directory> --target <target name>`.

## Demo

![](https://user-images.githubusercontent.com/4437447/66123312-31ec3500-e5d1-11e9-8404-492b8eff8511.gif)

## How to integrate

### Using [CPM.cmake](https://github.com/TheLartians/CPM) (recommended)

Run the following from the project's root directory to add CPM to your project.

```bash
mkdir -p cmake
wget -O cmake/CPM.cmake https://raw.githubusercontent.com/TheLartians/CPM/master/cmake/CPM.cmake
```

Add the following lines to the project's `CMakeLists.txt` after calling `project(...)`.

```CMake
include(cmake/CPM.cmake)

CPMAddPackage(
  NAME Format.cmake
  GITHUB_REPOSITORY TheLartians/Format.cmake
  VERSION 1.2
)
```

### Using git submodules (not suited for libraries)

Run the following from the project's root directory.

```bash
git submodule add https://github.com/TheLartians/Format.cmake 
```

In add the following lines to the project's `CMakeLists.txt` after calling `project(...)`.

```CMake
add_subdirectory(Format.cmake)
```

## Dependencies

_Format.cmake_ requires _clang-format_, _CMake_ and _python 2.7_ or _python 3_.
