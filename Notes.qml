import QtQuick 2.0
import QtQml.Models 2.1

Rectangle {
    color: "#FF8080"
    width: parent.width
    height:parent.height



    ListView{
        id: list
        width: parent.width
        height: parent.height
        anchors.top: titleSeparator.bottom
        spacing: 50
        model: contactModel
        delegate: contactdelegate
        boundsBehavior: Flickable.StopAtBounds
    }
    Component
    {
        id: contactdelegate

            Rectangle {
                id: notes
                color: "#8080FF"
                width: parent.parent.width
                height:parent.parent.height/3
             //   width: rowArea.width
                anchors.centerIn: parent.parent

                border.width: 1

                Row{
                    id: rowArea
                    spacing: 10
                    Repeater{
                        model: 2
                        Rectangle{
                            width: notes.width/4
                            height: notes.height
                            anchors.bottomMargin: 30
                            anchors.top: title.bottom -5
                            color: "blue"
                        }
                    }
                }

        }
    }


}
