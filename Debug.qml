import QtQuick 2.3
import QtQuick.Controls 1.2


Rectangle {


    Text {
        id: brojac
        property int counter: 0
        text: qsTr("Hello World + clicked " + counter)
        anchors.centerIn: parent
    }

    Button
    {
        width: 200
        height: 50



        text: qsTr("Klikni me")
        y: 100
        x: 100

        onClicked: {
            debugSignal();
            brojac.counter = brojac.counter + 1
            large.text += large.adicija + '\n'
        }
    }

    Text
    {
        property string adicija: "HAHATON"
        id: large
        x: 0
        y: 150

    }

    Button
    {
        width: 200
        height: 50

        id: realButton

        text: qsTr("GOTO real")
        y: 200
        x: 200

        onClicked:
        {

        }
    }
}
