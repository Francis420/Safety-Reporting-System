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
-- Table structure for table `notifications_notification`
--

DROP TABLE IF EXISTS `notifications_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications_notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `timestamp` datetime(6) NOT NULL,
  `read` tinyint(1) NOT NULL,
  `incident_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `message` varchar(255) NOT NULL,
  `receiver_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifi_receiver_id_b88ec508_fk_incidents` (`receiver_id`),
  KEY `idx_notification_user_id` (`user_id`),
  KEY `idx_notification_incident_id` (`incident_id`),
  CONSTRAINT `notifications_notifi_incident_id_f5d6cdb9_fk_incidents` FOREIGN KEY (`incident_id`) REFERENCES `incidents_incidentreport` (`id`),
  CONSTRAINT `notifications_notifi_receiver_id_b88ec508_fk_incidents` FOREIGN KEY (`receiver_id`) REFERENCES `incidents_incidentreport` (`id`),
  CONSTRAINT `notifications_notifi_user_id_b5e8c0ff_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications_notification`
--

LOCK TABLES `notifications_notification` WRITE;
/*!40000 ALTER TABLE `notifications_notification` DISABLE KEYS */;
INSERT INTO `notifications_notification` VALUES (40,'2025-01-11 05:01:40.691788',1,NULL,2,'New report submitted',32),(41,'2025-01-11 05:01:40.702993',0,NULL,7,'New report submitted',32),(42,'2025-01-11 05:05:39.774940',1,NULL,5,'Report hehe status updated to resolved',32),(43,'2025-01-11 05:47:57.495936',1,NULL,5,'Report hehe status updated to acknowledged',32),(44,'2025-01-11 06:44:04.028605',1,NULL,5,'Report hehe status updated to received',32),(45,'2025-01-11 06:44:18.251817',1,NULL,5,'Report hehe status updated to resolved',32),(46,'2025-01-11 06:47:26.537198',1,NULL,5,'Report hehe status updated to received',32),(50,'2025-01-12 13:04:42.929931',0,NULL,1,'New report submitted',41),(51,'2025-01-12 13:04:42.938673',1,NULL,2,'New report submitted',41),(52,'2025-01-12 13:04:42.991640',0,NULL,7,'New report submitted',41),(53,'2025-01-12 13:18:31.245014',0,NULL,1,'New report submitted',42),(54,'2025-01-12 13:18:31.252733',1,NULL,2,'New report submitted',42),(55,'2025-01-12 13:18:31.322563',0,NULL,7,'New report submitted',42),(56,'2025-01-12 14:28:58.064846',0,NULL,1,'New report submitted',32),(57,'2025-01-12 14:28:58.072315',1,NULL,2,'New report submitted',32),(58,'2025-01-12 14:28:58.128178',0,NULL,7,'New report submitted',32),(59,'2025-01-12 14:41:30.398509',1,NULL,5,'Report hehe status updated to Resolved',32),(60,'2025-01-12 14:42:52.988194',1,NULL,5,'Report hehe category changed to Unsafe Condition',32),(61,'2025-01-13 01:07:17.430744',1,NULL,5,'Report hehe category changed to Traffic Accident',32),(62,'2025-01-13 01:07:22.111335',1,NULL,5,'Report hehe status updated to Acknowledged',32),(66,'2025-01-13 02:04:18.974940',0,NULL,1,'New report submitted',44),(67,'2025-01-13 02:04:18.983084',1,NULL,2,'New report submitted',44),(68,'2025-01-13 02:04:19.039494',1,NULL,7,'New report submitted',44),(69,'2025-01-13 02:04:24.628951',0,NULL,1,'New report submitted',45),(70,'2025-01-13 02:04:24.638862',1,NULL,2,'New report submitted',45),(71,'2025-01-13 02:04:24.700561',1,NULL,7,'New report submitted',45),(72,'2025-01-13 02:04:29.739814',0,NULL,1,'New report submitted',46),(73,'2025-01-13 02:04:29.747610',1,NULL,2,'New report submitted',46),(74,'2025-01-13 02:04:29.809586',1,NULL,7,'New report submitted',46),(75,'2025-01-13 02:05:39.131262',0,NULL,1,'New report submitted',47),(76,'2025-01-13 02:05:39.139481',1,NULL,2,'New report submitted',47),(77,'2025-01-13 02:05:39.199732',1,NULL,7,'New report submitted',47),(78,'2025-01-13 02:09:48.067375',0,NULL,1,'New report submitted',48),(79,'2025-01-13 02:09:48.076003',1,NULL,2,'New report submitted',48),(80,'2025-01-13 02:09:48.129504',1,NULL,7,'New report submitted',48),(81,'2025-01-13 02:10:11.808447',0,NULL,1,'New report submitted',49),(82,'2025-01-13 02:10:11.816494',1,NULL,2,'New report submitted',49),(83,'2025-01-13 02:10:11.879653',1,NULL,7,'New report submitted',49),(84,'2025-01-13 02:21:41.389496',0,NULL,1,'New report submitted',50),(85,'2025-01-13 02:21:41.400886',1,NULL,2,'New report submitted',50),(86,'2025-01-13 02:21:41.459524',1,NULL,7,'New report submitted',50),(120,'2025-01-13 06:37:09.534154',1,NULL,2,'New report submitted',61),(121,'2025-01-13 06:37:09.591526',0,NULL,7,'New report submitted',61),(122,'2025-01-13 06:39:04.829908',1,NULL,2,'Report ffffffffff status updated to Acknowledged',61),(123,'2025-01-13 06:40:32.553290',1,NULL,2,'Report ffffffffff status updated to Resolved',61),(124,'2025-01-13 06:42:12.050470',1,NULL,2,'Report ffffffffff status updated to Acknowledged',61),(125,'2025-01-13 06:44:04.122573',1,NULL,2,'Report ffffffffff status updated to Received',61),(127,'2025-01-13 06:45:04.911508',1,NULL,2,'Report ffffffffff category changed to Traffic Accident',61),(128,'2025-01-13 06:50:17.549251',1,NULL,2,'Report ffffffffff status updated to Acknowledged',61),(129,'2025-01-13 06:50:20.402140',1,NULL,2,'Report ffffffffff category changed to Crime',61),(130,'2025-01-13 07:08:56.780074',0,NULL,2,'Report ffffffffff category changed to Traffic Accident',61),(131,'2025-01-13 07:09:21.701788',0,NULL,2,'New report submitted',62),(132,'2025-01-13 07:09:21.759924',0,NULL,7,'New report submitted',62),(133,'2025-01-13 07:10:01.122120',0,NULL,5,'Report asd category changed to Traffic Accident',62),(134,'2025-01-13 07:12:11.969513',0,NULL,5,'Report asd status updated to Received',62),(135,'2025-01-13 07:17:31.979783',0,NULL,5,'Report asd status updated to Acknowledged',62),(136,'2025-01-13 07:20:59.254346',0,NULL,5,'Report asd status updated to Received',62),(137,'2025-01-13 07:23:07.344106',0,NULL,5,'Report asd category changed to Crime',62),(139,'2025-01-13 07:38:11.558459',0,NULL,5,'Report asd status updated to Acknowledged',62),(140,'2025-01-13 07:38:18.753472',0,NULL,5,'Report asd category changed to Traffic Accident',62),(141,'2025-01-13 07:42:06.211739',0,NULL,5,'Report asd category changed to Unsafe Condition',62),(142,'2025-01-13 07:43:44.702599',0,NULL,5,'Report asd category changed to Crime',62),(143,'2025-01-13 07:49:22.941420',0,NULL,5,'Report asd status updated to Resolved',62),(147,'2025-01-13 07:59:41.498345',0,NULL,5,'Report asd status updated to Acknowledged',62),(150,'2025-01-13 08:01:34.625502',0,NULL,5,'Report asd status updated to Resolved',62),(152,'2025-01-13 08:06:38.228820',0,NULL,5,'Report asd status updated to Acknowledged',62),(153,'2025-01-13 08:55:14.779353',0,NULL,5,'Report asd status updated to Resolved',62),(154,'2025-01-13 08:55:19.058624',0,NULL,5,'Report asd category changed to Traffic Accident',62);
/*!40000 ALTER TABLE `notifications_notification` ENABLE KEYS */;
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
