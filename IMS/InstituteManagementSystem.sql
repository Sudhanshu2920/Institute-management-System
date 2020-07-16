create database InstituteManagementSystem ;
use InstituteManagementSystem ;

create table Department(
Dept_name varchar(30) not null,
Budget float not null check(budget>0),
Building varchar(20) unique,
primary key(Dept_name)
);

create table Faculty(
Name varchar(30) not null,
Qualification varchar(30) not null,
Fac_id char(5) ,
Gender varchar(6),
check (Gender in('Male','Female')),
Date_of_Birth date not null,
Address varchar(100) not null,
Designation varchar(30),
salary numeric(9,2)not null ,
check(salary>35000),
PhoneNumber char(10) unique not null,
Email_id varchar(30)unique not null,
Department varchar(30) not null,
Password varchar(20) not null,
primary key(Fac_id),
foreign key (Department) references Department(Dept_name)
);

create table Student(
Name varchar(30) not null,
Father_name varchar(30) not null,
Stu_id char(5) ,
Gender varchar(6) not null,
check (Gender in('Male','Female')),
Date_of_birth date not null,
date_of_admission date not null,
Address varchar(100) not null,
Course varchar(10),
PhoneNumber char(10) unique not null,
Email_id varchar(30) unique not null,
Password varchar(20) not null,
Department varchar(30) not null,
primary key(stu_id),
foreign key (Department) references Department(Dept_name)
);

create view student_view as select name,Department,stu_id,gender,date_of_admission from student;

create view faculty_view as select name,qualification,fac_id,gender,Department from faculty;

create table Course(
Course_id varchar(10) ,
Title varchar(50) not null,
Credits char(1) not null,
check(credits in(0,1,2,3,4,5)),
Department varchar(30) not null,
primary key(Course_id),
foreign key (Department) references Department(Dept_name)
);

create table Section(
Course_id varchar(10) not null,
Sec_id char(1) not null,
Semester char(1),
check (Semester in('1','2','3','4','5','6','7','8')),
year year ,
primary key(Course_id,sec_id,Semester,year),
foreign key (Course_id) references Course(Course_id) on delete cascade on update cascade
);

create table Prereq(
Course_id varchar(10) not null,
prereq_id varchar(10),
primary key(Course_id,prereq_id),
foreign key (Course_id) references Course(Course_id) on delete cascade on update cascade,
foreign key (prereq_id) references Course(Course_id) on delete cascade on update cascade
);

create table Advisor(
Fac_id char(5),
Stu_id char(5),
primary key(Stu_id),
foreign key (Fac_id) references Faculty(Fac_ID) on delete cascade on update cascade,
foreign key (Stu_id) references Student(Stu_id) on delete cascade on update cascade
);

create table Takes(
Course_id varchar(10),
Sec_id char(1),
Semester char(1),
year year,
Stu_id char(5),
grade char(2),
primary key(Course_id,Semester,year,stu_id),
foreign key (Stu_id) references Student(Stu_id) on delete cascade on update cascade,
foreign key(course_id,sec_id,semester,year) references section(course_id,sec_id,semester,year) on delete cascade on update cascade
);


create table Teaches(
Course_id varchar(10),
Sec_id char(1),
Semester char(1),
check (Semester in('1','2','3','4','5','6','7','8')),
year year,
Fac_id char(5),
primary key(Course_id,sec_id,Semester,year,Fac_id),
foreign key (Course_id) references Course(Course_id) on delete cascade on update cascade,
foreign key (Fac_id) references Faculty(Fac_id) on delete cascade on update cascade
);

create table Attendence(
Course_id varchar(10),
Sec_id char(1),
Semester char(1),
year year,
date date,
Status char,
check(Status in('P','A')),
Stu_id char(5),
primary key(Course_id,Sec_id,Semester,year,Stu_id,date),
foreign key(Course_id,sec_id,semester,year) references Section(Course_id,sec_id,semester,year) on delete cascade on update cascade,
foreign key(Stu_id) references Student(Stu_id) on delete cascade on update cascade
);

create table Classroom(
RoomNumber varchar(3) not null,
Building varchar(10) not null,
capacity int not null,
primary key(RoomNumber,Building)
);

create table Sec_class(
Course_id varchar(10),
Sec_id char(1),
Semester char(1),
year year,
RoomNumber varchar(3),
Building char(10),
primary key(Course_id,Sec_id,Semester,year,RoomNumber,Building),
foreign key(RoomNumber,Building) references classroom(RoomNumber,Building) on delete cascade on update cascade,
foreign key(Course_id,sec_id,semester,year) references Section(Course_id,sec_id,semester,year) on delete cascade on update cascade
);


-- this table is to know that which semester is going on i.e-even semester or odd semester is going on
create table current_semester(
id char,
semester char(4),
check(semester in("even","odd"))
);
insert into current_semester values('1','odd');

