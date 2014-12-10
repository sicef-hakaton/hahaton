import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0

Rectangle {
    color: "#FFD080"
    signal titleClicked()
    property int zbuf: 5;

    function getDays(){
        var today = new Date();
                today.setDate(today.getDate()-examDate.getDate())
                return Qt.formatDate(today, "yyMMdd");
    }

    ScreenTitle
    {
        id: title
        text: "Scheduler"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20

        onExitTriggered: titleClicked()
    }
    Rectangle
    {
        id: titleSeparator
        width: parent.width
        height: 2
        anchors.top: title.bottom
    }
    ListView{
        id: list
        width:parent.width
        height: parent.height
        anchors.top: titleSeparator.bottom
        anchors.topMargin: 40
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        spacing:40
        model: classModel
        delegate: contactdelegate

    }
    Component
    {
        id:contactdelegate


        Rectangle
        {
            width: parent.width
            height: 30
            color:"transparent"

            Rectangle{
                id:rec
            color: "#DB552D"

            radius: 10
            height: 30
            width: parent.width*timeSpent/studyingTime
            anchors.left: parent.left
            Text{
                text: timeSpent + 'h'
                font.pixelSize: 15
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignHCenter
            }

           }
            Rectangle{
            color: "#FFEECC"

            radius: 10
            height: 30
            width: parent.width - rec.width
            anchors.left: rec.right
            Text{
                text: studyingTime-timeSpent + 'h'
                font.pixelSize: 15
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignHCenter
            }

           }
            Text{

                anchors.left: parent.left
                anchors.leftMargin: 10
                text: name
                font.pixelSize: 15
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignHCenter
            }




                Rectangle{
                    id: dropDown1
                    visible: false

                color: "#DB552D"

                radius: 10
                height: 150
                width: parent.width*timeSpent/studyingTime

                anchors.top: rec.bottom
                anchors.left: rec.left
                border.width: 1
                border.color: "black"
                z: parent.z;

               }
                Rectangle{
                    id: dropDown2
                    visible: false
                color: "#FFEECC"
                border.width: 1
                border.color: "black"
                radius: 10
                height: 150
                width: parent.width - rec.width
                anchors.top: rec.bottom
                anchors.left: dropDown1.right

                Text{
                   color: black
                   font.pixelSize: 15

                   text: "You have" + getDays() +"days left"
                }

            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: { dropDown1.visible = !dropDown1.visible; dropDown2.visible = !dropDown2.visible; parent.z = zbuf; zbuf += 1; }

            }
        }

}
}


