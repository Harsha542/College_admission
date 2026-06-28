--1. Student Enrollment Procedure

--Registers a new student and automatically sets the admission status based on marks.

DELIMITER //

CREATE PROCEDURE Student_enrollment(
    IN p_first_name VARCHAR(20),
    IN p_last_name VARCHAR(20),
    IN p_gender VARCHAR(10),
    IN p_dob DATE,
    IN p_phone BIGINT,
    IN p_email VARCHAR(50),
    IN p_city VARCHAR(20),
    IN p_marks INT
)
BEGIN

    INSERT INTO students(
        first_name,
        last_name,
        gender,
        dob,
        phone,
        email,
        city,
        marks,
        admission_status
    )
    VALUES(
        p_first_name,
        p_last_name,
        p_gender,
        p_dob,
        p_phone,
        p_email,
        p_city,
        p_marks,
        CASE
            WHEN p_marks >= 800 THEN 'Eligible'
            WHEN p_marks = 0 THEN 'Not Provided'
            ELSE 'Not Eligible'
        END
    );

END //

DELIMITER ;


-- -----------------------------------------------------------------------------------

--2. Apply for Admission

--Allows a student to apply for a course.

DELIMITER //

CREATE PROCEDURE apply_admission(
    IN p_student_id INT,
    IN p_course_id INT
)
BEGIN

    INSERT INTO applications(
        student_id,
        course_id,
        application_date
    )
    VALUES(
        p_student_id,
        p_course_id,
        CURDATE()
    );

END //

DELIMITER ;
-- --------------------------------------------------------------------------------

--3. Student Full Profile

--Displays complete information about a student.

DELIMITER //

CREATE PROCEDURE student_full_profile(
    IN p_student_id INT
)
BEGIN

SELECT
    s.student_id,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    s.email,
    s.marks,
    s.admission_status,
    c.course_name,
    d.dept_name,
    a.application_status,
    ad.admission_date,
    f.total_fee,
    f.amount_paid,
    f.payment_status
FROM students s
LEFT JOIN applications a
ON s.student_id=a.student_id
LEFT JOIN courses c
ON a.course_id=c.course_id
LEFT JOIN departments d
ON c.dept_id=d.dept_id
LEFT JOIN admissions ad
ON a.application_id=ad.application_id
LEFT JOIN fees f
ON ad.admission_id=f.admission_id
WHERE s.student_id=p_student_id;

END //

DELIMITER ;
-- -----------------------------------------------------------------------------------------
--4. Pending Fee Students

--Lists students whose fees are still pending.

DELIMITER //

CREATE PROCEDURE pending_fee_students()
BEGIN

SELECT
    s.student_id,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    c.course_name,
    f.total_fee,
    f.amount_paid,
    f.payment_status
FROM students s
JOIN applications a
ON s.student_id=a.student_id
JOIN admissions ad
ON a.application_id=ad.application_id
JOIN fees f
ON ad.admission_id=f.admission_id
JOIN courses c
ON a.course_id=c.course_id
WHERE f.payment_status='Pending';

END //

DELIMITER ;

-- -----------------------------------------------------------------------------------------
--5. Highest Marks in Each Department
DELIMITER //

CREATE PROCEDURE top_student_each_department()
BEGIN

SELECT
    d.dept_name,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    s.marks
FROM students s
JOIN applications a
ON s.student_id=a.student_id
JOIN courses c
ON a.course_id=c.course_id
JOIN departments d
ON c.dept_id=d.dept_id
WHERE (c.dept_id,s.marks) IN
(
SELECT
    c.dept_id,
    MAX(s.marks)
FROM students s
JOIN applications a
ON s.student_id=a.student_id
JOIN courses c
ON a.course_id=c.course_id
GROUP BY c.dept_id
);

END //

DELIMITER ;