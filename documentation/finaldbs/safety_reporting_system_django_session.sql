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
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('1ztsp1i6m3vblkephiv1pmi44jibkxb1','.eJxVjEEOwiAQRe_C2hCg0AGX7j0DmQ6DVA0kpV0Z765NutDtf-_9l4i4rSVunZc4J3EWRpx-twnpwXUH6Y711iS1ui7zJHdFHrTLa0v8vBzu30HBXr41OacnwxmMB2ADlrwnwwmGMZtEwYWsbUBmnVMGhQgOrKIwZFSjCyjeH-mrOB4:1tXGGg:Q-71WZX_rUzp-hoXMxzBtuRs6Y9BiugBCxpYvNmmZ9k','2025-01-27 08:57:54.205696'),('5id21uniplr7uyd6iln2unbg2yvb6fi7','.eJxVjDsOwjAQRO_iGln-xhYlPWewdr0LDiBbipMKcXccKQVUI715M2-RYFtL2jovaSZxFkacfhlCfnLdC3pAvTeZW12XGeWuyKPt8tqIX5fD_Tso0MtY35wF9ooxuxGkddDKRGd5wmg9cBzAQpg8hGy0IsoIXkdUDsiScuLzBds6N6c:1tHxT4:Oa2FzgcpKG6KVs8Vj_3VeHzrOJhSj_8MEDZtnq-vBeQ','2024-12-16 03:51:26.954661'),('7ktr4l04kuc00492mxzbe53uhar1fyom','e30:1tXECt:qWDwiGqet0JP1IIqfDeOi68LcFZ7LeIKMVsqQZyvX70','2025-01-27 06:45:51.880140'),('8tof636ch7zxr3r20cy5flzfupf74imj','.eJxVjDsOwjAQRO_iGln-xhYlPWewdr0LDiBbipMKcXccKQVUI715M2-RYFtL2jovaSZxFkacfhlCfnLdC3pAvTeZW12XGeWuyKPt8tqIX5fD_Tso0MtY35wF9ooxuxGkddDKRGd5wmg9cBzAQpg8hGy0IsoIXkdUDsiScuLzBds6N6c:1tJOc7:IQVt-amDM3M2yEgkD-upT60MXRRFkbG_MS0xHTNVi1E','2024-12-20 03:02:43.562613'),('gbeugsy3ha3r23939d122393pavto5np','e30:1tJOQv:FXHXQH5Epv21xKz9QSEXk7ts6XxwapGKFjPXkio_-bI','2024-12-20 02:51:09.548168'),('huzal62a5j1d07su3ohim1lk4qviqu1a','.eJxVjEEOwiAQRe_C2hCg0AGX7j0DmQ6DVA0kpV0Z765NutDtf-_9l4i4rSVunZc4J3EWRpx-twnpwXUH6Y711iS1ui7zJHdFHrTLa0v8vBzu30HBXr41OacnwxmMB2ADlrwnwwmGMZtEwYWsbUBmnVMGhQgOrKIwZFSjCyjeH-mrOB4:1tTYqy:24zelIlRJY0f1J7Rt-mFmj9851FRa1-o7-F0XB-TldY','2025-01-17 04:00:04.028051'),('hys74n2rges6uxspmagqcz2d4ua9c0j5','.eJxVjDsOwjAQRO_iGln-xhYlPWewdr0LDiBbipMKcXccKQVUI715M2-RYFtL2jovaSZxFkacfhlCfnLdC3pAvTeZW12XGeWuyKPt8tqIX5fD_Tso0MtY35wF9ooxuxGkddDKRGd5wmg9cBzAQpg8hGy0IsoIXkdUDsiScuLzBds6N6c:1tKAtu:AMOLo4QlqHm-9vYoJui6fFZHx90t6gxTSJcm3qNc-zs','2024-12-22 06:36:18.526999'),('mqf9sy59lnskjdhd0y3krjbfx9mpqqzy','.eJxVjDsOwjAQRO_iGln-xhYlPWewdr0LDiBbipMKcXccKQVUI715M2-RYFtL2jovaSZxFkacfhlCfnLdC3pAvTeZW12XGeWuyKPt8tqIX5fD_Tso0MtY35wF9ooxuxGkddDKRGd5wmg9cBzAQpg8hGy0IsoIXkdUDsiScuLzBds6N6c:1tJ5es:QKGTUqGf_yfpqcCg5E0qZgbPEbBQJuDLZRtjmXvfDS0','2024-12-19 06:48:18.487191'),('mqv2435o7zb8ap4a6vs95qzhplfjk14m','e30:1tXEZS:NoDbL1jsPZ-0JSaTiFUouHznHOM6Q3n-bl_v2oNlGss','2025-01-27 07:09:10.708867'),('pnaa1rm87vjhrkgmo6r118ypwrnvhkco','.eJxVjEEOwiAQRe_C2hCg0AGX7j0DmQ6DVA0kpV0Z765NutDtf-_9l4i4rSVunZc4J3EWRpx-twnpwXUH6Y711iS1ui7zJHdFHrTLa0v8vBzu30HBXr41OacnwxmMB2ADlrwnwwmGMZtEwYWsbUBmnVMGhQgOrKIwZFSjCyjeH-mrOB4:1tNjz2:_F-xrexGAGEkdLTfF8OxcORXTCPDlZPKUyxU5uGZrPM','2025-01-01 02:40:20.313010'),('vpdvt0qr35xd5xtujl3rzr08mm3uqtpg','.eJxVjDsOwjAQRO_iGln-xhYlPWewdr0LDiBbipMKcXccKQVUI715M2-RYFtL2jovaSZxFkacfhlCfnLdC3pAvTeZW12XGeWuyKPt8tqIX5fD_Tso0MtY35wF9ooxuxGkddDKRGd5wmg9cBzAQpg8hGy0IsoIXkdUDsiScuLzBds6N6c:1tK8n9:vGpThaDgmqtRYGZCsCqE9yKdhKsE9ceXUBtLFsLtsPc','2024-12-22 04:21:11.241033'),('zxzpdzx5bjf0yowt9kiph9j8mk6dtns3','.eJxVjDsOwjAQRO_iGln-xhYlPWewdr0LDiBbipMKcXccKQVUI715M2-RYFtL2jovaSZxFkacfhlCfnLdC3pAvTeZW12XGeWuyKPt8tqIX5fD_Tso0MtY35wF9ooxuxGkddDKRGd5wmg9cBzAQpg8hGy0IsoIXkdUDsiScuLzBds6N6c:1tKwVv:qnKpTwIC5ipFcZlH-Q0dWVqwIEajk3Ah3apoIRBrhvk','2024-12-24 09:26:43.961430');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-13 17:11:24
