from flask import Flask, jsonify, render_template, request
import psycopg2
import psycopg2.extras

app = Flask(__name__)

DB_HOST = "localhost"
DB_NAME = "postgres"
DB_USER = "test_user"
DB_PASS = "Test1234"

def get_db_connection():
    return psycopg2.connect(
        host=DB_HOST,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASS
    )

# ======================
# PAGES
# ======================

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/event/<int:event_id>")
def event_page(event_id):
    return render_template("event.html", event_id=event_id)

# ======================
# API
# ======================

@app.route("/api/events/<date>/<sport>")
def get_events_filtered(date, sport):
    try:
        with get_db_connection() as conn:
            with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
                query = """
                    SELECT e.event_id,
                           ht.team_name AS home_team,
                           at.team_name AS away_team,
                           COALESCE(NULLIF(SPLIT_PART(e.score,'-',1),''),'0')::int AS home_score,
                           COALESCE(NULLIF(SPLIT_PART(e.score,'-',2),''),'0')::int AS away_score,
                           TO_CHAR(e.start_time,'HH24:MI') AS time,
                           e.venue,
                           t.tournament_name,
                           s.sport_name,
                           r.referee_name
                    FROM event e
                    JOIN team ht ON e.home_team_id = ht.team_id
                    JOIN team at ON e.away_team_id = at.team_id
                    JOIN tournament t ON e._tournament_id = t.tournament_id
                    JOIN sport s ON s.sport_id = t._sport_id
                    JOIN referee r ON e._referee_id = r.referee_id
                    WHERE DATE(e.start_time) = %s
                """
                params = [date]
                if sport.lower() != "all":
                    query += " AND s.sport_name ILIKE %s"
                    params.append(f"%{sport}%")
                query += " ORDER BY e.start_time"
                cur.execute(query, params)
                events = cur.fetchall()
        return jsonify([dict(r) for r in events])
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route("/api/sports/<date>")
def sports_structure(date):
    try:
        with get_db_connection() as conn:
            with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
                cur.execute("""
                    SELECT s.sport_name,
                           t.tournament_name,
                           e.event_id,
                           ht.team_name AS home_team,
                           at.team_name AS away_team,
                           COALESCE(NULLIF(SPLIT_PART(e.score,'-',1),''),'0')::int AS home_score,
                           COALESCE(NULLIF(SPLIT_PART(e.score,'-',2),''),'0')::int AS away_score,
                           TO_CHAR(e.start_time,'HH24:MI') AS time,
                           e.venue,
                           r.referee_name
                    FROM event e
                    JOIN team ht ON e.home_team_id = ht.team_id
                    JOIN team at ON e.away_team_id = at.team_id
                    JOIN tournament t ON e._tournament_id = t.tournament_id
                    JOIN sport s ON s.sport_id = t._sport_id
                    JOIN referee r ON e._referee_id = r.referee_id
                    WHERE DATE(e.start_time) = %s
                    ORDER BY s.sport_name, t.tournament_name, e.start_time
                """, (date,))
                events = cur.fetchall()
        data = {}
        for r in events:
            sport = r["sport_name"]
            tournament = r["tournament_name"]
            data.setdefault(sport, {}).setdefault(tournament, []).append(dict(r))
        return jsonify(data)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route("/api/event/<int:event_id>")
def get_event(event_id):
    try:
        with get_db_connection() as conn:
            with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
                cur.execute("""
                    SELECT e.event_id,
                           ht.team_name AS home_team,
                           ht.logo AS home_team_logo,
                           at.team_name AS away_team,
                           at.logo AS away_team_logo,
                           e.score,
                           e.start_time,
                           e.venue,
                           t.tournament_name,
                           s.sport_name,
                           r.referee_name
                    FROM event e
                    JOIN team ht ON e.home_team_id = ht.team_id
                    JOIN team at ON e.away_team_id = at.team_id
                    JOIN tournament t ON e._tournament_id = t.tournament_id
                    JOIN sport s ON s.sport_id = t._sport_id
                    JOIN referee r ON e._referee_id = r.referee_id
                    WHERE e.event_id = %s
                """, (event_id,))
                event = cur.fetchone()

        if not event:
            return jsonify({"error": "Not found"}), 404

        return jsonify(dict(event))

    except Exception as e:
        return jsonify({"error": str(e)}), 500

# ======================
# ADD NEW EVENT
# ======================

@app.route("/add_event", methods=["POST"])
def add_event():
    data = request.json


    required_fields = ['tournament_id', 'home_team_id', 'away_team_id', 'referee_id', 'start_time']
    for field in required_fields:
        if field not in data:
            return jsonify({"error": f"Missing field: {field}"}), 400

    with get_db_connection() as conn:
        with conn.cursor() as cur:

            cur.execute("SELECT stadium FROM team WHERE team_id=%s", (data['home_team_id'],))
            home_stadium_result = cur.fetchone()
            if not home_stadium_result:
                return jsonify({"error": "Home team not found"}), 400
            home_stadium = home_stadium_result[0]


            venue = data.get('venue') or home_stadium


            cur.execute("""
                INSERT INTO event
                (_tournament_id, home_team_id, away_team_id, _referee_id, start_time, venue, score)
                VALUES (%s,%s,%s,%s,%s,%s,%s)
            """, (
                data['tournament_id'],
                data['home_team_id'],
                data['away_team_id'],
                data['referee_id'],
                data['start_time'],
                venue,
                data.get('score')
            ))
        conn.commit()

    return jsonify({"message": "Event added", "venue_used": venue})

@app.route("/events", methods=["GET"])
def get_all_events():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("""
        SELECT 
            e.event_id,
            e.start_time,
            e.venue,
            e.score,
            ht.team_name AS home_team,
            ht.logo AS home_logo,
            at.team_name AS away_team,
            at.logo AS away_logo
        FROM event e
        JOIN team ht ON e.home_team_id = ht.team_id
        JOIN team at ON e.away_team_id = at.team_id
        ORDER BY e.start_time
    """)
    events = cur.fetchall()
    cur.close()
    conn.close()

    result = []
    for row in events:
        result.append({
            "event_id": row[0],
            "start_time": row[1].strftime("%Y-%m-%d %H:%M:%S") if row[1] else None,
            "venue": row[2],
            "score": row[3],
            "home_team": row[4],
            "home_logo": row[5],
            "away_team": row[6],
            "away_logo": row[7]
        })
    return jsonify(result)

# ======================
# RUN SERVER
# ======================

if __name__ == "__main__":
    print("🚀 http://127.0.0.1:5000")
    app.run(debug=True)