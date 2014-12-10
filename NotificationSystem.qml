import QtQuick 2.0
import QtQuick.Controls 1.2

Rectangle
{
    id: bounds

    property Rectangle attachee;

    property string activeTitle;
    property string activeMessage;
    property string activePos;
    property string activeNeg;
    property string activeImage;
    property string activeIndex;

    signal notifClicked()

    function removeActive()
     {
        myModel.remove(activeIndex)
     }

    ListView
    {
        anchors.top: parent.top
        anchors.right: parent.right
        id: myList
        orientation: ListView.Horizontal
        delegate: myDelegate
        model: myModel

        width: 60
        height: 30

    }

    ListModel
    {
        id: myModel



        ListElement
        {
            imageSource: "whitecontact.png"
            title: "Friend Request"
            message: "Person AB wants to be friends with you."
            pos: "Accept"
            neg: "Reject"
        }

        ListElement
        {
            imageSource: "book.png"

            title: "Study Opportunity"
            message: "It appears that one of your friends also has to study computer graphics in a few days. Would you like to join?"
            pos: "Yes"
            neg: "No thanks"

        }
    }

    Component
    {
        id: myDelegate

        Rectangle
        {

            width: 30
            height: 30

            color: "#FFD000"

            Behavior on color
            {
                ColorAnimation {duration: 300}
            }

            Image
            {
                width: 25
                height: 25
                anchors.centerIn: parent
                source: model.imageSource
                fillMode: Image.PreserveAspectCrop
            }

            MouseArea
            {
                anchors.fill: parent

                hoverEnabled: true

                onEntered: parent.color = "red"
                onExited: parent.color = "#FFD000"

                onClicked:
                {
                    activeTitle = model.title;
                    activeMessage = model.message;
                    activePos = model.pos;
                    activeNeg = model.neg;
                    activeImage = model.imageSource;
                    activeIndex = index;

                    notifClicked()
                }


            }
        }
    }


}
