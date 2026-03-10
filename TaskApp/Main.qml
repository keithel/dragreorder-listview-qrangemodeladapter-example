import QtQuick
import Com.Example.Tasks
import Com.Example.App

Window {
    width: 400
    height: 600
    visible: true
    title: "Task Reorderer"

    TaskBackend {
        id: backend
    }

    TaskListView {
        anchors.fill: parent
        model: backend.taskModel
        onMoveRequested: (from, to) => backend.moveTask(from, to)
    }
}
