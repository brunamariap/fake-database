CREATE TABLE Teacher (
	id serial NOT NULL,
	registration integer NOT NULL UNIQUE,
	name varchar NOT NULL,
	profile_photo varchar NOT NULL,
	departament varchar NOT NULL,
	CONSTRAINT Teacher_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE Course (
	id serial NOT NULL,
	name varchar NOT NULL,
	degree varchar NOT NULL,
	course_load integer NOT NULL,
	byname varchar NOT NULL,
	CONSTRAINT Course_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE Discipline (
	id serial NOT NULL,
	name varchar NOT NULL,
	code varchar NOT NULL UNIQUE,
	workload_in_clock integer NOT NULL,
	workload_in_class integer NOT NULL,
	is_optional BOOLEAN NOT NULL,
	CONSTRAINT Discipline_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE Class (
	id serial NOT NULL,
	class_leader integer NOT NULL,
	course_id integer NOT NULL,
	reference_period integer NOT NULL,
	shift varchar NOT NULL,
	CONSTRAINT Class_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE Teach (
	id serial NOT NULL,
	teacher_id integer NOT NULL,
	discipline_id integer NOT NULL,
	class_id integer NOT NULL,
	CONSTRAINT Teach_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE Student (
	id serial NOT NULL,
	registration integer NOT NULL,
	name varchar NOT NULL,
	profile_photo varchar NOT NULL,
	class_id integer NOT NULL,
	CONSTRAINT Student_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE StudentAssociation (
	id serial NOT NULL,
	student_id integer NOT NULL,
	discipline_id integer NOT NULL,
	CONSTRAINT StudentAssociation_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE Schedule (
	id serial NOT NULL,
	discipline_id integer NOT NULL,
	quantity integer NOT NULL,
	weekday DATE NOT NULL,
	start_time TIME NOT NULL,
	end_time TIME NOT NULL,
	class_id integer NOT NULL,
	CONSTRAINT Schedule_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE ClassCanceled (
	id serial NOT NULL,
	schedule_id integer NOT NULL,
	canceled_date DATE NOT NULL,
	reason TEXT,
	is_available BOOLEAN NOT NULL,
	teachers_id integer,
	CONSTRAINT ClassCanceled_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE TeachTemporarily (
	id serial NOT NULL,
	schedule_id integer NOT NULL,
	quantity integer NOT NULL,
	date DATE NOT NULL,
	teacher_id integer NOT NULL,
	discipline_id integer NOT NULL,
	CONSTRAINT TeachTemporarily_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE StudentAlerts (
	id serial NOT NULL,
	discipline_id integer NOT NULL,
	student_id integer NOT NULL,
	created_at DATE NOT NULL,
	reason VARCHAR(255) NOT NULL,
	CONSTRAINT StudentAlerts_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE CouseDiscipline (
	id serial NOT NULL,
	discipline_id integer NOT NULL,
	course_id integer NOT NULL,
	period integer NOT NULL,
	CONSTRAINT CouseDiscipline_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE SubstituteTeachers (
	id serial NOT NULL,
	teacher_id integer NOT NULL,
	class_canceled_id integer NOT NULL,
	CONSTRAINT SubstituteTeachers_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);






ALTER TABLE Class ADD CONSTRAINT Class_fk0 FOREIGN KEY (class_leader) REFERENCES Student(id);
ALTER TABLE Class ADD CONSTRAINT Class_fk1 FOREIGN KEY (course_id) REFERENCES Course(id);

ALTER TABLE Teach ADD CONSTRAINT Teach_fk0 FOREIGN KEY (teacher_id) REFERENCES Teacher(id);
ALTER TABLE Teach ADD CONSTRAINT Teach_fk1 FOREIGN KEY (discipline_id) REFERENCES Discipline(id);
ALTER TABLE Teach ADD CONSTRAINT Teach_fk2 FOREIGN KEY (class_id) REFERENCES Class(id);

ALTER TABLE Student ADD CONSTRAINT Student_fk0 FOREIGN KEY (class_id) REFERENCES Class(id);

ALTER TABLE StudentAssociation ADD CONSTRAINT StudentAssociation_fk0 FOREIGN KEY (student_id) REFERENCES Student(id);
ALTER TABLE StudentAssociation ADD CONSTRAINT StudentAssociation_fk1 FOREIGN KEY (discipline_id) REFERENCES Discipline(id);

ALTER TABLE Schedule ADD CONSTRAINT Schedule_fk0 FOREIGN KEY (discipline_id) REFERENCES Discipline(id);
ALTER TABLE Schedule ADD CONSTRAINT Schedule_fk1 FOREIGN KEY (class_id) REFERENCES Class(id);

ALTER TABLE ClassCanceled ADD CONSTRAINT ClassCanceled_fk0 FOREIGN KEY (schedule_id) REFERENCES Schedule(id);
ALTER TABLE ClassCanceled ADD CONSTRAINT ClassCanceled_fk1 FOREIGN KEY (teachers_id) REFERENCES SubstituteTeachers(id);

ALTER TABLE TeachTemporarily ADD CONSTRAINT TeachTemporarily_fk0 FOREIGN KEY (schedule_id) REFERENCES Schedule(id);
ALTER TABLE TeachTemporarily ADD CONSTRAINT TeachTemporarily_fk1 FOREIGN KEY (teacher_id) REFERENCES Teacher(id);
ALTER TABLE TeachTemporarily ADD CONSTRAINT TeachTemporarily_fk2 FOREIGN KEY (discipline_id) REFERENCES Discipline(id);

ALTER TABLE StudentAlerts ADD CONSTRAINT StudentAlerts_fk0 FOREIGN KEY (discipline_id) REFERENCES Discipline(id);
ALTER TABLE StudentAlerts ADD CONSTRAINT StudentAlerts_fk1 FOREIGN KEY (student_id) REFERENCES Student(id);

ALTER TABLE CouseDiscipline ADD CONSTRAINT CouseDiscipline_fk0 FOREIGN KEY (discipline_id) REFERENCES Discipline(id);
ALTER TABLE CouseDiscipline ADD CONSTRAINT CouseDiscipline_fk1 FOREIGN KEY (course_id) REFERENCES Course(id);

ALTER TABLE SubstituteTeachers ADD CONSTRAINT SubstituteTeachers_fk0 FOREIGN KEY (teacher_id) REFERENCES Teacher(id);
ALTER TABLE SubstituteTeachers ADD CONSTRAINT SubstituteTeachers_fk1 FOREIGN KEY (class_canceled_id) REFERENCES ClassCanceled(id);




