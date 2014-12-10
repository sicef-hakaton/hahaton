import QtQuick 2.0

Rectangle {
    color: "#80FF80"
    signal titleClicked()

    ScreenTitle
    {
        id: title
        text: "Other Stuff"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20

        MouseArea
        {
            anchors.fill: parent

            onClicked: titleClicked()
        }
    }
}