create table admin(
id char(5),
password varchar(15),
primary key (id)
);
insert into admin values(12345,"12345");



-- Classroom
insert into classroom values('01','CS',80);
insert into classroom values('02','CS',80);
insert into classroom values('01','IT',80);
insert into classroom values('02','IT',80);

-- Department
insert into department values("Computer Science",109876,"CS");
insert into department values("Information Technology",567453,"IT");

-- select *  from department;

-- Courses
-- 1st Semester
insert into course values('CS-111',"Introduction to C programming",3,'Computer Science');
insert into course values('CS-112',"Introduction to Electronics",3,'Computer Science');
insert into course values('CS-113',"Inroduction to Physics-1",3,'Computer Science');
insert into course values('CS-114',"English and Communication",3,'Computer Science');
-- 2nd Semester
insert into course values('CS-121',"Linear Algebra",3,'Computer Science');
insert into course values('CS-122',"Introduction to Electrical Enginnering",3,'Computer Science');
insert into course values('CS-123',"Inroduction to Physics-2",3,'Computer Science');
insert into course values('CS-124',"Science, Technology and Society",3,'Computer Science');
-- 3rd Semester
insert into course values('CS-231',"Discrete Mathematics",3,'Computer Science');
insert into course values('CS-232',"Introduction to Data Structure",3,'Computer Science');
insert into course values('CS-233',"Inroduction to OOPs",3,'Computer Science');
insert into course values('CS-234',"Technical Writing",3,'Computer Science');
-- 4th Semester
insert into course values('CS-241',"Probability and Statstics",3,'Computer Science');
insert into course values('CS-242',"Introduction to Algorithms",3,'Computer Science');
insert into course values('CS-243',"Digital Logic",3,'Computer Science');
insert into course values('CS-244',"Environmental Science",3,'Computer Science');
-- 5th Semester
insert into course values('CS-351',"Intoduction to Database",3,'Computer Science');
insert into course values('CS-352',"Computer Architecture",3,'Computer Science');
insert into course values('CS-353',"Operating System",3,'Computer Science');
insert into course values('CS-354',"Economics",3,'Computer Science');
-- 6th Semester
insert into course values('CS-361',"Computer Networks",3,'Computer Science');
insert into course values('CS-362',"Compiler Design",3,'Computer Science');
insert into course values('CS-363',"Software Engineering",3,'Computer Science');
insert into course values('CS-364',"Professional Ethics",3,'Computer Science');
-- 7th Semester
insert into course values('CS-471',"Cryptography",3,'Computer Science');
insert into course values('CS-472',"Artificial Intelligence",3,'Computer Science');
insert into course values('CS-473',"Machine Learning",3,'Computer Science');
insert into course values('CS-474',"Automata Theory",3,'Computer Science');
-- 8th Semester
insert into course values('CS-481','B.Tech Project-1',4,'Computer Science');
insert into course values('CS-482','B.Tech Project-2',4,'Computer Science');
insert into course values('CS-483','B.Tech Project-3',4,'Computer Science');

-- Courses for IT
-- 4th Semester 
insert into course values('IT-241',"Web Technology",3,'Information Technology');
-- 6th Semester
insert into course values('IT-361',"Information Retrievel",3,'Information Technology');
-- 7th Semester
insert into course values('IT-471',"Management in IT",3,'Information Technology');

-- Prerequisties
insert into prereq values('CS-471','CS-361');
insert into prereq values('CS-472','CS-241');
insert into prereq values('CS-473','CS-121');


-- Section
-- Both for CS and IT
insert into section values('CS-111','A','1',2017);
insert into section values('CS-112','A','1',2017);
insert into section values('CS-113','A','1',2017);
insert into section values('CS-114','A','1',2017);

insert into section values('CS-121','A','2',2018);
insert into section values('CS-122','A','2',2018);
insert into section values('CS-123','A','2',2018);
insert into section values('CS-124','A','2',2018);

insert into section values('CS-231','A','3',2018);
insert into section values('CS-232','A','3',2018);
insert into section values('CS-233','A','3',2018);
insert into section values('CS-234','A','3',2018);

insert into section values('CS-241','A','4',2019);
insert into section values('CS-242','A','4',2019);
insert into section values('CS-243','A','4',2019);
insert into section values('CS-244','A','4',2019);

insert into section values('CS-351','A','5',2019);
insert into section values('CS-352','A','5',2019);
insert into section values('CS-353','A','5',2019);
insert into section values('CS-354','A','5',2019);

insert into section values('CS-361','A','6',2020);
insert into section values('CS-362','A','6',2020);
insert into section values('CS-363','A','6',2020);
insert into section values('CS-364','A','6',2020);

insert into section values('CS-471','A','7',2020);
insert into section values('CS-472','A','7',2020);
insert into section values('CS-473','A','7',2020);
insert into section values('CS-474','A','7',2020);

