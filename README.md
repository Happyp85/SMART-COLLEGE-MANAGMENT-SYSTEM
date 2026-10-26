# Smart College Management System (DBMS Project)

Three simple parts:
| Part | Tech | File |
|------|------|------|
| Database | SQLite (SQL) | `database/schema.sql` |
| Backend  | Python + Flask (REST API) | `backend/app.py` |
| Frontend | HTML + CSS + JavaScript | `frontend/index.html` |

## How to run
1. Install Python 3, then: `pip install flask`
2. `cd backend` then `python app.py`
3. Open http://127.0.0.1:5000

The database file `college.db` is created automatically from `schema.sql`.

## Database design (ER overview)
- **department** 1 ──< **student**  (a department has many students)
- **department** 1 ──< **course**
- **student** >──< **course** via **enrollment** (many-to-many)
- **student** 1 ──< **attendance** >── 1 **course**
- **student** 1 ──< **fee_payment**

Concepts used: primary keys, foreign keys, CHECK/UNIQUE constraints, ON DELETE CASCADE,
JOIN, GROUP BY, aggregate functions (COUNT, SUM), subqueries, normalization (3NF).

## How it flows
Browser (frontend) -> fetch() -> Flask route (backend) -> SQL query -> SQLite (database) -> JSON back to the page.

## Useful viva queries
```sql
-- Students per department
SELECT d.dept_name, COUNT(*) FROM student s JOIN department d USING(dept_id) GROUP BY d.dept_name;
-- Students with pending fees
SELECT s.name, s.total_fee - IFNULL(SUM(f.amount),0) AS pending
FROM student s LEFT JOIN fee_payment f USING(student_id) GROUP BY s.student_id HAVING pending > 0;
```
