import QtQuick 2.0
import QtQuick.Controls 1.2

Rectangle
{
    id: clickLabel

    property alias label: labelText
    property alias labelText: labelText.text

    width: 200; height: 50
    color: "transparent"

    signal clicked();

    Label
    {
        id: labelText

        x: parent.x + 3; y: parent.height - height - 3;
        text: "LabelText"
        color: "cyan"
    }

    Rectangle
    {
        id: overlay

        anchors.fill: parent

        color: "white"
        opacity: 0.0;
    }

    MouseArea
    {
        acceptedButtons: Qt.LeftButton
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {  }
//        onPressed: { parent.state = "pressed" }
//        onReleased: { parent.state = containsMouse? "focused" : "normal" }
//        onEntered: { parent.state = "focused" }
//        onExited: { parent.state = pressed? "pressed" : "normal"; }
    }

    states:
    [
        State
        {
            name:"normal"
            PropertyChanges { target: overlay; color: "white" }
            PropertyChanges { target: overlay; opacity: 0.0 }
        },
        State
        {
            name:"focused"
            PropertyChanges { target: overlay; color: "white" }
            PropertyChanges { target: overlay; opacity: 0.5 }
        },
        State
        {
            name:"pressed"
            PropertyChanges { target: overlay; color: "#222222" }
            PropertyChanges { target: overlay; opacity: 0.5 }
        }
    ]

    transitions:
    [
        Transition
        {
            from: "*"; to: "*"
            ParallelAnimation
            {
                PropertyAnimation
                {
                    target: overlay
                    easing.type: Easing.Linear
                    properties: "color"
                    duration: 100
                }
                PropertyAnimation
                {
                    target: overlay
                    easing.type: Easing.Linear
                    properties: "opacity"
                    duration: 100
                }
            }
        }
    ]
}
