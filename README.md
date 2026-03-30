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

1️⃣ Clone repository


2️⃣ Create virtual environment
python -m venv venv


3️⃣ Install dependencies
pip install -r requirements.txt

Install PostgreSQL

Download from:

https://www.postgresql.org/download/

Make sure PostgreSQL tools are available:

4️⃣ Create database
createdb -U postgres match_calendar

5️⃣ Import database

Run from project root folder:

psql -U postgres -d match_calendar -f SQL/database.sql

This will create all tables and insert demo data.

6️⃣ Configure database connection

Update test_connection.py

▶️ Run the project

