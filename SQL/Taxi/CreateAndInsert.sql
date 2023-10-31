use test;

drop schema test;

create schema test;

use test;

-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: taxi
-- ------------------------------------------------------
-- Server version	5.5.5-10.7.3-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `fahrer`
--

DROP TABLE IF EXISTS `fahrer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fahrer` (
  `Fahrer_id` int(11) NOT NULL AUTO_INCREMENT,
  `Vorname` varchar(45) NOT NULL,
  `Nachname` varchar(45) NOT NULL,
  PRIMARY KEY (`Fahrer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fahrer`
--

LOCK TABLES `fahrer` WRITE;
/*!40000 ALTER TABLE `fahrer` DISABLE KEYS */;
INSERT INTO `fahrer` VALUES (1,'Georg ','Wolf'),(2,'Adan','Mehic'),(3,'David','Glas'),(4,'Alex','Kirchmeier'),(5,'Rustam','Eder'),(6,'Reinhard','Ludwig'),(7,'Max','Mustermann'),(8,'Anna','Musterfrau'),(9,'John','Doe'),(10,'Jane','Doe'),(11,'Michael','Smith'),(12,'Emily','Johnson'),(13,'David','Brown'),(14,'Sarah','Davis'),(15,'Robert','Wilson'),(16,'Olivia','Jones');
/*!40000 ALTER TABLE `fahrer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ort`
--

DROP TABLE IF EXISTS `ort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ort` (
  `Ort_id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Ort_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3 COMMENT='	';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ort`
--

LOCK TABLES `ort` WRITE;
/*!40000 ALTER TABLE `ort` DISABLE KEYS */;
INSERT INTO `ort` VALUES (1,'Graz'),(2,'Linz'),(3,'Eggersdorf'),(4,'Weiz'),(5,'Bergen'),(6,'Hallstatt'),(7,'Braunau'),(8,'Graz'),(9,'Linz'),(10,'Wien'),(11,'Salzburg'),(12,'Innsbruck'),(13,'Klagenfurt'),(14,'Eisenstadt'),(15,'Bregenz'),(16,'St. Pölten'),(17,'Dornbirn');
/*!40000 ALTER TABLE `ort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plz`
--

DROP TABLE IF EXISTS `plz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plz` (
  `PLZ_id` int(11) NOT NULL AUTO_INCREMENT,
  `Ort_id` int(11) NOT NULL,
  `PLZ_nr` varchar(45) NOT NULL,
  PRIMARY KEY (`PLZ_id`),
  KEY `fk_plz_ort_idx` (`Ort_id`),
  CONSTRAINT `fk_plz_ort` FOREIGN KEY (`Ort_id`) REFERENCES `ort` (`Ort_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plz`
--

LOCK TABLES `plz` WRITE;
/*!40000 ALTER TABLE `plz` DISABLE KEYS */;
INSERT INTO `plz` VALUES (1,1,'8010'),(2,7,'8020'),(3,2,'8010'),(4,2,'8020'),(5,3,'1010'),(6,4,'3030'),(7,5,'7070'),(8,6,'4900'),(9,7,'2900'),(10,4,'8010'),(11,1,'8020'),(12,2,'4020'),(13,2,'4030'),(14,6,'1010'),(15,4,'1020'),(16,4,'5020'),(17,4,'5030'),(18,5,'6010'),(19,5,'6020');
/*!40000 ALTER TABLE `plz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auto`
--

DROP TABLE IF EXISTS `auto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auto` (
  `Auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `Kennzeichen` varchar(45) NOT NULL,
  PRIMARY KEY (`Auto_id`),
  UNIQUE KEY `Kennzeichen_UNIQUE` (`Kennzeichen`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auto`
--

LOCK TABLES `auto` WRITE;
/*!40000 ALTER TABLE `auto` DISABLE KEYS */;
INSERT INTO `auto` VALUES (3,'AB123CD'),(11,'CD567EF'),(7,'EF345GH'),(2,'G759HL'),(12,'GH890IJ'),(8,'IJ678OP'),(5,'KL789MN'),(1,'LB463GW'),(9,'QR901RS'),(6,'UV012WX'),(4,'XY456ZT'),(10,'YZ234AB');
/*!40000 ALTER TABLE `auto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `anbieter`
--

DROP TABLE IF EXISTS `anbieter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anbieter` (
  `Anbieter_id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Anbieter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anbieter`
--

LOCK TABLES `anbieter` WRITE;
/*!40000 ALTER TABLE `anbieter` DISABLE KEYS */;
INSERT INTO `anbieter` VALUES (1,'EV Charging Co.'),(2,'Green Power Charging'),(3,'EcoCharge'),(4,'Clean Energy Charging'),(5,'ChargeUp'),(6,'PowerCharge'),(7,'EcoCharger'),(8,'GreenEnergy'),(9,'ChargeEasy'),(10,'EcoPower Charging');
/*!40000 ALTER TABLE `anbieter` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `strasse`
--

DROP TABLE IF EXISTS `strasse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `strasse` (
  `Strasse_id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `PLZ_id` int(11) NOT NULL,
  PRIMARY KEY (`Strasse_id`),
  KEY `fk_strasse_plz_idx` (`PLZ_id`),
  CONSTRAINT `fk_strasse_plz` FOREIGN KEY (`PLZ_id`) REFERENCES `plz` (`PLZ_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `strasse`
--

LOCK TABLES `strasse` WRITE;
/*!40000 ALTER TABLE `strasse` DISABLE KEYS */;
INSERT INTO `strasse` VALUES (1,'Michelbach',1),(2,'Breitenbergstrasse',2),(3,'Elfenberg',3),(4,'Bergenstrasse',4),(5,'Rollsdorf',4),(6,'Reinhardstrasse',5),(7,'Mecklenburg',6),(8,'Hauptplatz',1),(9,'Herrengasse',2),(10,'Geidorf',1),(11,'Opernring',1),(12,'Elisabethstrasse',2),(13,'Sporrgasse',1),(14,'Hauptstraße',1),(15,'Kirchgasse',2),(16,'Rathausplatz',3),(17,'Schulweg',4),(18,'Mozartstraße',5),(19,'Goetheallee',6),(20,'Beethovenstraße',7),(21,'Friedensgasse',8),(22,'Schubertweg',9),(23,'Bachgasse',10);
/*!40000 ALTER TABLE `strasse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adresse`
--

DROP TABLE IF EXISTS `adresse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adresse` (
  `Adresse_id` int(11) NOT NULL AUTO_INCREMENT,
  `Strasse_id` int(11) NOT NULL,
  `Hausnummer` int(11) NOT NULL,
  PRIMARY KEY (`Adresse_id`),
  KEY `fk_adresse_strasse_idx` (`Strasse_id`),
  CONSTRAINT `fk_adresse_strasse` FOREIGN KEY (`Strasse_id`) REFERENCES `strasse` (`Strasse_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adresse`
--

LOCK TABLES `adresse` WRITE;
/*!40000 ALTER TABLE `adresse` DISABLE KEYS */;
INSERT INTO `adresse` VALUES (1,1,10),(2,2,12),(3,3,90),(4,4,100),(5,5,99),(6,6,10),(7,8,11),(8,9,22),(9,1,10),(10,2,15),(11,3,5),(12,4,22),(13,5,17),(14,6,8),(15,7,30),(16,8,9),(17,9,14),(18,10,12);
/*!40000 ALTER TABLE `adresse` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `ladestation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ladestation` (
  `Ladestation_id` int(11) NOT NULL AUTO_INCREMENT,
  `Anbieter_id` int(11) NOT NULL,
  `Adresse_id` int(11) NOT NULL,
  `Kosten_Pro_Kwh` double NOT NULL,
  PRIMARY KEY (`Ladestation_id`),
  KEY `fk_ladestation_adress_idx` (`Adresse_id`),
  KEY `fk_anbieter_ladestation_idx` (`Anbieter_id`),
  CONSTRAINT `fk_anbieter_ladestation` FOREIGN KEY (`Anbieter_id`) REFERENCES `anbieter` (`Anbieter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ladestation_adress` FOREIGN KEY (`Adresse_id`) REFERENCES `adresse` (`Adresse_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ladestation`
--

LOCK TABLES `ladestation` WRITE;
/*!40000 ALTER TABLE `ladestation` DISABLE KEYS */;
INSERT INTO `ladestation` VALUES (1,1,1,0.25),(2,2,2,0.3),(3,3,3,0.28),(4,4,4,0.22),(5,5,5,0.26),(6,6,6,0.27),(7,7,7,0.29),(8,8,8,0.24),(9,9,9,0.23),(10,10,10,0.31),(11,1,1,0.25),(12,2,2,0.3),(13,3,3,0.28),(14,4,4,0.22),(15,5,5,0.26),(16,6,6,0.27),(17,7,7,0.29),(18,8,8,0.24),(19,9,9,0.23),(20,10,10,0.31);
/*!40000 ALTER TABLE `ladestation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auto_standort`
--

DROP TABLE IF EXISTS `auto_standort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auto_standort` (
  `Aust_id` int(11) NOT NULL,
  `Auto_id` int(11) NOT NULL AUTO_INCREMENT,
  `Ladestation_id` int(11) NOT NULL,
  PRIMARY KEY (`Aust_id`),
  KEY `fk_standort_auto_idx` (`Ladestation_id`),
  KEY `fk_auto_standort` (`Auto_id`),
  CONSTRAINT `fk_auto_standort` FOREIGN KEY (`Auto_id`) REFERENCES `auto` (`Auto_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_standort_auto` FOREIGN KEY (`Ladestation_id`) REFERENCES `ladestation` (`Ladestation_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auto_standort`
--

LOCK TABLES `auto_standort` WRITE;
/*!40000 ALTER TABLE `auto_standort` DISABLE KEYS */;
INSERT INTO `auto_standort` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10);
/*!40000 ALTER TABLE `auto_standort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fahrer_auto`
--

DROP TABLE IF EXISTS `fahrer_auto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fahrer_auto` (
  `Fau_id` int(11) NOT NULL AUTO_INCREMENT,
  `Fahrer_id` int(11) NOT NULL,
  `Auto_id` int(11) NOT NULL,
  `Datum` date NOT NULL,
  PRIMARY KEY (`Fau_id`),
  KEY `fk_fahrer_auto_idx` (`Auto_id`),
  KEY `fk_auto_fahrer` (`Fahrer_id`),
  CONSTRAINT `fk_auto_fahrer` FOREIGN KEY (`Fahrer_id`) REFERENCES `fahrer` (`Fahrer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_fahrer_auto` FOREIGN KEY (`Auto_id`) REFERENCES `auto` (`Auto_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fahrer_auto`
--

LOCK TABLES `fahrer_auto` WRITE;
/*!40000 ALTER TABLE `fahrer_auto` DISABLE KEYS */;
INSERT INTO `fahrer_auto` VALUES (1,1,1,'2023-10-23'),(2,2,2,'2023-10-23'),(3,1,1,'2023-10-23'),(4,2,2,'2023-10-23'),(5,3,3,'2023-10-23'),(6,4,4,'2023-10-23'),(7,5,5,'2023-10-23'),(8,6,6,'2023-10-23'),(9,1,7,'2023-10-23'),(10,2,8,'2023-10-23'),(11,3,9,'2023-10-23'),(12,4,10,'2023-10-23');
/*!40000 ALTER TABLE `fahrer_auto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ladevorgang`
--

DROP TABLE IF EXISTS `ladevorgang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ladevorgang` (
  `Ladevorgang_id` int(11) NOT NULL,
  `Aust_id` int(11) NOT NULL,
  `Dauer` int(11) NOT NULL,
  `Kwh` double DEFAULT NULL,
  `Beginn` datetime DEFAULT NULL,
  PRIMARY KEY (`Ladevorgang_id`),
  KEY `fk_lade_lade_idx` (`Aust_id`),
  CONSTRAINT `fk_lade_lade` FOREIGN KEY (`Aust_id`) REFERENCES `auto_standort` (`Aust_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ladevorgang`
--

LOCK TABLES `ladevorgang` WRITE;
/*!40000 ALTER TABLE `ladevorgang` DISABLE KEYS */;
INSERT INTO `ladevorgang` VALUES (1,1,30,10.5,'2023-10-24 13:13:55'),(2,2,45,15.2,'2023-10-24 13:13:55'),(3,3,60,20.1,'2023-10-24 13:13:55'),(4,4,25,8.4,'2023-10-24 13:13:55'),(5,5,40,13.7,'2023-10-24 13:13:55'),(6,6,35,12,'2023-10-24 13:13:55'),(7,7,50,17.3,'2023-10-24 13:13:55'),(8,8,55,19,'2023-10-24 13:13:55'),(9,9,42,14.4,'2023-10-24 13:13:55'),(10,10,38,13.1,'2023-10-24 13:13:55');
/*!40000 ALTER TABLE `ladevorgang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fahrt`
--

DROP TABLE IF EXISTS `fahrt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fahrt` (
  `Fahrt_id` int(11) NOT NULL AUTO_INCREMENT,
  `Fau_id` int(11) NOT NULL,
  `Adresse_Beginn` int(11) NOT NULL,
  `Adresse_Ende` int(11) DEFAULT NULL,
  `Zeit_Beginn` datetime NOT NULL,
  `Zeit_Ende` datetime DEFAULT NULL,
  `KM_Beginn` int(11) DEFAULT NULL,
  `KM_Ende` int(11) DEFAULT NULL,
  PRIMARY KEY (`Fahrt_id`),
  KEY `fk_Ziel_Adresse_idx` (`Adresse_Ende`),
  KEY `fk_Fahrt_Auto_idx` (`Fau_id`),
  KEY `fk_Beginn_Adresse` (`Adresse_Beginn`),
  CONSTRAINT `fk_Beginn_Adresse` FOREIGN KEY (`Adresse_Beginn`) REFERENCES `adresse` (`Adresse_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fahrt_Auto` FOREIGN KEY (`Fau_id`) REFERENCES `fahrer_auto` (`Fau_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ziel_Adresse` FOREIGN KEY (`Adresse_Ende`) REFERENCES `adresse` (`Adresse_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fahrt`
--

LOCK TABLES `fahrt` WRITE;
/*!40000 ALTER TABLE `fahrt` DISABLE KEYS */;
INSERT INTO `fahrt` VALUES (1,1,1,4,'2023-10-23 10:00:00','2023-10-23 11:15:00',10,30),(2,2,2,5,'2023-10-23 09:30:00','2023-10-23 10:45:00',15,35),(15,2,2,5,'2023-10-23 11:30:00','2023-10-23 12:45:00',45,55),(3,3,3,6,'2023-10-23 08:45:00','2023-10-23 10:00:00',20,40),(4,4,4,7,'2023-10-23 10:30:00','2023-10-23 11:45:00',8,25),(5,5,5,8,'2023-10-23 11:00:00','2023-10-23 12:15:00',13,33),(6,6,6,9,'2023-10-23 07:30:00','2023-10-23 08:45:00',12,28),(7,7,7,1,'2023-10-23 12:30:00','2023-10-23 13:45:00',30,45),(8,8,8,2,'2023-10-23 11:45:00','2023-10-23 13:00:00',25,42),(9,9,9,3,'2023-10-23 14:00:00','2023-10-23 15:15:00',18,38),(10,1,1,4,'2023-10-23 13:00:00','2023-10-23 14:15:00',40,50),(11,1,1,4,'2023-10-23 15:00:00','2023-10-23 16:15:00',70,90);
/*!40000 ALTER TABLE `fahrt` ENABLE KEYS */;
UNLOCK TABLES;

ALTER TABLE plz ADD UNIQUE `plz_ort_index_unique`(plz_nr, ort_id);

ALTER TABLE strasse ADD UNIQUE `strasse_plz_index_unique`(plz_id, name);