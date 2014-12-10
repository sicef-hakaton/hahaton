import QtQuick 2.0

Rectangle {
    color: "#FFD080"
    signal titleClicked()

    ScreenTitle
    {
        id: title
        text: "Useful Tips"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20

        onExitTriggered: titleClicked()
    }
}
