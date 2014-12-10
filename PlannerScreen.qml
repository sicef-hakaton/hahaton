import QtQuick 2.0

Rectangle
{

    color: "#8080FF"
    signal titleClicked()

    ScreenTitle
    {
        id: title
        text: "Planner"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20

        MouseArea
        {
            anchors.fill: parent

            onClicked: titleClicked()
        }
    }

    Rectangle
    {
        id: titleSeparator
        width: parent.width
        height: 2
        anchors.top: title.bottom
    }


    Rectangle {
        anchors.top: titleSeparator.bottom
        anchors.left: title.left
        height: parent.height - title.height
        width: parent.width

        Planner
        {
            anchors.top: parent.top
            anchors.left: parent.left
        }
    }
}
