import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
    title: "Pomodoro"

    property int remainingSeconds: 1500

    Timer {
        id: pomodoroTimer

        interval: 1000
        repeat: true
        running: false

        onTriggered: {
            remainingSeconds--

            if (remainingSeconds <= 0) {
                stop()
            }
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Label {
            text: Math.floor(remainingSeconds / 60) + ":" +
                  (remainingSeconds % 60 < 10 ? "0" : "") +
                  remainingSeconds % 60

            fontSize: "x-large"
        }

        Button {
            text: pomodoroTimer.running ? "Pause" : "Start"

            onClicked: {
                pomodoroTimer.running =
                        !pomodoroTimer.running
            }
        }

        Button {
            text: "Reset"

            onClicked: {
                remainingSeconds = 1500
                pomodoroTimer.stop()
            }
        }
    }
}

