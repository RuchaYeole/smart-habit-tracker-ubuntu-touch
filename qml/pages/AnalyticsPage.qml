import QtQuick 2.4
import Ubuntu.Components 1.3

import "../database/Database.js" as DB

Page {

    title: "Analytics"

    property int completedHabits: 0
    property int totalHabits: 0
    property int highestStreak: 0
    property int focusScore: 0

    function loadStats() {

        completedHabits = DB.getCompletedCount()
        totalHabits = DB.getTotalHabits()
        highestStreak = DB.getHighestStreak()
        focusScore = DB.getFocusScore()

        chartCanvas.requestPaint()
    }

    Component.onCompleted: {

        DB.init()
        loadStats()
    }

    Rectangle {

        anchors.fill: parent

        gradient: Gradient {

            GradientStop {
                position: 0.0
                color: "#141e30"
            }

            GradientStop {
                position: 1.0
                color: "#243b55"
            }
        }

        Flickable {

            anchors.fill: parent

            contentHeight: analyticsColumn.height + 50

            Column {

                id: analyticsColumn

                width: parent.width

                spacing: 20

                anchors.margins: 20

                Label {

                    text: "📊 Productivity Dashboard"

                    fontSize: "x-large"

                    color: "white"
                }

                Rectangle {

                    width: parent.width - 40
                    height: 100

                    radius: 16

                    color: "#ffffff"

                    Column {

                        anchors.centerIn: parent

                        spacing: 8

                        Text {

                            text: "🧠 Focus Score"

                            font.pixelSize: 22
                        }

                        Text {

                            text: focusScore

                            font.pixelSize: 32

                            font.bold: true

                            color: "#4CAF50"
                        }
                    }
                }

                Rectangle {

                    width: parent.width - 40
                    height: 100

                    radius: 16

                    color: "#ffffff"

                    Row {

                        anchors.centerIn: parent

                        spacing: 40

                        Column {

                            spacing: 5

                            Text {
                                text: "Completed"
                            }

                            Text {

                                text: completedHabits

                                font.pixelSize: 28

                                font.bold: true
                            }
                        }

                        Column {

                            spacing: 5

                            Text {
                                text: "Total"
                            }

                            Text {

                                text: totalHabits

                                font.pixelSize: 28

                                font.bold: true
                            }
                        }

                        Column {

                            spacing: 5

                            Text {
                                text: "Best Streak"
                            }

                            Text {

                                text: highestStreak

                                font.pixelSize: 28

                                font.bold: true

                                color: "#ff9800"
                            }
                        }
                    }
                }

                Rectangle {

                    width: parent.width - 40
                    height: 260

                    radius: 16

                    color: "#ffffff"

                    Column {

                        anchors.fill: parent

                        anchors.margins: 15

                        spacing: 10

                        Text {

                            text: "📈 Progress Chart"

                            font.pixelSize: 22
                        }

                        Canvas {

                            id: chartCanvas

                            width: parent.width - 20
                            height: 180

                            onPaint: {

                                var ctx = getContext("2d")

                                ctx.clearRect(
                                    0,
                                    0,
                                    width,
                                    height
                                )

                                ctx.fillStyle = "#4CAF50"

                                var completedHeight =
                                        completedHabits * 30

                                ctx.fillRect(
                                    40,
                                    height - completedHeight,
                                    60,
                                    completedHeight
                                )

                                ctx.fillStyle = "#2196F3"

                                var totalHeight =
                                        totalHabits * 30

                                ctx.fillRect(
                                    150,
                                    height - totalHeight,
                                    60,
                                    totalHeight
                                )

                                ctx.fillStyle = "#FF9800"

                                var streakHeight =
                                        highestStreak * 30

                                ctx.fillRect(
                                    260,
                                    height - streakHeight,
                                    60,
                                    streakHeight
                                )
                            }
                        }
                    }
                }

                Button {

                    width: parent.width - 40

                    text: "Refresh Analytics"

                    onClicked: {
                        loadStats()
                    }
                }
            }
        }
    }
}