insert into section values('CS-351','A','5',2020);
insert into section values('CS-352','A','5',2020);
insert into section values('CS-353','A','5',2020);
insert into section values('CS-354','A','5',2020);

insert into section values('CS-111','A','1',2020);
insert into section values('CS-112','A','1',2020);
insert into section values('CS-113','A','1',2020);
insert into section values('CS-114','A','1',2020);

-- Only for IT
insert into section values('IT-241','A','4',2019);
insert into section values('IT-361','A','6',2020);
insert into section values('IT-471','A','7',2020);

-- select * from section;
-- Sec_class
-- For Computer Science
insert into sec_class values('CS-471','A','7',2020,'01','CS');
insert into sec_class values('CS-472','A','7',2020,'01','CS');
insert into sec_class values('CS-473','A','7',2020,'01','CS');
insert into sec_class values('CS-474','A','7',2020,'01','CS');

-- For Information Technology
insert into sec_class values('IT-471','A','7',2020,'01','IT');
insert into sec_class values('CS-472','A','7',2020,'01','IT');
insert into sec_class values('CS-473','A','7',2020,'01','IT');
insert into sec_class values('CS-474','A','7',2020,'01','IT');

-- select * from sec_class;

--  Faculty
insert into faculty values('Aman Jha','Ph.D','001','Male','1988-07-07','Gandhinagar Gujarat','Professor',90000,6396568596,'aman@gmail.com','Computer Science','1988-07-07');
insert into teaches values('CS-471','A','7',2020,'001');

insert into faculty values('Akash Pal','Ph.D','002','Male','1988-07-07','Gandhinagar Gujarat','Professor',90000,6396568597,'akash@gmail.com','Computer Science','1988-07-07');
insert into teaches values('CS-472','A','7',2020,'002');

insert into faculty values('Prateek Senapati','Ph.D','003','Male','1988-07-07','Gandhinagar Gujarat','Professor',90000,6396568599,'prateek@gmail.com','Computer Science','1988-07-07');
insert into teaches values('CS-473','A','7',2020,'003');

insert into faculty values('Pavan Singh','Ph.D','004','Male','1988-07-07','Gandhinagar Gujarat','Professor',90000,6396568590,'pavan@gmail.com','Computer Science','1988-07-07');
insert into teaches values('CS-474','A','7',2020,'004');
insert into teaches values('IT-471','A','7',2020,'004');


insert into faculty values('Anirudh Jaiswal','Ph.D','005','Male','1988-07-07','Gandhinagar Gujarat','Professor',90000,6796568599,'anirudh@gmail.com','Computer Science','1988-07-07');
insert into faculty values('Chaman Lal','Ph.D','006','Male','1988-07-07','Gandhinagar Gujarat','Professor',90000,6396368596,'chaman@gmail.com','Computer Science','1988-07-07');
insert into faculty values('Samay Raina','Ph.D','007','Male','1988-07-07','Gandhinagar Gujarat','Professor',90000,6396568566,'samay@gmail.com','Computer Science','1988-07-07');
insert into faculty values('Abhisekh Singh','Ph.D','008','Male','1988-07-07','Gandhinagar Gujarat','Professor',90000,6396568516,'abhishek@gmail.com','Computer Science','1988-07-07');
insert into faculty values('Mandeep Singh','Ph.D','009','Male','1988-07-07','Gandhinagar Gujarat','Professor',90000,6396568196,'mandeep@gmail.com','Information Technology','1988-07-07');
insert into faculty values('Bhuvan Rai','Ph.D','010','Male','1988-07-07','Gandhinagar Gujarat','Professor',90000,6396568396,'bhuvan@gmail.com','Information Technology','1988-07-07');
insert into faculty values('Mukesh Kumar','Ph.D','011','Male','1988-07-07','Gandhinagar Gujarat','Professor',90000,6396564296,'mukesh@gmail.com','Information Technology','1988-07-07');
insert into faculty values('Suresh Pal','Ph.D','012','Male','1988-07-07','Gandhinagar Gujarat','Professor',90000,6396564596,'suresh@gmail.com','Information Technology','1988-07-07');
insert into faculty values('Naman Verma','Ph.D','013','Male','1988-07-07','Gandhinagar Gujarat','Professor',90000,6316512596,'naman@gmail.com','Information Technology','1988-07-07');

-- select * from faculty;


-- Student Entry 2017-2021 Batch
-- Computer Science
-- Student Information
insert into student values ("Aman Sagar","Asutosh Sagar",17001,'Male','2000-11-29','2017-07-22','A.N-241/3,chandangar colony,karaundi,varanasi,UP,221005','B.Tech',7393801581,'aman17@gmail.com','2000-11-29','Computer Science');
insert into student values ("Gaurav Singh","Manoj Singh",17002,'Male','2000-11-29','2017-07-22','A.N-241/3,chandangar colony,karaundi,varanasi,UP,221005','B.Tech',7393801582,'guarav17@gmail.com','2000-11-29','Computer Science');
insert into student values ("Neel Patel","Akash Patel",17003,'Male','2000-11-29','2017-07-22','A.N-241/3,chandangar colony,karaundi,varanasi,UP,221005','B.Tech',7393801583,'neel17@gmail.com','2000-11-29','Computer Science');
insert into student values ("Sudhanshu Pandey","Pradeep kr Pandey",17004,'Male','2000-11-29','2017-07-22','A.N-241/3,chandangar colony,karaundi,varanasi,UP,221005','B.Tech',7393801585,'shudhansu17@gmail.com','2000-11-29', 'Computer Science');


