import QtQuick 2.0

Rectangle {
    property alias thickness: height
    property alias height: width

    width: 100
    height: 62

    rotation: 90

    gradient: Gradient {
                GradientStop {
            position: 0.0;
            color: "white";
            }
                GradientStop {
            position: 1.0;
            color: "blue";
            }
        }


}
