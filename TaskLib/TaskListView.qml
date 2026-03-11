// TaskListView.qml
pragma ComponentBehavior: Bound

import QtQuick
import QtQml.Models
import QtQuick.Layouts

Item {
    id: root
    property alias model: visualModel.model
    signal commitMove(int from, int to)

    DelegateModel {
        id: visualModel
        delegate: TaskDelegate {
            width: ListView.view.width
            // Use itemsIndex from DelegateModel for the current visual position
            visualIndex: DelegateModel.itemsIndex
            listView: listView

            onMoveItem: (from, to) => {
                visualModel.items.move(from, to)
            }
            onCommitMove: (from, to) => {
                console.log("Committing move from", from, "to", to)
                ListView.view.commitMove(from, to)
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        ListViewDropPlaceholder {
            listView: listView
            Layout.fillWidth: true
        }

        ListView {
            id: listView

            function generateId() {
                // Uses the current time in milliseconds + a 4-digit random number
                return Date.now().toString(36) + Math.random().toString(36).substring(2, 6);
            }

            signal moveRequested(int from, int to)
            signal commitMove(int from, int to)
            property bool draggingItem: false
            property string dragDropKey

            Component.onCompleted: dragDropKey = generateId()

            Layout.fillWidth: true
            Layout.fillHeight: true
            interactive: !draggingItem

            model: visualModel
            displaced: Transition {
                NumberAnimation { properties: "y"; duration: 200; easing.type: Easing.OutQuad }
            }

            onCommitMove: (from, to) => { root.commitMove(from, to) }
        }
        ListViewDropPlaceholder {
            listView: listView
            Layout.fillWidth: true
        }
    }
}