-- Information Technology
insert into student values ("Aman Sagar","Asutosh Sagar",17101,'Male','2000-11-29','2017-07-22','A.N-241/3,chandangar colony,karaundi,varanasi,UP,221005','B.Tech',7193801581,'aman171@gmail.com','2000-11-29','Information Technology');
insert into student values ("Gaurav Singh","Manoj Singh",17102,'Male','2000-11-29','2017-07-22','A.N-241/3,chandangar colony,karaundi,varanasi,UP,221005','B.Tech',7193801582,'guarav171@gmail.com','2000-11-29','Information Technology');
insert into student values ("Neel Patel","Akash Patel",17103,'Male','2000-11-29','2017-07-22','A.N-241/3,chandangar colony,karaundi,varanasi,UP,221005','B.Tech',7193801583,'neel171@gmail.com','2000-11-29','Information Technology');
insert into student values ("Sudhanshu Pandey","Pradeep kr Pandey",17104,'Male','2000-11-29','2017-07-22','A.N-241/3,chandangar colony,karaundi,varanasi,UP,221005','B.Tech',7193801585,'shudhansu171@gmail.com','2000-11-29', 'Information Technology');
-- select * from student;


-- Student Entry 2018-2019 Batch
-- Computer Science
-- Student Information
insert into student values ("Aman Sagar","Asutosh Sagar",1801,'Male','2000-11-29','2018-07-22','A.N-241/3,chandangar colony,karaundi,varanasi,UP,221005','B.Tech',6393801581,'aman@gmail.com','2000-11-29','Computer Science');
insert into student values ("Gaurav Singh","Manoj Singh",1802,'Male','2000-11-29','2018-07-22','A.N-241/3,chandangar colony,karaundi,varanasi,UP,221005','B.Tech',6393801582,'guarav@gmail.com','2000-11-29','Computer Science');
insert into student values ("Neel Patel","Akash Patel",1803,'Male','2000-11-29','2018-07-22','A.N-241/3,chandangar colony,karaundi,varanasi,UP,221005','B.Tech',6393801583,'neel@gmail.com','2000-11-29','Computer Science');
insert into student values ("Ritesh Pandey","Akhil Kumar Pandey",1804,'Male','2000-11-29','2018-07-22','A.N-241/3,chandangar colony,karaundi,varanasi,UP,221005','B.Tech',6393801584,'ritesh@gmail.com','2000-11-29','Computer Science');
insert into student values ("Sudhanshu Pandey","Pradeep kr Pandey",1805,'Male','2000-11-29','2018-07-22','A.N-241/3,chandangar colony,karaundi,varanasi,UP,221005','B.Tech',6393801585,'shudhansu29@gmail.com','2000-11-29', 'Computer Science');


-- Course Takes by CS
-- ID 17001
insert into takes values('CS-111','A','1',2017,17001,'AA');
insert into takes values('CS-112','A','1',2017,17001,'AB');
insert into takes values('CS-113','A','1',2017,17001,'BB');
insert into takes values('CS-114','A','1',2017,17001,'AA');
insert into takes values('CS-121','A','2',2018,17001,'AB');
insert into takes values('CS-122','A','2',2018,17001,'BB');
insert into takes values('CS-123','A','2',2018,17001,'BC');
insert into takes values('CS-124','A','2',2018,17001,'AA');
insert into takes values('CS-231','A','3',2018,17001,'BB');
insert into takes values('CS-232','A','3',2018,17001,'AB');
insert into takes values('CS-233','A','3',2018,17001,'AA');
insert into takes values('CS-234','A','3',2018,17001,'AB');
insert into takes values('CS-241','A','4',2019,17001,'AB');
insert into takes values('CS-242','A','4',2019,17001,'BB');
insert into takes values('CS-243','A','4',2019,17001,'AA');
insert into takes values('CS-244','A','4',2019,17001,'BB');
insert into takes values('CS-351','A','5',2019,17001,'AA');
insert into takes values('CS-352','A','5',2019,17001,'AA');
insert into takes values('CS-353','A','5',2019,17001,'AB');
insert into takes values('CS-354','A','5',2019,17001,'AA');
insert into takes values('CS-361','A','6',2020,17001,'AA');
insert into takes values('CS-362','A','6',2020,17001,'AA');
insert into takes values('CS-363','A','6',2020,17001,'AA');
insert into takes values('CS-364','A','6',2020,17001,'AB');
insert into takes values('CS-471','A','7',2020,17001,'NA');
insert into takes values('CS-472','A','7',2020,17001,'NA');
insert into takes values('CS-473','A','7',2020,17001,'NA');
insert into takes values('CS-474','A','7',2020,17001,'NA');

