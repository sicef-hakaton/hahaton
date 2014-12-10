import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Rectangle {

    color: "#8080FF"
    signal titleClicked()

    //signal titleClicked()
    signal addNewClass(string name, string date, string info, int time)
    signal editClass(int index, string info, string date, int time)
    signal classPicked(int index)

    function clearFields()
    {
        nameInput.text = ""
        dateInput.text = ""
        infoInput.text = ""
        timeInput.text = ""
    }

    function convertToNumber(string)
    {
           return parseInt(string)
    }

    ScreenTitle
    {
        id: title
        text: "Classes"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20

        textColor: "white"

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
                onClicked: { addArea.visible = !addArea.visible  }//addNewClass()
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
        id: titleSeparator
        width: parent.width - 10
        height: 2
        anchors.top: title.bottom
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.rightMargin: 5
    }

    Rectangle
    {
        id: addArea
        color: "transparent"
        width: parent.width
        height: nameText.height + dateText.height + infoText.height + timeText.height + 5 * 10
        anchors.top: title.bottom
        anchors.left: parent.left
        visible: false

        Text
        {
            id: nameText
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.topMargin: 10
            font.pixelSize: 20
            text: "Name"
            color: "white"
            width: 100
        }

        Text
        {
            id: dateText
            anchors.left: parent.left
            anchors.top: nameText.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 10
            font.pixelSize: 20
            text: "Date"
            color: "white"
            width: 100
        }

        Text
        {
            id: infoText
            anchors.left: parent.left
            anchors.top: dateText.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 10
            font.pixelSize: 20
            text: "Additional Info"
            color: "white"
            width: 100
        }

        Text
        {
            id: timeText
            anchors.left: parent.left
            anchors.top: infoText.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 10
            font.pixelSize: 20
            text: "Time Remaining"
            color: "white"
            width: 100
        }


        TextField
        {
            id: nameInput
            anchors.left: nameText.left
            anchors.leftMargin: 200
            anchors.top: parent.top
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
            id: dateInput
            anchors.left: nameText.left
            anchors.leftMargin: 200
            anchors.top: nameInput.bottom
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
            id: infoInput
            anchors.left: nameText.left
            anchors.leftMargin: 200
            anchors.top: dateInput.bottom
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
            id: timeInput
            anchors.left: nameText.left
            anchors.leftMargin: 200
            anchors.top: infoInput.bottom
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

        ButtonClass
        {
            id: confirmButton
            anchors.bottom: dateText.bottom
            anchors.left: parent.left
            anchors.leftMargin: 400
            width: 200
            height: 50

            textItem.text: "Confirm"
            textItem.font.pixelSize: 18

            onButtonClicked:
            {
                addNewClass(nameInput.text, dateInput.text, infoInput.text, convertToNumber(timeInput.text))
                clearFields()
            }

        }

        ButtonClass
        {
            id: clearButton
            anchors.top: infoText.top

            anchors.left: parent.left
            anchors.leftMargin: 400
            width: 200
            height: 50

            textItem.text: "Clear"
            textItem.font.pixelSize: 18

            onButtonClicked: clearFields()

        }


    }


        Rectangle
        {
            id: gridBounds
            anchors.left: parent.left
            anchors.top: title.bottom
            width: parent.width
            height: parent.height/2
            color: "transparent"

  GridView
  {
      anchors.topMargin: addArea.visible ? addArea.height + 5 : 5
      anchors.top:  parent.top
      id: root
      width: (parent.width / parent.height) > parent.aspectRatio ? parent.height * 3 / 2 - 30 : parent.width - 30
      height: (parent.width / parent.height) < parent.aspectRatio ? parent.width * 2 / 3 - 30 : parent.height - 30

      currentIndex: -1
      property int size: 0
      cellWidth: 160
      cellHeight: 160

      model: classModel
      delegate: delegateRoot

      Behavior on anchors.topMargin
      {
          NumberAnimation { duration: 250; easing.type: Easing.OutQuad }
      }
      NumberAnimation {
                id: refreshAnim;
                target: delegateRoot
                property: "opacity";
                duration: 2000;
                easing.type:
                Easing.InOutQuad;
                running: false
                from: 0.0
                to: 1.0

            }

      onModelChanged:
      {
              //refreshAnim.start()
      }

      Component
      {
          id: delegateRoot

          Rectangle
          {
              id: delegateBound
              width: root.cellWidth
              height: root.cellHeight

              color: "transparent"



              Rectangle
              {
                  id: itemArea
                  anchors.margins: 10
                  anchors.fill: parent
                  color: index == root.currentIndex ? "#FFCC80" : "#FF6600"

                        NumberAnimation {
                                  id: refreshAnim;
                                  target: itemArea
                                  property: "opacity";
                                  duration: 2000;
                                  easing.type:
                                  Easing.InOutQuad;
                                  running: false
                                  from: 0.0
                                  to: 1.0

                              }

                  Behavior on color
                        {
                            ColorAnimation { duration: 200 }
                        }

                  Component.onCompleted:
                  {
                      root.size += 1;

                            if (index == root.size - 1)
                            {
                                refreshAnim.start()
                            }
                  }

                  Text
                  {
                      id: visualTitle
                      text: model.name
                      width: parent.width
                      font.pixelSize: parent.height / 4
                      wrapMode: Text.WordWrap

                      anchors.left: parent.left
                      anchors.top: parent.top
                  }

                  Text
                  {
                      id: subtitle
                      font.pixelSize: parent.height / 10
                      text: model.info
                      width: parent.width

                      wrapMode: Text.WordWrap

                      anchors.top: visualTitle.bottom
                      anchors.left: parent.left
                  }

                  Text
                  {
                      id: examTitle
                      font.pixelSize: parent.height/10
                      text: "Exam on: " + model.examDate
                      width:parent.width

                      wrapMode: Text.WordWrap

                      anchors.top: subtitle.bottom
                      anchors.left: parent.left
                  }
                  Text
                  {
                      id: remainingTime
                      font.pixelSize: parent.height/10
                      text: "Remaining time: " + model.studyingTime + "h"
                      width: parent.width

                      wrapMode: Text.WordWrap

                      anchors.bottom: parent.bottom
                      anchors.left: parent.left
                      anchors.bottomMargin: 10
                  }

                  MouseArea
                  {
                      anchors.fill:  parent

                      onClicked:
                      {
                          root.currentIndex = index;
                          console.log("index: " + index + model.name);
                          classPicked(index);
                      }
                  }
              }
          }
      }
            }
}
        Rectangle
        {
            id: classSeparator
            width: root.width
            height: 2
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            color: "transparent"
        }

        Rectangle
        {
            color: "transparent"
            width: parent.width
            height: parent.height/2
            anchors.top: gridBounds.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            FileOpener
            {
                objectName: "FileOpener"
                width: root.width/3
                height: 100
                anchors.top: parent.top
                anchors.left: parent.left
                model: openableModel
            }
        }




}
