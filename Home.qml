import QtQuick 2.3
import QtQml.Models 2.1

Rectangle
{
    id: rootRect

    property double aspectRatio: 3/2;

    property string chosenString: "";

    signal screenChosen();

    color: "#004050"

    FontLoader { id: titleFont; source: "Savor.ttf" }

    GridView
    {
        anchors.centerIn: parent
        id: root
        width: (parent.width / parent.height) > parent.aspectRatio ? parent.height * 3 / 2 - 30 : parent.width - 30
        height: (parent.width / parent.height) < parent.aspectRatio ? parent.width * 2 / 3 - 30 : parent.height - 30

        cellWidth: width / 3
        cellHeight: height / 2

        model: colorModel
        delegate: delegateRoot

        ListModel
        {
            id: colorModel
            ListElement
            {
                title: "Planner";
                subtitle: "Take a look at your schedule";
                color: "#8080FF";
                link: "plannerScreen"
                imgSrc: "calendar.png"
            }
            ListElement
            {
                title: "Classes";
                subtitle: "Review your deadlines and resources";
                color: "#80FF80";
                link: "classesScreen"
                imgSrc: "book.png"
            }
            ListElement
            {
                title: "Notes";
                subtitle: "Create notes & share them";
                color: "#FF8080"
                link: "notesScreen"
                imgSrc: "note.png"
            }
            ListElement
            {
                title: "Useful Links";
                subtitle: "Browse your library of hyperlinks";
                color: "#FFFF80"
                link: "linksScreen"
                imgSrc: "link.png"
            }
            ListElement
            {
                title: "Scheduler";
                subtitle: "Let the app help you sort out the time";
                color: "#FFD080"
                link: "tipsScreen"
                imgSrc: "watch.png"
            }
            ListElement
            {
                title: "Other Stuff ";
                subtitle: "For all the cool stuff besides studying";
                color: "#FF80FF"
                link: "otherScreen"
                imgSrc: "sun.png"
            }
        }

        Component
        {
            id: delegateRoot

            Rectangle
            {
                width: root.cellWidth
                height: root.cellHeight

                color: "transparent"

                Rectangle
                {
                    anchors.margins: 30
                    anchors.fill: parent

                    color: "#DB552D"
                    Text
                    {
                        id: visualTitle
                        text: model.title
                        color: "white"
                        width: parent.width
                        font.pixelSize: parent.height / 6
                        font.family: titleFont.name
                        wrapMode: Text.WordWrap

                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter
                        anchors.top: parent.top
                        anchors.topMargin: 5
                    }

                    Image
                    {
                        id: img
                        source: model.imgSrc
                        width:  parent.height / 3
                        height: parent.height / 3

                        fillMode: Image.PreserveAspectCrop
                        anchors {centerIn: parent; }
                    }

                    Text
                    {
                        font.pixelSize: parent.height / 10
                        text: model.subtitle
                        width: parent.width
                        color: "white"
                        wrapMode: Text.WordWrap
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter

                        anchors.bottom: parent.bottom
                        //anchors.left: parent.left
                        //anchors.leftMargin: 5
                        anchors.bottomMargin: 5
                    }

                    MouseArea
                    {
                        anchors.fill:  parent

                        onClicked:
                        {
                            rootRect.chosenString = model.link;
                            screenChosen();
                        }
                    }
                }
            }
        }



//           MouseArea {
//                id: delegateRoot

//                property int visualIndex: colorModel.index

//                width: 80; height: 80
//                drag.target: icon

//                Rectangle {
//                    id: icon
//                    width: 72; height: 72
//                    anchors {
//                        horizontalCenter: parent.horizontalCenter;
//                        verticalCenter: parent.verticalCenter
//                    }
//                    color: colorModel.color
//                    radius: 3

//                    Drag.active: delegateRoot.drag.active
//                    Drag.source: delegateRoot
//                    Drag.hotSpot.x: 36
//                    Drag.hotSpot.y: 36

//                    states: [
//                        State {
//                            when: icon.Drag.active
//                            ParentChange {
//                                target: icon
//                                parent: root
//                            }

//                            AnchorChanges {
//                                target: icon;
//                                anchors.horizontalCenter: undefined;
//                                anchors.verticalCenter: undefined
//                            }
//                        }
//                    ]
//                }

//                DropArea {
//                    anchors { fill: parent; margins: 15 }

//                    onEntered: colorModel.items.move(drag.source.visualIndex, delegateRoot.visualIndex)
//                }
//            }

    }
}
