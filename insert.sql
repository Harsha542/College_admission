
-- Department Tables sample 5 records
-- ----------------------------------
INSERT INTO departments (dept_name)
VALUES
('Computer Science'),
('Electronics'),
('Mechanical'),
('Civil'),
('Business Administration');




-- courses Tables sample 5 records
-- ----------------------------------
INSERT INTO courses (course_name, dept_id)
VALUES
('B.Tech CSE', 1),
('B.Tech AI & ML', 1),
('B.Tech ECE', 2),
('B.Tech Mechanical', 3),
('BBA', 5);


-- applications Tables sample 5 records
-- ----------------------------------
INSERT INTO students
(first_name,last_name,gender,dob,phone,email,city,marks,admission_status)
VALUES
('Harsha','Vardhan','Male','2004-04-20',9393993939,'harsha@gmail.com','Zahirabad',890,'Approved'),

('Ravi','Kumar','Male','2004-01-15',9123456789,'ravi@gmail.com','Hyderabad',760,'Rejected'),

('Sneha','Reddy','Female','2005-03-18',9876543210,'sneha@gmail.com','Warangal',920,'Approved'),

('Anjali','Sharma','Female','2004-11-12',9988776655,'anjali@gmail.com','Karimnagar',810,'Approved'),

('Arjun','Patel','Male','2005-05-25',9012345678,'arjun@gmail.com','Nizamabad',690,'Rejected');

-- students Tables sample 5 records
-- ----------------------------------
-- trigger automatically sets application_status and remarks.

INSERT INTO applications
(student_id,course_id,application_date)
VALUES
(1,1,'2026-06-20'),
(2,3,'2026-06-20'),
(3,2,'2026-06-21'),
(4,5,'2026-06-21'),
(5,4,'2026-06-22');

-- admissions Tables sample 5 records
-- ----------------------------------
-- Only approved applications should appear here.

INSERT INTO admissions
(application_id,admission_date)
VALUES
(1,'2026-06-22'),
(3,'2026-06-23'),
(4,'2026-06-23');

-- fees Tables sample 5 records
-- ----------------------------------
INSERT INTO fees
(admission_id,total_fee,amount_paid,payment_status)
VALUES
(1,85000,85000,'Paid'),
(2,90000,45000,'Partial'),
(3,70000,0,'Pending');



