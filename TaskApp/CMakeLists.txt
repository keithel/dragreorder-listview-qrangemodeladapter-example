qt_add_executable(appTaskApp main.cpp)
qt_add_qml_module(appTaskApp
    URI Com.Example.App
    VERSION 1.0
    QML_FILES Main.qml
)

set_target_properties(appTaskApp PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}"
)

# Link the shared library and the generated plugin
target_link_libraries(appTaskApp PRIVATE Qt6::Quick Qt6::QuickControls2)
