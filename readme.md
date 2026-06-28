# 🎓 College Admission Management System

## 📌 Project Overview

The **College Admission Management System** is a SQL-based database project developed using MySQL. It simulates the admission process of a college by managing students, departments, courses, applications, admissions, and fee records.

The project demonstrates database design, automation using triggers, business logic with stored procedures, reporting through views, and performance optimization using indexes.

---

## 🚀 Features

* Student enrollment
* Department and course management
* Course application process
* Automatic application approval/rejection based on student marks
* Automatic admission generation for eligible students
* Automatic rejection tracking for ineligible students
* Fee management and payment tracking
* Student status reporting
* Email indexing for faster search

---

## 🗂️ Database Tables

| Table          | Description                    |
| -------------- | ------------------------------ |
| `students`     | Stores student information     |
| `departments`  | Stores department details      |
| `courses`      | Stores available courses       |
| `applications` | Stores student applications    |
| `admissions`   | Stores approved admissions     |
| `fees`         | Stores fee payment information |

---

## ⚙️ SQL Concepts Used

* Primary Keys
* Foreign Keys
* Constraints
* Auto Increment
* Joins
* Views
* Stored Procedures
* Triggers
* Indexes
* CASE Statements
* Aggregate Functions

---

## 🔄 Workflow

1. Student details are added to the **Students** table.
2. The student applies for a course.
3. A **BEFORE INSERT Trigger** checks the student's marks.
4. The application is automatically marked as **Approved** or **Rejected**.
5. An **AFTER INSERT Trigger**:

   * Creates an admission record for approved applications.
   * Updates the student's admission status.
6. Fee details are maintained for admitted students.
7. Views generate reports for admitted students, rejected students, and overall student status.

---

## 🔥 Triggers Implemented

### 1. Marks Validation Trigger

* Executes before inserting an application.
* Checks student marks.
* Automatically sets:

  * `Approved`
  * `Rejected`
* Adds appropriate remarks.

### 2. Admission Processing Trigger

* Executes after a new application is inserted.
* Creates admission records for approved applications.
* Updates student admission status.
* Records rejected applications.

---

## 📌 Stored Procedures

### Student Enrollment

Registers a new student and stores student information.

### Apply Admission

Allows a student to apply for a selected course.

### Student Full Profile

Displays complete student information including:

* Student Details
* Course
* Department
* Admission Status
* Fee Details

### Pending Fee Students

Displays students whose fee payment is pending.

### Top Student in Each Department

Returns the student with the highest marks in every department.

### Pay Fee

Updates fee payment and automatically changes payment status.

---

## 👁️ Views

* **admitted_students**

  * Displays all admitted students.

* **rejected_students**

  * Displays rejected students with rejection remarks.

* **student_status**

  * Displays overall application and admission status of every student.

---

## ⚡ Performance Optimization

Created an index on the **email** column for faster student search.

```sql
CREATE INDEX idx_students_email
ON students(email);
```

---

## 🖼️ ER Diagram

The ER diagram representing relationships between all database tables is included in this repository.

**File:** `er-diagram.png`

---

## 📁 Project Structure

```text
College-Admission-Management-System/
│
├── schema.sql
├── insert_data.sql
├── triggers.sql
├── procedures.sql
├── views.sql
├── README.md
└── er-diagram.png
```

---

## 🛠️ Technologies Used

* MySQL
* MySQL Workbench
* SQL

---

## 📚 Learning Outcomes

Through this project, I gained hands-on experience with:

* Relational Database Design
* SQL Query Writing
* Database Automation using Triggers
* Business Logic using Stored Procedures
* Reporting using Views
* Query Optimization using Indexes
* Database Relationships and Joins

---

## 👨‍💻 Author

**Harsha Vardhan**

Aspiring Data Analyst / Data Engineer

Currently learning:

* SQL
* Python
* Java (DSA)
* Data Science

---

## ⭐ Future Enhancements

* Build a web interface using Python (Flask/FastAPI)
* Add authentication for students and administrators
* Generate admission reports
* Develop an analytics dashboard
