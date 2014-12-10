import QtQuick 2.0


Rectangle {
    id: contextMenu
    width: 150
    height: 200
    visible:false
    color: "purple"
    x: 2000
    y: 2000

    Column{
        width: parent
        height:parent
        Repeater{
            id: repeater
            model: ["Call", "Remove contact", "Add contact"]

            ClickLabel{
                label.text: modelData
                label.font.pointSize: 12
                width: dropDown.width - 6
                height: label.height + 6
            }
        }
    }
    MouseArea{
        acceptedButtons: Qt.RightButton
        anchors.fill: container
        hoverEnabled: true
        onClicked: { contextMenu.visible = true; contextMenu.x = mouse.x; contextMenu.y = mouse.y}
        onPressed: {  }
    }
    MouseArea{
        acceptedButtons: Qt.LeftButton
        anchors.fill: container
        hoverEnabled: true
        onClicked: { contextMenu.visible = false}
        onPressed: {  }

    }
}
