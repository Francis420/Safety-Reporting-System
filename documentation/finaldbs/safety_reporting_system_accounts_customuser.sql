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
-- Table structure for table `accounts_customuser`
--

DROP TABLE IF EXISTS `accounts_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_customuser` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `display_name` varchar(50) DEFAULT NULL,
  `remarks` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `idx_username` (`username`),
  KEY `idx_is_admin` (`is_admin`),
  KEY `idx_is_superuser` (`is_superuser`),
  KEY `idx_is_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_customuser`
--

LOCK TABLES `accounts_customuser` WRITE;
/*!40000 ALTER TABLE `accounts_customuser` DISABLE KEYS */;
INSERT INTO `accounts_customuser` VALUES (1,'pbkdf2_sha256$870000$D7Z0vTd2xi4oTHgRYawuiG$KFXMCH7RE0t2LSe8Pu1FVI+SNUkQctOUh2lsJ0ML+30=','2025-01-11 02:34:03.325415',1,'admin','Heihei','Da Great','heihei@da.great',1,1,'2024-11-21 10:36:42.000000','mars','0987654321',1,NULL,'Chickenzz'),(2,'pbkdf2_sha256$870000$D7Z0vTd2xi4oTHgRYawuiG$KFXMCH7RE0t2LSe8Pu1FVI+SNUkQctOUh2lsJ0ML+30=','2025-01-13 08:57:54.193466',1,'admin1','Heiheizz','Da Greataarzz','admin@admin.commmzz',1,1,'2024-11-22 03:08:01.000000','Marsyyzz','09876543168',1,'chickennnzz',''),(4,'pbkdf2_sha256$870000$TImqV4A5zseAKJbZk3XqBe$zwPsaTxyzZ/TTv9ASjzeMUABHb7P1vb+IOgz+23H2ME=','2025-01-12 01:50:58.572892',0,'dodo','dodo','bird','dodo@bird.abvian.gg',0,1,'2024-12-02 05:34:38.000000','somewhere','0987654321',0,NULL,NULL),(5,'pbkdf2_sha256$870000$D7Z0vTd2xi4oTHgRYawuiG$KFXMCH7RE0t2LSe8Pu1FVI+SNUkQctOUh2lsJ0ML+30=','2025-01-13 08:57:38.199187',0,'admin2','','','admin@admin.com',1,1,'2024-12-18 01:31:52.000000',NULL,NULL,0,'hehe',''),(6,'pbkdf2_sha256$870000$D7Z0vTd2xi4oTHgRYawuiG$KFXMCH7RE0t2LSe8Pu1FVI+SNUkQctOUh2lsJ0ML+30=','2025-01-13 04:19:12.112992',0,'admin4','','','ad@min.com',1,1,'2024-12-18 01:41:45.000000',NULL,NULL,0,NULL,''),(7,'pbkdf2_sha256$870000$OBoimib08RL8SFbQlIAZZ8$NbHM8nVeAB6GP2uBtlPXgVzjZ8kMy3UbxGPMIwNgH2M=','2025-01-13 04:19:29.186916',0,'admin69','','','admin@amin.com',1,1,'2025-01-11 01:59:11.000000',NULL,NULL,1,NULL,'noob');
/*!40000 ALTER TABLE `accounts_customuser` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_update_accounts_user_profile` BEFORE UPDATE ON `accounts_customuser` FOR EACH ROW BEGIN
    DECLARE changes TEXT DEFAULT '';
    
    IF OLD.first_name != NEW.first_name THEN
        SET changes = CONCAT(changes, 'first_name: "', OLD.first_name, '" to "', NEW.first_name, '"; ');
    END IF;
    IF OLD.last_name != NEW.last_name THEN
        SET changes = CONCAT(changes, 'last_name: "', OLD.last_name, '" to "', NEW.last_name, '"; ');
    END IF;
    IF OLD.email != NEW.email THEN
        SET changes = CONCAT(changes, 'email: "', OLD.email, '" to "', NEW.email, '"; ');
    END IF;
    IF OLD.address != NEW.address THEN
        SET changes = CONCAT(changes, 'address: "', OLD.address, '" to "', NEW.address, '"; ');
    END IF;
    IF OLD.phone_number != NEW.phone_number THEN
        SET changes = CONCAT(changes, 'phone_number: "', OLD.phone_number, '" to "', NEW.phone_number, '"; ');
    END IF;
    IF OLD.display_name != NEW.display_name THEN
        SET changes = CONCAT(changes, 'display_name: "', OLD.display_name, '" to "', NEW.display_name, '"; ');
    END IF;
    IF OLD.remarks != NEW.remarks THEN
        SET changes = CONCAT(changes, 'remarks: "', OLD.remarks, '" to "', NEW.remarks, '"; ');
    END IF;

    IF changes != '' THEN
        INSERT INTO audit_log (user_id, action, changes, timestamp)
        VALUES (NEW.id, 'update_profile', changes, NOW());
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_password_changed` AFTER UPDATE ON `accounts_customuser` FOR EACH ROW BEGIN
    IF OLD.password != NEW.password THEN
        INSERT INTO audit_log (user_id, action, changes, timestamp)
        VALUES (NEW.id, 'password_change', 'Password changed', NOW());
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_admin_status` AFTER UPDATE ON `accounts_customuser` FOR EACH ROW BEGIN
    DECLARE admin_user_id BIGINT;
    SET admin_user_id = (SELECT @current_user_id);  -- Retrieve the current user ID from a session variable

    IF OLD.is_admin != NEW.is_admin THEN
        INSERT INTO audit_log (user_id, action, changes, timestamp)
        VALUES (admin_user_id, 'toggle_admin_status', CONCAT('Changed admin status for user_id: ', NEW.id, ' from "', OLD.is_admin, '" to "', NEW.is_admin, '"'), NOW());
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_account_status` AFTER UPDATE ON `accounts_customuser` FOR EACH ROW BEGIN
    DECLARE admin_user_id BIGINT;
    SET admin_user_id = (SELECT @current_user_id);  -- Retrieve the current user ID from a session variable

    IF OLD.is_active != NEW.is_active THEN
        INSERT INTO audit_log (user_id, action, changes, timestamp)
        VALUES (admin_user_id, 'toggle_account_status', CONCAT('Changed account status for user_id: ', NEW.id, ' from "', OLD.is_active, '" to "', NEW.is_active, '"'), NOW());
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_account_remarks` AFTER UPDATE ON `accounts_customuser` FOR EACH ROW BEGIN
    DECLARE admin_user_id BIGINT;
    SET admin_user_id = (SELECT @current_user_id);  -- Retrieve the current user ID from a session variable

    IF OLD.remarks != NEW.remarks THEN
        INSERT INTO audit_log (user_id, action, changes, timestamp)
        VALUES (admin_user_id, 'update_remarks', CONCAT('Updated remarks for user_id: ', NEW.id, ' from "', OLD.remarks, '" to "', NEW.remarks, '"'), NOW());
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_superuser_status` AFTER UPDATE ON `accounts_customuser` FOR EACH ROW BEGIN
    DECLARE admin_user_id BIGINT;
    SET admin_user_id = (SELECT @current_user_id);  -- Retrieve the current user ID from a session variable

    IF OLD.is_superuser != NEW.is_superuser THEN
        INSERT INTO audit_log (user_id, action, changes, timestamp)
        VALUES (admin_user_id, 'toggle_superuser_status', CONCAT('Changed superuser status for user_id: ', NEW.id, ' from "', OLD.is_superuser, '" to "', NEW.is_superuser, '"'), NOW());
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

-- Dump completed on 2025-01-13 17:11:23
