import QtQuick 2.0

Rectangle
{
    id: boundingRect
    width: parent.width
    height: 50

    color: "transparent"

    property alias text: titleText.text
    property alias textColor: titleText.color

    FontLoader { id: titleFont; source: "Savor.ttf" }

    signal exitTriggered()

    Text
    {
        id: backButton

        font.family: titleFont.name
        font.pixelSize: 30

        text: "<"

        anchors.left: parent.left
        anchors.leftMargin: 10
        color: "white"

        MouseArea
        {
           anchors.fill: parent

           onClicked:
           {
               exitTriggered()
           }
        }
    }

    Text
    {
        id: titleText

        font.family: titleFont.name
        font.pixelSize: 30

        anchors.left: backButton.right
        anchors.leftMargin: 20

        color: "white"
    }
}
