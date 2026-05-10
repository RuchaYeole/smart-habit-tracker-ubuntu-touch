import QtQuick 2.4
import Ubuntu.Components 1.3

import "../database/Database.js" as DB
import "../components"

Page {

    title: "Habits"

    ListModel {
        id: habitsModel
    }

    function loadHabits() {

        habitsModel.clear()

        var habits = DB.getHabits()

        for (var i = 0; i < habits.length; i++) {

            habitsModel.append({
                "id": habits[i].id,
                "name": habits[i].name,
                "completed": habits[i].completed,
                "streak": habits[i].streak
            })
        }
    }

    Component.onCompleted: {

        DB.init()
        loadHabits()
    }

    Rectangle {

        anchors.fill: parent

        gradient: Gradient {

            GradientStop {
                position: 0.0
                color: "#f5f7fa"
            }

            GradientStop {
                position: 1.0
                color: "#c3cfe2"
            }
        }

        Column {

            anchors.fill: parent
            anchors.margins: 20

            spacing: 20

            Label {

                text: "Your Daily Habits"

                fontSize: "x-large"

                color: "#333"
            }

            TextField {

                id: habitInput

                placeholderText: "Enter habit"
            }

            TextField {

                id: categoryInput

                placeholderText: "Category"
            }

            Button {

                width: parent.width

                text: "Add Habit"

                onClicked: {

                    if (habitInput.text !== "") {

                        DB.addHabit(
                            habitInput.text,
                            categoryInput.text
                        )

                        habitInput.text = ""
                        categoryInput.text = ""

                        loadHabits()
                    }
                }
            }

            Button {

                width: parent.width

                text: "Refresh"

                onClicked: {
                    loadHabits()
                }
            }

            ListView {

                width: parent.width

                height: parent.height - 320

                spacing: 15

                model: habitsModel

                delegate: HabitCard {

                    width: parent.width

                    habitId: model.id
                    habitName: model.name
                    streak: model.streak
                    completed: model.completed

                    onDeleteClicked: {

                        DB.deleteHabit(id)

                        loadHabits()
                    }

                    onToggleClicked: {

                        DB.toggleHabit(id, checked)

                        loadHabits()
                    }
                }
            }
        }
    }
}
