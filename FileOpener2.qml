import QtQuick 2.0

Rectangle
{
    id: root
    width: parent.width
    height: 300
    color: "transparent"

    signal openFile(string file)

    property alias model: list.model

    ListView
    {
        id: list
        width: root.width
        height: root.height
        delegate: listDelegate
        boundsBehavior: Flickable.StopAtBounds
        model: dataModel
    }

    Component
    {
        id: listDelegate
        Rectangle
        {
            id: delegateArea

            //property alias path: model.path

            color: "transparent"
            height: 20
            width: root.width

            MouseArea
            {
                anchors.fill: parent
                onDoubleClicked: openFile(model.path)
            }

            Text {
                id: filename
                text: model.name
                anchors.left: parent.left
                anchors.leftMargin: 10
                color: "blue"
                font.pointSize: 18
            }

        }
    }

}