-- ID 17002
insert into takes values('CS-111','A','1',2017,17002,'AA');
insert into takes values('CS-112','A','1',2017,17002,'AB');
insert into takes values('CS-113','A','1',2017,17002,'BB');
insert into takes values('CS-114','A','1',2017,17002,'AA');
insert into takes values('CS-121','A','2',2018,17002,'AB');
insert into takes values('CS-122','A','2',2018,17002,'BB');
insert into takes values('CS-123','A','2',2018,17002,'Bc');
insert into takes values('CS-124','A','2',2018,17002,'AA');
insert into takes values('CS-231','A','3',2018,17002,'BB');
insert into takes values('CS-232','A','3',2018,17002,'AB');
insert into takes values('CS-233','A','3',2018,17002,'AA');
insert into takes values('CS-234','A','3',2018,17002,'AB');
insert into takes values('CS-241','A','4',2019,17002,'AB');
insert into takes values('CS-242','A','4',2019,17002,'BB');
insert into takes values('CS-243','A','4',2019,17002,'AA');
insert into takes values('CS-244','A','4',2019,17002,'BB');
insert into takes values('CS-351','A','5',2019,17002,'AA');
insert into takes values('CS-352','A','5',2019,17002,'AA');
insert into takes values('CS-353','A','5',2019,17002,'AB');
insert into takes values('CS-354','A','5',2019,17002,'AA');
insert into takes values('CS-361','A','6',2020,17002,'AA');
insert into takes values('CS-362','A','6',2020,17002,'AA');
insert into takes values('CS-363','A','6',2020,17002,'AA');
insert into takes values('CS-364','A','6',2020,17002,'AB');
insert into takes values('CS-471','A','7',2020,17002,'NA');
insert into takes values('CS-472','A','7',2020,17002,'NA');
insert into takes values('CS-473','A','7',2020,17002,'NA');
insert into takes values('CS-474','A','7',2020,17002,'NA');

-- ID 17003
insert into takes values('CS-111','A','1',2017,17003,'AA');
insert into takes values('CS-112','A','1',2017,17003,'AB');
insert into takes values('CS-113','A','1',2017,17003,'BB');
insert into takes values('CS-114','A','1',2017,17003,'AA');
insert into takes values('CS-121','A','2',2018,17003,'AB');
insert into takes values('CS-122','A','2',2018,17003,'BB');
insert into takes values('CS-123','A','2',2018,17003,'Bc');
insert into takes values('CS-124','A','2',2018,17003,'AA');
insert into takes values('CS-231','A','3',2018,17003,'BB');
insert into takes values('CS-232','A','3',2018,17003,'AB');
insert into takes values('CS-233','A','3',2018,17003,'AA');
insert into takes values('CS-234','A','3',2018,17003,'AB');
insert into takes values('CS-241','A','4',2019,17003,'AB');
insert into takes values('CS-242','A','4',2019,17003,'BB');
insert into takes values('CS-243','A','4',2019,17003,'AA');
insert into takes values('CS-244','A','4',2019,17003,'BB');
insert into takes values('CS-351','A','5',2019,17003,'AA');
insert into takes values('CS-352','A','5',2019,17003,'AA');
insert into takes values('CS-353','A','5',2019,17003,'AB');
insert into takes values('CS-354','A','5',2019,17003,'AA');
insert into takes values('CS-361','A','6',2020,17003,'AA');
insert into takes values('CS-362','A','6',2020,17003,'AA');
insert into takes values('CS-363','A','6',2020,17003,'AA');
insert into takes values('CS-364','A','6',2020,17003,'AB');
insert into takes values('CS-471','A','7',2020,17003,'NA');
insert into takes values('CS-472','A','7',2020,17003,'NA');
insert into takes values('CS-473','A','7',2020,17003,'NA');
insert into takes values('CS-474','A','7',2020,17003,'NA');

