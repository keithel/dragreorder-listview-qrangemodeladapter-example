import QtQuick

DropArea {
    id: root
    required property var listView

    states: [
        State {
            name: "dragging"
            when: root.listView.draggingItem
            PropertyChanges {
                root.implicitHeight: (root.listView.count > 0) ? root.listView.itemAtIndex(0).height : 0
            }
        },
        State {
            name: "not_dragging"
            when: !root.listView.draggingItem
            PropertyChanges {
                root.implicitHeight: 0
            }
        }
    ]

    transitions: [
        Transition {
            from: "dragging"
            to: "not_dragging"
            NumberAnimation { properties: "implicitHeight"; easing.type: Easing.InQuad }
        },
        Transition {
            from: "not_dragging"
            to: "dragging"
            NumberAnimation { properties: "implicitHeight"; easing.type: Easing.OutQuad }
        }
    ]

    implicitHeight: (listView.count > 0 && listView.draggingItem) ? listView.itemAtIndex(0).height : 0

    keys: [listView.dragDropKey]
    onEntered: (drag) => {
        console.log("Drag area entered!")
    }
    onExited: {
        console.log("Drag area exited!")
    }

    onDropped: (drop) => {
        console.log("Drag area DROPPED!")
        // handle drop
    }
    Rectangle {
        anchors.fill: parent
        color: "blue"
    }
}
