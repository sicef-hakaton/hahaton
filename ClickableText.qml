import QtQuick 2.3

Rectangle
{
    id: area
    color: "transparent"

    anchors.left: parent.left
    anchors.top: title.bottom

    signal textClicked();

    property alias text: addnewText.text

    //Behavior on color {
    //             ColorAnimation { duration: 1000 }
    //}

    //Behavior on width{
    //    NumberAnimation { duration: 300; easing.type: Easing.Linear }
    //}

    width: 100
    height: addnewText.height

    Text
    {
        id: addnewText
        font.pixelSize: 20

        text: "Add New..."
    }

    MouseArea
    {
        acceptedButtons: Qt.LeftButton
        anchors.fill: parent
        hoverEnabled: true
        onClicked:
        {
            textClicked()
        }
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
            PropertyChanges { target: addnewText; color: "#000000" }
        },
        State
        {
            name:"focused"
            PropertyChanges { target: addnewText; color: "#808080" }
        },
        State
        {
            name:"pressed"
            PropertyChanges { target: addnewText; color: "#FF0000" }
        }
    ]

    transitions:
    [
        Transition
        {
            from: "*"; to: "*"

            PropertyAnimation
            {
                target: addnewText
                easing.type: Easing.Linear
                properties: "color"
                duration: 300
            }
        }
    ]
}
