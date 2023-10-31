-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema adresse
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema adresse
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `adresse` DEFAULT CHARACTER SET utf8 ;
USE `adresse` ;

-- -----------------------------------------------------
-- Table `adresse`.`plz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adresse`.`plz` (
  `plz_nr` INT NOT NULL,
  PRIMARY KEY (`plz_nr`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `adresse`.`ort`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adresse`.`ort` (
  `ort_id` INT NOT NULL AUTO_INCREMENT,
  `ort_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ort_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `adresse`.`plz_ort`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adresse`.`plz_ort` (
  `plor_id` INT NOT NULL AUTO_INCREMENT,
  `plz_nr` INT NOT NULL,
  `ort_id` INT NOT NULL,
  INDEX `fk_plz_has_ort_ort1_idx` (`ort_id` ASC),
  INDEX `fk_plz_has_ort_plz_idx` (`plz_nr` ASC),
  PRIMARY KEY (`plor_id`),
  CONSTRAINT `fk_plz_has_ort_plz`
    FOREIGN KEY (`plz_nr`)
    REFERENCES `adresse`.`plz` (`plz_nr`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plz_has_ort_ort1`
    FOREIGN KEY (`ort_id`)
    REFERENCES `adresse`.`ort` (`ort_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `adresse`.`strasse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adresse`.`strasse` (
  `str_id` INT NOT NULL AUTO_INCREMENT,
  `str_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`str_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `adresse`.`strasse_plz_ort`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adresse`.`strasse_plz_ort` (
  `spo_id` INT NOT NULL AUTO_INCREMENT,
  `str_id` INT NOT NULL,
  `plor_id` INT NOT NULL,
  INDEX `fk_strasse_has_plz_ort_plz_ort1_idx` (`plor_id` ASC),
  INDEX `fk_strasse_has_plz_ort_strasse1_idx` (`str_id` ASC),
  PRIMARY KEY (`spo_id`),
  CONSTRAINT `fk_strasse_has_plz_ort_strasse1`
    FOREIGN KEY (`str_id`)
    REFERENCES `adresse`.`strasse` (`str_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_strasse_has_plz_ort_plz_ort1`
    FOREIGN KEY (`plor_id`)
    REFERENCES `adresse`.`plz_ort` (`plor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