-- ID 17004
insert into takes values('CS-111','A','1',2017,17004,'AA');
insert into takes values('CS-112','A','1',2017,17004,'AB');
insert into takes values('CS-113','A','1',2017,17004,'BB');
insert into takes values('CS-114','A','1',2017,17004,'AA');
insert into takes values('CS-121','A','2',2018,17004,'AB');
insert into takes values('CS-122','A','2',2018,17004,'BB');
insert into takes values('CS-123','A','2',2018,17004,'Bc');
insert into takes values('CS-124','A','2',2018,17004,'AA');
insert into takes values('CS-231','A','3',2018,17004,'BB');
insert into takes values('CS-232','A','3',2018,17004,'AB');
insert into takes values('CS-233','A','3',2018,17004,'AA');
insert into takes values('CS-234','A','3',2018,17004,'AB');
insert into takes values('CS-241','A','4',2019,17004,'AB');
insert into takes values('CS-242','A','4',2019,17004,'BB');
insert into takes values('CS-243','A','4',2019,17004,'AA');
insert into takes values('CS-244','A','4',2019,17004,'BB');
insert into takes values('CS-351','A','5',2019,17004,'AA');
insert into takes values('CS-352','A','5',2019,17004,'AA');
insert into takes values('CS-353','A','5',2019,17004,'AB');
insert into takes values('CS-354','A','5',2019,17004,'AA');
insert into takes values('CS-361','A','6',2020,17004,'AA');
insert into takes values('CS-362','A','6',2020,17004,'AA');
insert into takes values('CS-363','A','6',2020,17004,'AA');
insert into takes values('CS-364','A','6',2020,17004,'AB');
insert into takes values('CS-471','A','7',2020,17004,'NA');
insert into takes values('CS-472','A','7',2020,17004,'NA');
insert into takes values('CS-473','A','7',2020,17004,'NA');
insert into takes values('CS-474','A','7',2020,17004,'NA');

-- select * from takes;


-- Course Takes by IT
-- ID 17101
insert into takes values('CS-111','A','1',2017,17101,'AA');
insert into takes values('CS-112','A','1',2017,17101,'AB');
insert into takes values('CS-113','A','1',2017,17101,'BB');
insert into takes values('CS-114','A','1',2017,17101,'AA');
insert into takes values('CS-121','A','2',2018,17101,'AB');
insert into takes values('CS-122','A','2',2018,17101,'BB');
insert into takes values('CS-123','A','2',2018,17101,'BC');
insert into takes values('CS-124','A','2',2018,17101,'AA');
insert into takes values('CS-231','A','3',2018,17101,'BB');
insert into takes values('CS-232','A','3',2018,17101,'AB');
insert into takes values('CS-233','A','3',2018,17101,'AA');
insert into takes values('CS-234','A','3',2018,17101,'AB');
insert into takes values('IT-241','A','4',2019,17101,'AB');
insert into takes values('CS-242','A','4',2019,17101,'BB');
insert into takes values('CS-243','A','4',2019,17101,'AA');
insert into takes values('CS-244','A','4',2019,17101,'BB');
insert into takes values('CS-351','A','5',2019,17101,'AA');
insert into takes values('CS-352','A','5',2019,17101,'AA');
insert into takes values('CS-353','A','5',2019,17101,'AB');
insert into takes values('CS-354','A','5',2019,17101,'AA');
insert into takes values('IT-361','A','6',2020,17101,'AA');
insert into takes values('CS-362','A','6',2020,17101,'AA');
insert into takes values('CS-363','A','6',2020,17101,'AA');
insert into takes values('CS-364','A','6',2020,17101,'AB');
insert into takes values('IT-471','A','7',2020,17101,'NA');
insert into takes values('CS-472','A','7',2020,17101,'NA');
insert into takes values('CS-473','A','7',2020,17101,'NA');
insert into takes values('CS-474','A','7',2020,17101,'NA');

-- ID 17102
insert into takes values('CS-111','A','1',2017,17102,'AA');
insert into takes values('CS-112','A','1',2017,17102,'AB');
insert into takes values('CS-113','A','1',2017,17102,'BB');
insert into takes values('CS-114','A','1',2017,17102,'AA');
insert into takes values('CS-121','A','2',2018,17102,'AB');
insert into takes values('CS-122','A','2',2018,17102,'BB');
insert into takes values('CS-123','A','2',2018,17102,'Bc');
insert into takes values('CS-124','A','2',2018,17102,'AA');
insert into takes values('CS-231','A','3',2018,17102,'BB');
insert into takes values('CS-232','A','3',2018,17102,'AB');
insert into takes values('CS-233','A','3',2018,17102,'AA');
insert into takes values('CS-234','A','3',2018,17102,'AB');
insert into takes values('IT-241','A','4',2019,17102,'AB');
insert into takes values('CS-242','A','4',2019,17102,'BB');
insert into takes values('CS-243','A','4',2019,17102,'AA');
insert into takes values('CS-244','A','4',2019,17102,'BB');
insert into takes values('CS-351','A','5',2019,17102,'AA');
insert into takes values('CS-352','A','5',2019,17102,'AA');
insert into takes values('CS-353','A','5',2019,17102,'AB');
insert into takes values('CS-354','A','5',2019,17102,'AA');
insert into takes values('IT-361','A','6',2020,17102,'AA');
insert into takes values('CS-362','A','6',2020,17102,'AA');
insert into takes values('CS-363','A','6',2020,17102,'AA');
insert into takes values('CS-364','A','6',2020,17102,'AB');
insert into takes values('IT-471','A','7',2020,17102,'NA');
insert into takes values('CS-472','A','7',2020,17102,'NA');
insert into takes values('CS-473','A','7',2020,17102,'NA');
insert into takes values('CS-474','A','7',2020,17102,'NA');

