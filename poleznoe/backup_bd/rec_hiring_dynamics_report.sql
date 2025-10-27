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
-- Table structure for table `hiring_dynamics_report`
--

DROP TABLE IF EXISTS `hiring_dynamics_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hiring_dynamics_report` (
  `id` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(255) NOT NULL,
  `new_employees_count` int NOT NULL DEFAULT '0',
  `active_vacancies_count` int NOT NULL DEFAULT '0',
  `avg_hires_per_month` float NOT NULL DEFAULT '0',
  `time_interval_months` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hiring_dynamics_report`
--

LOCK TABLES `hiring_dynamics_report` WRITE;
/*!40000 ALTER TABLE `hiring_dynamics_report` DISABLE KEYS */;
INSERT INTO `hiring_dynamics_report` VALUES (4,'Software Developer (101)',0,0,0,'2023-01-01 - 2023-12-31','2025-01-22 09:35:52'),(5,'Marketing Manager (205)',0,0,0,'2023-01-01 - 2023-12-31','2025-01-22 09:35:52'),(6,'Customer Support Rep (302)',0,1,0,'2023-01-01 - 2023-12-31','2025-01-22 09:35:52'),(7,'Software Developer (101)',0,0,0,'2023-02-01 - 2023-03-01','2025-01-22 12:38:31'),(8,'Marketing Manager (205)',0,0,0,'2023-02-01 - 2023-03-01','2025-01-22 12:38:31'),(9,'Customer Support Rep (302)',0,0,0,'2023-02-01 - 2023-03-01','2025-01-22 12:38:31'),(45,'Software Developer (101)',0,0,0,'2020-01-01 - 2020-12-31','2025-03-01 09:24:00'),(46,'Software Developer (102)',0,0,0,'2020-01-01 - 2020-12-31','2025-03-01 09:24:00'),(47,'Marketing Manager (205)',1,1,0.0909091,'2020-01-01 - 2020-12-31','2025-03-01 09:24:00'),(48,'Customer Support Rep (302)',0,0,0,'2020-01-01 - 2020-12-31','2025-03-01 09:24:00'),(49,'Data scientist (401)',0,0,0,'2020-01-01 - 2020-12-31','2025-03-01 09:24:00'),(50,'QA engineer (501)',0,0,0,'2020-01-01 - 2020-12-31','2025-03-01 09:24:00'),(51,'HR (601)',0,0,0,'2020-01-01 - 2020-12-31','2025-03-01 09:24:00');
/*!40000 ALTER TABLE `hiring_dynamics_report` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-27 14:09:51
