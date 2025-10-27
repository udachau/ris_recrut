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
-- Table structure for table `response`
--

DROP TABLE IF EXISTS `response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `response` (
  `user_login` varchar(45) NOT NULL,
  `opening_id` int NOT NULL,
  `status` enum('откликнулся','отменено','собеседование назначено') NOT NULL,
  PRIMARY KEY (`user_login`,`opening_id`),
  KEY `opening_id` (`opening_id`),
  CONSTRAINT `response_ibfk_1` FOREIGN KEY (`user_login`) REFERENCES `check_users` (`user_login`),
  CONSTRAINT `response_ibfk_2` FOREIGN KEY (`opening_id`) REFERENCES `openings` (`opening_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `response`
--

LOCK TABLES `response` WRITE;
/*!40000 ALTER TABLE `response` DISABLE KEYS */;
INSERT INTO `response` VALUES ('A',4,'отменено'),('dora',2,'собеседование назначено'),('dora',3,'собеседование назначено'),('dora',4,'отменено'),('dora',10,'откликнулся'),('dora',11,'откликнулся'),('ds',10,'откликнулся'),('ds',11,'отменено'),('ds1',10,'откликнулся'),('ds2',10,'откликнулся'),('ds3',10,'откликнулся'),('ds4',10,'откликнулся'),('new',2,'собеседование назначено'),('new',4,'собеседование назначено'),('new1',2,'откликнулся'),('new1',3,'откликнулся'),('new1',4,'собеседование назначено'),('qa',10,'отменено'),('qa',11,'откликнулся'),('qa1',11,'откликнулся'),('rot',2,'откликнулся'),('rot',3,'собеседование назначено'),('rot',4,'откликнулся'),('tema',2,'отменено'),('tema',3,'отменено'),('tema',4,'отменено'),('tester',2,'собеседование назначено'),('tester',3,'собеседование назначено'),('tester',4,'собеседование назначено'),('tester',10,'отменено'),('tester',11,'собеседование назначено');
/*!40000 ALTER TABLE `response` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-27 14:09:52
