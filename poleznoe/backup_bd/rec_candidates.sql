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
-- Table structure for table `candidates`
--

DROP TABLE IF EXISTS `candidates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidates` (
  `candidate_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `age` int NOT NULL,
  `sex` varchar(45) NOT NULL,
  `user_login` varchar(45) NOT NULL,
  PRIMARY KEY (`candidate_id`),
  KEY `fk_user_login` (`user_login`),
  CONSTRAINT `fk_user_login` FOREIGN KEY (`user_login`) REFERENCES `check_users` (`user_login`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidates`
--

LOCK TABLES `candidates` WRITE;
/*!40000 ALTER TABLE `candidates` DISABLE KEYS */;
INSERT INTO `candidates` VALUES (1,'Иван Петров','Москва',25,'M','user_1'),(2,'Анна Сидорова','Санкт-Петербург',30,'F','user_2'),(3,'Сергей Иванов','Казань',40,'M','user_3'),(4,'Мария Кузнецова','Екатеринбург',22,'F','user_4'),(5,'Максим Попов','Нижний Новгород',35,'M','user_5'),(6,'Екатерина Смирнова','Новосибирск',28,'F','user_6'),(7,'Ваня Тапочкин','Мурманск',21,'М','user_7'),(8,'Маша Ваша','Коломна',22,'F','user_8'),(9,'Таня Зайкина','Москва',20,'F','user_9'),(10,'Максим Успехов','Иваново',30,'M','1'),(11,'Оля Вошла_в_ИТ','Сиетл',18,'F','rec'),(12,'Макс Правин','Москва',24,'M','user'),(13,'Александр Левин','Зеленоград',27,'M','user_13'),(14,'Иван Сильный','Уфа',25,'M','user_14'),(18,'Даша ТестЮзер','Радуга',21,'F','dora'),(19,'Test Profile','Computer',99,'M','tester'),(20,'a','a',11,'M','A'),(21,'Мэнеджер Проекта','ПМ',27,'F','mang'),(22,'Неизвестно','Неизвестно',0,'Неизвестно','an'),(23,'Соискатель','Москва',18,'M','new'),(24,'New1','Fff',21,'M','new1'),(25,'Zaglushka','New York',18,'M','rot'),(26,'Неизвестно','Неизвестно',0,'Неизвестно','tema'),(27,'Неизвестно','Неизвестно',0,'Неизвестно','new2'),(28,'Неизвестно','Неизвестно',0,'Неизвестно','an1'),(29,'Неизвестно','Неизвестно',0,'Неизвестно','mang1'),(30,'Неизвестно','Неизвестно',0,'Неизвестно','an2'),(31,'Неизвестно','Неизвестно',0,'Неизвестно','rec1'),(32,'Неизвестно','Неизвестно',0,'Неизвестно','an3'),(33,'Роман','Москва',22,'M','ds'),(34,'Куашник','Питер',22,'M','qa'),(35,'Qa1','test',21,'M','qa1'),(36,'ds1','test',33,'M','ds1'),(37,'ds2','test',41,'M','ds2'),(38,'ds3','tetst',18,'F','ds3'),(39,'ds4','test',52,'F','ds4'),(40,'Неизвестно','Неизвестно',0,'Неизвестно','dwqjn');
/*!40000 ALTER TABLE `candidates` ENABLE KEYS */;
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
