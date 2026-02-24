USE pwskills_subqueries;
CREATE TABLE Student_Performance (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    course VARCHAR(30),
    score INT,
    attendance INT,
    mentor VARCHAR(50),
    join_date DATE,
    city VARCHAR(50)
);
INSERT INTO Student_Performance
(student_id, name, course, score, attendance, mentor, join_date, city)
VALUES
(101,'Aarav Mehta','Data Science',88,92,'Dr. Sharma','2023-06-12','Mumbai'),
(102,'Riya Singh','Data Science',76,85,'Dr. Sharma','2023-07-01','Delhi'),
(103,'Kabir Khanna','Python',91,96,'Ms. Nair','2023-06-20','Mumbai'),
(104,'Tanvi Patel','SQL',84,89,'Mr. Iyer','2023-05-30','Bengaluru'),
(105,'Ayesha Khan','Python',67,81,'Ms. Nair','2023-07-10','Hyderabad');

-- Question1 Create a ranking of students based on score (highest first).
SELECT
    student_id,
    name,
    score,
    RANK() OVER (ORDER BY score DESC) AS score_rank
FROM Student_Performance;

-- question2 how each student's score and the previous student’s score (based on score order).

SELECT
    name,
    score,
    LAG(score) OVER (ORDER BY score DESC) AS previous_score
FROM Student_Performance;

-- question3 Convert all student names to uppercase and extract the month name from join_date.

SELECT
    UPPER(name) AS student_name,
    MONTHNAME(join_date) AS join_month
FROM Student_Performance;

-- Question4 Show each student's name and the next student’s attendance (ordered by attendance).
SELECT
    name,
    attendance,
    LEAD(attendance) OVER (ORDER BY attendance) AS next_student_attendance
FROM Student_Performance;

-- Question5 Assign students into 4 performance groups using NTILE().

SELECT
    name,
    score,
    NTILE(4) OVER (ORDER BY score DESC) AS performance_group
FROM Student_Performance;

-- Question6 For each course, assign a row number based on attendance (highest first).
SELECT
    name,
    course,
    attendance,
    ROW_NUMBER() OVER (
        PARTITION BY course
        ORDER BY attendance DESC
    ) AS row_num
FROM Student_Performance;

-- Question7 Calculate the number of days each student has been enrolled
SELECT
    name,
    join_date,
    DATEDIFF('2025-01-01', join_date) AS days_enrolled
FROM Student_Performance;

-- Question8 Format join_date as “Month Year” (e.g., “June 2023”).
SELECT
    name,
    DATE_FORMAT(join_date, '%M %Y') AS formatted_join_date
FROM Student_Performance;

-- Question9 Replace the city ‘Mumbai’ with ‘MUM’ for display purposes.
SELECT
    name,
    REPLACE(city, 'Mumbai', 'MUM') AS city_display
FROM Student_Performance;

-- Question10 For each course, find the highest score using FIRST_VALUE().
SELECT
    name,
    course,
    score,
    FIRST_VALUE(score) OVER (
        PARTITION BY course
        ORDER BY score DESC
    ) AS highest_score_in_course
FROM Student_Performance;
