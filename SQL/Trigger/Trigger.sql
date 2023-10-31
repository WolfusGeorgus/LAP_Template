drop schema if exists adresse_trigger;
create schema adresse_trigger;

use adresse_trigger;

drop table ort_after_insert;

create table ort_after_insert (
	oai_id int primary key auto_increment,
    oai_user varchar(255) default user(),
	oai_time timestamp default current_timestamp(),
    oai_new_ortid int not null
);

use adresse;

create trigger after_insert_ort after insert on ort
for each row 
	insert into adresse_trigger.ort_after_insert(oai_new_ortid) values(new.ort_id);
    
insert into ort (ort_name) values ('Ottensheim');
select * from ort;
select * from adresse_trigger.ort_after_insert;

##########################
use adresse_trigger;

create table plz_after_insert (
	oai_id int primary key auto_increment,
    oai_user varchar(255) default user(),
	oai_time timestamp default current_timestamp(),
    oai_new_plznr int not null
);

use adresse;

create trigger after_insert_plz after insert on plz
for each row 
	insert into adresse_trigger.plz_after_insert(oai_new_plznr) values(new.plz_nr);
    
insert into plz (plz_nr) values (8010);
select * from plz;
select * from adresse_trigger.plxz_after_insert;