######################
### User erstellen ###
######################

create user user1@localhost identified by 'user1';

create user user2@localhost identified by 'user2';

#######################
### Rechte vergeben ###
#######################

grant select, insert, update on quiz.* to user1@localhost;

grant update, delete on quiz.* to user2@localhost;

##########################
### Anmelden als user1 ###
##########################
use quiz;

select * from quiz;
# => Funktioniert

insert into quiz values (7, '2022-04-08');
# => Funktioniert

Update quiz set quiz_datum = '2022-04-09'
		where quiz_id = 7;
# => Funktioniert

Delete from quiz where quiz_id = 7;
# => Error Code: 1142. DELETE command denied to user 'user1'@'localhost' for table 'quiz'

create table abc(xyz int);
# => Error Code: 1142. DELETE command denied to user 'user1'@'localhost' for table 'quiz'

##########################
### Anmelden als user2 ###
##########################

use quiz;

select * from quiz;
# => Error Code: 1142. SELECT command denied to user 'user2'@'localhost' for table 'quiz'

Update quiz set quiz_datum = '2022-04-09'
		where quiz_id = 7;
# => Error Code: 1143. SELECT command denied to user 'user2'@'localhost' for column 'quiz_id' in table 'quiz'

Update quiz set quiz_datum = '2022-04-09';
# => Funktioniert

Delete from quiz where quiz_id = 7;
# => Error Code: 1143. SELECT command denied to user 'user2'@'localhost' for column 'quiz_id' in table 'quiz'

Delete from quiz;
# => Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`quiz`.`quiz_has_frage_antwort`, CONSTRAINT `fk_quiz_has_frage_antwort_quiz1` FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`quiz_id`) ON DELETE NO ACTION ON UPDATE NO ACTION)

insert into quiz values (7, '2022-04-08');
# => Error Code: 1142. INSERT command denied to user 'user2'@'localhost' for table 'quiz'

