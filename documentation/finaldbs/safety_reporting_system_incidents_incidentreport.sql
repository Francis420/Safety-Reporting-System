-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: safety_reporting_system
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `incidents_incidentreport`
--

DROP TABLE IF EXISTS `incidents_incidentreport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidents_incidentreport` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `location` varchar(255) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_incident_user_id` (`user_id`),
  KEY `idx_category` (`category`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_status` (`status`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `incidents_incidentre_user_id_c22f3f01_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidents_incidentreport`
--

LOCK TABLES `incidents_incidentreport` WRITE;
/*!40000 ALTER TABLE `incidents_incidentreport` DISABLE KEYS */;
INSERT INTO `incidents_incidentreport` VALUES (32,'Traffic Accident','heheaaaazza','Marssssaaaasszzza',11.094688752964156,124.78355308516787,'Acknowledged','2025-01-11 05:01:40.685229','2025-01-13 11:44:45.000000',5),(36,'Crime','asdsdsd','sdsdsds',11.101378107404711,124.57245675253203,'received','2025-01-12 13:42:19.000000','2025-01-12 13:42:19.000000',5),(37,'Crime','qqqqqqqqqqqqqqqqqqqq','qqqqqqqqqqqqqqqqq',9.988715685028335,122.90272320109054,'received','2025-01-12 13:48:33.000000','2025-01-12 13:48:33.000000',5),(38,'Crime','aaaaaaaaaaaaaaaa','aaaaaaaaaaaaaaaaa',9.5551744071122,125.46870192759836,'Received','2025-01-12 14:12:15.000000','2025-01-12 14:12:15.000000',5),(41,'Crime','zxc','zxc',7.288063106264295,125.61481914700667,'Resolved','2025-01-12 21:04:42.000000','2025-01-12 21:04:42.000000',5),(42,'Traffic Accident','bnm','bnm',6.2207666542602205,125.67781030720276,'Acknowledged','2025-01-12 21:18:31.000000','2025-01-12 21:18:31.000000',5),(44,'Crime','ppppp','ppppppp',11.254609419482842,124.94508650835604,'Received','2025-01-13 02:04:18.965229','2025-01-13 02:04:18.965256',5),(45,'Unsafe Condition','ppppp','pppppp',11.26161996044113,124.9011408163075,'Received','2025-01-13 02:04:24.621368','2025-01-13 02:04:24.621392',5),(46,'Traffic Accident','ppppp','pppppp',11.254609419482842,124.94508650835604,'Received','2025-01-13 02:04:29.644056','2025-01-13 02:04:29.644084',5),(47,'Traffic Accident','pppppa','ppppppa',11.253665022117616,124.87092915619202,'Received','2025-01-13 02:05:39.121279','2025-01-13 02:05:39.121304',5),(48,'Crime','pppppa','ppppppa',11.255180265413241,124.8609730409267,'Received','2025-01-13 02:09:48.059784','2025-01-13 02:09:48.059812',5),(49,'Crime','ppppp','pppppp',11.254609419482842,124.94508650835604,'Received','2025-01-13 02:10:11.799944','2025-01-13 02:10:11.799968',5),(50,'Crime','pppppaa','ppppppaa',9.646530868760234,123.19931006657086,'Received','2025-01-13 02:21:41.381823','2025-01-13 02:21:41.381845',5),(61,'Traffic Accident','ffffffffff','fffffffffff',10.974308248702929,122.29852535583778,'Received','2025-01-13 14:37:09.000000','2025-01-13 14:37:09.000000',2),(62,'Traffic Accident','asd','asd',11.263532374799397,124.9066353045727,'Resolved','2025-01-13 15:09:21.000000','2025-01-13 15:09:21.000000',5);
/*!40000 ALTER TABLE `incidents_incidentreport` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_incident_category` AFTER UPDATE ON `incidents_incidentreport` FOR EACH ROW BEGIN
    DECLARE admin_user_id BIGINT;
    SET admin_user_id = (SELECT @current_user_id);  -- Retrieve the current user ID from a session variable

    IF OLD.category != NEW.category THEN
        INSERT INTO audit_log (user_id, action, changes, timestamp)
        VALUES (admin_user_id, 'update_incident_category', CONCAT('Updated category for incident_id: ', NEW.id, ' from "', OLD.category, '" to "', NEW.category, '"'), NOW());
    END IF;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_incident_status_change` AFTER UPDATE ON `incidents_incidentreport` FOR EACH ROW BEGIN
    IF NEW.status <> OLD.status THEN
        INSERT INTO audit_log (user_id, action, changes, timestamp)
        VALUES (NEW.user_id, 'update_incident_status', CONCAT('Updated status for incident_id: ', NEW.id, ' from "', OLD.status, '" to "', NEW.status, '"'), NOW());
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

-- Dump completed on 2025-01-13 17:11:22
