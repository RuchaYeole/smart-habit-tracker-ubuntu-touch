.import QtQuick.LocalStorage 2.0 as Sql

var db = Sql.LocalStorage.openDatabaseSync(
    "SmartHabitDB",
    "1.0",
    "Habit Tracker Database",
    1000000
)

function init() {

    db.transaction(function(tx) {

        tx.executeSql(
            'CREATE TABLE IF NOT EXISTS habits(' +
            'id INTEGER PRIMARY KEY AUTOINCREMENT,' +
            'name TEXT,' +
            'completed INTEGER,' +
            'streak INTEGER,' +
            'category TEXT)'
        )
    })
}

function addHabit(name, category) {

    db.transaction(function(tx) {

        tx.executeSql(
            'INSERT INTO habits(name, completed, streak, category) VALUES(?, ?, ?, ?)',
            [name, 0, 0, category]
        )
    })
}

function getHabits() {

    var habits = []

    db.transaction(function(tx) {

        var rs = tx.executeSql(
            'SELECT * FROM habits'
        )

        for (var i = 0; i < rs.rows.length; i++) {

            habits.push(rs.rows.item(i))
        }
    })

    return habits
}

function deleteHabit(id) {

    db.transaction(function(tx) {

        tx.executeSql(
            'DELETE FROM habits WHERE id=?',
            [id]
        )
    })
}

function toggleHabit(id, value) {

    db.transaction(function(tx) {

        var rs = tx.executeSql(
            'SELECT * FROM habits WHERE id=?',
            [id]
        )

        if (rs.rows.length > 0) {

            var habit = rs.rows.item(0)

            var newStreak = value
                ? habit.streak + 1
                : 0

            tx.executeSql(
                'UPDATE habits SET completed=?, streak=? WHERE id=?',
                [value ? 1 : 0, newStreak, id]
            )
        }
    })
}

function getCompletedCount() {

    var count = 0

    db.transaction(function(tx) {

        var rs = tx.executeSql(
            'SELECT * FROM habits WHERE completed=1'
        )

        count = rs.rows.length
    })

    return count
}

function getTotalHabits() {

    var count = 0

    db.transaction(function(tx) {

        var rs = tx.executeSql(
            'SELECT * FROM habits'
        )

        count = rs.rows.length
    })

    return count
}

function getHighestStreak() {

    var highest = 0

    db.transaction(function(tx) {

        var rs = tx.executeSql(
            'SELECT MAX(streak) as maxStreak FROM habits'
        )

        if (rs.rows.length > 0) {

            highest = rs.rows.item(0).maxStreak || 0
        }
    })

    return highest
}

function getFocusScore() {

    var score = 0

    db.transaction(function(tx) {

        var rs = tx.executeSql(
            'SELECT * FROM habits'
        )

        for (var i = 0; i < rs.rows.length; i++) {

            var habit = rs.rows.item(i)

            score += habit.completed * 10
            score += habit.streak * 5
        }
    })

    return score
}
