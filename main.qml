import QtQuick 2.3
import QtQuick.Controls 1.2

ApplicationWindow {
    id: rootWindow
    visible: true
    width: 1366
    height: 768
    title: qsTr("Hello World")

    color: "black"

    signal debugSignal()

    property int screenHeight: height - titleBar.height - statusBar.height - 10
    property int screenWidth:  width  - contacts.width - 10

    property bool contactsVisible: true

    property string userName;

    Rectangle
    {
        id: baseRect
        width: parent.width
        height: parent.height
        color: "#FF8000"

        Rectangle
        {
            id: titleBar
            height: 30
            width: parent.width - profileArea.width

            color: "transparent"

            anchors.right: parent.right
            anchors.rightMargin: 35
            anchors.top: parent.top

            NotificationSystem
            {
                id: notifSystem
                anchors.right: parent.right
                anchors.rightMargin: 2.5
            }
        }


        Rectangle
        {
            id: profileArea

            color: "#FFEECC"

            width: contacts.width - 5
            anchors.top: titleBar.bottom
            anchors.topMargin: 5
            height: 200 - titleBar.height

            Image
            {
                id: pic
                source: "fractal.jpg"

                height: 100
                width: 100

                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.topMargin: 5
                anchors.top: parent.top
            }

            Text
            {
                text: "Random User"
                anchors.left: pic.right
                anchors.leftMargin: 5
                anchors.top: pic.top
                anchors.topMargin: 5
                width: parent.width - pic.width - 10
                wrapMode: Text.Wrap
                font.pixelSize: 30
            }

            Text
            {
                id: statusText
                anchors.left: pic.left
                anchors.leftMargin: 5
                anchors.top: pic.bottom
                anchors.topMargin: 5
                width: parent.width - 10
                wrapMode: Text.Wrap

                text: "Arriving somewhere, but not here..."

                font.pixelSize: 20
            }
        }

        Rectangle
        {
            id: contacts

            height: parent.height - statusBar.height - titleBar.height - profileArea.height - 10
            anchors.top: profileArea.bottom
            anchors.topMargin: 5

            width: parent.width / 4

            color: "blue"

            Behavior on x
            {
                NumberAnimation { duration: 250; easing.type: Easing.OutQuint }

            }

            ContactBar
            {
                objectName: "ContactBar"
                anchors.fill: parent
            }
        }

        Rectangle
        {
            width: 10
            height: parent.width
            color: "#FF8000"

            anchors.top: titleBar.bottom
            anchors.horizontalCenter: contacts.right

            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    if (contactsVisible)
                    {
                        contacts.x -= rootWindow.width / 5

                    }
                    else
                    {
                        contacts.x += rootWindow.width / 5
                    }

                    contactsVisible = !contactsVisible

                    console.log("contact bar retracted!")
                }
            }
        }

        Rectangle
        {
            id: screenContainer

            color: "#004050"

            width: contactsVisible ? screenWidth : screenWidth + rootWindow.width / 5
            height: screenHeight

            anchors.top: titleBar.bottom
            anchors.topMargin: 5
            anchors.left: contacts.right
            anchors.leftMargin: 5

            Behavior on width
            {
                NumberAnimation { duration: 250; easing.type: Easing.OutQuint }
            }

            HomeScreen
            {
                id: homeScreen
                objectName: "homeScreen"

                color: parent.color

                width: parent.width
                height: parent.height

                visible: false

            }

            PlannerScreen
            {
                id: plannerScreen
                objectName: "plannerScreen"

                color: parent.color

                width: parent.width
                height: parent.height


                visible: false
            }

            ClassesScreen
            {
                id: classesScreen
                objectName: "classesScreen"

                color: parent.color

                width: parent.width
                height: parent.height


                visible: false
            }

            NotesScreen
            {
                id: notesScreen
                objectName: "notesScreen"

                color: parent.color

                width: parent.width
                height: parent.height

                visible: false
            }

            LinksScreen
            {
                id: linksScreen
                objectName: "linksScreen"

                width: parent.width
                height: parent.height
                color: parent.color


                visible: false
            }

            SchedulerScreen
            {
                id: tipsScreen
                objectName: "tipsScreen"

                width: parent.width
                height: parent.height
                color: parent.color

                visible: false
            }

            OtherScreen
            {
                id: otherScreen
                objectName: "otherScreen"
                color: parent.color

                width: parent.width
                height: parent.height

                visible: false
            }
        }



        Rectangle
        {
            id: statusBar
            height: 30
            width: parent.width

            color: "lightsteelblue"

            anchors.left: parent.left
            anchors.bottom: parent.bottom
        }
    }

    Rectangle
    {
        id: loginScreen
        width: parent.width
        height: parent.height

        objectName: "loginScreen"

        color: screenContainer.color
        anchors.centerIn: parent

        property int rightOffset: -2000


        NumberAnimation on rightOffset { from: -2000; to: 400; duration: 1000; easing.type: Easing.OutQuad}

        signal loginClicked(string arg)



        visible: true

        Behavior on opacity
        {
            NumberAnimation { duration: 300; onStopped: {loginScreen.visible = false; loginScreen.x -= 2000} }
        }

        //MouseArea
        //{
        //    anchors.fill: parent
        //}

        FontLoader { id: titleFont; source: "Savor.ttf" }

        Image
        {
            id: cap
            source: "icon-cap.png"

            anchors.bottom: titleText.top
            anchors.bottomMargin: -50
            anchors.right: titleText.right
            anchors.rightMargin: 30
        }

        Text
        {
            id: titleText
            text: "UniForms"
            font.family: titleFont.name
            font.pixelSize: 150
            color: "#FFC080"

            anchors.leftMargin: 150
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 300

            NumberAnimation on opacity { from: 0.0; to: 1.0; duration: 1000 }

        }


        Text
        {
            text: "Accelerating your studies"

            font.pixelSize: 30
            color: "white"


            anchors.left: titleText.left
            anchors.top: titleText.top
            anchors.topMargin: 160


        }

        Text
        {
            id: userText
            text: "User Name"
            font.pixelSize: 15
            color: "white"

            anchors.top: parent.top
            anchors.topMargin: 300
            anchors.rightMargin: parent.rightOffset - width
            anchors.right: parent.right
        }

        TextField
        {
            id: userInput
            anchors.top: userText.bottom
            anchors.topMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: parent.rightOffset - width
            style: TFieldStyle
            {
              background:
                  Rectangle
              {
                  radius: 2
                  implicitWidth: 200
                  implicitHeight: 36
                  border.color: "#FF8000"
                  border.width: 1
                  color: "transparent"
              }
            }
        }

        Text
        {
            id: passText
            text: "Password"
            font.pixelSize: 15
            color: "white"

            anchors.top: userInput.bottom
            anchors.topMargin: 15
            anchors.rightMargin: parent.rightOffset - width
            anchors.right: parent.right
        }

        TextField
        {
            id: passInput
            anchors.top: passText.bottom
            anchors.topMargin: 15
            anchors.right: parent.right
            anchors.rightMargin: parent.rightOffset - width
            style: TFieldStyle
            {
              background:
                  Rectangle
              {
                  radius: 2
                  implicitWidth: 200
                  implicitHeight: 36
                  border.color: "#FF8000"
                  border.width: 1
                  color: "transparent"
              }
            }
        }


        ButtonClass
        {
            id: loginButton
            textItem.text: "Log In"

            anchors.top: passInput.bottom
            anchors.topMargin: 50
            anchors.right: parent.right
            anchors.rightMargin: parent.rightOffset - width

            onButtonClicked:
            {
                parent.opacity -= 1.0
            }

        }

        ButtonClass
        {
            textItem.text: "Offline Mode"

            anchors.top: loginButton.bottom
            anchors.topMargin: 30
            anchors.right: parent.right
            anchors.rightMargin: parent.rightOffset - width

            onButtonClicked:
            {
                parent.loginClicked("lol")
            }
        }
    }

        Rectangle
        {
            id: notifBox

            x: 2000
            y: -2000
            width: 500
            height: 300

            color: "#004050"

            property alias titleText: boxTitle.text
            property alias messageText: boxMsg.text
            property alias boxImage: boxImage.source
            property string yesText;
            property string noText;

            z: 200

            Behavior on x
            {
                NumberAnimation { duration: 500; easing.type: Easing.OutQuad }
            }

            Behavior on y
            {
                NumberAnimation { duration: 500; easing.type: Easing.OutQuad }
            }

            Text
            {
                id: boxTitle
                font.pixelSize: 40
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 10
                anchors.top: parent.top
                color: "#FF8000"
            }

            Rectangle
            {
                anchors.top: boxTitle.bottom
                height: 2
                color: "#FF8000"
                width: parent.width - 10
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image
            {
                id: boxImage
                width: 80
                height: 80

                anchors.top: boxTitle.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text
            {
                id: boxMsg

                color: "white"
                anchors.top: boxImage.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
                width: parent.width - 10

                wrapMode: Text.WordWrap

            }

            ButtonClass
            {
                id: yesButton

                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 50

                width: 100
                height: 40

                textItem.text: parent.yesText

                onButtonClicked:
                {
                    parent.x = 2000
                    parent.y = -2000
                }
            }

            ButtonClass
            {
                id: noButton

                width: 100
                height: 40

                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.right: parent.right
                anchors.rightMargin: 50

                textItem.text: parent.noText

                onButtonClicked:
                {
                    parent.x = 2000
                    parent.y = -2000

                    notifSystem.removeActive()
                }
            }

        }

        Connections
        {
            target: notifSystem
            onNotifClicked: { showMessageBox(); console.log("notif clicked"); }
        }

        function showMessageBox()
        {
            notifBox.x = baseRect.x + baseRect.width / 2 - notifBox.width / 2
            notifBox.y = baseRect.y + baseRect.height / 2- notifBox.height / 2
            console.log("X: " + notifBox.x + "Y: " + notifBox.y);
            notifBox.titleText = notifSystem.activeTitle;
            notifBox.messageText = notifSystem.activeMessage;
            notifBox.boxImage = notifSystem.activeImage;
            notifBox.yesText = notifSystem.activePos;
            notifBox.noText = notifSystem.activeNeg;
        }
}
