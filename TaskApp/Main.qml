import QtQuick
import Com.Example.Tasks
import QtQuick.Controls.Material

Window {
    id: rootWindow
    width: 400
    height: 600
    visible: true
    title: "Task Reorderer"
    Material.theme: Material.Light

    TaskBackend {
        id: backend
    }

    TaskListView {
        anchors.fill: parent
        model: backend.taskModel
        onCommitMove: (from, to) => backend.moveTask(from, to)
    }
}
