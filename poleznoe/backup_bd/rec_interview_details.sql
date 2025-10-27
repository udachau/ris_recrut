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
-- Table structure for table `interview_details`
--

DROP TABLE IF EXISTS `interview_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interview_details` (
  `interview_detail_id` int NOT NULL AUTO_INCREMENT,
  `candidate_id` int NOT NULL,
  `interview_id` int NOT NULL,
  `result` tinyint NOT NULL,
  PRIMARY KEY (`interview_detail_id`),
  KEY `candidate_id` (`candidate_id`),
  KEY `interview_id` (`interview_id`),
  CONSTRAINT `interview_details_ibfk_1` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`candidate_id`),
  CONSTRAINT `interview_details_ibfk_2` FOREIGN KEY (`interview_id`) REFERENCES `interviews` (`interview_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interview_details`
--

LOCK TABLES `interview_details` WRITE;
/*!40000 ALTER TABLE `interview_details` DISABLE KEYS */;
INSERT INTO `interview_details` VALUES (1,1,1,1),(2,2,2,0),(3,3,2,1),(4,4,2,0),(5,5,3,0),(6,6,4,1),(7,7,5,0),(8,8,5,0),(9,9,5,0),(10,10,5,1),(11,11,5,1),(12,12,5,1),(18,14,18,0),(19,13,19,0),(20,1,20,0),(21,18,21,0),(22,18,22,0),(23,18,23,0),(24,19,24,0),(25,25,25,0),(26,23,26,0),(27,23,27,0),(28,19,28,0),(29,19,29,0),(30,23,30,0),(31,24,32,0);
/*!40000 ALTER TABLE `interview_details` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_interview_detail_insert` AFTER INSERT ON `interview_details` FOR EACH ROW BEGIN
    -- Проверяем, принят ли кандидат
    IF NEW.result = 1 THEN
        INSERT INTO employees (name, birth_date, address, education, position_id, salary, enrollment_date)
        SELECT 
            c.name,
            -- STR_TO_DATE(CONCAT(YEAR(DATE_SUB(CURDATE(), INTERVAL c.age YEAR)), '-01-01'), '%Y-%m-%d'),
			DATE_SUB(CURDATE(), INTERVAL c.age YEAR), -- Примерная дата рождения вычисленная по извесным данным 
            c.address,
            NULL,  -- Образование можно оставить пустым или заполнить по необходимости
            o.position_id,
            p.min_salary + (RAND() * (p.max_salary - p.min_salary)),
            -- p.min_salary,
            i.date
        FROM candidates c
        JOIN interview_details id ON c.candidate_id = id.candidate_id
        JOIN interviews i ON id.interview_id = i.interview_id
        JOIN openings o ON i.opening_id = o.opening_id
        JOIN positions p ON o.position_id = p.position_id
		WHERE id.candidate_id = NEW.candidate_id;
    END IF;
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
