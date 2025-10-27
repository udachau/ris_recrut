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
-- Temporary view structure for view `position_openings_count`
--

DROP TABLE IF EXISTS `position_openings_count`;
/*!50001 DROP VIEW IF EXISTS `position_openings_count`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `position_openings_count` AS SELECT 
 1 AS `position_id`,
 1 AS `job_name`,
 1 AS `openings_count`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `position_openings_count`
--

/*!50001 DROP VIEW IF EXISTS `position_openings_count`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `position_openings_count` AS select `p`.`position_id` AS `position_id`,`p`.`job_name` AS `job_name`,count(0) AS `openings_count` from (`positions` `p` join `openings` `o` on((`p`.`position_id` = `o`.`position_id`))) group by `p`.`position_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'rec'
--

--
-- Dumping routines for database 'rec'
--
/*!50003 DROP PROCEDURE IF EXISTS `annual_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`manager`@`localhost` PROCEDURE `annual_report`(
    IN `start_date` DATE, -- Начальная дата интервала
    IN `end_date` DATE    -- Конечная дата интервала
)
BEGIN
    -- Удаляем данные за указанный интервал дат (если уже существуют)
    DELETE FROM `report` 
    WHERE `date_range` = CONCAT(DATE_FORMAT(start_date, '%Y-%m-%d'), ' - ', DATE_FORMAT(end_date, '%Y-%m-%d'));

    -- Вставляем агрегированные данные
    INSERT INTO `report` (`position_id`, `job_name`, `openings_count`, `avg_close_days`, `date_range`, `created_at`)
    SELECT
        p.`position_id`,
        p.`job_name`,
        IFNULL(v.`openings_count`, 0), -- Количество вакансий
        IFNULL(AVG(DATEDIFF(o.`close_date`, o.`open_date`)), 0) AS avg_close_days, -- Среднее время закрытия вакансий
        CONCAT(DATE_FORMAT(start_date, '%Y-%m-%d'), ' - ', DATE_FORMAT(end_date, '%Y-%m-%d')) AS date_range, -- Интервал дат
        NOW() AS created_at -- Текущая дата и время
    FROM `positions` p
    LEFT JOIN (
        SELECT
            o.`position_id`,
            COUNT(o.`opening_id`) AS openings_count -- Подсчет количества вакансий за указанный период
        FROM `openings` o
        WHERE o.`open_date` BETWEEN start_date AND end_date -- Учитываем только вакансии в указанном интервале
        GROUP BY o.`position_id`
    ) v ON p.`position_id` = v.`position_id`
    LEFT JOIN `openings` o ON p.`position_id` = o.`position_id` AND o.`open_date` BETWEEN start_date AND end_date
    GROUP BY p.`position_id`, p.`job_name`;

    -- Фиксация изменений
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generate_hiring_dynamics_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`manager`@`localhost` PROCEDURE `generate_hiring_dynamics_report`(
    IN `start_date` DATE,  -- Начальная дата интервала
    IN `end_date` DATE     -- Конечная дата интервала
)
BEGIN
    -- Удаляем старые данные за указанный период
    DELETE FROM `hiring_dynamics_report`
    WHERE `created_at` BETWEEN start_date AND end_date;

    -- Вставляем агрегированные данные
    INSERT INTO `hiring_dynamics_report` (
        `department_name`,          -- Название должности
        `new_employees_count`,      -- Количество новых сотрудников
        `active_vacancies_count`,   -- Количество активных вакансий
        `avg_hires_per_month`,      -- Среднее количество наймов в месяц
        `time_interval_months`,     -- Интервал времени в формате 'YYYY-MM-DD - YYYY-MM-DD'
        `created_at`                -- Дата создания отчета
    )
    SELECT
        CONCAT(p.`job_name`, ' (', p.`division_code`, ')') AS department_name, -- Название должности и код отдела
        IFNULL(COUNT(e.`employee_id`), 0) AS new_employees_count,            -- Количество новых сотрудников
        IFNULL(COUNT(DISTINCT o.`opening_id`), 0) AS active_vacancies_count, -- Количество активных вакансий
        IFNULL(COUNT(e.`employee_id`) / NULLIF(TIMESTAMPDIFF(MONTH, start_date, end_date), 0), 0) AS avg_hires_per_month, -- Среднее количество наймов в месяц
        CONCAT(DATE_FORMAT(start_date, '%Y-%m-%d'), ' - ', DATE_FORMAT(end_date, '%Y-%m-%d')) AS time_interval_months, -- Интервал времени
        NOW() AS created_at                      -- Дата создания отчета
    FROM `positions` p
    LEFT JOIN `employees` e ON p.`position_id` = e.`position_id` AND e.`enrollment_date` BETWEEN start_date AND end_date
    LEFT JOIN `openings` o ON p.`position_id` = o.`position_id` AND o.`open_date` BETWEEN start_date AND end_date
    GROUP BY p.`division_code`, p.`job_name`;

    -- Фиксация изменений
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `HireEmployeesWithCursor1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `HireEmployeesWithCursor1`(IN interview_date DATE)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE candidate_id INT;
    DECLARE candidate_name VARCHAR(45);
    DECLARE candidate_birth_date DATE;
    DECLARE candidate_address VARCHAR(45);
    DECLARE candidate_position_id INT;
    DECLARE candidate_min_salary FLOAT;
    DECLARE candidate_salary FLOAT;

    -- Создаем курсор для выборки принятых кандидатов на собеседовании
    DECLARE cur CURSOR FOR
        SELECT c.candidate_id, c.name, c.address, o.position_id, p.min_salary
        FROM candidates c
        INNER JOIN interview_details id ON c.candidate_id = id.candidate_id
        INNER JOIN interviews i ON id.interview_id = i.interview_id
        INNER JOIN openings o ON i.opening_id = o.opening_id
        INNER JOIN positions p ON o.position_id = p.position_id
        WHERE i.date = interview_date AND id.result = 1; -- id.result = 1 для принятых кандидатов

    -- Объявляем, что курсор будет использоваться в цикле
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        -- Читаем данные из курсора
        FETCH cur INTO candidate_id, candidate_name, candidate_address, candidate_position_id, candidate_min_salary;

        -- Если больше данных нет, выходим из цикла
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Вставляем данные в таблицу сотрудников
        INSERT INTO employees (name, address, birth_date, position_id, salary, enrollment_date)
        VALUES (candidate_name, candidate_address, '2000-01-01', candidate_position_id, candidate_min_salary, interview_date);
    END LOOP;

    CLOSE cur;
END ;;
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
