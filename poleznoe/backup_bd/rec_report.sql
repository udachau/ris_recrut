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
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report` (
  `id_rep` int NOT NULL AUTO_INCREMENT,
  `position_id` int NOT NULL,
  `job_name` varchar(255) NOT NULL,
  `openings_count` int NOT NULL DEFAULT '0',
  `avg_close_days` float NOT NULL DEFAULT '0',
  `date_range` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_rep`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
INSERT INTO `report` VALUES (1,1,'Software Developer',0,0,'2023-01-01 - 2023-12-31','2025-01-22 06:11:35'),(2,2,'Marketing Manager',0,0,'2023-01-01 - 2023-12-31','2025-01-22 06:11:35'),(3,3,'Customer Support Rep',1,0,'2023-01-01 - 2023-12-31','2025-01-22 06:11:35'),(4,1,'Software Developer',0,0,'2023-01-01 - 2023-03-01','2025-01-22 06:37:20'),(5,2,'Marketing Manager',0,0,'2023-01-01 - 2023-03-01','2025-01-22 06:37:20'),(6,3,'Customer Support Rep',1,0,'2023-01-01 - 2023-03-01','2025-01-22 06:37:20'),(7,1,'Software Developer',0,0,'2023-01-01 - 2023-02-01','2025-01-22 06:43:07'),(8,2,'Marketing Manager',0,0,'2023-01-01 - 2023-02-01','2025-01-22 06:43:07'),(9,3,'Customer Support Rep',1,0,'2023-01-01 - 2023-02-01','2025-01-22 06:43:07'),(10,1,'Software Developer',0,0,'2018-01-01 - 2024-01-01','2025-02-16 12:16:45'),(11,2,'Marketing Manager',2,1093,'2018-01-01 - 2024-01-01','2025-02-16 12:16:45'),(12,3,'Customer Support Rep',0,0,'2018-01-01 - 2024-01-01','2025-02-16 12:16:45'),(13,4,'Software Developer',0,0,'2018-01-01 - 2024-01-01','2025-02-16 12:16:45'),(14,5,'HR',1,2327,'2018-01-01 - 2024-01-01','2025-02-16 12:16:45'),(15,6,'HR',1,2315,'2018-01-01 - 2024-01-01','2025-02-16 12:16:45'),(16,7,'Software Developer',1,2315,'2018-01-01 - 2024-01-01','2025-02-16 12:16:45'),(17,8,'Marketing Manager',1,263,'2018-01-01 - 2024-01-01','2025-02-16 12:16:45'),(18,9,'Data scientist',1,0,'2018-01-01 - 2024-01-01','2025-02-16 12:16:45'),(19,10,'QA engineer',0,0,'2018-01-01 - 2024-01-01','2025-02-16 12:16:45');
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
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
