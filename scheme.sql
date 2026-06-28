-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema college_admission
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema college_admission
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `college_admission` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `college_admission` ;

-- -----------------------------------------------------
-- Table `college_admission`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college_admission`.`students` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(20) NULL DEFAULT NULL,
  `last_name` VARCHAR(20) NULL DEFAULT NULL,
  `Gender` VARCHAR(8) NULL DEFAULT NULL,
  `dob` DATE NULL DEFAULT NULL,
  `phone` BIGINT NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `city` VARCHAR(20) NULL DEFAULT NULL,
  `marks` INT NULL DEFAULT '0',
  `admission_status` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  INDEX `idx_students_email` (`email` ASC) VISIBLE,
  INDEX `idx_students_phone` (`phone` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 52
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `college_admission`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college_admission`.`departments` (
  `dept_id` INT NOT NULL AUTO_INCREMENT,
  `dept_name` VARCHAR(50) NOT NULL,
  `hod_name` VARCHAR(50) NOT NULL,
  `total_seats` INT NOT NULL,
  `available_seats` INT NOT NULL,
  PRIMARY KEY (`dept_id`),
  UNIQUE INDEX `dept_name` (`dept_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `college_admission`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college_admission`.`courses` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `course_name` VARCHAR(100) NOT NULL,
  `dept_id` INT NOT NULL,
  `duration_years` INT NOT NULL,
  `course_fee` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_course_department` (`dept_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_department`
    FOREIGN KEY (`dept_id`)
    REFERENCES `college_admission`.`departments` (`dept_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `college_admission`.`applications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college_admission`.`applications` (
  `application_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NULL DEFAULT NULL,
  `course_id` INT NULL DEFAULT NULL,
  `application_date` DATE NULL DEFAULT NULL,
  `application_status` ENUM('Pending', 'Approved', 'Rejected') NULL DEFAULT 'Pending',
  `remarks` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`application_id`),
  INDEX `student_id` (`student_id` ASC) VISIBLE,
  INDEX `course_id` (`course_id` ASC) VISIBLE,
  CONSTRAINT `applications_ibfk_1`
    FOREIGN KEY (`student_id`)
    REFERENCES `college_admission`.`students` (`student_id`),
  CONSTRAINT `applications_ibfk_2`
    FOREIGN KEY (`course_id`)
    REFERENCES `college_admission`.`courses` (`course_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 82
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `college_admission`.`admissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college_admission`.`admissions` (
  `admission_id` INT NOT NULL AUTO_INCREMENT,
  `application_id` INT NULL DEFAULT NULL,
  `admission_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`admission_id`),
  UNIQUE INDEX `application_id` (`application_id` ASC) VISIBLE,
  CONSTRAINT `admissions_ibfk_1`
    FOREIGN KEY (`application_id`)
    REFERENCES `college_admission`.`applications` (`application_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 36
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `college_admission`.`fees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college_admission`.`fees` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `admission_id` INT NOT NULL,
  `total_fee` DECIMAL(10,2) NOT NULL,
  `amount_paid` DECIMAL(10,2) NULL DEFAULT '0.00',
  `payment_date` DATE NULL DEFAULT NULL,
  `payment_mode` ENUM('Cash', 'UPI', 'Credit Card', 'Debit Card', 'Net Banking') NULL DEFAULT NULL,
  `payment_status` ENUM('Pending', 'Partial', 'Paid') NULL DEFAULT 'Pending',
  PRIMARY KEY (`payment_id`),
  INDEX `fk_fees_admission` (`admission_id` ASC) VISIBLE,
  CONSTRAINT `fk_fees_admission`
    FOREIGN KEY (`admission_id`)
    REFERENCES `college_admission`.`admissions` (`admission_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 65
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `college_admission`.`rejections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college_admission`.`rejections` (
  `rejection_id` INT NOT NULL AUTO_INCREMENT,
  `application_id` INT NULL DEFAULT NULL,
  `rejected_date` DATE NULL DEFAULT NULL,
  `reason` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`rejection_id`),
  UNIQUE INDEX `application_id` (`application_id` ASC) VISIBLE,
  CONSTRAINT `rejections_ibfk_1`
    FOREIGN KEY (`application_id`)
    REFERENCES `college_admission`.`applications` (`application_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `college_admission` ;

-- -----------------------------------------------------
-- Placeholder table for view `college_admission`.`vw_admitted_students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college_admission`.`vw_admitted_students` (`student_id` INT, `student_name` INT, `city` INT, `marks` INT, `course_name` INT, `dept_name` INT, `application_status` INT, `admission_id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `college_admission`.`vw_rejected_students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college_admission`.`vw_rejected_students` (`student_id` INT, `student_name` INT, `city` INT, `marks` INT, `course_name` INT, `reason` INT, `rejected_date` INT);

-- -----------------------------------------------------
-- Placeholder table for view `college_admission`.`vw_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college_admission`.`vw_status` (`student_name` INT, `student_id` INT, `marks` INT, `status` INT, `eligablity` INT);

-- -----------------------------------------------------
-- procedure Student_enrollment
-- -----------------------------------------------------

DELIMITER $$
USE `college_admission`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Student_enrollment`(
    IN p_first_name VARCHAR(20),
    IN p_last_name VARCHAR(20),
    IN p_gender VARCHAR(8),
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

        -- default will kick in if NULL
        p_marks,

        -- status logic
        CASE
            WHEN p_marks >= 800 THEN 'Eligible'
            WHEN p_marks = 0 THEN 'Not Provided'
            ELSE 'Not Eligible'
        END
    );

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure apply_admission
-- -----------------------------------------------------

DELIMITER $$
USE `college_admission`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `apply_admission`(IN p_student_id int ,IN p_course_id int)
begin
declare v_marks int;
select marks into v_marks from students where student_id = p_student_id;

if v_marks is null Then
   signal sqlstate '45000'
   set message_text = 'INVALID STUDENT DETAILS';
else
   insert into applications(student_id,course_id,application_date) values(p_student_id,p_course_id,curdate());
   
End if ;

end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure student_full_profile
-- -----------------------------------------------------

DELIMITER $$
USE `college_admission`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `student_full_profile`(
    IN p_student_id INT
)
BEGIN

    SELECT
        s.student_id,
        CONCAT(s.first_name, ' ', s.last_name) AS student_name,
        s.gender,
        s.dob,
        s.phone,
        s.email,
        s.city,
        s.marks,
        s.admission_status,

        a.application_id,
        a.application_date,
        a.application_status,

        c.course_name,
        d.dept_name,

        ad.admission_id,

        f.total_fee,
        f.amount_paid,
        f.payment_status

    FROM students s

    LEFT JOIN applications a
        ON s.student_id = a.student_id

    LEFT JOIN courses c
        ON a.course_id = c.course_id

    LEFT JOIN departments d
        ON c.dept_id = d.dept_id

    LEFT JOIN admissions ad
        ON a.application_id = ad.application_id

    LEFT JOIN fees f
        ON ad.admission_id = f.admission_id

    WHERE s.student_id = p_student_id;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `college_admission`.`vw_admitted_students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `college_admission`.`vw_admitted_students`;
USE `college_admission`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `college_admission`.`vw_admitted_students` AS select `s`.`student_id` AS `student_id`,concat(`s`.`first_name`,' ',`s`.`last_name`) AS `student_name`,`s`.`city` AS `city`,`s`.`marks` AS `marks`,`c`.`course_name` AS `course_name`,`d`.`dept_name` AS `dept_name`,`a`.`application_status` AS `application_status`,`ad`.`admission_id` AS `admission_id` from ((((`college_admission`.`students` `s` join `college_admission`.`applications` `a` on((`s`.`student_id` = `a`.`student_id`))) join `college_admission`.`admissions` `ad` on((`a`.`application_id` = `ad`.`application_id`))) join `college_admission`.`courses` `c` on((`a`.`course_id` = `c`.`course_id`))) join `college_admission`.`departments` `d` on((`c`.`dept_id` = `d`.`dept_id`)));

-- -----------------------------------------------------
-- View `college_admission`.`vw_rejected_students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `college_admission`.`vw_rejected_students`;
USE `college_admission`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `college_admission`.`vw_rejected_students` AS select `s`.`student_id` AS `student_id`,concat(`s`.`first_name`,' ',`s`.`last_name`) AS `student_name`,`s`.`city` AS `city`,`s`.`marks` AS `marks`,`c`.`course_name` AS `course_name`,`r`.`reason` AS `reason`,`r`.`rejected_date` AS `rejected_date` from (((`college_admission`.`students` `s` join `college_admission`.`applications` `a` on((`s`.`student_id` = `a`.`student_id`))) join `college_admission`.`rejections` `r` on((`a`.`application_id` = `r`.`application_id`))) join `college_admission`.`courses` `c` on((`a`.`course_id` = `c`.`course_id`)));

-- -----------------------------------------------------
-- View `college_admission`.`vw_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `college_admission`.`vw_status`;
USE `college_admission`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `college_admission`.`vw_status` AS select concat(`s`.`first_name`,' ',`s`.`last_name`) AS `student_name`,`s`.`student_id` AS `student_id`,`s`.`marks` AS `marks`,coalesce(`a`.`application_status`,'not applied') AS `status`,(case when (`s`.`marks` >= 800) then 'eligiable' else 'not eligiable' end) AS `eligablity` from (`college_admission`.`students` `s` left join `college_admission`.`applications` `a` on((`s`.`student_id` = `a`.`student_id`)));
USE `college_admission`;

DELIMITER $$
USE `college_admission`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `college_admission`.`Marks_check`
BEFORE INSERT ON `college_admission`.`applications`
FOR EACH ROW
begin 
   declare stu_marks int;
   
   select marks into stu_marks
   from students where student_id = new.student_id;
   
   IF stu_marks >= 800 THEN
	  set new.application_status = 'Approved';
      set new.remarks = 'Eligible for Admission';
   else
	  set new.application_status = 'Rejected';
      set new.remarks = 'Not Eligible for Admission';
    end if ;
end$$

USE `college_admission`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `college_admission`.`trg_application_process1`
AFTER INSERT ON `college_admission`.`applications`
FOR EACH ROW
BEGIN

    IF NEW.application_status = 'Approved' THEN

        INSERT INTO admissions(application_id, admission_date)
        VALUES(NEW.application_id, CURDATE());
        
        UPDATE students
        SET admission_status = 'Approved'
        WHERE student_id = NEW.student_id;

    ELSE

        INSERT INTO rejections(application_id, rejected_date, reason)
        VALUES(
            NEW.application_id,
            CURDATE(),
            NEW.remarks
        );
        
        UPDATE students
        SET admission_status = 'Rejected'
        WHERE student_id = NEW.student_id;

    END IF;

END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
