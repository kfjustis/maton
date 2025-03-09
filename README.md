# Building
Run the desired install script from the top-level directory. (If you cd into `scripts/` first, the paths won't work.) Builds are output into `build/`. (Only one build at a time. If you build desktop, clear it before building web. Otherwise, the install won't work.)

# Dependencies
Raylib 5.5 and latest Emscripten for web builds.

# Developing
When running code and debugging, do everything from CMake Tools commands. Otherwise, VSCode will not know where the header files are and fail to run.
