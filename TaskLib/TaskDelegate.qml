import QtQuick
import QtQuick.Controls

Item {
    id: delegateRoot
    height: 60
    
    signal moveItem(int from, int to)

    Rectangle {
        id: content
        anchors.fill: parent
        color: dragArea.held ? "#eee" : "white"
        border.color: "#ccc"

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
                drag.target: held ? content : undefined
                drag.axis: Drag.YAxis

                onPressed: held = true
                onReleased: held = false
            }
        }

        Text {
            anchors.left: handle.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            text: model.display // Default role for QRangeModel
        }

        // 2. Drag/Drop Logic
        Drag.active: dragArea.held
        Drag.source: delegateRoot
        Drag.hotSpot.y: height / 2

        DropArea {
            anchors.fill: parent
            onEntered: (drag) => {
                if (drag.source !== delegateRoot) {
                    delegateRoot.moveItem(drag.source.visualIndex, delegateRoot.visualIndex)
                }
            }
        }
    }
}
