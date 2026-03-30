# Match Calendar

Web application for viewing sports matches and events with calendar navigation, match details, and database-driven content.

Built using **Python (Flask)** and **PostgreSQL**.

---

## 🚀 Features

- Match calendar with date selection
- Dynamic match loading
- Database-driven events
- Football & hockey matches
- Responsive interface (Bootstrap)
- PostgreSQL integration

---

## 🛠 Tech Stack

- Python 3
- Flask
- PostgreSQL
- HTML / CSS / Bootstrap
- JavaScript
- Jinja2 Templates

---

## 📦 Project Setup


## 🚀 Quick Start (Windows/macOS/Linux)

### 1. Clone the repository
bash
git clone <your-repo-url>
cd match_calendar


### 2. Create virtual environment
bash
# Windows
python -m venv venv
venv\Scripts\activate

# macOS/Linux
python3 -m venv venv
source venv/bin/activate

✅ **`(venv)` prefix = activated**

### 3. Install dependencies
bash
pip install -r requirements.txt


### 4. Install PostgreSQL
| OS | Instructions |
|----|--------------|
| **Windows** | [Download](https://www.postgresql.org/download/windows/) → **Keep port 5432** → Remember `postgres` password |
| **macOS** | `brew install postgresql@18 && brew services start postgresql@18` |
| **Ubuntu** | `sudo apt update && sudo apt install postgresql postgresql-contrib` |

**🔧 Windows PATH:** `C:\Program Files\PostgreSQL\18\bin`

### 5. Create database
bash
# Enter postgres password when prompted
createdb -U postgres match_calendar


**❌ Windows:** `"C:\Program Files\PostgreSQL\18\bin\createdb.exe" -U postgres match_calendar`

### 6. Import database schema + data
bash
psql -U postgres -d match_calendar -f SQL/database.sql


✅ **Success =** `CREATE TABLE`, `INSERT`, `COPY` commands

### 7. Test database connection
bash
python test_connection.py

**✅ Success:**

✅ Database connected!
📊 Events: 4
🏆 Teams: 4
⚽ Sports: 2


### 8. Run the project
bash
python app.py

**✅ Open:** `http://127.0.0.1:5000`


## 🆕 API: Add Event (REST)

### 📝 Curl Example (adds ice hockey match):
bash# Match Calendar

Web application for viewing sports matches and events with calendar navigation, match details, and database-driven content.

Built using **Python (Flask)** and **PostgreSQL**.

---

## 🚀 Features

- Match calendar with date selection
- Dynamic match loading
- Database-driven events
- Football & hockey matches
- Responsive interface (Bootstrap)
- PostgreSQL integration

---

## 🛠 Tech Stack

- Python 3
- Flask
- PostgreSQL
- HTML / CSS / Bootstrap
- JavaScript
- Jinja2 Templates

---

## 📦 Project Setup


## 🚀 Quick Start (Windows/macOS/Linux)

### 1. Clone the repository
```bash```
git clone <your-repo-url>
cd match_calendar


### 2. Create virtual environment
```bash```
# Windows
python -m venv venv
venv\Scripts\activate

# macOS/Linux
python3 -m venv venv
source venv/bin/activate

✅ **`(venv)` prefix = activated**

### 3. Install dependencies
```bash```
pip install -r requirements.txt


### 4. Install PostgreSQL
| OS | Instructions |
|----|--------------|
| **Windows** | [Download](https://www.postgresql.org/download/windows/) → **Keep port 5432** → Remember `postgres` password |
| **macOS** | `brew install postgresql@18 && brew services start postgresql@18` |
| **Ubuntu** | `sudo apt update && sudo apt install postgresql postgresql-contrib` |

**🔧 Windows PATH:** `C:\Program Files\PostgreSQL\18\bin`

### 5. Create database
```bash```
# Enter postgres password when prompted
createdb -U postgres match_calendar


**❌ Windows:** `"C:\Program Files\PostgreSQL\18\bin\createdb.exe" -U postgres match_calendar`

### 6. Import database schema + data
```bash```
psql -U postgres -d match_calendar -f SQL/database.sql


✅ **Success =** `CREATE TABLE`, `INSERT`, `COPY` commands

### 7. Test database connection
```bash```
python test_connection.py

**✅ Success:**

✅ Database connected!
📊 Events: 4
🏆 Teams: 4
⚽ Sports: 2


### 8. Run the project
```bash```
python app.py

**✅ Open:** `http://127.0.0.1:5000`


## 🆕 API: Add Event (REST)

### 📝 Curl Example (adds ice hockey match):
```bash```
curl -X POST http://127.0.0.1:5000/add_event \
  -H "Content-Type: application/json" \
  -d '{
    "tournament_id": 2,
    "home_team_id": 3,
    "away_team_id": 4,
    "referee_id": 2,
    "start_time": "2026-04-02 17:30:00",
    "venue": "Klagenfurt Arena",
    "score": null
  }'

curl -X POST http://127.0.0.1:5000/add_event \
  -H "Content-Type: application/json" \
  -d '{
    "tournament_id": 2,
    "home_team_id": 3,
    "away_team_id": 4,
    "referee_id": 2,
    "start_time": "2026-04-02 17:30:00",
    "venue": "Klagenfurt Arena",
    "score": null
  }'
