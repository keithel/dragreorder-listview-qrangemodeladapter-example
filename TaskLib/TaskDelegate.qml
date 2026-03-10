// TaskDelegate.qml
pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

Item {
    id: delegateRoot
    height: 60
    
    required property var model
    required property int index
    required property int visualIndex
    signal moveItem(int from, int to)

    Rectangle {
        id: content
        width: delegateRoot.width
        height: delegateRoot.height
        parent: delegateRoot
        y: 0
        z: 1
        color: "white"
        border.color: "#ccc"

        states: State {
            when: dragArea.held
            ParentChange {
                target: content
                parent: content.Window.window.contentItem
            }
            PropertyChanges {
                target: content
                y: dragArea.heldY
                z: 100
                color: "#eeeeee"
            }
        }

        // 1. Grab Handle
        Rectangle {
            id: handle
            width: 40
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            color: "#ddd"
            Text { text: "☰"; anchors.centerIn: parent }

            MouseArea {
                id: dragArea
                anchors.fill: parent
                property bool held: false
                property real heldY: 0

                onPressed: (mouse) => {
                    let globalPos = delegateRoot.mapToItem(Window.window.contentItem, 0, 0)
                    heldY = globalPos.y
                    held = true
                    /*ListView.view*/listView.dragActive = true
                }
                onReleased: {
                    held = false
                    /*ListView.view*/listView.dragActive = false
                }
                // onHeldChanged: console.log("Delegate", delegateRoot.index, (held ? "held" : "not held"))

                drag.target: content
                drag.axis: Drag.YAxis
                drag.minimumY: 0
                drag.maximumY: Window.window.height - content.height
            }
        }

        Label {
            anchors.left: handle.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            text: delegateRoot.model.display // Default role for QRangeModel
        }

        // 2. Drag/Drop Logic
        Drag.active: dragArea.held
        Drag.source: delegateRoot
        Drag.hotSpot.x: width / 2
        Drag.hotSpot.y: height / 2
        Drag.keys: ["task-item"]
    }

    DropArea {
        anchors.fill: parent
        keys: ["task-item"]
        onEntered: (drag) => {
            let from = drag.source.visualIndex
            let to = delegateRoot.visualIndex

            if (from !== to) {
                delegateRoot.moveItem(from, to)
            }
        }
    }

}
