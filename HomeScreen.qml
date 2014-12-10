import QtQuick 2.0

Rectangle {
    width: parent.width
    height: parent.height

    signal gridClicked(string name)

    Home
    {
        id: mainView
        width: parent.width
        height: parent.height

        anchors.centerIn: parent

        onScreenChosen: gridClicked(mainView.chosenString)
    }
}
