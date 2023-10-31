drop schema if exists arztpraxis;

create schema arztpraxis;

use arztpraxis;

create table person
(
	per_id int primary key auto_increment,
    per_vname varchar(50) not null,
    per_nname varchar(50) not null,
    per_svnr varchar(11) not null,
    per_geburt date
);

create table diagnose
(
	dia_id int primary key auto_increment,
    dia_name varchar(50) not null
);

create table behandlungszeitraum
(
	ter_id int primary key auto_increment,
    dia_id int not null,
    per_id int not null,
    ter_begin datetime,
    ter_end datetime,
    constraint fk_dia foreign key (dia_id) references diagnose (dia_id),
    constraint fk_per foreign key (per_id) references person (per_id)
);


insert into person (per_vname, per_nname, per_svnr, per_geburt)  values ("Roswitha", "Maier", 1234, "1970-10-05"), 
																		 ("Hannes", "Lauter", 8273, "2001-05-22");
                                                                         
                                                                         
insert into diagnose values (1, "Grippaler Infekt"), (2, "Influenza"), (3, "Gastritis");

insert into behandlungszeitraum (ter_id, ter_begin, ter_end, dia_id, per_id) values (1, "2020-01-31 10:15:22", "2020-02-10 15:22:30", 3, 1),
										(2, "2020-02-12 10:15:22", "2020-03-01 14:40:10", 1, 1),
                                        (3, "2020-03-10 10:15:22", "2020-04-05 15:22:30", 2, 1),
                                        (4, "2020-03-10 10:15:22", "2020-03-10 15:22:30", 1, 2),
                                        (5, "2020-03-31 10:15:22", "2020-03-14 15:22:30", 1, 3),
                                        (6, "2020-01-15 10:15:22", null, 3, 1),
                                        (7, "2020-01-10 10:15:22", null, 3, 1),
                                        (8, "2020-04-20 10:15:22", null, 3, 1),
										("Karen", "Ulmer", 1234, "2016-09-10"),
									    ("Walter", "Welsner", 1234, "1956-07-18");