CREATE TABLE teacher (
	id serial NOT NULL,
	registration integer NOT NULL UNIQUE,
	name varchar NOT NULL,
	profile_photo varchar NOT NULL,
	departament varchar NOT NULL,
	CONSTRAINT teacher_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE course (
	id serial NOT NULL,
	name varchar NOT NULL,
	degree varchar NOT NULL,
	course_load integer NOT NULL,
	byname varchar NOT NULL,
	CONSTRAINT course_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE discipline (
	id serial NOT NULL,
	name varchar NOT NULL,
	code varchar NOT NULL UNIQUE,
	workload_in_clock integer NOT NULL,
	workload_in_class integer NOT NULL,
	is_optional BOOLEAN NOT NULL,
	CONSTRAINT discipline_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE class (
	id serial NOT NULL,
	class_leader integer,
	course_id integer NOT NULL,
	reference_period integer NOT NULL,
	shift varchar NOT NULL,
	CONSTRAINT class_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE teach (
	id serial NOT NULL,
	teacher_id integer NOT NULL,
	discipline_id integer NOT NULL,
	class_id integer NOT NULL,
	CONSTRAINT teach_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE student (
	id serial NOT NULL,
	registration integer NOT NULL,
	name varchar NOT NULL,
	profile_photo varchar NOT NULL,
	class_id integer NOT NULL,
	CONSTRAINT student_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE studentassociation (
	id serial NOT NULL,
	student_id integer NOT NULL,
	discipline_id integer NOT NULL,
	CONSTRAINT studentassociation_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE schedule (
	id serial NOT NULL,
	discipline_id integer NOT NULL,
	quantity integer NOT NULL,
	weekday DATE NOT NULL,
	start_time TIME NOT NULL,
	end_time TIME NOT NULL,
	class_id integer NOT NULL,
	CONSTRAINT schedule_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE classcanceled (
	id serial NOT NULL,
	schedule_id integer NOT NULL,
	canceled_date DATE NOT NULL,
	reason TEXT NOT NULL,
	is_available BOOLEAN NOT NULL,
	teachers_id integer NOT NULL,
	CONSTRAINT classcanceled_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE teachtemporarily (
	id serial NOT NULL,
	class_canceled_id integer NOT NULL,
	quantity integer NOT NULL,
	date DATE NOT NULL,
	teacher_id integer NOT NULL,
	discipline_id integer NOT NULL,
	CONSTRAINT teachtemporarily_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE studentalerts (
	id serial NOT NULL,
	discipline_id integer NOT NULL,
	student_id integer NOT NULL,
	created_at DATE NOT NULL,
	reason varchar NOT NULL,
	CONSTRAINT studentalerts_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE cousediscipline (
	id serial NOT NULL,
	discipline_id integer NOT NULL,
	course_id integer NOT NULL,
	period integer NOT NULL,
	CONSTRAINT cousediscipline_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE substituteteachers (
	id serial NOT NULL,
	teacher_id integer NOT NULL,
	class_canceled_id integer NOT NULL,
	CONSTRAINT substituteteachers_pk PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);






ALTER TABLE class ADD CONSTRAINT class_fk0 FOREIGN KEY (class_leader) REFERENCES student(id);
ALTER TABLE class ADD CONSTRAINT class_fk1 FOREIGN KEY (course_id) REFERENCES course(id);

ALTER TABLE teach ADD CONSTRAINT teach_fk0 FOREIGN KEY (teacher_id) REFERENCES teacher(id);
ALTER TABLE teach ADD CONSTRAINT teach_fk1 FOREIGN KEY (discipline_id) REFERENCES discipline(id);
ALTER TABLE teach ADD CONSTRAINT teach_fk2 FOREIGN KEY (class_id) REFERENCES class(id);

ALTER TABLE student ADD CONSTRAINT student_fk0 FOREIGN KEY (class_id) REFERENCES class(id);

ALTER TABLE studentassociation ADD CONSTRAINT studentassociation_fk0 FOREIGN KEY (student_id) REFERENCES student(id);
ALTER TABLE studentassociation ADD CONSTRAINT studentassociation_fk1 FOREIGN KEY (discipline_id) REFERENCES discipline(id);

ALTER TABLE schedule ADD CONSTRAINT schedule_fk0 FOREIGN KEY (discipline_id) REFERENCES discipline(id);
ALTER TABLE schedule ADD CONSTRAINT schedule_fk1 FOREIGN KEY (class_id) REFERENCES class(id);

ALTER TABLE classcanceled ADD CONSTRAINT classcanceled_fk0 FOREIGN KEY (schedule_id) REFERENCES schedule(id);
ALTER TABLE classcanceled ADD CONSTRAINT classcanceled_fk1 FOREIGN KEY (teachers_id) REFERENCES substituteteachers(id);

ALTER TABLE teachtemporarily ADD CONSTRAINT teachtemporarily_fk0 FOREIGN KEY (class_canceled_id) REFERENCES classcanceled(id);
ALTER TABLE teachtemporarily ADD CONSTRAINT teachtemporarily_fk1 FOREIGN KEY (teacher_id) REFERENCES teacher(id);
ALTER TABLE teachtemporarily ADD CONSTRAINT teachtemporarily_fk2 FOREIGN KEY (discipline_id) REFERENCES discipline(id);

ALTER TABLE studentalerts ADD CONSTRAINT studentalerts_fk0 FOREIGN KEY (discipline_id) REFERENCES discipline(id);
ALTER TABLE studentalerts ADD CONSTRAINT studentalerts_fk1 FOREIGN KEY (student_id) REFERENCES student(id);

ALTER TABLE cousediscipline ADD CONSTRAINT cousediscipline_fk0 FOREIGN KEY (discipline_id) REFERENCES discipline(id);
ALTER TABLE cousediscipline ADD CONSTRAINT cousediscipline_fk1 FOREIGN KEY (course_id) REFERENCES course(id);

ALTER TABLE substituteteachers ADD CONSTRAINT substituteteachers_fk0 FOREIGN KEY (teacher_id) REFERENCES teacher(id);
ALTER TABLE substituteteachers ADD CONSTRAINT substituteteachers_fk1 FOREIGN KEY (class_canceled_id) REFERENCES classcanceled(id);














