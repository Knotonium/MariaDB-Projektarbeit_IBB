-- MariaDB dump 10.17  Distrib 10.4.8-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: wawi
-- ------------------------------------------------------
-- Server version	10.4.8-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `artikel`
--

DROP TABLE IF EXISTS `artikel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artikel` (
  `Art_Id` int(11) NOT NULL AUTO_INCREMENT,
  `B_Id` int(11) DEFAULT NULL,
  `Art_Name` varchar(100) DEFAULT NULL,
  `EAN` char(13) DEFAULT NULL,
  `Art_Art` varchar(100) DEFAULT 'Eisenwaren',
  `Preis_EK` decimal(6,2) DEFAULT NULL,
  `Preis_VK` decimal(6,2) DEFAULT NULL,
  `Steuer` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`Art_Id`),
  UNIQUE KEY `EAN` (`EAN`),
  KEY `B_Id` (`B_Id`),
  CONSTRAINT `artikel_ibfk_1` FOREIGN KEY (`B_Id`) REFERENCES `brand` (`B_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artikel`
--

LOCK TABLES `artikel` WRITE;
/*!40000 ALTER TABLE `artikel` DISABLE KEYS */;
INSERT INTO `artikel` VALUES (1,1,'Suki Kreuz-Holzschrauben BASIC 4,5x50mm, XL-Pack','4032526105481','Eisenwaren',3.48,8.49,19.00),(2,1,'Suki Torx-Holzschrauben BASIC 4,5x50mm, XL-Pack','4032526105482','Eisenwaren',3.48,8.49,19.00),(3,1,'Suki Kreuz-Holzschrauben BASIC 4,5x50mm, L-Pack','4032526105483','Eisenwaren',1.74,4.49,19.00),(4,1,'Suki Torx-Holzschrauben BASIC 4,5x50mm, L-Pack','4032526105484','Eisenwaren',1.74,4.49,19.00),(5,1,'Suki Kreuz-Holzschrauben BASIC 4,5x50mm, M-Pack','4032526105485','Eisenwaren',0.87,2.49,19.00),(6,1,'Suki Torx-Holzschrauben BASIC 4,5x50mm, M-Pack','4032526105486','Eisenwaren',0.87,2.49,19.00),(7,4,'Spax-Universalschraube 4x50mm, XXL-Pack','4032526105491','Eisenwaren',6.88,14.49,19.00),(8,4,'Spax-Universalschraube 5x80mm, XL-Pack','4032526105492','Eisenwaren',3.88,9.89,19.00),(9,2,'fischer Torx-Betonschraube ULTRACUT FBS ll 8x55mm, L-Pack','4048962251340','Eisenwaren',10.00,23.95,19.00),(10,2,'fischer Torx-Betonschraube ULTRACUT FBS ll 8x100mm, L-Pack','4048962251388','Eisenwaren',14.00,29.55,19.00),(11,2,'fischer Torx-Betonschraube ULTRACUT FBS ll 8x130mm, L-Pack','4048962251401','Eisenwaren',15.00,32.50,19.00),(12,3,'Tox Betonschraube Sumo Pro 1 M10x100x20 mm, M-Pack','4049563023671','Eisenwaren',8.40,20.79,19.00),(13,3,'Tox Betonschraube Sumo Pro 1 M10x100x20 mm, L-Pack','4049563023672','Eisenwaren',16.80,39.49,19.00),(14,3,'Tox Betonschraube Sumo Pro 1 M10x100x20 mm, XL-Pack','4049563023673','Eisenwaren',33.60,78.89,19.00);
/*!40000 ALTER TABLE `artikel` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger tr_neuer_artikel after insert on artikel for each row
begin
declare va_was varchar(200);
set va_was = concat('Neuer Artikel: ', new.Art_Name, ' ', new.Art_Art);
call p_write_prot('artikel', va_was);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `auftrag`
--

DROP TABLE IF EXISTS `auftrag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auftrag` (
  `A_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Kd_Id` int(11) DEFAULT NULL,
  `Ma_Id` int(11) DEFAULT NULL,
  `A_Datum` date DEFAULT NULL,
  `A_Status` enum('offen','bezahlt','versendet','storniert','retoure') DEFAULT 'offen',
  `Z_Ziel` date DEFAULT NULL,
  `Z_Datum` date DEFAULT NULL,
  `Z_Art` varchar(50) DEFAULT NULL,
  `Marktplatz` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`A_Id`),
  KEY `Kd_Id` (`Kd_Id`),
  KEY `Ma_Id` (`Ma_Id`),
  CONSTRAINT `auftrag_ibfk_1` FOREIGN KEY (`Kd_Id`) REFERENCES `kunde` (`Kd_Id`) ON DELETE CASCADE,
  CONSTRAINT `auftrag_ibfk_2` FOREIGN KEY (`Ma_Id`) REFERENCES `mitarbeiter` (`Ma_Id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auftrag`
--

LOCK TABLES `auftrag` WRITE;
/*!40000 ALTER TABLE `auftrag` DISABLE KEYS */;
INSERT INTO `auftrag` VALUES (1,3,4,'2019-10-21','versendet','2019-11-04','2019-10-21','klarna','schraube4u.de'),(2,1,4,'2019-10-22','offen','2019-11-05',NULL,'Ueberweisung','schraube4u.de'),(3,2,3,'2019-10-22','bezahlt','2019-11-05','2019-10-22','PayPal','schraube4u.de'),(4,9,4,'2019-10-22','bezahlt','2019-11-05','2019-10-22','PayPal','ebay'),(5,5,4,'2019-10-22','bezahlt','2019-11-05','2019-10-22','PayPal','ebay'),(6,11,4,'2019-10-23','bezahlt','2019-11-06','2019-10-23','PayPal','ebay'),(7,12,4,'2019-10-23','offen','2019-11-06',NULL,'Ueberweisung','schraube4u.de'),(8,5,3,'2019-10-23','bezahlt','2019-11-06','2019-10-23','klarna','schraube4u.de'),(9,1,7,'2019-10-24','bezahlt','2019-11-07','2019-10-24','PayPal','ebay'),(10,5,7,'2019-10-24','bezahlt','2019-11-07','2019-10-24','PayPal','ebay');
/*!40000 ALTER TABLE `auftrag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bestand`
--

DROP TABLE IF EXISTS `bestand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bestand` (
  `Best_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Art_Id` int(11) DEFAULT NULL,
  `Best_Verf` int(11) DEFAULT NULL,
  `Best_Res` int(11) DEFAULT NULL,
  `Best_Ges` int(11) DEFAULT NULL,
  PRIMARY KEY (`Best_Id`),
  UNIQUE KEY `Art_Id` (`Art_Id`),
  CONSTRAINT `bestand_ibfk_1` FOREIGN KEY (`Art_Id`) REFERENCES `artikel` (`Art_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestand`
--

LOCK TABLES `bestand` WRITE;
/*!40000 ALTER TABLE `bestand` DISABLE KEYS */;
INSERT INTO `bestand` VALUES (1,1,0,0,0),(2,2,0,0,0),(3,3,0,0,0),(4,4,0,0,0),(5,5,0,0,0),(6,6,0,0,0),(7,7,0,0,0),(8,8,0,0,0),(9,9,0,0,0),(10,10,0,0,0),(11,11,0,0,0),(12,12,0,0,0),(13,13,0,0,0),(14,14,0,0,0);
/*!40000 ALTER TABLE `bestand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brand` (
  `B_Id` int(11) NOT NULL AUTO_INCREMENT,
  `B_Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`B_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (1,'SUKI'),(2,'Fischer'),(3,'TOX'),(4,'Spax');
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kunde`
--

DROP TABLE IF EXISTS `kunde`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kunde` (
  `Kd_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Kd_Name` varchar(50) DEFAULT NULL,
  `Kd_Vorname` varchar(50) DEFAULT NULL,
  `PLZ` char(9) DEFAULT NULL,
  `Ort` varchar(50) DEFAULT NULL,
  `Kd_Email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Kd_Id`),
  UNIQUE KEY `Kd_Email` (`Kd_Email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kunde`
--

LOCK TABLES `kunde` WRITE;
/*!40000 ALTER TABLE `kunde` DISABLE KEYS */;
INSERT INTO `kunde` VALUES (1,'Dolan','Phillip','60599','Offenbach am Main','dolan@web.de'),(2,'Forouhar','Farhad','45355','Essen','farifor@web.de'),(3,'Saaber','Marco','45276','Essen','saaber@aol.com'),(4,'Reisser','Martin','52062','Aachen','martin.reisser@gmail.com'),(5,'Knoten','Nicole','45145','Essen','knotonium@protonmail.com'),(6,'Pietrucha','Gosia','80331','Muenchen','pietrucha@gmx.de'),(7,'Leowald','Philipp','46514','Schermbeck','baumdoktor@arcor.de'),(8,'Mueller','Kevin','27472','Cuxhaven','kevinski@googlemail.com'),(9,'Knipprath','Sandra','20095','Hamburg','knippsand@hotmail.com'),(10,'Guttau','Martina','65934','Frankfurt am Main','guttau@googlemail.com'),(11,'Ziegler','Sebastian','35037','Marburg','ziegelbasti@web.de'),(12,'Kryzelewski','Bjoern','66111','Saarbruecken','bambusbjoern@gmail.com');
/*!40000 ALTER TABLE `kunde` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lr`
--

DROP TABLE IF EXISTS `lr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lr` (
  `LR_Id` int(11) NOT NULL AUTO_INCREMENT,
  `A_Id` int(11) DEFAULT NULL,
  `Ma_Id` int(11) DEFAULT NULL,
  `LR_Datum` date DEFAULT NULL,
  `Z_Summe` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`LR_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lr`
--

LOCK TABLES `lr` WRITE;
/*!40000 ALTER TABLE `lr` DISABLE KEYS */;
INSERT INTO `lr` VALUES (1,1,4,'2019-10-22',16.98);
/*!40000 ALTER TABLE `lr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mitarbeiter`
--

DROP TABLE IF EXISTS `mitarbeiter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mitarbeiter` (
  `Ma_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Ma_Name` varchar(50) DEFAULT NULL,
  `Ma_Vorname` varchar(50) DEFAULT NULL,
  `Funktion` varchar(100) DEFAULT NULL,
  `Ma_Email` varchar(100) DEFAULT NULL,
  `Ma_Geb` date DEFAULT NULL,
  PRIMARY KEY (`Ma_Id`),
  UNIQUE KEY `Ma_Name` (`Ma_Name`,`Ma_Vorname`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mitarbeiter`
--

LOCK TABLES `mitarbeiter` WRITE;
/*!40000 ALTER TABLE `mitarbeiter` DISABLE KEYS */;
INSERT INTO `mitarbeiter` VALUES (1,'Forouhar','Nicole','CEO','forouhar@schraube4u.de','1990-12-29'),(2,'Heldt','Stefan','Einkauf','heldt@schraube4u.de','1985-11-25'),(3,'Leowald','Philipp','Verkauf','leowald@schraube4u.de','1983-05-13'),(4,'Zielke','Torsten','Verkauf','zielke@schraube4u.de','1983-05-13'),(5,'Hilger','Julia','Personal/Buchhaltung','hilger@schraube4u.de','1991-07-21'),(6,'Giersemehl','Gerd','Webshop','giersemehl@schraube4u.de','1985-11-28'),(7,'Juergens','Michael','Verkauf','juergens@schraube4u.de','1980-01-15');
/*!40000 ALTER TABLE `mitarbeiter` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger tr_neuer_name after insert on mitarbeiter for each row
begin
declare va_was varchar(200);
set va_was = concat('Neuer Ma_Name: ', new.Ma_Vorname, ' ', new.Ma_Name);
call p_write_prot('mitarbeiter', va_was);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger tr_name_aendern after update on mitarbeiter for each row
begin
declare va_was varchar(200);
set va_was = concat('Ma_Name geaendert von: ', old.Ma_Vorname, ' ', old.Ma_Name);
set va_was = concat(va_was, ' in: ', new.Ma_Vorname, ' ', new.Ma_Name);
call p_write_prot('mitarbeiter', va_was);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger tr_name_loeschen after delete on mitarbeiter for each row
begin
declare va_was varchar(200);
set va_was = concat('Ma_Name geloescht: ', old.Ma_Vorname, ' ', old.Ma_Name);
call p_write_prot('mitarbeiter', va_was);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `position`
--

DROP TABLE IF EXISTS `position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `position` (
  `Pos_Id` int(11) NOT NULL AUTO_INCREMENT,
  `A_Id` int(11) DEFAULT NULL,
  `Art_Id` int(11) DEFAULT NULL,
  `Pos_Anzahl` int(11) DEFAULT NULL,
  `Pos_Preis` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`Pos_Id`),
  KEY `A_Id` (`A_Id`),
  CONSTRAINT `position_ibfk_1` FOREIGN KEY (`A_Id`) REFERENCES `auftrag` (`A_Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `position`
--

LOCK TABLES `position` WRITE;
/*!40000 ALTER TABLE `position` DISABLE KEYS */;
INSERT INTO `position` VALUES (1,1,1,2,16.98),(2,2,3,1,4.49),(3,2,10,1,29.55),(4,3,14,1,78.89),(5,3,8,1,9.89),(6,3,4,1,4.49),(7,4,3,2,8.98),(8,4,1,2,16.98),(9,5,12,2,20.79),(10,6,2,2,16.98),(11,6,4,1,4.49),(12,6,12,1,20.79),(13,6,9,1,23.95),(14,7,5,2,4.98),(15,7,7,1,14.49),(16,8,3,1,4.49),(17,8,11,1,32.50),(18,9,10,2,59.10),(19,10,2,1,8.49),(20,10,13,1,39.49);
/*!40000 ALTER TABLE `position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `position_pro_auf`
--

DROP TABLE IF EXISTS `position_pro_auf`;
/*!50001 DROP VIEW IF EXISTS `position_pro_auf`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `position_pro_auf` (
  `A_Id` tinyint NOT NULL,
  `Pos_pro_A` tinyint NOT NULL,
  `Kd_Id` tinyint NOT NULL,
  `Kd_Vorname` tinyint NOT NULL,
  `Kd_Name` tinyint NOT NULL,
  `Kd_Email` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `protokoll`
--

DROP TABLE IF EXISTS `protokoll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `protokoll` (
  `p_id` int(11) NOT NULL AUTO_INCREMENT,
  `p_wo` varchar(200) DEFAULT NULL,
  `p_wann` datetime DEFAULT NULL,
  `p_was` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`p_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `protokoll`
--

LOCK TABLES `protokoll` WRITE;
/*!40000 ALTER TABLE `protokoll` DISABLE KEYS */;
/*!40000 ALTER TABLE `protokoll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `showall`
--

DROP TABLE IF EXISTS `showall`;
/*!50001 DROP VIEW IF EXISTS `showall`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `showall` (
  `Art_Name` tinyint NOT NULL,
  `Pos_Anzahl` tinyint NOT NULL,
  `A_Id` tinyint NOT NULL,
  `A_Datum` tinyint NOT NULL,
  `A_Status` tinyint NOT NULL,
  `Ma_Name` tinyint NOT NULL,
  `Kd_Name` tinyint NOT NULL,
  `Kd_Vorname` tinyint NOT NULL,
  `B_Name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `umsatz_pro_art`
--

DROP TABLE IF EXISTS `umsatz_pro_art`;
/*!50001 DROP VIEW IF EXISTS `umsatz_pro_art`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `umsatz_pro_art` (
  `Art_Id` tinyint NOT NULL,
  `Umsatz` tinyint NOT NULL,
  `Art_Name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `position_pro_auf`
--

/*!50001 DROP TABLE IF EXISTS `position_pro_auf`*/;
/*!50001 DROP VIEW IF EXISTS `position_pro_auf`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `position_pro_auf` AS select `pos`.`A_Id` AS `A_Id`,count(`pos`.`Pos_Id`) AS `Pos_pro_A`,`auf`.`Kd_Id` AS `Kd_Id`,`kun`.`Kd_Vorname` AS `Kd_Vorname`,`kun`.`Kd_Name` AS `Kd_Name`,`kun`.`Kd_Email` AS `Kd_Email` from ((`position` `pos` join `auftrag` `auf` on(`pos`.`A_Id` = `auf`.`A_Id`)) join `kunde` `kun` on(`auf`.`Kd_Id` = `kun`.`Kd_Id`)) group by `pos`.`A_Id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `showall`
--

/*!50001 DROP TABLE IF EXISTS `showall`*/;
/*!50001 DROP VIEW IF EXISTS `showall`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `showall` AS select `art`.`Art_Name` AS `Art_Name`,`pos`.`Pos_Anzahl` AS `Pos_Anzahl`,`auf`.`A_Id` AS `A_Id`,`auf`.`A_Datum` AS `A_Datum`,`auf`.`A_Status` AS `A_Status`,`mit`.`Ma_Name` AS `Ma_Name`,`kun`.`Kd_Name` AS `Kd_Name`,`kun`.`Kd_Vorname` AS `Kd_Vorname`,`bra`.`B_Name` AS `B_Name` from (((((`position` `pos` join `auftrag` `auf` on(`pos`.`A_Id` = `auf`.`A_Id`)) join `artikel` `art` on(`pos`.`Art_Id` = `art`.`Art_Id`)) join `kunde` `kun` on(`auf`.`Kd_Id` = `kun`.`Kd_Id`)) join `mitarbeiter` `mit` on(`auf`.`Ma_Id` = `mit`.`Ma_Id`)) join `brand` `bra` on(`art`.`B_Id` = `bra`.`B_Id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `umsatz_pro_art`
--

/*!50001 DROP TABLE IF EXISTS `umsatz_pro_art`*/;
/*!50001 DROP VIEW IF EXISTS `umsatz_pro_art`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `umsatz_pro_art` AS select `art`.`Art_Id` AS `Art_Id`,sum(`pos`.`Pos_Preis`) AS `Umsatz`,`art`.`Art_Name` AS `Art_Name` from (`artikel` `art` left join `position` `pos` on(`pos`.`Art_Id` = `art`.`Art_Id`)) group by `pos`.`Art_Id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-06 16:12:11
