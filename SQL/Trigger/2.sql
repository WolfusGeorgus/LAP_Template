drop schema movie_trigger;
CREATE schema if not exists movie_trigger;

USE movie_trigger;

CREATE TABLE AFTER_INSERT_PROTAGONIST (
    aip_id INT PRIMARY KEY AUTO_INCREMENT,
    aip_user VARCHAR(100) NOT NULL,
    aip_time DATETIME DEFAULT NOW(),
    aip_pro_vname VARCHAR(100) NOT NULL,
    aip_pro_nname VARCHAR(100) NOT NULL
);

CREATE TABLE AFTER_UPDATE_COUNTRY (
    auc_id INT PRIMARY KEY AUTO_INCREMENT,
    auc_user VARCHAR(100) NOT NULL,
    auc_time DATETIME DEFAULT NOW(),
    auc_cou_id INT NOT NULL,
    auc_cou_old_name VARCHAR(100) NOT NULL,
    auc_cou_new_name VARCHAR(100) NOT NULL
);