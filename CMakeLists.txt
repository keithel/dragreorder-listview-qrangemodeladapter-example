cmake_minimum_required(VERSION 3.21)
project(TaskReorderer LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20) # Required for modern ranges and 6.11 features
set(CMAKE_AUTOMOC ON)

find_package(Qt6 6.11 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2)

set(QT_QML_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/qml")
add_subdirectory(TaskLib)
add_subdirectory(TaskApp)
