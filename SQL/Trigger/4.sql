## a) Fügen Sie einen beliebigen Datensatz in die Tabelle PROTAGONIST ein. 
##	  Geben Sie anschließend die Tabelle USER_INSERT_ACTOR aus.

USE MOVIE;

INSERT INTO PROTAGONIST (pro_fname, pro_sname) VALUES ('John', 'Doe');

USE movie_trigger;

SELECT * FROM MOVIE.PROTAGONIST where pro_fname = 'John';
SELECT * FROM AFTER_INSERT_PROTAGONIST where aip_pro_vname = 'John';


## b) Ändern Sie in der Tabelle COUNTRY den Datensatz mit der ID 3 von Österreich auf Austria.
##    Geben Sie anschließend die Tabelle USER_UPDATE_COUNTRY aus.

USE MOVIE;

UPDATE COUNTRY SET cou_name = 'Austria' WHERE cou_id = 3;

USE movie_trigger;

SELECT * FROM MOVIE.COUNTRY;
SELECT * FROM AFTER_UPDATE_COUNTRY;
