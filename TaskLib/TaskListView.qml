// TaskListView.qml
pragma ComponentBehavior: Bound

import QtQuick
import QtQml.Models

Item {
    id: root
    property alias model: visualModel.model
    signal moveRequested(int from, int to)

    DelegateModel {
        id: visualModel
        delegate: TaskDelegate {
            width: ListView.view.width
            // Use itemsIndex from DelegateModel for the current visual position
            visualIndex: DelegateModel.itemsIndex
            
            onMoveItem: (from, to) => {
                // console.log("DelegateModel.onMoveItem(", from, ", ", to, ") called")
                visualModel.items.move(from, to)
                ListView.view.moveRequested(from, to)
            }
        }
    }

    ListView {
        id: listView

        signal moveRequested(int from, int to)
        property bool dragActive: false

        anchors.fill: parent
        interactive: !dragActive

        model: visualModel
        displaced: Transition {
            NumberAnimation { properties: "y"; duration: 200; easing.type: Easing.OutQuad }
        }

        onMoveRequested: (from, to) => { root.moveRequested(from, to) }
    }
}