-- ID 17103
insert into takes values('CS-111','A','1',2017,17103,'AA');
insert into takes values('CS-112','A','1',2017,17103,'AB');
insert into takes values('CS-113','A','1',2017,17103,'BB');
insert into takes values('CS-114','A','1',2017,17103,'AA');
insert into takes values('CS-121','A','2',2018,17103,'AB');
insert into takes values('CS-122','A','2',2018,17103,'BB');
insert into takes values('CS-123','A','2',2018,17103,'Bc');
insert into takes values('CS-124','A','2',2018,17103,'AA');
insert into takes values('CS-231','A','3',2018,17103,'BB');
insert into takes values('CS-232','A','3',2018,17103,'AB');
insert into takes values('CS-233','A','3',2018,17103,'AA');
insert into takes values('CS-234','A','3',2018,17103,'AB');
insert into takes values('IT-241','A','4',2019,17103,'AB');
insert into takes values('CS-242','A','4',2019,17103,'BB');
insert into takes values('CS-243','A','4',2019,17103,'AA');
insert into takes values('CS-244','A','4',2019,17103,'BB');
insert into takes values('CS-351','A','5',2019,17103,'AA');
insert into takes values('CS-352','A','5',2019,17103,'AA');
insert into takes values('CS-353','A','5',2019,17103,'AB');
insert into takes values('CS-354','A','5',2019,17103,'AA');
insert into takes values('IT-361','A','6',2020,17103,'AA');
insert into takes values('CS-362','A','6',2020,17103,'AA');
insert into takes values('CS-363','A','6',2020,17103,'AA');
insert into takes values('CS-364','A','6',2020,17103,'AB');
insert into takes values('IT-471','A','7',2020,17103,'NA');
insert into takes values('CS-472','A','7',2020,17103,'NA');
insert into takes values('CS-473','A','7',2020,17103,'NA');
insert into takes values('CS-474','A','7',2020,17103,'NA');

-- ID 17104
insert into takes values('CS-111','A','1',2017,17104,'AA');
insert into takes values('CS-112','A','1',2017,17104,'AB');
insert into takes values('CS-113','A','1',2017,17104,'BB');
insert into takes values('CS-114','A','1',2017,17104,'AA');
insert into takes values('CS-121','A','2',2018,17104,'AB');
insert into takes values('CS-122','A','2',2018,17104,'BB');
insert into takes values('CS-123','A','2',2018,17104,'Bc');
insert into takes values('CS-124','A','2',2018,17104,'AA');
insert into takes values('CS-231','A','3',2018,17104,'BB');
insert into takes values('CS-232','A','3',2018,17104,'AB');
insert into takes values('CS-233','A','3',2018,17104,'AA');
insert into takes values('CS-234','A','3',2018,17104,'AB');
insert into takes values('IT-241','A','4',2019,17104,'AB');
insert into takes values('CS-242','A','4',2019,17104,'BB');
insert into takes values('CS-243','A','4',2019,17104,'AA');
insert into takes values('CS-244','A','4',2019,17104,'BB');
insert into takes values('CS-351','A','5',2019,17104,'AA');
insert into takes values('CS-352','A','5',2019,17104,'AA');
insert into takes values('CS-353','A','5',2019,17104,'AB');
insert into takes values('CS-354','A','5',2019,17104,'AA');
insert into takes values('IT-361','A','6',2020,17104,'AA');
insert into takes values('CS-362','A','6',2020,17104,'AA');
insert into takes values('CS-363','A','6',2020,17104,'AA');
insert into takes values('CS-364','A','6',2020,17104,'AB');
insert into takes values('IT-471','A','7',2020,17104,'NA');
insert into takes values('CS-472','A','7',2020,17104,'NA');
insert into takes values('CS-473','A','7',2020,17104,'NA');
insert into takes values('CS-474','A','7',2020,17104,'NA');


-- Attendence
-- ID 17001
insert into attendence values('CS-471','A','7',2020,'2020-07-23','P',17001);
insert into attendence values('CS-471','A','7',2020,'2020-07-25','P',17001);
insert into attendence values('CS-472','A','7',2020,'2020-07-22','P',17001);
insert into attendence values('CS-472','A','7',2020,'2020-07-24','P',17001);
insert into attendence values('CS-473','A','7',2020,'2020-07-23','P',17001);
insert into attendence values('CS-473','A','7',2020,'2020-07-25','P',17001);
insert into attendence values('CS-474','A','7',2020,'2020-07-22','P',17001);
insert into attendence values('CS-474','A','7',2020,'2020-07-24','P',17001);

