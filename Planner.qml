import QtQuick 2.3
import QtQml.Models 2.1

import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.1
import SqlEventModel 1.2


Flow {
    id: row
    anchors.fill: parent
    anchors.margins: 20
    spacing: 10
    layoutDirection: Qt.RightToLeft

    SqlEventModel {
        id: eventModel
    }

    Calendar {
        id: calendar
        width: (parent.width > parent.height ? parent.width * 0.6 - parent.spacing : parent.width)
        height: (parent.height > parent.width ? parent.height * 0.6 - parent.spacing : parent.height)
        frameVisible: true
        weekNumbersVisible: true
        selectedDate: new Date(2014, 10, 23)
        focus: true

        property alias eventName: eventText.text
        property alias partnerName: partnerText.text
        property alias start: startText.text

        //
//        onDoubleClicked:
//        {
//            eventModel.addEvent(eventName, partnerName, calendar.selectedDate, start);
//            eventsListView.model = eventModel.eventsForDate(calendar.selectedDate)
//        }
        onClicked:
        {
            eventsListView.model = eventModel.eventsForDate(calendar.selectedDate);
        }


        style: CalendarStyle {
            dayDelegate: Item {
                readonly property color sameMonthDateTextColor: "#444"
                readonly property color selectedDateColor: "#3778d0"
                readonly property color selectedDateTextColor: "white"
                readonly property color differentMonthDateTextColor: "#bbb"
                readonly property color invalidDatecolor: "#dddddd"

                Rectangle {
                    anchors.fill: parent
                    border.color: "transparent"
                    color: styleData.date !== undefined && styleData.selected ? selectedDateColor : "transparent"
                    anchors.margins: styleData.selected ? -1 : 0
                }

                Image {
                    id: img
                    visible: eventModel.eventsForDate(styleData.date).length > 0
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.margins: -1
                    width: 12
                    height: width
                    source: "../eventindicator.png"
                }

                Label {
                    id: dayDelegateText
                    text: styleData.date.getDate()
                    anchors.centerIn: parent
                    color: {
                        var color = invalidDatecolor;
                        if (styleData.valid) {
                            // Date is within the valid range.
                            color = styleData.visibleMonth ? sameMonthDateTextColor : differentMonthDateTextColor;
                            if (styleData.selected) {
                                color = selectedDateTextColor;
                            }
                        }
                        color;
                    }
                }
            }
        }
    }

    Component {
        id: eventListHeader

        Row {
            id: eventDateRow
            width: parent.width
            height: eventDayLabel.height
            spacing: 10

            Label {
                id: eventDayLabel
                text: calendar.selectedDate.getDate()
                font.pointSize: 35
            }

            Column {
                height: eventDayLabel.height

                Label {
                    readonly property var options: { weekday: "long" }
                    text: Qt.locale().standaloneDayName(calendar.selectedDate.getDay(), Locale.LongFormat)
                    font.pointSize: 18
                }
                Label {
                    text: Qt.locale().standaloneMonthName(calendar.selectedDate.getMonth())
                          + calendar.selectedDate.toLocaleDateString(Qt.locale(), " yyyy")
                    font.pointSize: 12
                }

            }
        }
    }

    Rectangle {
        width: (parent.width > parent.height ? parent.width * 0.4 - parent.spacing : parent.width)
        height: (parent.height > parent.width ? parent.height * 0.4 - parent.spacing : parent.height)
        border.color: Qt.darker(color, 1.2)

        ListView {
            id: eventsListView
            spacing: 4
            clip: true
            header: eventListHeader
            anchors.fill: parent
            anchors.margins: 10
            model: eventModel.eventsForDate(calendar.selectedDate)

            delegate: Rectangle {

                MouseArea {
                    anchors.fill: parent
                    //
                    onDoubleClicked:
                    {
                        console.log(index);
                        console.log(modelData.name);
                        eventModel.removeEvent(modelData.name)
                        eventsListView.model = eventModel.eventsForDate(calendar.selectedDate)
                    }
                    onClicked:
                    {
                        eventsListView.model = eventModel.eventsForDate(calendar.selectedDate)
                    }
                }

                width: eventsListView.width
                height: eventItemColumn.height
                anchors.horizontalCenter: parent.horizontalCenter

                Image {
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    width: 12
                    height: width
                    source: "../eventindicator.png"
                }

                Rectangle {
                    width: parent.width
                    height: 1
                    color: "#eee"
                }

                Column {
                    id: eventItemColumn
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.right: parent.right
                    height: timeLabel.height + nameLabel.height + 10

                    Label {
                        id: nameLabel
                        width: parent.width
                        wrapMode: Text.Wrap
                        text: modelData.name
                    }
                    Label {
                        id: partnerLabel
                        width: parent.width
                        wrapMode: Text.Wrap
                        text: "with " + modelData.partner
                    }
                    Label {
                        id: timeLabel
                        width: parent.width
                        wrapMode: Text.Wrap
                        text: modelData.startDate.toLocaleTimeString(calendar.locale, Locale.ShortFormat)
                        color: "#aaa"
                    }
                }


                }

        }

        Row
        {
            spacing: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom:parent.bottom


            Column {
                Text {
                    text: "Name "
                    font.pixelSize: 16
                }

                Text {
                    text: "Partner "
                    font.pixelSize: 16
                }

                Text {
                    text: "Time "
                    font.pixelSize: 16
                }
            }

            Column {

                id: col2

                TextField {
                    id: eventText
                    width: 100
                    height: 20
                }

                TextField {
                    id: partnerText
                    width: 100
                    height: 20
                }
                TextField {
                    id: startText
                    width: 100
                    height: 20
                }
            }

            Column {
                anchors.verticalCenter: parent.verticalCenter
                ButtonClass {
                    width: 50
                    height: 20
                    textItem.text: "Add"
                    onButtonClicked: {
                        eventModel.addEvent(calendar.eventName, calendar.partnerName, calendar.selectedDate, calendar.start);
                        eventsListView.model = eventModel.eventsForDate(calendar.selectedDate);
                        eventText.text = "";
                        partnerText.text = "";
                        startText.text = "";
                    }
                }
            }

        }

//                Row
//                {
//                    anchors.top: eventLabel.bottom
//                    anchors.left: parent.left
//                    Text {
//                        id: newPartnerLabel
//                        text: "Partner: "
//                        width: 50
//                        height: 20
//                    }

//                    TextField {
//                        id: partnerText
//                        width: 100
//                        height: 20
//                        onTextChanged: currentPartner = text;
//                    }
//                }
//                Row
//                {
//                    anchors.top: newPartnerLabel.bottom
//                    anchors.left: parent.left
//                    Text {
//                        id: startLabel
//                        text: "Start time: "
//                        width: 70
//                        height: 20
//                    }

//                    TextField {
//                        id: startText
//                        width: 100
//                        height: 20
//                        onTextChanged: currentTime = text;
//                    }
//                }
            }
}
