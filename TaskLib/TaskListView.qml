import QtQuick
import QtQuick.Controls
import QtQml.Models

Item {
    id: root
    property alias model: visualModel.model
    signal moveRequested(int from, int to)

    DelegateModel {
        id: visualModel
        delegate: TaskDelegate {
            width: root.width
            // Use itemsIndex from DelegateModel for the current visual position
            property int visualIndex: DelegateModel.itemsIndex
            
            onMoveItem: (from, to) => {
                visualModel.items.move(from, to)
                root.moveRequested(from, to)
            }
        }
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: visualModel
        displacementTransition: Transition {
            NumberAnimation { properties: "y"; duration: 200; easing.type: Easing.OutQuad }
        }
    }
}
