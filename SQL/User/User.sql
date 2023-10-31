### User erstellen ###

create user user1@localhost identified by 'user1';

create user user2@localhost identified by 'user2';

### Rechte vergeben ###

grant select, select, update on quiz.* to user1@localhost;

grant update, delete on quiz.* to user1@localhost;


### Anmelden als user1 ###

use quiz;

select * from quiz;

delete from quiz where quiz_id = 7;

insert into quiz values (7, '2022-04-08');


