drop schema Movie;
create schema if not exists Movie;
use Movie;
CREATE TABLE COUNTRY (
    cou_id INT PRIMARY KEY,
    cou_name VARCHAR(255)
);

 

CREATE TABLE COMPANY (
    com_id INT PRIMARY KEY,
    com_name VARCHAR(255),
    cou_id INT,
    FOREIGN KEY (cou_id) REFERENCES COUNTRY(cou_id)
);

 

CREATE TABLE MOVIE (
    mov_id INT PRIMARY KEY,
    mov_title VARCHAR(255)
);

 

CREATE TABLE PROTAGONIST (
    pro_id INT PRIMARY KEY AUTO_INCREMENT,
    pro_fname VARCHAR(255),
    pro_sname VARCHAR(255),
    UNIQUE (pro_fname, pro_sname)
);

 

CREATE TABLE PROTAGONIST_MOVIE (
    prmo_id INT PRIMARY KEY,
    pro_actor_id INT,
    mov_id INT,
    pro_regie_id INT,
    com_id INT,
    FOREIGN KEY (pro_actor_id) REFERENCES PROTAGONIST(pro_id),
    FOREIGN KEY (mov_id) REFERENCES MOVIE(mov_id),
    FOREIGN KEY (pro_regie_id) REFERENCES PROTAGONIST(pro_id),
    FOREIGN KEY (com_id) REFERENCES COMPANY(com_id)
);

 

INSERT INTO COUNTRY (cou_id, cou_name) VALUES
    (1, 'USA'),
    (2, 'Deutschland'),
    (3, 'Österreich'),
    (4, 'Great Britain');

 

INSERT INTO COMPANY (com_id, com_name, cou_id) VALUES
    (1, 'Warner Bros. Entertainment', 1),
    (2, 'Walt Disney Motion Pictures Group', 1),
    (3, 'Bavaria Filmstudios', 2),
    (4, 'Rosenhügel-Filmstudios', 3),
    (5, '20th Century Fox', 1);

 

INSERT INTO MOVIE (mov_id, mov_title) VALUES
    (1, 'Der Bockerer'),
    (2, 'Der Hobbit'),
    (3, 'Die unendliche Geschichte'),
    (4, 'Das Boot');

 

INSERT INTO PROTAGONIST (pro_id, pro_fname, pro_sname) VALUES
    (1, 'Barret', 'Oliver'),
    (2, 'Tami', 'Stronach'),
    (3, 'Karl', 'Merkatz'),
    (4, 'Ida', 'Krottendorf'),
    (5, 'Martin', 'Freeman'),
    (6, 'Ian', 'McKellen'),
    (7, 'Jürgen', 'Prochnow'),
    (8, 'Wolfgang', 'Peteresen'),
    (9, 'Franz', 'Antel');

 

INSERT INTO PROTAGONIST_MOVIE (prmo_id, pro_actor_id, mov_id, pro_regie_id, com_id) VALUES
    (1, 7, 4, 8, 3),
    (2, 3, 1, 9, 4),
    (3, 4, 1, 9, 4),
    (4, 1, 3, 8, 3),
    (5, 2, 3, 8, 3);