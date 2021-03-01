[![Actions Status](https://github.com/TheLartians/Format.cmake/workflows/Unix/badge.svg)](https://github.com/TheLartians/Format.cmake/actions)
[![Actions Status](https://github.com/TheLartians/Format.cmake/workflows/Windows/badge.svg)](https://github.com/TheLartians/Format.cmake/actions)

# Format.cmake

clang-format and cmake-format for CMake

## About

Format.cmake adds three additional targets to your CMake project.

- `format` Shows which files are affected by clang-format
- `check-format` Errors if files are affected by clang-format (for CI integration)
- `fix-format` Applies clang-format to all affected files

To run the targets, invoke CMake with `cmake --build <build directory> --target <target name>`.

To disable using _cmake_format_ to format CMake files, set the cmake option `FORMAT_SKIP_CMAKE` to a truthy value, e.g. by invoking CMake with `-DFORMAT_SKIP_CMAKE=YES`, or enabling the option when [adding the dependency](#how-to-integrate) (recommended).

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
  VERSION 1.7.0
  GITHUB_REPOSITORY TheLartians/Format.cmake
  OPTIONS # set to yes skip cmake formatting
          "FORMAT_SKIP_CMAKE NO"
          # path to exclude (optional, supports regular expressions)
          "CMAKE_FORMAT_EXCLUDE cmake/CPM.cmake"
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

_Format.cmake_ requires _CMake_, _clang-format_, _python 2.7_ or _python 3_, and _cmake-format_ (optional).
