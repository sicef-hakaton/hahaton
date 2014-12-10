import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Rectangle {

    color: "#FF8080"
    signal titleClicked()
    signal addNewNote(string className, string note)

    signal editClass(int index, string info, string date, int time)

    function clearFields()
    {
        classInput.text = ""
        pointInput.text = ""
    }

    ScreenTitle
    {
        id: title
        text: "Notes"
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
        anchors.top: title.bottom
        height: classText.height + pointText.height+ 5 * 10
        anchors.left: parent.left
        visible: false

        Text
        {
            id: classText
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.topMargin: 10
            font.pixelSize: 20
            text: "Class"
            color: "white"
            width: 100
        }

        Text
        {
            id: pointText
            anchors.left: parent.left
            anchors.top: classText.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 10
            font.pixelSize: 20
            text: "Point"
            color: "white"
            width: 100
        }



        TextField
        {
            id: classInput
            anchors.left: classText.left
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
            id: pointInput
            anchors.left: classText.left
            anchors.leftMargin: 200
            anchors.top: classInput.bottom
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
            anchors.top: classText.top
            anchors.left: parent.left
            anchors.leftMargin: 400
            width: 200
            height: 50

            textItem.text: "Confirm"
            textItem.font.pixelSize: 18

            onButtonClicked:
            {
                addNewNote(classInput.text, pointInput.text)
                clearFields()
            }

        }

        ButtonClass
        {
            id: clearButton
            anchors.top: confirmButton.bottom

            anchors.left: parent.left
            anchors.leftMargin: 400
            anchors.topMargin: 5
            width: 200
            height: 50

            textItem.text: "Clear"
            textItem.font.pixelSize: 18

            onButtonClicked: clearFields()

        }


    }


  GridView
  {
      anchors.topMargin: addArea.visible ? addArea.height + 10 : 5
      anchors.top:  title.bottom
      id: root
      width: (parent.width / parent.height) > parent.aspectRatio ? parent.height * 3 / 2 - 30 : parent.width - 30
      height: (parent.width / parent.height) < parent.aspectRatio ? parent.width * 2 / 3 - 30 : parent.height - 30

      currentIndex: -1
      property int size: 0
      cellWidth: 160
      cellHeight: 160

      model: noteModel
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
              height: index == root.currentIndex ? root.cellHeight * 2 : root.cellHeight

              color: "transparent"

              Behavior on height
                    {
                        NumberAnimation
                        {
                            duration: 500; easing.type: Easing.InQuad;
                        }
                    }


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

                        FontLoader {id: scriptfont; source: "Segoe Script Regular.ttf"}

                  Text
                  {
                      id: visualTitle
                      text: link
                      width: parent.width
                      font.pixelSize: parent.width / 8
                            font.family: scriptfont.name
                      wrapMode: Text.WordWrap

                      anchors.horizontalCenter: parent.horizontalCenter
                      anchors.top: parent.top
                            anchors.topMargin: 5
                            horizontalAlignment: Text.AlignHCenter
                  }

                  Text
                  {
                      id: subtitle
                      text: tag
                      width: parent.width
                      font.pixelSize: parent.width / 11
                            font.family: scriptfont.name
                      wrapMode: Text.WordWrap

                      anchors.top: visualTitle.bottom
                            anchors.topMargin: 20
                      anchors.left: parent.left
                  }


                  MouseArea
                  {
                      anchors.fill:  parent

                      onClicked:
                      {
                          root.currentIndex = index
                          console.log("index: " + index + model.name)


                      }
                  }
              }
          }
      }
}

}
