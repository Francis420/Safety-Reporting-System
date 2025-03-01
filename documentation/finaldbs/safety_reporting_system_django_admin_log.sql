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
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_accounts_customuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_accounts_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_customuser` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-11-22 03:21:52.025430','3','admin2',1,'[{\"added\": {}}]',6,2),(2,'2024-11-22 03:22:55.207697','3','admin2',3,'',6,2),(3,'2024-11-22 03:23:11.874257','2','admin1',2,'[{\"changed\": {\"fields\": [\"Groups\", \"First name\", \"Last name\", \"Address\", \"Phone number\", \"Is admin\"]}}]',6,2),(4,'2024-12-18 01:32:37.065972','1','admin',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',6,5),(5,'2024-12-18 01:33:05.088348','2','admin1',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',6,5),(6,'2024-12-18 01:40:43.228994','4','dodo',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',6,5),(7,'2024-12-18 01:40:54.162559','5','admin2',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',6,5),(8,'2024-12-18 01:43:48.338510','5','admin2',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',6,6),(9,'2024-12-18 01:43:53.644762','4','dodo',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',6,6),(10,'2024-12-18 01:43:58.818605','2','admin1',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',6,6),(11,'2024-12-18 01:44:04.742066','1','admin',2,'[{\"changed\": {\"fields\": [\"Password\"]}}]',6,6),(12,'2025-01-11 01:59:45.877951','2','admin1',2,'[{\"changed\": {\"fields\": [\"Active\"]}}]',6,7),(13,'2025-01-11 01:59:57.996561','1','admin',2,'[{\"changed\": {\"fields\": [\"Staff status\"]}}]',6,7),(14,'2025-01-11 02:00:09.616338','1','admin',2,'[{\"changed\": {\"fields\": [\"Superuser status\", \"Groups\"]}}]',6,7),(15,'2025-01-13 04:15:04.341584','7','admin69',2,'[{\"changed\": {\"fields\": [\"Superuser status\"]}}]',6,2),(16,'2025-01-13 04:15:12.835279','6','admin4',2,'[{\"changed\": {\"fields\": [\"Superuser status\"]}}]',6,2),(17,'2025-01-13 04:15:25.228462','5','admin2',2,'[{\"changed\": {\"fields\": [\"Superuser status\"]}}]',6,2);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-13 17:11:22
