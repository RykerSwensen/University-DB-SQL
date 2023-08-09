-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `university` ;

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`college` ;

CREATE TABLE IF NOT EXISTS `university`.`college` (
  `college_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`department` ;

CREATE TABLE IF NOT EXISTS `university`.`department` (
  `department_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `department_name` VARCHAR(45) NOT NULL,
  `department_code` ENUM('CIT', 'ECON', 'HUM') NOT NULL,
  `college_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`department_id`),
  INDEX `fk_department_college_idx` (`college_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`course` ;

CREATE TABLE IF NOT EXISTS `university`.`course` (
  `course_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_name` VARCHAR(45) NOT NULL,
  `course_number` INT NOT NULL,
  `course_credit` INT NOT NULL,
  `department_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_course_department1_idx` (`department_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`faculty` ;

CREATE TABLE IF NOT EXISTS `university`.`faculty` (
  `faculty_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `faculty_last_name` VARCHAR(45) NOT NULL,
  `faculty_first_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`faculty_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`semester`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`semester` ;

CREATE TABLE IF NOT EXISTS `university`.`semester` (
  `semester_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `semester_name` ENUM('Fall', 'Winter') NOT NULL,
  `semester_year` YEAR NOT NULL,
  PRIMARY KEY (`semester_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`section` ;

CREATE TABLE IF NOT EXISTS `university`.`section` (
  `section_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `section_number` INT NOT NULL,
  `section_capacity` INT NOT NULL,
  `course_id` INT UNSIGNED NOT NULL,
  `faculty_id` INT UNSIGNED NOT NULL,
  `semester_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_section_course1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_section_faculty1_idx` (`faculty_id` ASC) VISIBLE,
  INDEX `fk_section_semester1_idx` (`semester_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`student` ;

CREATE TABLE IF NOT EXISTS `university`.`student` (
  `student_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `student_last_name` VARCHAR(45) NOT NULL,
  `student_first_name` VARCHAR(45) NOT NULL,
  `student_gender` ENUM('M', 'F') NOT NULL,
  `student_city` VARCHAR(45) NOT NULL,
  `student_state` VARCHAR(2) NOT NULL,
  `student_dob` DATE NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `university`.`enrollment` (
  `student_id` INT UNSIGNED NOT NULL,
  `section_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`student_id`, `section_id`),
  INDEX `fk_student_has_section_section1_idx` (`section_id` ASC) VISIBLE,
  INDEX `fk_student_has_section_student1_idx` (`student_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE university; 
INSERT INTO college
(college_name)
VALUES 
('College of Physical Science and Engineering'),
('College of Business and Communication'),
('College of Language and Letters');

INSERT INTO department
(department_name, department_code, college_id)
VALUES
('Computer Information Technology', 1,1),
('Economics',2,2),
('Humanities and Philosophy',3,3);

INSERT INTO course 
(course_name, course_number, course_credit, department_id)
VALUES
('Intro to Databases', 111, 3, 1),
('Econometrics', 388, 4, 2),
('Micro Economics', 150, 3, 2),
('Classical Heritage', 376, 2, 3);

INSERT INTO faculty
(faculty_first_name, faculty_last_name)
VALUES
('Marty', 'Morring'),
('Nate', 'Nathan'),
('Ben', 'Barrus'),
('John', 'Jenson'),
('Bill', 'Barney');

INSERT INTO semester
(semester_year, semester_name)
VALUES
(2018, 2),
(2019, 1);

INSERT INTO section
(section_number, section_capacity, course_id, faculty_id, semester_id)
VALUES
(1, 30, 1, 1, 2),
(1, 50, 3, 2, 2),
(2, 50, 3, 2, 2),
(1, 35, 2, 3, 2),
(1, 30, 4, 4, 2),
(2, 30, 1, 1, 1),
(3, 35, 1, 5, 1),
(1, 50, 3, 2, 1),
(2, 50, 3, 2, 1),
(1, 30, 4, 4, 1);

INSERT INTO student
(student_first_name, student_last_name, student_gender, student_city, student_state, student_dob)
VALUES
('Paul', 'Miller', 1, 'Dallas', 'TX', '1996-02-22'),
('Katie', 'Smith', 2, 'Provo', 'UT', '1995-07-22'),
('Kelly', 'Jones', 2, 'Provo', 'UT', '1998-06-22'),
('Devon', 'Merrill', 1, 'Mesa', 'AZ', '2000-07-22'),
('Mandy', 'Murdock', 2, 'Topeka', 'KS', '1996-11-22'),
('Alece', 'Adams', 2, 'Rigby', 'ID', '1997-05-22'),
('Bryce', 'Carlson', 1, 'Bozemen', 'MT', '1997-11-22'),
('Preston', 'Larsen', 1, 'Decatur', 'TN', '1996-09-22'),
('Julia', 'Madsen', 2, 'Rexburg', 'ID', '1998-09-22'),
('Susan', 'Sorensen', 2, 'Mesa', 'AZ', '1998-08-09');

INSERT INTO enrollment
(student_id, section_id)
VALUES
(6,7),
(7,6),
(7,8),
(7,10),
(4,5),
(9, 9),
(2,4),
(3,4),
(5,4),
(5,5),
(1, 1),
(1,3),
(8,9),
(10,6);

SET sql_mode="ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION";

/* Query 1: Students, and their birthdays, of students born in September. Format the date to look like it is shown in the result set. Sort by the student's last name. */
USE university;
SELECT student_first_name AS student_firstname, student_last_name AS student_lastname, DATE_FORMAT(student_dob, "%M %d, %Y") AS 'Sept Birthdays'
FROM student
WHERE DATE_FORMAT(student_dob, '%c') = 9;

/* Query 2: Student's age in years and days as of Jan. 5, 2017.  Sorted from oldest to youngest.  (You can assume a 365 day year and ignore leap day.) Hint: Use modulus for days left over after years. The 5th column is just the 3rd and 4th column combined with labels. */
SELECT student_last_name AS student_lastname, student_first_name AS student_firstname, FLOOR(DATEDIFF('2017-01-05', student_dob) / 365) AS Years, DATEDIFF('2017-01-05', student_dob) % 365 AS Days, concat(concat(FLOOR(DATEDIFF('2017-01-05', student_dob) / 365), '-Yrs, '), CONCAT(DATEDIFF('2017-01-05', student_dob) % 365), '-Days') AS 'Years and Days'
FROM student
ORDER BY DATEDIFF('2017-01-05', student_dob) / 365 DESC;

/* Query 3: Students taught by John Jensen. Sorted by student last name */
SELECT student_first_name AS student_firstname, student_last_name AS student_lastname
FROM student as s
JOIN enrollment AS e ON s.student_id = e.student_id
JOIN section AS se ON e.section_id = se.section_id
WHERE e.section_id = 10 OR e.section_id = 5
ORDER BY student_lastname;

/* Query 4:   A list of the instructors Bryce Carlson will have in Winter 2018. Sort by the faculty's last name. */
SELECT faculty_first_name AS faculty_firstname, faculty_last_name AS faculty_lastname
FROM faculty AS f
JOIN section as s ON f.faculty_id = s.faculty_id
JOIN enrollment AS e ON e.section_id = s.section_id
WHERE student_id = 7
ORDER BY faculty_lastname;

/* Query 5: Students that take Econometrics in Fall 2019. Sort by student last name. */ 
SELECT student_first_name AS student_firstname, student_last_name AS student_lastname
FROM student as s
JOIN enrollment AS e ON s.student_id = e.student_id
JOIN section AS se ON e.section_id = se.section_id
JOIN course AS c ON se.course_id = c.course_id
JOIN semester AS sem ON se.semester_id = sem.semester_id
WHERE se.semester_id = 2 and se.course_id = 2
ORDER BY student_lastname;

/* Query 6: Report showing all of Bryce Carlson's courses for Winter. Sort by the name of the course. */
SELECT department_code, course_number AS course_num, course_name
FROM department as d
JOIN course as c ON d.department_id = c.department_id
JOIN section AS s ON c.course_id = s.course_id
JOIN enrollment AS e ON s.section_id = e.section_id 
JOIN student AS st ON e.student_id = st.student_id
WHERE st.student_id = 7
ORDER BY course_name;

/* Query 7: The number of non-distinct students enrolled for Fall 2019 */
SELECT semester_name AS term, semester_year, count(e.student_id) AS Enrollment
FROM semester AS s
JOIN section AS se ON s.semester_id = se.semester_id
JOIN enrollment AS e ON se.section_id = e.section_id
JOIN student AS st ON e.student_id = st.student_id
WHERE s.semester_name = 1
GROUP BY semester_year;

/* Query 8: The number of courses in each college. Sort by college name. */
SELECT college_name AS colleges, count(course_id) AS courses
FROM college AS c
JOIN department AS d ON c.college_id = d.college_id
JOIN course AS co ON d.department_id = co.department_id
GROUP BY college_name
ORDER BY college_name;

/* Query 9: The total number of students each professor can teach in Winter 2018. Sort by that total number of students (teaching capacity). 
As long as the TeachingCapacity is from least to greatest, the order of the faculty names doesn't matter. */
SELECT faculty_first_name AS faculty_firstname, faculty_last_name AS faculty_lastname, SUM(section_capacity) AS TeachingCapacity
FROM faculty AS f
JOIN section AS s ON f.faculty_id = s.faculty_id
JOIN semester AS se ON s.semester_id = se.semester_id
WHERE s.semester_id = 1
GROUP BY section_capacity, f.faculty_first_name, f.faculty_last_name
ORDER BY section_capacity, f.faculty_first_name, f.faculty_last_name;

/* Query 10: Each student's total credit load for Fall 2019, but only students with a credit load greater than three.  Sort by credit load in descending order. */ 
SELECT student_last_name AS student_lastname, student_first_name AS student_firstname, SUM(course_credit) AS Credits
FROM student AS s
JOIN enrollment AS e ON s.student_id = e.student_id
JOIN section AS se ON e.section_id = se.section_id
JOIN course AS c ON se.course_id = c.course_id
WHERE semester_id = 2
GROUP BY student_last_name, student_first_name
ORDER BY SUM(course_credit) DESC
LIMIT 4;
