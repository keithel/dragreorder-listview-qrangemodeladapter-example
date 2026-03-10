qt_add_executable(TaskApp main.cpp)
qt_add_qml_module(TaskApp
    URI "Com.Example.App"
    VERSION 1.0
    QML_FILES Main.qml
)
# Link the shared library and the generated plugin
target_link_libraries(TaskApp PRIVATE Qt6::Quick TaskLib)
