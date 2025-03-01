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
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-11-21 08:52:56.629495'),(2,'contenttypes','0002_remove_content_type_name','2024-11-21 08:52:56.700952'),(3,'auth','0001_initial','2024-11-21 08:52:57.215958'),(4,'auth','0002_alter_permission_name_max_length','2024-11-21 08:52:57.293847'),(5,'auth','0003_alter_user_email_max_length','2024-11-21 08:52:57.306228'),(6,'auth','0004_alter_user_username_opts','2024-11-21 08:52:57.315219'),(7,'auth','0005_alter_user_last_login_null','2024-11-21 08:52:57.322882'),(8,'auth','0006_require_contenttypes_0002','2024-11-21 08:52:57.326869'),(9,'auth','0007_alter_validators_add_error_messages','2024-11-21 08:52:57.336324'),(10,'auth','0008_alter_user_username_max_length','2024-11-21 08:52:57.344123'),(11,'auth','0009_alter_user_last_name_max_length','2024-11-21 08:52:57.351955'),(12,'auth','0010_alter_group_name_max_length','2024-11-21 08:52:57.370852'),(13,'auth','0011_update_proxy_permissions','2024-11-21 08:52:57.380414'),(14,'auth','0012_alter_user_first_name_max_length','2024-11-21 08:52:57.389256'),(15,'accounts','0001_initial','2024-11-21 08:52:57.774113'),(16,'admin','0001_initial','2024-11-21 08:52:57.936749'),(17,'admin','0002_logentry_remove_auto_add','2024-11-21 08:52:57.947259'),(18,'admin','0003_logentry_add_action_flag_choices','2024-11-21 08:52:57.957992'),(19,'audit_trail','0001_initial','2024-11-21 08:52:58.053369'),(20,'feedback','0001_initial','2024-11-21 08:52:58.148181'),(21,'incidents','0001_initial','2024-11-21 08:52:58.244211'),(22,'sessions','0001_initial','2024-11-21 08:52:58.287762'),(23,'admin_panel','0001_initial','2024-11-21 09:14:41.567094'),(24,'admin_panel','0002_alter_incidentreport_user','2024-11-21 09:31:07.928510'),(25,'incidents','0002_incidentreport_delete_incident','2024-11-21 09:31:08.067987'),(26,'audit_trail','0002_auditlog_details_alter_auditlog_user','2024-11-21 10:22:07.562994'),(27,'feedback','0002_rename_feedback_userfeedback','2024-11-21 10:22:07.614473'),(28,'notifications','0001_initial','2024-11-21 11:03:27.887620'),(29,'accounts','0002_customuser_is_admin','2024-11-22 03:07:17.513941'),(30,'admin_panel','0003_alter_incidentreport_status','2024-12-03 01:17:35.938836'),(31,'admin_panel','0004_alter_incidentreport_status','2024-12-03 01:20:09.484767'),(32,'incidents','0003_alter_incidentreport_status','2024-12-03 01:21:24.961071'),(33,'admin_panel','0005_delete_incidentreport','2024-12-03 01:31:21.474714'),(34,'accounts','0003_customuser_display_name','2024-12-05 08:21:15.113428'),(35,'notifications','0002_rename_incident_notification_target_and_more','2024-12-06 01:43:48.978017'),(36,'feedback','0003_rename_userfeedback_feedback_and_more','2024-12-18 00:59:00.527001'),(37,'notifications','0003_rename_verb_notification_message','2025-01-10 10:50:44.691343'),(38,'notifications','0004_rename_target_notification_incident','2025-01-10 11:03:58.636001'),(39,'feedback','0004_rename_feedback_text_feedback_feedback_message','2025-01-10 11:07:17.649342'),(40,'notifications','0005_rename_recipient_notification_user','2025-01-10 11:23:03.520204'),(41,'notifications','0006_rename_user_notification_recipient','2025-01-10 23:40:22.150624'),(42,'notifications','0007_rename_recipient_notification_user','2025-01-10 23:52:54.696090'),(43,'notifications','0008_notification_target','2025-01-11 00:19:59.407544'),(44,'accounts','0004_customuser_remarks','2025-01-11 01:53:13.016744'),(45,'notifications','0009_rename_target_notification_receiver','2025-01-11 04:59:05.341297'),(46,'incidents','0004_alter_incidentreport_category_and_more','2025-01-12 05:21:18.510055'),(47,'incidents','0005_alter_incidentreport_status','2025-01-12 05:25:05.696099');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
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
