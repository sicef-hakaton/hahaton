import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2


Rectangle {
    id: container
    color: "#8E2323"

    //signal titleClicked()
    signal asd()
    signal addNewLink(string link, string tag)

    function clearFields()
        {
           linkInput.text = ""
           tagInput.text = ""

        }

   // onAsd: addNewLink(linkInput.text, tagInput.text)

//    onAddNewLink: addNewLink()

    signal titleClicked()

    ScreenTitle
    {
        id: title
        text: "Useful Links"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20

        onExitTriggered: titleClicked()

        Rectangle
        {
            id: addNew
            width: 40
            height: 40
            anchors.right: parent.right
            anchors.margins: 50

            color: "transparent"

            MouseArea
            {
                anchors.fill: parent
                onClicked: addArea.visible = !addArea.visible;  //addNewClass()
            }
            Rectangle
            {
                id: plus1
                width: 10
                height: 40
                anchors.horizontalCenter: parent.horizontalCenter
                visible: !addArea.visible
            }

            Rectangle
            {
                id: plus2
                width: 40
                height: 10
                anchors.verticalCenter: plus1.verticalCenter

            }
        }
    }


    Rectangle
    {
        id: addArea
        color: "transparent"
        width: parent.width
        height: confirmButton.height + clearButton.height + 2 * 10
        anchors.top: title.bottom
        anchors.left: parent.left
        visible: false

        Text
        {
            id: linkText
            anchors.left: parent.left
            anchors.bottom: confirmButton.bottom
            anchors.leftMargin: 10
            font.pixelSize: 20
            text: "Link"
            color: "white"
            width: 100
        }

        Text
        {
            id: tagText
            anchors.left: parent.left
            anchors.top: clearButton.top
            anchors.leftMargin: 10
            font.pixelSize: 20
            text: "Tag"
            color: "white"
            width: 100
        }



        TextField
        {
            id: linkInput
            anchors.left: linkText.left
            anchors.bottom: confirmButton.bottom
            anchors.leftMargin: 200
            anchors.topMargin: 10

            style: TextFieldStyle
            {
            textColor: "white"
            font.pixelSize: 15
                background: Rectangle {
                    radius: 2
                    implicitWidth: 150
                    implicitHeight: 24
                    border.color: "#FF8000"
                    border.width: 1
                    color: "transparent"
                }
            }
        }

        TextField
        {
            id: tagInput
            anchors.left: tagText.left
            anchors.leftMargin: 200
            anchors.top: clearButton.top

            style: TextFieldStyle
            {
                textColor: "white"
               // font.pixelSize: 15
                background: Rectangle {
                    radius: 2
                    implicitWidth: 150
                    implicitHeight: 24
                    border.color: "#FF8000"
                    border.width: 1
                    color: "transparent"
                }
            }
        }

        ButtonClass
        {
            id: confirmButton
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: tagInput.right
            anchors.leftMargin: 10
            width: 200
            height: 50

            textItem.text: "Confirm"
            textItem.font.pixelSize: 18

            onButtonClicked:
            {
                addNewLink(linkInput.text, tagInput.text)
                clearFields()
            }

        }

        ButtonClass
        {
            id: clearButton
            anchors.top: confirmButton.bottom
            anchors.topMargin: 10
            anchors.left: tagInput.right
            anchors.leftMargin: 10
            width: 200
            height: 50

            textItem.text: "Clear"
            textItem.font.pixelSize: 18

            onButtonClicked: clearFields()

        }


    }




    Rectangle
    {
        id: listBounds
        //anchors.top: title.bottom
        color: "transparent"
        width: parent.width
        height: parent.height - title.height
        anchors.topMargin: addArea.visible ? addArea.height + 5 : 5;
        anchors.top:  title.bottom

            Behavior on anchors.topMargin
            {
                NumberAnimation { duration: 250; easing.type: Easing.OutQuad }
            }

        ListView
        {
            id: list
            width: parent.width
            height: parent.height
            model: linkModel
            delegate: linkDelegate
            boundsBehavior: Flickable.StopAtBounds
        }

        Component
        {
            id: linkDelegate

            Rectangle
            {
                id: delegateArea

                color: index % 2 ? "#FF8866" : "#FFCC88"
                height: 30
                width: container.width


                    Text
                    {
                        id: fullTag
                        text: tag

                        //text: link

                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 10
                        color: "black"
                        font.pointSize: 14
                        width:300

                    }

                    Text
                    {

                        id: fullLink
                        text: '<html><style type="text/css"></style><a href="'+link+'">'+link+'</a></html>'

                        anchors.left: fullTag.right
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 14
                        onLinkActivated: Qt.openUrlExternally(link);
                    }



//                Column{
//                    id: linksColumn
//                    //spacing: 10

////                    anchors{
////                        top: title.bottom
////                    }


//                    Row{
//                        id:linkRow
//                        //anchors.top: linksColumn.bottom

//                        Text {
//                            id: fullTag
//                            text: tag

//                            //text: link

//                            anchors.leftMargin: 10
//                            color: "black"
//                            font.pointSize: 14
//                            width:300


//                        }

//                        Text
//                        {

//                        id: fullLink
//                        text: '<html><style type="text/css"></style><a href="'+link+'">'+link+'</a></html>'

//                        anchors.left: fullTag.right
//                        anchors.leftMargin: 10
//                        anchors.top: fullname.bottom
//                        font.pointSize: 14
//                        onLinkActivated: Qt.openUrlExternally(link);
//                        }

//                    }
//                }
            }
        }
    }

    Rectangle
    {
        id: titleSeparator
        width: parent.width - 10
        height: 2
        anchors.top: title.bottom
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.rightMargin: 5
    }

}




