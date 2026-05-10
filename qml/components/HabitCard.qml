import QtQuick 2.4
import Ubuntu.Components 1.3

Rectangle {

    id: root

    width: parent.width
    height: 120

    radius: 18

    color: completed
           ? "#d4edda"
           : "#ffffff"

    border.color: "#cccccc"

    property string habitName
    property int streak
    property bool completed
    property int habitId

    signal toggleClicked(int id, bool checked)
    signal deleteClicked(int id)

    Column {

        anchors.fill: parent
        anchors.margins: 14

        spacing: 12

        Row {

            spacing: 12

            CheckBox {

                id: habitCheck

                checked: root.completed

                onClicked: {

                    root.toggleClicked(
                        root.habitId,
                        checked
                    )
                }
            }

            Text {

                text: root.habitName

                font.pixelSize: 24

                font.bold: true

                color: "#222"
            }
        }

        Row {

            spacing: 20

            Rectangle {

                width: 110
                height: 35

                radius: 12

                color: "#ff9800"

                Text {

                    anchors.centerIn: parent

                    text: "🔥 " + root.streak

                    color: "white"

                    font.bold: true
                }
            }

            Button {

                text: "Delete"

                onClicked: {

                    root.deleteClicked(
                        root.habitId
                    )
                }
            }
        }
    }
}