-- ID 17002
insert into attendence values('CS-471','A','7',2020,'2020-07-23','P',17002);
insert into attendence values('CS-471','A','7',2020,'2020-07-25','P',17002);
insert into attendence values('CS-472','A','7',2020,'2020-07-22','P',17002);
insert into attendence values('CS-472','A','7',2020,'2020-07-24','P',17002);
insert into attendence values('CS-473','A','7',2020,'2020-07-23','P',17002);
insert into attendence values('CS-473','A','7',2020,'2020-07-25','P',17002);
insert into attendence values('CS-474','A','7',2020,'2020-07-22','P',17002);
insert into attendence values('CS-474','A','7',2020,'2020-07-24','P',17002);

-- ID 17003
insert into attendence values('CS-471','A','7',2020,'2020-07-23','P',17003);
insert into attendence values('CS-471','A','7',2020,'2020-07-25','P',17003);
insert into attendence values('CS-472','A','7',2020,'2020-07-22','P',17003);
insert into attendence values('CS-472','A','7',2020,'2020-07-24','P',17003);
insert into attendence values('CS-473','A','7',2020,'2020-07-23','P',17003);
insert into attendence values('CS-473','A','7',2020,'2020-07-25','P',17003);
insert into attendence values('CS-474','A','7',2020,'2020-07-22','P',17003);
insert into attendence values('CS-474','A','7',2020,'2020-07-24','P',17003);

-- ID 17004
insert into attendence values('CS-471','A','7',2020,'2020-07-23','P',17004);
insert into attendence values('CS-471','A','7',2020,'2020-07-25','P',17004);
insert into attendence values('CS-472','A','7',2020,'2020-07-22','P',17004);
insert into attendence values('CS-472','A','7',2020,'2020-07-24','P',17004);
insert into attendence values('CS-473','A','7',2020,'2020-07-23','P',17004);
insert into attendence values('CS-473','A','7',2020,'2020-07-25','P',17004);
insert into attendence values('CS-474','A','7',2020,'2020-07-22','P',17004);
insert into attendence values('CS-474','A','7',2020,'2020-07-24','P',17004);

-- Attendence
-- ID 17101
insert into attendence values('IT-471','A','7',2020,'2020-07-23','P',17101);
insert into attendence values('IT-471','A','7',2020,'2020-07-25','P',17101);
insert into attendence values('CS-472','A','7',2020,'2020-07-22','P',17101);
insert into attendence values('CS-472','A','7',2020,'2020-07-24','P',17101);
insert into attendence values('CS-473','A','7',2020,'2020-07-23','P',17101);
insert into attendence values('CS-473','A','7',2020,'2020-07-25','P',17101);
insert into attendence values('CS-474','A','7',2020,'2020-07-22','P',17101);
insert into attendence values('CS-474','A','7',2020,'2020-07-24','P',17101);

-- ID 17102
insert into attendence values('IT-471','A','7',2020,'2020-07-23','P',17102);
insert into attendence values('IT-471','A','7',2020,'2020-07-25','P',17102);
insert into attendence values('CS-472','A','7',2020,'2020-07-22','P',17102);
insert into attendence values('CS-472','A','7',2020,'2020-07-24','P',17102);
insert into attendence values('CS-473','A','7',2020,'2020-07-23','P',17102);
insert into attendence values('CS-473','A','7',2020,'2020-07-25','P',17102);
insert into attendence values('CS-474','A','7',2020,'2020-07-22','P',17102);
insert into attendence values('CS-474','A','7',2020,'2020-07-24','P',17102);

-- ID 17103
insert into attendence values('IT-471','A','7',2020,'2020-07-23','P',17103);
insert into attendence values('IT-471','A','7',2020,'2020-07-25','P',17103);
insert into attendence values('CS-472','A','7',2020,'2020-07-22','P',17103);
insert into attendence values('CS-472','A','7',2020,'2020-07-24','P',17103);
insert into attendence values('CS-473','A','7',2020,'2020-07-23','P',17103);
insert into attendence values('CS-473','A','7',2020,'2020-07-25','P',17103);
insert into attendence values('CS-474','A','7',2020,'2020-07-22','P',17103);
insert into attendence values('CS-474','A','7',2020,'2020-07-24','P',17103);

-- ID 17104
insert into attendence values('IT-471','A','7',2020,'2020-07-23','P',17104);
insert into attendence values('IT-471','A','7',2020,'2020-07-25','P',17104);
insert into attendence values('CS-472','A','7',2020,'2020-07-22','P',17104);
insert into attendence values('CS-472','A','7',2020,'2020-07-24','P',17104);
insert into attendence values('CS-473','A','7',2020,'2020-07-23','P',17104);
insert into attendence values('CS-473','A','7',2020,'2020-07-25','P',17104);
insert into attendence values('CS-474','A','7',2020,'2020-07-22','P',17104);
insert into attendence values('CS-474','A','7',2020,'2020-07-24','P',17104);



select * from advisor;



