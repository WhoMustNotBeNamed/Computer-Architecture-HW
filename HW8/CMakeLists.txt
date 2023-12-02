# CMakeList.txt: проект CMake для HW8; включите исходный код и определения,
# укажите здесь логику для конкретного проекта.
#

# Добавьте источник в исполняемый файл этого проекта.
add_executable (HW8 "HW8.cpp" "HW8.h")

if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET HW8 PROPERTY CXX_STANDARD 20)
endif()

# TODO: Добавьте тесты и целевые объекты, если это необходимо.
