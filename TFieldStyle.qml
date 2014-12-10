import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

TextFieldStyle
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
