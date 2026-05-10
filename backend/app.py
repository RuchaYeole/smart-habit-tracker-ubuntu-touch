from flask import Flask, request, jsonify
from flask_cors import CORS
import sqlite3

app = Flask(__name__)
CORS(app)

# ---------- DB ----------
def get_db():
    return sqlite3.connect("habits.db")

def init_db():
    conn = get_db()
    cursor = conn.cursor()

    cursor.execute("""
    CREATE TABLE IF NOT EXISTS habits (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE,
        streak INTEGER DEFAULT 0,
        done INTEGER DEFAULT 0,
        distractions INTEGER DEFAULT 0
    )
    """)

    conn.commit()
    conn.close()

init_db()

# ---------- ROUTES ----------

@app.route('/')
def home():
    return "Backend running"

# ADD HABIT
@app.route('/add_habit', methods=['POST'])
def add_habit():
    data = request.json
    name = data.get("name")

    conn = get_db()
    cursor = conn.cursor()

    try:
        cursor.execute(
            "INSERT INTO habits (name, streak, done, distractions) VALUES (?, 0, 0, 0)",
            (name,)
        )
        conn.commit()
    except:
        return jsonify({"message": "Habit already exists"})

    conn.close()
    return jsonify({"message": "Habit added"})

# GET HABITS
@app.route('/get_habits', methods=['GET'])
def get_habits():
    conn = get_db()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM habits")
    rows = cursor.fetchall()

    habits = []
    for row in rows:
        habits.append({
            "id": row[0],
            "name": row[1],
            "streak": row[2] or 0,
            "done": bool(row[3]),
            "distractions": row[4] or 0
        })

    conn.close()
    return jsonify(habits)

# MARK DONE
@app.route('/mark_done', methods=['POST'])
def mark_done():
    data = request.json
    habit_id = data.get("id")

    conn = get_db()
    cursor = conn.cursor()

    cursor.execute(
        "UPDATE habits SET done=1, streak=streak+1 WHERE id=?",
        (habit_id,)
    )

    conn.commit()
    conn.close()

    return jsonify({"message": "Updated"})

# ADD DISTRACTION
@app.route('/add_distraction', methods=['POST'])
def add_distraction():
    data = request.json
    habit_id = data.get("id")

    conn = get_db()
    cursor = conn.cursor()

    cursor.execute(
        "UPDATE habits SET distractions=distractions+1 WHERE id=?",
        (habit_id,)
    )

    conn.commit()
    conn.close()

    return jsonify({"message": "Updated"})

# RESET STREAK
@app.route('/reset_streak', methods=['POST'])
def reset_streak():
    data = request.json
    habit_id = data.get("id")

    conn = get_db()
    cursor = conn.cursor()

    cursor.execute(
        "UPDATE habits SET streak=0, done=0 WHERE id=?",
        (habit_id,)
    )

    conn.commit()
    conn.close()

    return jsonify({"message": "Reset"})

# DELETE HABIT
@app.route('/delete_habit', methods=['POST'])
def delete_habit():
    data = request.json
    habit_id = data.get("id")

    conn = get_db()
    cursor = conn.cursor()

    cursor.execute("DELETE FROM habits WHERE id=?", (habit_id,))

    conn.commit()
    conn.close()

    return jsonify({"message": "Deleted"})

# ---------- RUN ----------
if __name__ == '__main__':
    app.run(debug=True)