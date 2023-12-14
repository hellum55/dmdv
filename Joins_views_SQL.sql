-- 1. Consider the tables given in the figure above. Make an inner join between Student course and Student.
select sc.student_number, sc.course_id, sc.accepted, s.student_number, s.student_name, s.department_code 
from student_course sc
inner join student s 
on sc.student_number = s.student_number;

-- . Make the same inner join as in the previous exercise, but only select the columns accepted and student name
select sc.accepted, s.student_name 
from student_course sc
inner join student s 
on sc.student_number = s.student_number;

-- 3. Consider the tables given in the figure above. Make an inner join between Student course, 
-- Student and Course but only select the columns accepted, student name and course name.
select sc.accepted, s.student_name, c.course_name
from student_course sc
inner join student s 
on sc.student_number = s.student_number
inner join course c 
on c.course_id = sc.course_id;

-- 4. Consider the tables given in the figure above. Make a view that gives the number
-- of students applied for the different course majors (i.e. replicate the table below)
create view bi.students_applied as
select count(sc.student_number) as students_appled, c.course_major
from bi.course c 
inner join bi.student_course sc 
on c.course_id = sc.course_id
group by c.course_major;

select * from bi.students_applied;

-- 5. Consider the tables given in the figure above. Make a view(call the view vw students all info) 
--that gives the number ofstudents who applied for each course with information on
--department name, and course major (i.e. replicate the table below).
create view bi.vw_students_all_info as
select count(s.student_number) as students_applied, d.department_name, c.course_name, c.course_major
from bi.department d 
left join bi.student s 
on d.department_code = s.department_code  
left join bi.student_course sc 
on sc.student_number  = s.student_number 
left join bi.course c 
on c.course_id = sc.course_id 
group by d.department_name, c.course_name, c.course_major;

select * from bi.vw_students_all_info;

-- 6. A new student, Magnus, is accepted to take the course Biochemistry at Bsc in Medicine
-- in the Medicine department. Update the basetable(s) accordingly. Run the view
-- vw students all info) and confirm it is updated correctly (i.e.nthe view should look like the table below)

select * from bi.vw_students_all_info;

insert into bi.student values(default, 'Magnus', 4);
insert into bi.student_course values(5, 5, 'Accepted');















































