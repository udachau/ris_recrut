CREATE DATABASE  IF NOT EXISTS `rec` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `rec`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: rec
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `check_users`
--

DROP TABLE IF EXISTS `check_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `check_users` (
  `idcheck_users` int NOT NULL AUTO_INCREMENT,
  `group_login` varchar(45) NOT NULL,
  `group_pass` varchar(45) NOT NULL,
  `user_login` varchar(45) NOT NULL,
  `user_pass` varchar(45) NOT NULL,
  PRIMARY KEY (`idcheck_users`,`user_login`),
  UNIQUE KEY `user_login_UNIQUE` (`user_login`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `check_users`
--

LOCK TABLES `check_users` WRITE;
/*!40000 ALTER TABLE `check_users` DISABLE KEYS */;
INSERT INTO `check_users` VALUES (1,'boss','111','user','1234'),(2,'recruter','111','rec','1234'),(3,'guest','111','1','1'),(4,'guest','111','user_1','1'),(5,'guest','111','user_2','1'),(6,'guest','111','user_3','1'),(7,'guest','111','user_4','1'),(8,'guest','111','user_5','1'),(9,'guest','111','user_6','1'),(10,'guest','111','user_7','1'),(11,'guest','111','user_8','1'),(12,'guest','111','user_9','1'),(13,'guest','111','user_13','1'),(14,'guest','111','user_14','1'),(15,'guest','111','dora','dura'),(16,'guest','111','tester','1234'),(17,'guest','111','A','1'),(18,'manager','111','mang','1234'),(19,'analyst','111','an','1234'),(20,'guest','111','new','1234'),(21,'guest','111','new1','1234'),(22,'guest','111','rot','ebal'),(23,'guest','111','tema','1234'),(24,'guest','111','new2','1234'),(25,'analyst','111','an1','1234'),(26,'manager','111','mang1','1234'),(27,'analyst','111','an2','1234'),(28,'recruter','111','rec1','1234'),(29,'analyst','111','an3','1234'),(30,'guest','111','ds','1234'),(31,'guest','111','qa','1234'),(32,'guest','111','qa1','1234'),(33,'guest','111','ds1','1234'),(34,'guest','111','ds2','1234'),(35,'guest','111','ds3','1234'),(36,'guest','111','ds4','1234'),(37,'guest','111','dwqjn','1234');
/*!40000 ALTER TABLE `check_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_users_AFTER_INSERT` AFTER INSERT ON `check_users` FOR EACH ROW BEGIN
	INSERT INTO candidates (user_login, name, address, age, sex)
    VALUES (NEW.user_login, 'Неизвестно', 'Неизвестно', 0, 'Неизвестно');
END */;;
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_users_AFTER_DELETE` AFTER DELETE ON `check_users` FOR EACH ROW BEGIN
	DELETE FROM candidates
    WHERE user_login = OLD.user_login;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-27 14:09:52
