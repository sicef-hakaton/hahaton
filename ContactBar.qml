import QtQuick 2.0
import QtQuick.Controls 1.2

Rectangle {
    id: container
    width: 100
    height: parent.height

    property int cols
    property int index

    color: "#FFEECC"

    signal skypeCall()


    ListView
    {
        id: list
        width: parent.width
        height: parent.height
        model: contactModel
        delegate: contactdelegate
        boundsBehavior: Flickable.StopAtBounds
    }

    Component
    {
        id: contactdelegate

        Rectangle
        {
            id: delegateArea

            color: "transparent"
            height: 80
            width: container.width

            MouseArea
            {
                anchors.fill: parent
                onDoubleClicked: skypeCall()
            }

            Rectangle {
                id: imageBounds
                width:  parent.height
                height: parent.height
                anchors.left: parent.left
                //border.width: 1

                color: "transparent"

                Image
                {
                    id: img

                    width:  parent.height - 10
                    height: parent.height - 10

                    fillMode: Image.PreserveAspectCrop
                    anchors {centerIn: parent; }
                    source: "contactImage.png"
                }
            }

            Text {
                id: fullname
                text: name + " " + lastname
                anchors.left: imageBounds.right
                anchors.leftMargin: 10
                color: "black"
                font.pointSize: 18
            }

            Text {
                id: nick
                text: status
                color: "black"
                anchors.left: imageBounds.right
                anchors.leftMargin: 10
                anchors.top: fullname.bottom
                font.pointSize: 12
            }
        }
    }
}
