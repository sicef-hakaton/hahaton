import QtQuick 2.0


Rectangle{
    id: button
    width: 200
    height: 50
    color: "#FF8000"

    property alias textItem: textField

    signal buttonClicked()

    Text{
        id: textField
        text: "Add new class"
        anchors.centerIn: parent
        font.pixelSize: 18
    }


    MouseArea
    {
        acceptedButtons: Qt.LeftButton
        anchors.fill: parent
        hoverEnabled: true
        onClicked: { buttonClicked() }
        onPressed: { parent.state = "pressed" }
        onReleased: { parent.state = containsMouse? "focused" : "normal" }
        onEntered: { parent.state = "focused"; }
        onExited: { parent.state = pressed? "pressed" : "normal"; }
    }

    states:
    [
        State
        {
            name:"normal"
            PropertyChanges { target: button; color: "#FF8000" }
        },
        State
        {
            name:"focused"
            PropertyChanges { target: button; color: "#FFD080" }
        },
        State
        {
            name:"pressed"
            PropertyChanges { target: button; color: "#D04000" }

        }
    ]

    transitions:
    [
        Transition
        {
            from: "*"; to: "*"

            PropertyAnimation
            {
                target: button
                easing.type: Easing.InQuad

                properties: "color"
                duration: 300
            }
        }
    ]

}
