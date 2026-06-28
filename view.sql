--1. Admitted Students View
CREATE VIEW admitted_students AS
SELECT
    s.student_id,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    c.course_name,
    d.dept_name,
    ad.admission_date
FROM students s
JOIN applications a
ON s.student_id = a.student_id
JOIN admissions ad
ON a.application_id = ad.application_id
JOIN courses c
ON a.course_id = c.course_id
JOIN departments d
ON c.dept_id = d.dept_id;
------------------------------------------------------------------------------------
--2. Rejected Students View
CREATE VIEW rejected_students AS
SELECT
    s.student_id,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    s.marks,
    a.remarks,
    a.application_date
FROM students s
JOIN applications a
ON s.student_id = a.student_id
WHERE a.application_status = 'Rejected';
----------------------------------------------------------------------------------
--Student Status View
CREATE VIEW student_status AS
SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    s.marks,
    c.course_name,
    a.application_status,
    s.admission_status
FROM students s
LEFT JOIN applications a
    ON s.student_id = a.student_id
LEFT JOIN courses c
    ON a.course_id = c.course_id;