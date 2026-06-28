-- trg_application_process1 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | CREATE DEFINER=`root`@`localhost` TRIGGER `trg_application_process1` AFTER INSERT ON `applications` FOR EACH ROW BEGIN

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


------------+----------------------+--------------------+
| Marks_check             
 | INSERT | applications 
 | begin
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
end                    

 BEFORE | 2026-06-27 23:12:25.91 | ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION,NO_ZERO_DATE,NO_ZERO_IN_DATE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| trg_application_process1 | INSERT | applications | BEGIN

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


