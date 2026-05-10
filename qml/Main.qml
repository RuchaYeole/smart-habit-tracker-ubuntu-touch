import QtQuick 2.4
import Ubuntu.Components 1.3

MainView {

    applicationName: "smart-habit"

    width: units.gu(45)
    height: units.gu(75)

    PageStack {
        id: pageStack
        anchors.fill: parent

        Component.onCompleted: {
            push(mainPage)
        }
    }

    Page {

        id: mainPage
        title: "Smart Habit Tracker"

        Rectangle {

            anchors.fill: parent

            gradient: Gradient {

                GradientStop {
                    position: 0.0
                    color: "#1f1c2c"
                }

                GradientStop {
                    position: 1.0
                    color: "#928dab"
                }
            }

            Column {

                anchors.centerIn: parent
                spacing: 25

                Label {

                    text: "SMART HABIT TRACKER"

                    fontSize: "x-large"

                    color: "white"
                }

                Label {

                    text: "Build Better Habits Daily"

                    color: "#dddddd"
                }

                Button {

                    width: 220
                    text: "📋 Habits"

                    onClicked: {

                        pageStack.push(
                            Qt.resolvedUrl(
                                "pages/HabitsPage.qml"
                            )
                        )
                    }
                }

                Button {

                    width: 220
                    text: "📊 Analytics"

                    onClicked: {

                        pageStack.push(
                            Qt.resolvedUrl(
                                "pages/AnalyticsPage.qml"
                            )
                        )
                    }
                }

                Button {

                    width: 220
                    text: "⏳ Pomodoro"

                    onClicked: {

                        pageStack.push(
                            Qt.resolvedUrl(
                                "pages/PomodoroPage.qml"
                            )
                        )
                    }
                }

                Button {

                    width: 220
                    text: "⚙ Settings"

                    onClicked: {

                        pageStack.push(
                            Qt.resolvedUrl(
                                "pages/SettingsPage.qml"
                            )
                        )
                    }
                }
            }
        }
    }
}
