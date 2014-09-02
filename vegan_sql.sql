-- MySQL dump 10.13  Distrib 5.5.38, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: vegan_development
-- ------------------------------------------------------
-- Server version	5.5.38-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `augury_environments`
--

DROP TABLE IF EXISTS `augury_environments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `augury_environments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `store_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `environment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `store_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `augury_environments`
--

LOCK TABLES `augury_environments` WRITE;
/*!40000 ALTER TABLE `augury_environments` DISABLE KEYS */;
/*!40000 ALTER TABLE `augury_environments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banner_images`
--

DROP TABLE IF EXISTS `banner_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banner_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `image_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner_images`
--

LOCK TABLES `banner_images` WRITE;
/*!40000 ALTER TABLE `banner_images` DISABLE KEYS */;
INSERT INTO `banner_images` VALUES (1,1,'2014-08-06 10:29:59','2014-08-06 10:29:59','images.jpeg','image/jpeg',14572,'2014-08-06 10:29:59'),(2,1,'2014-08-06 10:31:10','2014-08-06 10:31:10','index.jpeg','image/jpeg',9400,'2014-08-06 10:31:10'),(3,2,'2014-08-21 10:47:19','2014-08-21 10:47:19','snacks-19a.jpg','image/jpeg',139240,'2014-08-21 10:47:19'),(4,3,'2014-08-21 10:47:40','2014-08-21 10:47:40','index.jpeg','image/jpeg',9400,'2014-08-21 10:47:40'),(5,4,'2014-08-21 10:51:53','2014-08-21 10:51:53',NULL,NULL,NULL,NULL),(6,5,'2014-08-28 09:51:31','2014-08-28 09:51:31',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `banner_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT '0',
  `cart_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
INSERT INTO `cart_items` VALUES (1,NULL,1,1,1,'2014-08-06 10:02:57','2014-08-06 10:02:57'),(2,NULL,2,1,1,'2014-08-06 10:03:11','2014-08-06 10:03:11'),(3,NULL,3,1,1,'2014-08-06 10:03:14','2014-08-06 10:03:14'),(4,NULL,4,1,1,'2014-08-06 10:03:15','2014-08-06 10:03:15'),(5,NULL,5,1,1,'2014-08-06 10:03:16','2014-08-06 10:03:16');
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `subscription_id` int(11) DEFAULT NULL,
  `is_current` tinyint(1) DEFAULT '1',
  `delivery_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES (1,2,1,1,'2014-08-16 10:02:42');
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ckeditor_assets`
--

DROP TABLE IF EXISTS `ckeditor_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ckeditor_assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data_file_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `data_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_file_size` int(11) DEFAULT NULL,
  `assetable_id` int(11) DEFAULT NULL,
  `assetable_type` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ckeditor_assetable_type` (`assetable_type`,`type`,`assetable_id`),
  KEY `idx_ckeditor_assetable` (`assetable_type`,`assetable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ckeditor_assets`
--

LOCK TABLES `ckeditor_assets` WRITE;
/*!40000 ALTER TABLE `ckeditor_assets` DISABLE KEYS */;
INSERT INTO `ckeditor_assets` VALUES (2,'img1-snack.jpg','image/jpeg',40134,1,'Spree::User','Ckeditor::Picture',450,300,'2014-08-22 04:15:32','2014-08-22 04:15:32');
/*!40000 ALTER TABLE `ckeditor_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commenter` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment_body` text COLLATE utf8_unicode_ci,
  `comment_notification` tinyint(1) DEFAULT NULL,
  `post_notification` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,'dsafsdafds','fasdfasdf','asdfasdfasdf','sdfasdfasdfasdfasfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasfasdfasdfasd',0,0,'2014-08-21 10:31:24','2014-08-21 10:31:24',1);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coupons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `discount_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `braintree_discount_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `discount_rate` decimal(8,2) DEFAULT NULL,
  `counter` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (1,'cou123','asdfasfasdf','10_dollar_off',10.00,0,'2014-08-06 10:33:56','2014-08-06 10:33:56',0);
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creditcards`
--

DROP TABLE IF EXISTS `creditcards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creditcards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `cc_part_1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cc_part_2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cc_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cc_holder_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expiration_month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expiration_year` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_expiring` tinyint(1) DEFAULT '0',
  `is_expired` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creditcards`
--

LOCK TABLES `creditcards` WRITE;
/*!40000 ALTER TABLE `creditcards` DISABLE KEYS */;
/*!40000 ALTER TABLE `creditcards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `post_image_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `post_image_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `post_image_file_size` int(11) DEFAULT NULL,
  `post_image_updated_at` datetime DEFAULT NULL,
  `summary` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'fasdfasdfasd','fasdfasdfasdfasdfasdfasdfasdfadsf\r\n','2014-08-06 10:29:59','2014-08-06 10:29:59',NULL,NULL,NULL,NULL,NULL),(2,'sdaflk;jfkl;sdajflkjasd','<p>fasdfasdfasdfasdfsadfdsafasdfasdfasdfasdfasdfasdfadsfasdfasdfasdfsadlkjxcklvnjpajnfgalkjsdhvasdfofhgopaigjl;kasdhgpoiarjgm,xcbnvpoasnv;jhasdf</p>\r\n\r\n<p>fasdfasdfasdfasdfsadfdsafasdfasdfasdfasdfasdfasdfadsfasdfasdfasdfsadlkjxcklvnjpajnfgalkjsdhvasdfofhgopaigjl;kasdhgpoiarjgm,xcbnvpoasnv;jhasdf</p>\r\n\r\n<p>fasdfasdfasdfasdfsadfdsafasdfasdfasdfasdfasdfasdfadsfasdfasdfasdfsadlkjxcklvnjpajnfgalkjsdhvasdfofhgopaigjl;kasdhgpoiarjgm,xcbnvpoasnv;jhasdf</p>\r\n\r\n<p>fasdfasdfasdfasdfsadfdsafasdfasdfasdfasdfasdfasdfadsfasdfasdfasdfsadlkjxcklvnjpajnfgalkjsdhvasdfofhgopaigjl;kasdhgpoiarjgm,xcbnvpoasnv;jhasdf</p>\r\n\r\n<p>fasdfasdfasdfasdfsadfdsafasdfasdfasdfasdfasdfasdfadsfasdfasdfasdfsadlkjxcklvnjpajnfgalkjsdhvasdfofhgopaigjl;kasdhgpoiarjgm,xcbnvpoasnv;jhasdffasdfasdfasdfasdfsadfdsafasdfasdfasdfasdfasdfasdfadsfasdfasdfasdfsadlkjxcklvnjpajnfgalkjsdhvasdfofhgopaigjl;kasdhgpoiarjgm,xcbnvpoasnv;jhasdffasdfasdfasdfasdfsadfdsafasdfasdfasdfasdfasdfasdfadsfasdfasdfasdfsadlkjxcklvnjpajnfgalkjsdhvasdfofhgopaigjl;kasdhgpoiarjgm,xcbnvpoasnv;jhasdf</p>\r\n\r\n<p>&nbsp;</p>\r\n','2014-08-21 10:47:19','2014-08-21 10:47:19',NULL,NULL,NULL,NULL,NULL),(3,'asdfasdf','<p>fasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdffasdfasdfasdfasdfasdf</p>\r\n','2014-08-21 10:47:40','2014-08-21 10:47:40',NULL,NULL,NULL,NULL,NULL),(4,'ffgsfdgsfdg','<p><img alt=\"\" src=\"/ckeditor_assets/pictures/1/content_index.jpeg\" style=\"height:194px; width:259px\" /></p>\r\n','2014-08-21 10:51:53','2014-08-21 10:51:53','content_index.jpeg','image/jpeg',10895,'2014-08-21 10:51:51',NULL),(5,'fasdfasdfas','<p><img alt=\"\" src=\"/ckeditor_assets/pictures/2/content_img1-snack.jpg\" style=\"height:300px; width:450px\" />sdfadsfasdfasdfasdfasdfasdfasdfasdvfasdfasdfasdfasdfasdf</p>\r\n','2014-08-28 09:51:31','2014-08-28 09:51:31','content_img1-snack.jpg','image/jpeg',43366,'2014-08-28 09:51:29',NULL);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts_tags`
--

DROP TABLE IF EXISTS `posts_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts_tags`
--

LOCK TABLES `posts_tags` WRITE;
/*!40000 ALTER TABLE `posts_tags` DISABLE KEYS */;
INSERT INTO `posts_tags` VALUES (1,1,1);
/*!40000 ALTER TABLE `posts_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20140123062623'),('20140123062624'),('20140123062625'),('20140123062626'),('20140123062627'),('20140123062628'),('20140123062629'),('20140123062630'),('20140123062631'),('20140123062632'),('20140123062633'),('20140123062634'),('20140123062635'),('20140123062636'),('20140123062637'),('20140123062638'),('20140123062639'),('20140123062640'),('20140123062641'),('20140123062642'),('20140123062643'),('20140123062644'),('20140123062645'),('20140123062646'),('20140123062647'),('20140123062648'),('20140123062649'),('20140123062650'),('20140123062651'),('20140123062652'),('20140123062653'),('20140123062654'),('20140123062655'),('20140123062656'),('20140123062657'),('20140123062658'),('20140123062659'),('20140123062660'),('20140123062661'),('20140123062662'),('20140123062663'),('20140123062664'),('20140123062665'),('20140123062666'),('20140123062667'),('20140123062668'),('20140123062669'),('20140123062670'),('20140123062671'),('20140123062672'),('20140123062673'),('20140123062674'),('20140123062675'),('20140123062676'),('20140123062677'),('20140123062678'),('20140123062679'),('20140123062680'),('20140123062681'),('20140123062682'),('20140123062683'),('20140123062684'),('20140123062685'),('20140123062686'),('20140123062687'),('20140123062688'),('20140123062689'),('20140123062690'),('20140123062691'),('20140123062692'),('20140123062693'),('20140123062694'),('20140123062695'),('20140123062696'),('20140123062697'),('20140123062698'),('20140123062699'),('20140123062700'),('20140123062701'),('20140123062702'),('20140123062703'),('20140123062704'),('20140123062705'),('20140123062706'),('20140123062707'),('20140123062708'),('20140123062709'),('20140123062710'),('20140123062711'),('20140123062712'),('20140123062713'),('20140123062714'),('20140123062715'),('20140123062716'),('20140123062717'),('20140123062718'),('20140123062719'),('20140123062720'),('20140123062721'),('20140123062722'),('20140123062723'),('20140123062724'),('20140123062725'),('20140123062726'),('20140123062727'),('20140123062728'),('20140123062729'),('20140123062730'),('20140123092145'),('20140128043843'),('20140128103933'),('20140130105151'),('20140130105152'),('20140131042531'),('20140131042532'),('20140203064936'),('20140212100850'),('20140212101045'),('20140212102426'),('20140212164659'),('20140213091844'),('20140213100506'),('20140220094742'),('20140225062212'),('20140302122123'),('20140324181317'),('20140326075421'),('20140327080425'),('20140327080426'),('20140327080427'),('20140327080428'),('20140327080429'),('20140327080430'),('20140327080431'),('20140327080432'),('20140407153142'),('20140407171139'),('20140414074218'),('20140416145547'),('20140420063759'),('20140421120813'),('20140422062243'),('20140422070736'),('20140422203435'),('20140423041554'),('20140426044147'),('20140426080826'),('20140426100830'),('20140427071534'),('20140427081919'),('20140427091850'),('20140427114855'),('20140428051902'),('20140428072016'),('20140428140937'),('20140428141921'),('20140429125757'),('20140430043620'),('20140509071426'),('20140512063733'),('20140512071340'),('20140512072024'),('20140512072228'),('20140521033536'),('20140521130829'),('20140522055350'),('20140522055610'),('20140524090652'),('20140526091749'),('20140527090937'),('20140604121145'),('20140608033701'),('20140610100849'),('20140610103143'),('20140618081846'),('20140618112014'),('20140618112045'),('20140619113325'),('20140625051148'),('20140627073942'),('20140627073958'),('20140627075037'),('20140627075123'),('20140714054030'),('20140714054137'),('20140714060341'),('20140715074912'),('20140717131653');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_sessions_on_session_id` (`session_id`),
  KEY `index_sessions_on_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,'8bb514d548b3b4c7ae6bfcefe60de16c','BAh7CUkiEF9jc3JmX3Rva2VuBjoGRUZJIjEvdU51ZWIrVmkvNmR3Y2VrV1ll\nN2ViRUNQU2VIMlpJUFRmZ0R2bGsrZ1JrPQY7AEZJIhRvbW5pYXV0aC5wYXJh\nbXMGOwBUewBJIhRvbW5pYXV0aC5vcmlnaW4GOwBUIhtodHRwOi8vbG9jYWxo\nb3N0OjMwMDEvSSITb21uaWF1dGguc3RhdGUGOwBUSSI1ZjdkMWEyNzMyMDMw\nMjQ5YjBiZmRmNTcwNTYxOTMxN2MzNDZkMGRkNjUxNGQ1NzBmBjsARg==\n','2014-08-04 10:47:32','2014-08-04 11:31:09'),(3,'357ad360b6e1ab19180d2bd7d7a7700e','BAh7BkkiH3dhcmRlbi51c2VyLnNwcmVlX3VzZXIua2V5BjoGRVRbB1sGaQZJ\nIhluamd6ZnNuNWlYOXlfemRBX1loaAY7AFQ=\n','2014-08-04 12:31:58','2014-08-04 12:31:58'),(4,'079d685a6b37b41ec0e2375331aa49f8','BAh7CUkiEF9jc3JmX3Rva2VuBjoGRUZJIjF0V2RKVUJUUWFsRG52Zk42bEor\nMDBjQzl5NHJtNXVJY1VVcXBWVjYwL240PQY7AEZJIhRvbW5pYXV0aC5wYXJh\nbXMGOwBUewBJIhRvbW5pYXV0aC5vcmlnaW4GOwBUIidodHRwOi8vbG9jYWxo\nb3N0OjMwMDAvc3ByZWUvc2lnbnVwSSITb21uaWF1dGguc3RhdGUGOwBUSSI1\nYzA5OWYxMjI4MzkwNmNhMzY1NmM1NWE0ZDIyMTE0MDQxM2M3ZDZkODMwYmUy\nOTY4BjsARg==\n','2014-08-05 05:14:59','2014-08-05 05:41:44'),(20,'93ddae8b4ac882851e9fd75d73959d83','BAh7CEkiH3dhcmRlbi51c2VyLnNwcmVlX3VzZXIua2V5BjoGRVRbB1sGaQZJ\nIhluamd6ZnNuNWlYOXlfemRBX1loaAY7AFRJIhBfY3NyZl90b2tlbgY7AEZJ\nIjE4SjdFR3kwcmxCRDF2bWZNbFdDMkw4djBBcDlMaHVzNUxadjRocGdEOGxR\nPQY7AEZJIg5yZXR1cm5fdG8GOwBGSSIvaHR0cDovL2xvY2FsaG9zdDozMDAw\nL3NwcmVlL2FkbWluL3Byb2R1Y3RzBjsAVA==\n','2014-08-06 10:24:34','2014-08-06 10:35:31'),(21,'fd88a16f0a928eda8b2f8759d7926916','BAh7B0kiCmZsYXNoBjoGRVR7B0kiDGRpc2NhcmQGOwBUWwBJIgxmbGFzaGVz\nBjsAVHsGOgtub3RpY2VJIh1TaWduZWQgb3V0IHN1Y2Nlc3NmdWxseS4GOwBU\nSSIQX2NzcmZfdG9rZW4GOwBGSSIxSG9HKzRtS0lFazNqcnFVOEMxTzhxUWIv\nUmVGSXIvUUdLWWxrTmZUNjZCVT0GOwBG\n','2014-08-06 10:39:07','2014-08-06 10:39:07'),(22,'72d69d9425434a4d2c3a641c0e448b03','BAh7CUkiEF9jc3JmX3Rva2VuBjoGRUZJIjFvbU9McDdQOWRJZFg1Vks1S3g0\nWDdPM2JhdTJmVXZUcitQbXRldFNBYVBNPQY7AEZJIhRvbW5pYXV0aC5wYXJh\nbXMGOwBUewBJIhRvbW5pYXV0aC5vcmlnaW4GOwBUIhtodHRwOi8vbG9jYWxo\nb3N0OjMwMDAvSSITb21uaWF1dGguc3RhdGUGOwBUSSI1OTljOWU5YzIzZjkx\nOGQ2NDZmZGM5MTEyMzRmMzk5NzcwOTFlOTA3OTIyNmY2YzlhBjsARg==\n','2014-08-07 04:35:04','2014-08-07 04:57:30'),(23,'f1f7443fa0ef8ea2b1ca15ea5b2b04af','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE2NHNHajkzaDF4VDdyV3BtVFA0\nN0doRGROaEk5eWNZb3Y3REw4dFZhdnJ3PQY7AEY=\n','2014-08-07 10:58:43','2014-08-07 10:58:43'),(24,'8ae84eaf4a37617097c1da34cdb467a3','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFsSTk3V0RQRGlWdHNzTFhwa0Vz\na0M3TWhXKytoUVgrelQrY2xCZFR6M0Y4PQY7AEY=\n','2014-08-07 10:59:22','2014-08-07 10:59:22'),(25,'9b8d1717784c00efd80f2ddb5df38997','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFDcjVOa04wMkFwcFJ1QThVTW5M\nMndZeDJsaG5JOElGdWtENVdyQ25WdHZrPQY7AEY=\n','2014-08-08 09:59:50','2014-08-08 09:59:50'),(30,'6c1e778e25792024ea33a32cc2529d92','BAh7CEkiH3dhcmRlbi51c2VyLnNwcmVlX3VzZXIua2V5BjoGRVRbB1sGaQZJ\nIhlFdWp2WDlVRjF5U1VUcEp5czJvUgY7AFRJIhBfY3NyZl90b2tlbgY7AEZJ\nIjFReTlERlB4bWJsRDVKdE94cnhrRW9wWHVWaHcvL3BCK2JSa1QwV1hNN08w\nPQY7AEZJIg5yZXR1cm5fdG8GOwBGSSIvaHR0cDovL2xvY2FsaG9zdDozMDAw\nL3NwcmVlL2FkbWluL3Byb2R1Y3RzBjsAVA==\n','2014-08-21 10:46:06','2014-08-21 10:46:33'),(31,'4678212788911b4b58410d7f5ac8dd6b','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFpOHFka21RTVViMEYyMUsrUWVV\nVGNjVUhFYnp5TzJsUGtESXBmZ2k5NVNvPQY7AEY=\n','2014-08-21 12:11:28','2014-08-21 12:11:28'),(32,'80713213bbe438047b531c75591e1ea5','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFocWxPejMyYUY0MFFMZU5XTStG\nNUtVSlRJWS8wUVFWb3dVVll1M2RJVEtjPQY7AEY=\n','2014-08-21 12:26:57','2014-08-21 12:26:57'),(34,'aa72da729c30feded47b4ba50dd59840','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFPVWNpQUNMMjIyR1haWVBDcEtB\ncVFqMytjbXpWdGx1WE14clMweDZHN3lBPQY7AEY=\n','2014-08-22 04:05:20','2014-08-22 04:05:20'),(35,'54f60545c0de0b5d9e054f884c004a1b','BAh7CEkiCmZsYXNoBjoGRVR7B0kiDGRpc2NhcmQGOwBUWwBJIgxmbGFzaGVz\nBjsAVHsGOgphbGVydEkiNllvdSBuZWVkIHRvIHNpZ24gaW4gb3Igc2lnbiB1\ncCBiZWZvcmUgY29udGludWluZy4GOwBUSSIQX2NzcmZfdG9rZW4GOwBGSSIx\nd0p3N0NyZHNmZ0pYRXJxREpVS1AyTjN0STNXSHZSWU45eVJKQ2Z6N2pRST0G\nOwBGSSIZc3ByZWVfdXNlcl9yZXR1cm5fdG8GOwBGIhIvc25hY2tfZGV0YWls\n','2014-08-22 05:20:53','2014-08-22 05:37:55'),(36,'d7b3aa07b30dd4e26420570ea30b51c0','BAh7B0kiEF9jc3JmX3Rva2VuBjoGRUZJIjFjWFBDT2ZmMnJKOVlvM2JOZXJ1\nSU5uSGFTOFByd05BbkpjaDZ2ZFRuNGtJPQY7AEZJIhhyZWdpc3RyYXRpb25f\ncGFyYW1zBjsARnsA\n','2014-08-25 05:29:53','2014-08-25 11:07:58'),(37,'3082d4b2dc3a12b03f787dce96354031','BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFyZUFTN3ZuTy9vOENzOWFTanhU\na1A1VGtqQ1FFWTBRd3htWW5xTFJBMHBnPQY7AEZJIhhyZWdpc3RyYXRpb25f\ncGFyYW1zBjsARnsRSSIPZmlyc3RfbmFtZQY7AFRJIgpzdW5pbAY7AFRJIg5s\nYXN0X25hbWUGOwBUSSIKa3VtYXIGOwBUSSIKZW1haWwGOwBUSSIUc3VuaWxA\ndHJpZ21hLmluBjsAVEkiDXBhc3N3b3JkBjsAVEkiDXBhc3N3b3JkBjsAVEki\nGnBhc3N3b3JkX2NvbmZpcm1hdGlvbgY7AFRJIg1wYXNzd29yZAY7AFRJIhNh\nZGRyZXNzX2xpbmVfMQY7AFRJIhRhZGRyZXNzc2FkYXNkc2QGOwBUSSIJY2l0\neQY7AFRJIg9jaGFuZGlnYXJoBjsAVEkiCnN0YXRlBjsAVEkiD2NoYW5kaWdh\ncmgGOwBUSSIOdGVsZXBob25lBjsAVEkiDzc2ODU2OTQ0NTYGOwBUSSIMemlw\nY29kZQY7AFRJIgsxNjAwNDcGOwBUSSIbY3JlZGl0Y2FyZHNfYXR0cmlidXRl\ncwY7AFRDOi1BY3RpdmVTdXBwb3J0OjpIYXNoV2l0aEluZGlmZmVyZW50QWNj\nZXNzewdJIgYwBjsAVEM7BnsKSSIUY2FyZGhvbGRlcl9uYW1lBjsAVEkiCnN1\nbmlsBjsAVEkiDGNhcmRfbm8GOwBUSSIXNDI0MjQyNDI0MjQyNDI0MjQyBjsA\nVEkiCGN2dgY7AFRJIgAGOwBUSSIKbW9udGgGOwBUSSIGMgY7AFRJIgl5ZWFy\nBjsAVEkiCTIwMTUGOwBUSSIGMQY7AFRDOwZ7CkkiFGNhcmRob2xkZXJfbmFt\nZQY7AFRJIgAGOwBUSSIMY2FyZF9ubwY7AFRJIgAGOwBUSSIIY3Z2BjsAVEki\nAAY7AFRJIgptb250aAY7AFRJIgAGOwBUSSIJeWVhcgY7AFRJIgAGOwBUSSIZ\nYWRkcmVzc2VzX2F0dHJpYnV0ZXMGOwBUQzsGewdJIgYwBjsAVEM7BnsNSSIO\nZmlyc3RuYW1lBjsAVEkiCXNmZHMGOwBUSSINbGFzdG5hbWUGOwBUSSIMZGZz\nZGZkcwY7AFRJIg1hZGRyZXNzMQY7AFRJIgtmZGZkc2YGOwBUSSINYWRkcmVz\nczIGOwBUSSIKZGZzZGYGOwBUSSIJY2l0eQY7AFRJIg1kc2Zkc2ZzZAY7AFRJ\nIg9zdGF0ZV9uYW1lBjsAVEkiC2RzZnNkZgY7AFRJIgx6aXBjb2RlBjsAVEki\nCzE2MDA1NAY7AFRJIgpwaG9uZQY7AFRJIg80NTY3ODkxMjMwBjsAVEkiBjEG\nOwBUQzsGew1JIg5maXJzdG5hbWUGOwBUSSIABjsAVEkiDWxhc3RuYW1lBjsA\nVEkiAAY7AFRJIg1hZGRyZXNzMQY7AFRJIgAGOwBUSSINYWRkcmVzczIGOwBU\nSSIABjsAVEkiCWNpdHkGOwBUSSIABjsAVEkiD3N0YXRlX25hbWUGOwBUSSIA\nBjsAVEkiDHppcGNvZGUGOwBUSSIABjsAVEkiCnBob25lBjsAVEkiAAY7AFRJ\nIhZyZWdpc3RyYXRpb25fc3RlcAY7AEZJIgxiaWxsaW5nBjsAVA==\n','2014-08-26 05:08:17','2014-08-26 09:30:39'),(38,'6aa258c6dc694a7e51a1ce2368e4bd6f','BAh7B0kiGHJlZ2lzdHJhdGlvbl9wYXJhbXMGOgZFRnsASSIQX2NzcmZfdG9r\nZW4GOwBGSSIxOW9odE1HMFBaQXFVdnFJYVU5bnFjbzBnNWJicjVmbWt1ZmtR\nbHNWZjhJUT0GOwBG\n','2014-08-26 07:21:13','2014-08-26 07:21:13'),(39,'0fd36e37782f4f256713301e821aacc0','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFXNko0bDgzTDZPNC9Ua1NuWXpM\naWJwWEpZb0tITGNIRWtveEl2am5wMmJRPQY7AEY=\n','2014-08-27 04:34:46','2014-08-27 04:34:46'),(41,'6cf86deac2c0e4ad8433fe6e33312829','BAh7CUkiEF9jc3JmX3Rva2VuBjoGRUZJIjEyZFRUMWxqTGtjcG5Ka3FHTU1D\nNmthMzM5ZW53Z2JSKzY2dDB3VmNRZy9rPQY7AEZJIhRvbW5pYXV0aC5wYXJh\nbXMGOwBUewBJIhRvbW5pYXV0aC5vcmlnaW4GOwBUIhtodHRwOi8vMTI3LjAu\nMC4xOjMwMDAvSSITb21uaWF1dGguc3RhdGUGOwBUSSI1ZWViNGYwODU4OTkz\nMTAxNzIyODk1ZjQ5ZmIzZmI2ZjU2ZWEzNjhiMWNlODQyNTMwBjsARg==\n','2014-08-27 06:40:44','2014-08-27 09:12:43'),(42,'8586028ef0491aafc2653f1359b1762b','BAh7CkkiFG9tbmlhdXRoLnBhcmFtcwY6BkVUewBJIhRvbW5pYXV0aC5vcmln\naW4GOwBUIhtodHRwOi8vbG9jYWxob3N0OjMwMDAvSSITb21uaWF1dGguc3Rh\ndGUGOwBUSSI1Y2VjNTE0NWM1OTE5ZmQzMTYxMGVkN2Y2ZjQwNWMwMDM3YTVi\nNGY4MGFmNGM0ZjZmBjsARkkiH3dhcmRlbi51c2VyLnNwcmVlX3VzZXIua2V5\nBjsAVFsHWwZpBkkiGUV1anZYOVVGMXlTVVRwSnlzMm9SBjsAVEkiEF9jc3Jm\nX3Rva2VuBjsARkkiMVhKRDVvMndwTXFRUkN4cFdpaXZIR24zeXlQSzhZN0gv\nVkI1cFBDelZ3bWM9BjsARg==\n','2014-08-27 11:42:00','2014-08-27 11:42:01'),(45,'fcabb0c27a31f2ce6b9ee2d0538395a7','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFyazhwVmRxZ1F6TEd4enBtdnhN\nT1lzV3dCZW1JeFc3cE1QUTBNTFl4dlA4PQY7AEY=\n','2014-08-28 04:29:35','2014-08-28 04:29:35'),(49,'8f26337dfd14d58af135b6772e4a44c4','BAh7CkkiCmZsYXNoBjoGRVR7B0kiDGRpc2NhcmQGOwBUWwBJIgxmbGFzaGVz\nBjsAVHsGOgtub3RpY2VJIh1TaWduZWQgb3V0IHN1Y2Nlc3NmdWxseS4GOwBU\nSSIQX2NzcmZfdG9rZW4GOwBGSSIxRnVEZjlXTUFRY0xiOVZxOUxsckxlc284\neWkvakRUU1hoays1U3o1TndaWT0GOwBGSSIUb21uaWF1dGgucGFyYW1zBjsA\nVHsASSIUb21uaWF1dGgub3JpZ2luBjsAVCIbaHR0cDovLzEyNy4wLjAuMToz\nMDAwL0kiE29tbmlhdXRoLnN0YXRlBjsAVEkiNWQxOTNkMDRjZTg0YmE1NGYy\nN2ZiNjBlM2I5Zjk2NzlhN2I0ZWZjNzI2ZWRlMWU0OQY7AEY=\n','2014-08-28 06:59:58','2014-08-28 07:00:06'),(50,'13a11ab51134cbf00b5941b13423220f','BAh7C0kiFG9tbmlhdXRoLnBhcmFtcwY6BkVUewBJIhRvbW5pYXV0aC5vcmln\naW4GOwBUIhtodHRwOi8vbG9jYWxob3N0OjMwMDAvSSITb21uaWF1dGguc3Rh\ndGUGOwBUSSI1ZGNhNjExMjdjYTA5ZWIwNDQ1ZTg3ZWE1YWFjYWFmMzUwZjE0\nZDgyOTc5Yzg3MWM2BjsARkkiH3dhcmRlbi51c2VyLnNwcmVlX3VzZXIua2V5\nBjsAVFsHWwZpBkkiGUV1anZYOVVGMXlTVVRwSnlzMm9SBjsAVEkiEF9jc3Jm\nX3Rva2VuBjsARkkiMVZucVV6dkV3dFZCRndEc2RLMWQ5RGVGTG94cHp3MWJ4\nTjBLRzI4QVd3Nk09BjsARkkiDnJldHVybl90bwY7AEZJIi9odHRwOi8vbG9j\nYWxob3N0OjMwMDAvc3ByZWUvYWRtaW4vcHJvZHVjdHMGOwBU\n','2014-08-28 09:18:02','2014-08-28 09:18:11'),(51,'51e280cf674329de1dc8384684a2c067','BAh7B0kiCmZsYXNoBjoGRVR7B0kiDGRpc2NhcmQGOwBUWwBJIgxmbGFzaGVz\nBjsAVHsGOgtub3RpY2VJIh1TaWduZWQgb3V0IHN1Y2Nlc3NmdWxseS4GOwBU\nSSIQX2NzcmZfdG9rZW4GOwBGSSIxSi9MY3Avb0x6cUo1amFPd05ycnVwMXlt\naVpLWEVrN0c2WkhwSFM1U2R2VT0GOwBG\n','2014-08-28 09:50:20','2014-08-28 09:50:22');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_activators`
--

DROP TABLE IF EXISTS `spree_activators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_activators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `starts_at` datetime DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `usage_limit` int(11) DEFAULT NULL,
  `match_policy` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'all',
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `advertise` tinyint(1) DEFAULT '0',
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_activators`
--

LOCK TABLES `spree_activators` WRITE;
/*!40000 ALTER TABLE `spree_activators` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_activators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_addresses`
--

DROP TABLE IF EXISTS `spree_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zipcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `alternative_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `country` int(11) DEFAULT NULL,
  `address_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `is_complete` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `index_addresses_on_firstname` (`firstname`),
  KEY `index_addresses_on_lastname` (`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_addresses`
--

LOCK TABLES `spree_addresses` WRITE;
/*!40000 ALTER TABLE `spree_addresses` DISABLE KEYS */;
INSERT INTO `spree_addresses` VALUES (1,'sunil','kumar','klasdjflkasj','sdkajf;laksdjfkl;','klfjalksdjfl','160047','123456789','<null>asdf','1234567890','<null>fasdfas',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0);
/*!40000 ALTER TABLE `spree_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_adjustments`
--

DROP TABLE IF EXISTS `spree_adjustments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_adjustments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source_id` int(11) DEFAULT NULL,
  `source_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `adjustable_id` int(11) DEFAULT NULL,
  `adjustable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `originator_id` int(11) DEFAULT NULL,
  `originator_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mandatory` tinyint(1) DEFAULT NULL,
  `eligible` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `included` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_adjustments_on_order_id` (`adjustable_id`),
  KEY `index_spree_adjustments_on_order_id` (`order_id`),
  KEY `index_spree_adjustments_on_source_type_and_source_id` (`source_type`,`source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_adjustments`
--

LOCK TABLES `spree_adjustments` WRITE;
/*!40000 ALTER TABLE `spree_adjustments` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_adjustments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_assets`
--

DROP TABLE IF EXISTS `spree_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `viewable_id` int(11) DEFAULT NULL,
  `viewable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment_width` int(11) DEFAULT NULL,
  `attachment_height` int(11) DEFAULT NULL,
  `attachment_file_size` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `attachment_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(75) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment_updated_at` datetime DEFAULT NULL,
  `alt` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `index_assets_on_viewable_id` (`viewable_id`),
  KEY `index_assets_on_viewable_type_and_type` (`viewable_type`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_assets`
--

LOCK TABLES `spree_assets` WRITE;
/*!40000 ALTER TABLE `spree_assets` DISABLE KEYS */;
INSERT INTO `spree_assets` VALUES (8,8,'Spree::Variant',450,300,40134,1,'image/jpeg','img1-snack.jpg','Spree::Image','2014-08-22 04:16:06',''),(9,9,'Spree::Variant',450,300,66131,1,'image/jpeg','img2-snack.jpg','Spree::Image','2014-08-22 04:17:12',''),(10,10,'Spree::Variant',449,300,51687,1,'image/jpeg','img3-snack.jpg','Spree::Image','2014-08-22 04:18:00',''),(11,11,'Spree::Variant',450,300,46506,1,'image/jpeg','img4-snack.jpg','Spree::Image','2014-08-22 04:18:46',''),(12,12,'Spree::Variant',450,300,47161,1,'image/jpeg','img5-snack.jpg','Spree::Image','2014-08-22 04:19:54',''),(13,13,'Spree::Variant',449,300,36432,1,'image/jpeg','img6-snack.jpg','Spree::Image','2014-08-22 04:20:47','');
/*!40000 ALTER TABLE `spree_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_authentication_methods`
--

DROP TABLE IF EXISTS `spree_authentication_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_authentication_methods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `environment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `api_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `api_secret` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_authentication_methods`
--

LOCK TABLES `spree_authentication_methods` WRITE;
/*!40000 ALTER TABLE `spree_authentication_methods` DISABLE KEYS */;
INSERT INTO `spree_authentication_methods` VALUES (1,'development','facebook','452205614882129','60d54695164b6f89c5263a32a473315a',1,'2014-08-28 04:29:21','2014-08-28 06:59:37');
/*!40000 ALTER TABLE `spree_authentication_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_calculators`
--

DROP TABLE IF EXISTS `spree_calculators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_calculators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `calculable_id` int(11) DEFAULT NULL,
  `calculable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_calculators`
--

LOCK TABLES `spree_calculators` WRITE;
/*!40000 ALTER TABLE `spree_calculators` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_calculators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_configurations`
--

DROP TABLE IF EXISTS `spree_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_configurations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_spree_configurations_on_name_and_type` (`name`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_configurations`
--

LOCK TABLES `spree_configurations` WRITE;
/*!40000 ALTER TABLE `spree_configurations` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_countries`
--

DROP TABLE IF EXISTS `spree_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iso_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `iso` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `iso3` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `numcode` int(11) DEFAULT NULL,
  `states_required` tinyint(1) DEFAULT '0',
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_countries`
--

LOCK TABLES `spree_countries` WRITE;
/*!40000 ALTER TABLE `spree_countries` DISABLE KEYS */;
INSERT INTO `spree_countries` VALUES (1,'CHAD','TD','TCD','Chad',148,0,'2014-08-04 10:39:16'),(2,'FAROE ISLANDS','FO','FRO','Faroe Islands',234,0,'2014-08-04 10:39:16'),(3,'INDIA','IN','IND','India',356,1,'2014-08-04 10:39:16'),(4,'NICARAGUA','NI','NIC','Nicaragua',558,0,'2014-08-04 10:39:16'),(5,'SAINT LUCIA','LC','LCA','Saint Lucia',662,0,'2014-08-04 10:39:16'),(6,'FIJI','FJ','FJI','Fiji',242,0,'2014-08-04 10:39:17'),(7,'INDONESIA','ID','IDN','Indonesia',360,0,'2014-08-04 10:39:17'),(8,'NIGER','NE','NER','Niger',562,0,'2014-08-04 10:39:17'),(9,'SAINT PIERRE AND MIQUELON','PM','SPM','Saint Pierre and Miquelon',666,0,'2014-08-04 10:39:17'),(10,'FINLAND','FI','FIN','Finland',246,0,'2014-08-04 10:39:17'),(11,'NIGERIA','NG','NGA','Nigeria',566,1,'2014-08-04 10:39:17'),(12,'SAINT VINCENT AND THE GRENADINES','VC','VCT','Saint Vincent and the Grenadines',670,0,'2014-08-04 10:39:17'),(13,'FRANCE','FR','FRA','France',250,0,'2014-08-04 10:39:17'),(14,'IRAN, ISLAMIC REPUBLIC OF','IR','IRN','Iran, Islamic Republic of',364,0,'2014-08-04 10:39:17'),(15,'NIUE','NU','NIU','Niue',570,0,'2014-08-04 10:39:17'),(16,'SAMOA','WS','WSM','Samoa',882,0,'2014-08-04 10:39:17'),(17,'FRENCH GUIANA','GF','GUF','French Guiana',254,0,'2014-08-04 10:39:17'),(18,'IRAQ','IQ','IRQ','Iraq',368,1,'2014-08-04 10:39:17'),(19,'SAN MARINO','SM','SMR','San Marino',674,0,'2014-08-04 10:39:17'),(20,'IRELAND','IE','IRL','Ireland',372,0,'2014-08-04 10:39:17'),(21,'SAO TOME AND PRINCIPE','ST','STP','Sao Tome and Principe',678,0,'2014-08-04 10:39:17'),(22,'ISRAEL','IL','ISR','Israel',376,0,'2014-08-04 10:39:18'),(23,'SAUDI ARABIA','SA','SAU','Saudi Arabia',682,0,'2014-08-04 10:39:18'),(24,'ITALY','IT','ITA','Italy',380,0,'2014-08-04 10:39:18'),(25,'SENEGAL','SN','SEN','Senegal',686,0,'2014-08-04 10:39:18'),(26,'JAMAICA','JM','JAM','Jamaica',388,0,'2014-08-04 10:39:18'),(27,'JAPAN','JP','JPN','Japan',392,0,'2014-08-04 10:39:18'),(28,'JORDAN','JO','JOR','Jordan',400,0,'2014-08-04 10:39:18'),(29,'BELGIUM','BE','BEL','Belgium',56,0,'2014-08-04 10:39:18'),(30,'BELIZE','BZ','BLZ','Belize',84,0,'2014-08-04 10:39:18'),(31,'KAZAKHSTAN','KZ','KAZ','Kazakhstan',398,0,'2014-08-04 10:39:18'),(32,'UGANDA','UG','UGA','Uganda',800,0,'2014-08-04 10:39:18'),(33,'BENIN','BJ','BEN','Benin',204,0,'2014-08-04 10:39:18'),(34,'KENYA','KE','KEN','Kenya',404,0,'2014-08-04 10:39:18'),(35,'UKRAINE','UA','UKR','Ukraine',804,0,'2014-08-04 10:39:18'),(36,'BERMUDA','BM','BMU','Bermuda',60,0,'2014-08-04 10:39:18'),(37,'KIRIBATI','KI','KIR','Kiribati',296,0,'2014-08-04 10:39:18'),(38,'MEXICO','MX','MEX','Mexico',484,1,'2014-08-04 10:39:18'),(39,'UNITED ARAB EMIRATES','AE','ARE','United Arab Emirates',784,1,'2014-08-04 10:39:18'),(40,'BHUTAN','BT','BTN','Bhutan',64,0,'2014-08-04 10:39:18'),(41,'CUBA','CU','CUB','Cuba',192,0,'2014-08-04 10:39:19'),(42,'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF','KP','PRK','North Korea',408,0,'2014-08-04 10:39:19'),(43,'MICRONESIA, FEDERATED STATES OF','FM','FSM','Micronesia, Federated States of',583,1,'2014-08-04 10:39:19'),(44,'UNITED KINGDOM','GB','GBR','United Kingdom',826,0,'2014-08-04 10:39:19'),(45,'BOLIVIA','BO','BOL','Bolivia',68,0,'2014-08-04 10:39:19'),(46,'CYPRUS','CY','CYP','Cyprus',196,0,'2014-08-04 10:39:19'),(47,'KOREA, REPUBLIC OF','KR','KOR','South Korea',410,0,'2014-08-04 10:39:19'),(48,'MOLDOVA, REPUBLIC OF','MD','MDA','Moldova, Republic of',498,0,'2014-08-04 10:39:19'),(49,'UNITED STATES','US','USA','United States',840,1,'2014-08-04 10:39:19'),(50,'BOSNIA AND HERZEGOVINA','BA','BIH','Bosnia and Herzegovina',70,0,'2014-08-04 10:39:19'),(51,'CZECH REPUBLIC','CZ','CZE','Czech Republic',203,0,'2014-08-04 10:39:19'),(52,'KUWAIT','KW','KWT','Kuwait',414,0,'2014-08-04 10:39:19'),(53,'MONACO','MC','MCO','Monaco',492,0,'2014-08-04 10:39:19'),(54,'URUGUAY','UY','URY','Uruguay',858,0,'2014-08-04 10:39:19'),(55,'BOTSWANA','BW','BWA','Botswana',72,0,'2014-08-04 10:39:19'),(56,'DENMARK','DK','DNK','Denmark',208,0,'2014-08-04 10:39:19'),(57,'GUADELOUPE','GP','GLP','Guadeloupe',312,0,'2014-08-04 10:39:19'),(58,'KYRGYZSTAN','KG','KGZ','Kyrgyzstan',417,0,'2014-08-04 10:39:19'),(59,'MONGOLIA','MN','MNG','Mongolia',496,0,'2014-08-04 10:39:19'),(60,'PHILIPPINES','PH','PHL','Philippines',608,0,'2014-08-04 10:39:20'),(61,'BRAZIL','BR','BRA','Brazil',76,1,'2014-08-04 10:39:20'),(62,'DJIBOUTI','DJ','DJI','Djibouti',262,0,'2014-08-04 10:39:20'),(63,'GUAM','GU','GUM','Guam',316,0,'2014-08-04 10:39:20'),(64,'LAO PEOPLE\'S DEMOCRATIC REPUBLIC','LA','LAO','Lao People\'s Democratic Republic',418,0,'2014-08-04 10:39:20'),(65,'MONTSERRAT','MS','MSR','Montserrat',500,0,'2014-08-04 10:39:20'),(66,'PITCAIRN','PN','PCN','Pitcairn',612,0,'2014-08-04 10:39:20'),(67,'UZBEKISTAN','UZ','UZB','Uzbekistan',860,0,'2014-08-04 10:39:20'),(68,'BRUNEI DARUSSALAM','BN','BRN','Brunei Darussalam',96,0,'2014-08-04 10:39:20'),(69,'DOMINICA','DM','DMA','Dominica',212,0,'2014-08-04 10:39:20'),(70,'GUATEMALA','GT','GTM','Guatemala',320,0,'2014-08-04 10:39:20'),(71,'MOROCCO','MA','MAR','Morocco',504,0,'2014-08-04 10:39:20'),(72,'POLAND','PL','POL','Poland',616,0,'2014-08-04 10:39:20'),(73,'VANUATU','VU','VUT','Vanuatu',548,0,'2014-08-04 10:39:20'),(74,'DOMINICAN REPUBLIC','DO','DOM','Dominican Republic',214,0,'2014-08-04 10:39:20'),(75,'MOZAMBIQUE','MZ','MOZ','Mozambique',508,0,'2014-08-04 10:39:20'),(76,'PORTUGAL','PT','PRT','Portugal',620,0,'2014-08-04 10:39:20'),(77,'SUDAN','SD','SDN','Sudan',736,1,'2014-08-04 10:39:20'),(78,'VENEZUELA','VE','VEN','Venezuela',862,1,'2014-08-04 10:39:20'),(79,'ECUADOR','EC','ECU','Ecuador',218,0,'2014-08-04 10:39:20'),(80,'GUINEA','GN','GIN','Guinea',324,0,'2014-08-04 10:39:21'),(81,'MYANMAR','MM','MMR','Myanmar',104,0,'2014-08-04 10:39:21'),(82,'PUERTO RICO','PR','PRI','Puerto Rico',630,0,'2014-08-04 10:39:21'),(83,'SURINAME','SR','SUR','Suriname',740,0,'2014-08-04 10:39:21'),(84,'VIET NAM','VN','VNM','Viet Nam',704,0,'2014-08-04 10:39:21'),(85,'EGYPT','EG','EGY','Egypt',818,0,'2014-08-04 10:39:21'),(86,'GUINEA-BISSAU','GW','GNB','Guinea-Bissau',624,0,'2014-08-04 10:39:21'),(87,'NAMIBIA','NA','NAM','Namibia',516,0,'2014-08-04 10:39:21'),(88,'QATAR','QA','QAT','Qatar',634,0,'2014-08-04 10:39:21'),(89,'SVALBARD AND JAN MAYEN','SJ','SJM','Svalbard and Jan Mayen',744,0,'2014-08-04 10:39:21'),(90,'EL SALVADOR','SV','SLV','El Salvador',222,0,'2014-08-04 10:39:21'),(91,'GUYANA','GY','GUY','Guyana',328,0,'2014-08-04 10:39:21'),(92,'REUNION','RE','REU','Reunion',638,0,'2014-08-04 10:39:21'),(93,'HAITI','HT','HTI','Haiti',332,0,'2014-08-04 10:39:21'),(94,'ROMANIA','RO','ROM','Romania',642,0,'2014-08-04 10:39:21'),(95,'SWAZILAND','SZ','SWZ','Swaziland',748,0,'2014-08-04 10:39:21'),(96,'HOLY SEE (VATICAN CITY STATE)','VA','VAT','Holy See (Vatican City State)',336,0,'2014-08-04 10:39:21'),(97,'RUSSIAN FEDERATION','RU','RUS','Russian Federation',643,1,'2014-08-04 10:39:22'),(98,'SWEDEN','SE','SWE','Sweden',752,0,'2014-08-04 10:39:22'),(99,'HONDURAS','HN','HND','Honduras',340,0,'2014-08-04 10:39:22'),(100,'RWANDA','RW','RWA','Rwanda',646,0,'2014-08-04 10:39:22'),(101,'SWITZERLAND','CH','CHE','Switzerland',756,0,'2014-08-04 10:39:22'),(102,'HONG KONG','HK','HKG','Hong Kong',344,0,'2014-08-04 10:39:22'),(103,'SYRIAN ARAB REPUBLIC','SY','SYR','Syrian Arab Republic',760,0,'2014-08-04 10:39:22'),(104,'TAIWAN, PROVINCE OF CHINA','TW','TWN','Taiwan',158,0,'2014-08-04 10:39:22'),(105,'TAJIKISTAN','TJ','TJK','Tajikistan',762,0,'2014-08-04 10:39:22'),(106,'TANZANIA, UNITED REPUBLIC OF','TZ','TZA','Tanzania, United Republic of',834,0,'2014-08-04 10:39:22'),(107,'ARMENIA','AM','ARM','Armenia',51,0,'2014-08-04 10:39:22'),(108,'ARUBA','AW','ABW','Aruba',533,0,'2014-08-04 10:39:22'),(109,'AUSTRALIA','AU','AUS','Australia',36,1,'2014-08-04 10:39:22'),(110,'THAILAND','TH','THA','Thailand',764,0,'2014-08-04 10:39:22'),(111,'AUSTRIA','AT','AUT','Austria',40,0,'2014-08-04 10:39:22'),(112,'MADAGASCAR','MG','MDG','Madagascar',450,0,'2014-08-04 10:39:22'),(113,'TOGO','TG','TGO','Togo',768,0,'2014-08-04 10:39:22'),(114,'AZERBAIJAN','AZ','AZE','Azerbaijan',31,0,'2014-08-04 10:39:22'),(115,'CHILE','CL','CHL','Chile',152,0,'2014-08-04 10:39:23'),(116,'MALAWI','MW','MWI','Malawi',454,0,'2014-08-04 10:39:23'),(117,'TOKELAU','TK','TKL','Tokelau',772,0,'2014-08-04 10:39:23'),(118,'BAHAMAS','BS','BHS','Bahamas',44,0,'2014-08-04 10:39:23'),(119,'CHINA','CN','CHN','China',156,0,'2014-08-04 10:39:23'),(120,'MALAYSIA','MY','MYS','Malaysia',458,0,'2014-08-04 10:39:23'),(121,'TONGA','TO','TON','Tonga',776,0,'2014-08-04 10:39:23'),(122,'BAHRAIN','BH','BHR','Bahrain',48,0,'2014-08-04 10:39:23'),(123,'COLOMBIA','CO','COL','Colombia',170,0,'2014-08-04 10:39:23'),(124,'MALDIVES','MV','MDV','Maldives',462,0,'2014-08-04 10:39:23'),(125,'TRINIDAD AND TOBAGO','TT','TTO','Trinidad and Tobago',780,0,'2014-08-04 10:39:23'),(126,'BANGLADESH','BD','BGD','Bangladesh',50,0,'2014-08-04 10:39:23'),(127,'COMOROS','KM','COM','Comoros',174,1,'2014-08-04 10:39:23'),(128,'FRENCH POLYNESIA','PF','PYF','French Polynesia',258,0,'2014-08-04 10:39:23'),(129,'MALI','ML','MLI','Mali',466,0,'2014-08-04 10:39:23'),(130,'NORFOLK ISLAND','NF','NFK','Norfolk Island',574,0,'2014-08-04 10:39:23'),(131,'TUNISIA','TN','TUN','Tunisia',788,0,'2014-08-04 10:39:23'),(132,'BARBADOS','BB','BRB','Barbados',52,0,'2014-08-04 10:39:23'),(133,'CONGO','CG','COG','Congo',178,0,'2014-08-04 10:39:23'),(134,'GABON','GA','GAB','Gabon',266,0,'2014-08-04 10:39:24'),(135,'MALTA','MT','MLT','Malta',470,0,'2014-08-04 10:39:24'),(136,'NORTHERN MARIANA ISLANDS','MP','MNP','Northern Mariana Islands',580,0,'2014-08-04 10:39:24'),(137,'TURKEY','TR','TUR','Turkey',792,0,'2014-08-04 10:39:24'),(138,'CONGO, THE DEMOCRATIC REPUBLIC OF THE','CD','COD','Congo, the Democratic Republic of the',180,0,'2014-08-04 10:39:24'),(139,'MARSHALL ISLANDS','MH','MHL','Marshall Islands',584,0,'2014-08-04 10:39:24'),(140,'NORWAY','NO','NOR','Norway',578,0,'2014-08-04 10:39:24'),(141,'TURKMENISTAN','TM','TKM','Turkmenistan',795,0,'2014-08-04 10:39:24'),(142,'BELARUS','BY','BLR','Belarus',112,0,'2014-08-04 10:39:24'),(143,'COOK ISLANDS','CK','COK','Cook Islands',184,0,'2014-08-04 10:39:24'),(144,'GAMBIA','GM','GMB','Gambia',270,0,'2014-08-04 10:39:24'),(145,'MARTINIQUE','MQ','MTQ','Martinique',474,0,'2014-08-04 10:39:24'),(146,'OMAN','OM','OMN','Oman',512,0,'2014-08-04 10:39:25'),(147,'SEYCHELLES','SC','SYC','Seychelles',690,0,'2014-08-04 10:39:25'),(148,'TURKS AND CAICOS ISLANDS','TC','TCA','Turks and Caicos Islands',796,0,'2014-08-04 10:39:25'),(149,'GEORGIA','GE','GEO','Georgia',268,0,'2014-08-04 10:39:25'),(150,'MAURITANIA','MR','MRT','Mauritania',478,0,'2014-08-04 10:39:25'),(151,'PAKISTAN','PK','PAK','Pakistan',586,1,'2014-08-04 10:39:25'),(152,'SIERRA LEONE','SL','SLE','Sierra Leone',694,0,'2014-08-04 10:39:25'),(153,'TUVALU','TV','TUV','Tuvalu',798,0,'2014-08-04 10:39:25'),(154,'COSTA RICA','CR','CRI','Costa Rica',188,0,'2014-08-04 10:39:25'),(155,'GERMANY','DE','DEU','Germany',276,0,'2014-08-04 10:39:25'),(156,'MAURITIUS','MU','MUS','Mauritius',480,0,'2014-08-04 10:39:25'),(157,'PALAU','PW','PLW','Palau',585,0,'2014-08-04 10:39:25'),(158,'COTE D\'IVOIRE','CI','CIV','Cote D\'Ivoire',384,0,'2014-08-04 10:39:25'),(159,'PANAMA','PA','PAN','Panama',591,0,'2014-08-04 10:39:25'),(160,'SINGAPORE','SG','SGP','Singapore',702,0,'2014-08-04 10:39:25'),(161,'CROATIA','HR','HRV','Croatia',191,0,'2014-08-04 10:39:25'),(162,'GHANA','GH','GHA','Ghana',288,0,'2014-08-04 10:39:26'),(163,'PAPUA NEW GUINEA','PG','PNG','Papua New Guinea',598,0,'2014-08-04 10:39:26'),(164,'SLOVAKIA','SK','SVK','Slovakia',703,0,'2014-08-04 10:39:26'),(165,'GIBRALTAR','GI','GIB','Gibraltar',292,0,'2014-08-04 10:39:26'),(166,'PARAGUAY','PY','PRY','Paraguay',600,0,'2014-08-04 10:39:26'),(167,'SLOVENIA','SI','SVN','Slovenia',705,0,'2014-08-04 10:39:26'),(168,'GREECE','GR','GRC','Greece',300,0,'2014-08-04 10:39:26'),(169,'PERU','PE','PER','Peru',604,0,'2014-08-04 10:39:26'),(170,'SOLOMON ISLANDS','SB','SLB','Solomon Islands',90,0,'2014-08-04 10:39:26'),(171,'GREENLAND','GL','GRL','Greenland',304,0,'2014-08-04 10:39:26'),(172,'SOMALIA','SO','SOM','Somalia',706,1,'2014-08-04 10:39:26'),(173,'GRENADA','GD','GRD','Grenada',308,0,'2014-08-04 10:39:26'),(174,'SOUTH AFRICA','ZA','ZAF','South Africa',710,0,'2014-08-04 10:39:26'),(175,'SPAIN','ES','ESP','Spain',724,0,'2014-08-04 10:39:26'),(176,'SRI LANKA','LK','LKA','Sri Lanka',144,0,'2014-08-04 10:39:27'),(177,'AFGHANISTAN','AF','AFG','Afghanistan',4,0,'2014-08-04 10:39:27'),(178,'ALBANIA','AL','ALB','Albania',8,0,'2014-08-04 10:39:27'),(179,'ALGERIA','DZ','DZA','Algeria',12,0,'2014-08-04 10:39:27'),(180,'LATVIA','LV','LVA','Latvia',428,0,'2014-08-04 10:39:27'),(181,'AMERICAN SAMOA','AS','ASM','American Samoa',16,0,'2014-08-04 10:39:27'),(182,'BULGARIA','BG','BGR','Bulgaria',100,0,'2014-08-04 10:39:27'),(183,'LEBANON','LB','LBN','Lebanon',422,0,'2014-08-04 10:39:27'),(184,'ANDORRA','AD','AND','Andorra',20,0,'2014-08-04 10:39:27'),(185,'BURKINA FASO','BF','BFA','Burkina Faso',854,0,'2014-08-04 10:39:27'),(186,'LESOTHO','LS','LSO','Lesotho',426,0,'2014-08-04 10:39:27'),(187,'ANGOLA','AO','AGO','Angola',24,0,'2014-08-04 10:39:27'),(188,'BURUNDI','BI','BDI','Burundi',108,0,'2014-08-04 10:39:27'),(189,'LIBERIA','LR','LBR','Liberia',430,0,'2014-08-04 10:39:27'),(190,'VIRGIN ISLANDS, BRITISH','VG','VGB','Virgin Islands, British',92,0,'2014-08-04 10:39:28'),(191,'ANGUILLA','AI','AIA','Anguilla',660,0,'2014-08-04 10:39:28'),(192,'CAMBODIA','KH','KHM','Cambodia',116,0,'2014-08-04 10:39:28'),(193,'EQUATORIAL GUINEA','GQ','GNQ','Equatorial Guinea',226,0,'2014-08-04 10:39:28'),(194,'LIBYAN ARAB JAMAHIRIYA','LY','LBY','Libyan Arab Jamahiriya',434,0,'2014-08-04 10:39:28'),(195,'NAURU','NR','NRU','Nauru',520,0,'2014-08-04 10:39:28'),(196,'VIRGIN ISLANDS, U.S.','VI','VIR','Virgin Islands, U.S.',850,0,'2014-08-04 10:39:28'),(197,'ANTIGUA AND BARBUDA','AG','ATG','Antigua and Barbuda',28,0,'2014-08-04 10:39:28'),(198,'CAMEROON','CM','CMR','Cameroon',120,0,'2014-08-04 10:39:28'),(199,'LIECHTENSTEIN','LI','LIE','Liechtenstein',438,0,'2014-08-04 10:39:28'),(200,'NEPAL','NP','NPL','Nepal',524,1,'2014-08-04 10:39:28'),(201,'WALLIS AND FUTUNA','WF','WLF','Wallis and Futuna',876,0,'2014-08-04 10:39:28'),(202,'WESTERN SAHARA','EH','ESH','Western Sahara',732,0,'2014-08-04 10:39:28'),(203,'ARGENTINA','AR','ARG','Argentina',32,0,'2014-08-04 10:39:28'),(204,'CANADA','CA','CAN','Canada',124,1,'2014-08-04 10:39:28'),(205,'ERITREA','ER','ERI','Eritrea',232,0,'2014-08-04 10:39:28'),(206,'LITHUANIA','LT','LTU','Lithuania',440,0,'2014-08-04 10:39:29'),(207,'NETHERLANDS','NL','NLD','Netherlands',528,0,'2014-08-04 10:39:29'),(208,'YEMEN','YE','YEM','Yemen',887,0,'2014-08-04 10:39:29'),(209,'CAPE VERDE','CV','CPV','Cape Verde',132,0,'2014-08-04 10:39:29'),(210,'ESTONIA','EE','EST','Estonia',233,0,'2014-08-04 10:39:29'),(211,'LUXEMBOURG','LU','LUX','Luxembourg',442,0,'2014-08-04 10:39:29'),(212,'NETHERLANDS ANTILLES','AN','ANT','Netherlands Antilles',530,0,'2014-08-04 10:39:29'),(213,'SAINT HELENA','SH','SHN','Saint Helena',654,0,'2014-08-04 10:39:29'),(214,'ZAMBIA','ZM','ZMB','Zambia',894,0,'2014-08-04 10:39:29'),(215,'CAYMAN ISLANDS','KY','CYM','Cayman Islands',136,0,'2014-08-04 10:39:29'),(216,'ETHIOPIA','ET','ETH','Ethiopia',231,1,'2014-08-04 10:39:29'),(217,'HUNGARY','HU','HUN','Hungary',348,0,'2014-08-04 10:39:29'),(218,'MACAO','MO','MAC','Macao',446,0,'2014-08-04 10:39:29'),(219,'NEW CALEDONIA','NC','NCL','New Caledonia',540,0,'2014-08-04 10:39:29'),(220,'ZIMBABWE','ZW','ZWE','Zimbabwe',716,0,'2014-08-04 10:39:29'),(221,'CENTRAL AFRICAN REPUBLIC','CF','CAF','Central African Republic',140,0,'2014-08-04 10:39:29'),(222,'FALKLAND ISLANDS (MALVINAS)','FK','FLK','Falkland Islands (Malvinas)',238,0,'2014-08-04 10:39:29'),(223,'ICELAND','IS','ISL','Iceland',352,0,'2014-08-04 10:39:29'),(224,'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF','MK','MKD','Macedonia',807,0,'2014-08-04 10:39:29'),(225,'NEW ZEALAND','NZ','NZL','New Zealand',554,0,'2014-08-04 10:39:29'),(226,'SAINT KITTS AND NEVIS','KN','KNA','Saint Kitts and Nevis',659,1,'2014-08-04 10:39:30'),(227,'SERBIA','RS','SRB','Serbia',999,0,'2014-08-04 10:39:30');
/*!40000 ALTER TABLE `spree_countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_credit_cards`
--

DROP TABLE IF EXISTS `spree_credit_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_credit_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `year` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cc_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_digits` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `gateway_customer_profile_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gateway_payment_profile_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_credit_cards`
--

LOCK TABLES `spree_credit_cards` WRITE;
/*!40000 ALTER TABLE `spree_credit_cards` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_credit_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_gateways`
--

DROP TABLE IF EXISTS `spree_gateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_gateways` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `active` tinyint(1) DEFAULT '1',
  `environment` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'development',
  `server` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'test',
  `test_mode` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_gateways`
--

LOCK TABLES `spree_gateways` WRITE;
/*!40000 ALTER TABLE `spree_gateways` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_gateways` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_inventory_units`
--

DROP TABLE IF EXISTS `spree_inventory_units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_inventory_units` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `shipment_id` int(11) DEFAULT NULL,
  `return_authorization_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `pending` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `index_inventory_units_on_order_id` (`order_id`),
  KEY `index_inventory_units_on_shipment_id` (`shipment_id`),
  KEY `index_inventory_units_on_variant_id` (`variant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_inventory_units`
--

LOCK TABLES `spree_inventory_units` WRITE;
/*!40000 ALTER TABLE `spree_inventory_units` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_inventory_units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_line_items`
--

DROP TABLE IF EXISTS `spree_line_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_line_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variant_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cost_price` decimal(8,2) DEFAULT NULL,
  `tax_category_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_spree_line_items_on_order_id` (`order_id`),
  KEY `index_spree_line_items_on_variant_id` (`variant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_line_items`
--

LOCK TABLES `spree_line_items` WRITE;
/*!40000 ALTER TABLE `spree_line_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_line_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_log_entries`
--

DROP TABLE IF EXISTS `spree_log_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_log_entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source_id` int(11) DEFAULT NULL,
  `source_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_log_entries`
--

LOCK TABLES `spree_log_entries` WRITE;
/*!40000 ALTER TABLE `spree_log_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_log_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_option_types`
--

DROP TABLE IF EXISTS `spree_option_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_option_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `presentation` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_option_types`
--

LOCK TABLES `spree_option_types` WRITE;
/*!40000 ALTER TABLE `spree_option_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_option_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_option_types_prototypes`
--

DROP TABLE IF EXISTS `spree_option_types_prototypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_option_types_prototypes` (
  `prototype_id` int(11) DEFAULT NULL,
  `option_type_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_option_types_prototypes`
--

LOCK TABLES `spree_option_types_prototypes` WRITE;
/*!40000 ALTER TABLE `spree_option_types_prototypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_option_types_prototypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_option_values`
--

DROP TABLE IF EXISTS `spree_option_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_option_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `presentation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `option_type_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_option_values`
--

LOCK TABLES `spree_option_values` WRITE;
/*!40000 ALTER TABLE `spree_option_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_option_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_option_values_variants`
--

DROP TABLE IF EXISTS `spree_option_values_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_option_values_variants` (
  `variant_id` int(11) DEFAULT NULL,
  `option_value_id` int(11) DEFAULT NULL,
  KEY `index_option_values_variants_on_variant_id_and_option_value_id` (`variant_id`,`option_value_id`),
  KEY `index_spree_option_values_variants_on_variant_id` (`variant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_option_values_variants`
--

LOCK TABLES `spree_option_values_variants` WRITE;
/*!40000 ALTER TABLE `spree_option_values_variants` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_option_values_variants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_orders`
--

DROP TABLE IF EXISTS `spree_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `adjustment_total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `user_id` int(11) DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `bill_address_id` int(11) DEFAULT NULL,
  `ship_address_id` int(11) DEFAULT NULL,
  `payment_total` decimal(10,2) DEFAULT '0.00',
  `shipping_method_id` int(11) DEFAULT NULL,
  `shipment_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payment_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `special_instructions` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_ip_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `channel` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'spree',
  `tax_total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `subscription_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `subscription_id` int(11) DEFAULT '1',
  `subscription_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `request_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_pushed` tinyint(1) DEFAULT '0',
  `creditcard_id` int(11) DEFAULT NULL,
  `is_new` tinyint(1) DEFAULT NULL,
  `user_subscription_id` int(11) DEFAULT NULL,
  `shipstation_order_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `is_blocked` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_spree_orders_on_number` (`number`),
  KEY `index_spree_orders_on_user_id` (`user_id`),
  KEY `index_spree_orders_on_completed_at` (`completed_at`),
  KEY `index_spree_orders_on_user_id_and_created_by_id` (`user_id`,`created_by_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_orders`
--

LOCK TABLES `spree_orders` WRITE;
/*!40000 ALTER TABLE `spree_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_payment_methods`
--

DROP TABLE IF EXISTS `spree_payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_payment_methods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `active` tinyint(1) DEFAULT '1',
  `environment` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'development',
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `display_on` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `auto_capture` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_payment_methods`
--

LOCK TABLES `spree_payment_methods` WRITE;
/*!40000 ALTER TABLE `spree_payment_methods` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_payments`
--

DROP TABLE IF EXISTS `spree_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `order_id` int(11) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `source_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payment_method_id` int(11) DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `response_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avs_response` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `identifier` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cvv_response_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cvv_response_message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_spree_payments_on_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_payments`
--

LOCK TABLES `spree_payments` WRITE;
/*!40000 ALTER TABLE `spree_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_preferences`
--

DROP TABLE IF EXISTS `spree_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_preferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` text COLLATE utf8_unicode_ci,
  `key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_spree_preferences_on_key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_preferences`
--

LOCK TABLES `spree_preferences` WRITE;
/*!40000 ALTER TABLE `spree_preferences` DISABLE KEYS */;
INSERT INTO `spree_preferences` VALUES (1,'--- Spree Demo Site\n...\n','spree/app_configuration/site_name','string','2014-08-04 10:39:14','2014-08-28 09:44:13'),(2,'--- false\n...\n','spree/app_configuration/override_actionmailer_config','boolean','2014-08-04 10:39:14','2014-08-28 09:44:13'),(3,'--- no-reply@local.com\n...\n','spree/app_configuration/mails_from','string','2014-08-04 10:39:14','2014-08-28 09:44:14'),(4,'--- true\n...\n','spree/app_configuration/enable_mail_delivery','boolean','2014-08-04 10:39:14','2014-08-28 09:44:14'),(5,'--- false\n...\n','spree/app_configuration/allow_ssl_in_production','boolean','2014-08-04 10:39:14','2014-08-28 09:44:14'),(6,'--- false\n...\n','spree/app_configuration/address_requires_state','boolean','2014-08-04 10:39:14','2014-08-28 09:44:14'),(7,'--- 5397ef5f69702d4c491e0400\n...\n','spree/hub_configuration/hub_store_id','string','2014-08-04 10:39:14','2014-08-28 09:44:14'),(8,'--- 16ec9a9ee787e1be95e4cd8e683f506c842abab48b5635ee\n...\n','spree/hub_configuration/hub_token','string','2014-08-04 10:39:14','2014-08-28 09:44:14'),(9,'--- https://my.wombat.co/push\n...\n','spree/hub_configuration/hub_push_uri','string','2014-08-04 10:39:14','2014-08-28 09:44:14'),(10,'--- true\n...\n','spree/hub_configuration/enable_push','boolean','2014-08-04 10:39:15','2014-08-28 09:44:14'),(11,'--- false\n...\n','spree/app_configuration/tax_using_ship_address','boolean','2014-08-04 10:39:15','2014-08-28 09:44:14'),(12,'--- 49\n...\n','spree/app_configuration/default_country_id','integer','2014-08-04 10:39:30','2014-08-04 10:39:30'),(13,'--- \'\'\n','spree/app_configuration/default_seo_title','string','2014-08-06 10:11:51','2014-08-06 10:11:51'),(14,'--- spree, demo\n...\n','spree/app_configuration/default_meta_keywords','string','2014-08-06 10:11:52','2014-08-06 10:11:52'),(15,'--- Spree demo site\n...\n','spree/app_configuration/default_meta_description','string','2014-08-06 10:11:52','2014-08-06 10:11:52'),(16,'--- demo.spreecommerce.com\n...\n','spree/app_configuration/site_url','string','2014-08-06 10:11:52','2014-08-06 10:11:52'),(17,'--- true\n...\n','spree/app_configuration/allow_ssl_in_staging','boolean','2014-08-06 10:11:52','2014-08-06 10:11:52'),(18,'--- false\n...\n','spree/app_configuration/allow_ssl_in_development_and_test','boolean','2014-08-06 10:11:52','2014-08-06 10:11:52'),(19,'--- true\n...\n','spree/app_configuration/check_for_spree_alerts','boolean','2014-08-06 10:11:52','2014-08-06 10:11:52'),(20,'--- false\n...\n','spree/app_configuration/display_currency','boolean','2014-08-06 10:11:52','2014-08-06 10:11:52'),(21,'--- false\n...\n','spree/app_configuration/hide_cents','boolean','2014-08-06 10:11:52','2014-08-06 10:11:52'),(22,'--- INR\n...\n','spree/app_configuration/currency','string','2014-08-06 10:11:52','2014-08-06 10:11:52'),(23,'--- before\n...\n','spree/app_configuration/currency_symbol_position','string','2014-08-06 10:11:52','2014-08-06 10:11:52'),(24,'--- .\n...\n','spree/app_configuration/currency_decimal_mark','string','2014-08-06 10:11:52','2014-08-06 10:11:52'),(25,'--- \',\'\n','spree/app_configuration/currency_thousands_separator','string','2014-08-06 10:11:52','2014-08-06 10:11:52');
/*!40000 ALTER TABLE `spree_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_prices`
--

DROP TABLE IF EXISTS `spree_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_prices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variant_id` int(11) NOT NULL,
  `amount` decimal(8,2) DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_spree_prices_on_variant_id_and_currency` (`variant_id`,`currency`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_prices`
--

LOCK TABLES `spree_prices` WRITE;
/*!40000 ALTER TABLE `spree_prices` DISABLE KEYS */;
INSERT INTO `spree_prices` VALUES (1,1,0.00,'USD','2014-08-21 12:53:20'),(2,2,0.00,'USD','2014-08-21 12:53:25'),(3,3,0.00,'USD','2014-08-21 12:53:30'),(4,4,0.00,'USD','2014-08-21 12:56:10'),(5,5,0.00,'USD','2014-08-21 12:56:17'),(6,6,0.00,'USD','2014-08-21 12:56:21'),(7,7,0.00,'USD','2014-08-21 12:53:15'),(8,7,0.00,'INR','2014-08-21 12:53:15'),(9,1,NULL,'INR','2014-08-21 12:53:20'),(10,2,NULL,'INR','2014-08-21 12:53:25'),(11,3,NULL,'INR','2014-08-21 12:53:30'),(12,4,NULL,'INR','2014-08-21 12:56:10'),(13,5,NULL,'INR','2014-08-21 12:56:17'),(14,6,NULL,'INR','2014-08-21 12:56:21'),(15,8,0.00,'INR',NULL),(16,9,0.00,'INR',NULL),(17,10,0.00,'INR',NULL),(18,11,0.00,'INR',NULL),(19,12,0.00,'INR',NULL),(20,13,0.00,'INR',NULL);
/*!40000 ALTER TABLE `spree_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_product_option_types`
--

DROP TABLE IF EXISTS `spree_product_option_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_product_option_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `option_type_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_product_option_types`
--

LOCK TABLES `spree_product_option_types` WRITE;
/*!40000 ALTER TABLE `spree_product_option_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_product_option_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_product_properties`
--

DROP TABLE IF EXISTS `spree_product_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_product_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `property_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `position` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_product_properties_on_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_product_properties`
--

LOCK TABLES `spree_product_properties` WRITE;
/*!40000 ALTER TABLE `spree_product_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_product_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_products`
--

DROP TABLE IF EXISTS `spree_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` text COLLATE utf8_unicode_ci,
  `available_on` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `permalink` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta_description` text COLLATE utf8_unicode_ci,
  `meta_keywords` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tax_category_id` int(11) DEFAULT NULL,
  `shipping_category_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `nutritional_fact_image_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nutritional_fact_image_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nutritional_fact_image_file_size` int(11) DEFAULT NULL,
  `nutritional_fact_image_updated_at` datetime DEFAULT NULL,
  `ingredients` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permalink_idx_unique` (`permalink`),
  KEY `index_spree_products_on_available_on` (`available_on`),
  KEY `index_spree_products_on_deleted_at` (`deleted_at`),
  KEY `index_spree_products_on_name` (`name`),
  KEY `index_spree_products_on_permalink` (`permalink`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_products`
--

LOCK TABLES `spree_products` WRITE;
/*!40000 ALTER TABLE `spree_products` DISABLE KEYS */;
INSERT INTO `spree_products` VALUES (1,'sank1','this is snak',NULL,'2014-08-21 12:53:20','1408625600_20140806131156',NULL,NULL,NULL,1,'2014-08-06 08:51:22','2014-08-21 12:53:20',1,'images.jpeg','image/jpeg',14572,'2014-08-06 08:51:21',''),(2,'snak2','asddffasdfasdfasdfasdfasdfasdfasdfadsasdfasdfasdfasdfasdfasdfasd',NULL,'2014-08-21 12:53:25','1408625605_20140806142327',NULL,NULL,NULL,1,'2014-08-06 08:53:53','2014-08-21 12:53:25',1,'index.jpeg','image/jpeg',9400,'2014-08-06 08:53:52',''),(3,'snak3','dfassdfasdfa',NULL,'2014-08-21 12:53:30','1408625610_20140806142416',NULL,NULL,NULL,1,'2014-08-06 08:54:31','2014-08-21 12:53:30',1,'snacks-19a.jpg','image/jpeg',139240,'2014-08-06 08:54:29',''),(4,'snak4','asdfasdfasdfas',NULL,'2014-08-21 12:56:11','1408625770_20140806142453',NULL,NULL,NULL,1,'2014-08-06 08:55:06','2014-08-21 12:56:11',1,'images.jpeg','image/jpeg',14572,'2014-08-06 08:55:05',''),(5,'snak5','asdfasdfas',NULL,'2014-08-21 12:56:17','1408625777_20140806142530',NULL,NULL,NULL,1,'2014-08-06 08:55:43','2014-08-21 12:56:17',1,'index.jpeg','image/jpeg',9400,'2014-08-06 08:55:42','<p>afasdfff</p>\r\n\r\n<p>fasdf</p>\r\n\r\n<p>asddsafsdfa</p>\r\n\r\n<p>asdf</p>\r\n\r\n<p>asdf</p>\r\n\r\n<p>asdf</p>\r\n'),(6,'snak6','asdfasdfasd',NULL,'2014-08-21 12:56:21','1408625781_20140806142714',NULL,NULL,NULL,1,'2014-08-06 08:57:36','2014-08-21 12:56:21',1,'snacks-19a.jpg','image/jpeg',139240,'2014-08-06 08:57:34','<p>dfasdfds</p>\r\n\r\n<p>fasd</p>\r\n\r\n<p>f</p>\r\n\r\n<p>asdfasdfasdfasdf</p>\r\n\r\n<p>sdafasdfasdfasd</p>\r\n'),(7,'asfasdfsadfasd','asdfsdfadsffa',NULL,'2014-08-21 12:53:16','1408625596_20140806142801',NULL,NULL,NULL,1,'2014-08-06 08:58:18','2014-08-21 12:53:16',1,'img1-snack.jpg','image/jpeg',40134,'2014-08-21 12:30:59','<p>fasdf</p>\r\n\r\n<p>fsdafasdfasdf</p>\r\n\r\n<p>fsdfasfasdfas</p>\r\n\r\n<p>asdfasdfasdf</p>\r\n\r\n<p>sdafasdfasd</p>\r\n'),(8,'food1','dasfadsfasdfasfdasasdfasfasdfasdf',NULL,NULL,'20140822094428',NULL,NULL,NULL,1,'2014-08-22 04:15:39','2014-08-22 04:16:07',1,'img1-snack.jpg','image/jpeg',40134,'2014-08-22 04:15:38','<p><img alt=\"\" src=\"/ckeditor_assets/pictures/2/content_img1-snack.jpg\" style=\"height:300px; width:450px\" /></p>\r\n'),(9,'food2','fsdafasdfasdfasdfasasfdfa',NULL,NULL,'20140822094616',NULL,NULL,NULL,1,'2014-08-22 04:16:46','2014-08-22 04:17:13',1,'img2-snack.jpg','image/jpeg',66131,'2014-08-22 04:16:45',''),(10,'food3','asdfasdfasasdfas',NULL,NULL,'20140822094723',NULL,NULL,NULL,1,'2014-08-22 04:17:44','2014-08-22 04:18:01',1,'img3-snack.jpg','image/jpeg',51687,'2014-08-22 04:17:43',''),(11,'food4','asdfasdfasdfasdfaSDFA',NULL,NULL,'20140822094808',NULL,NULL,NULL,1,'2014-08-22 04:18:29','2014-08-22 04:18:46',1,'img4-snack.jpg','image/jpeg',46506,'2014-08-22 04:18:28',''),(12,'food5','YWREGFAGASFASDFGSDFGSDFG',NULL,NULL,'20140822094856',NULL,NULL,NULL,1,'2014-08-22 04:19:37','2014-08-22 04:19:54',1,'img5-snack.jpg','image/jpeg',47161,'2014-08-22 04:19:36',''),(13,'food6','ASDFASDFASDFASFAF',NULL,NULL,'20140822095005',NULL,NULL,NULL,1,'2014-08-22 04:20:25','2014-08-22 04:20:48',1,'img6-snack.jpg','image/jpeg',36432,'2014-08-22 04:20:23','');
/*!40000 ALTER TABLE `spree_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_products_promotion_rules`
--

DROP TABLE IF EXISTS `spree_products_promotion_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_products_promotion_rules` (
  `product_id` int(11) DEFAULT NULL,
  `promotion_rule_id` int(11) DEFAULT NULL,
  KEY `index_products_promotion_rules_on_product_id` (`product_id`),
  KEY `index_products_promotion_rules_on_promotion_rule_id` (`promotion_rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_products_promotion_rules`
--

LOCK TABLES `spree_products_promotion_rules` WRITE;
/*!40000 ALTER TABLE `spree_products_promotion_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_products_promotion_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_products_taxons`
--

DROP TABLE IF EXISTS `spree_products_taxons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_products_taxons` (
  `product_id` int(11) DEFAULT NULL,
  `taxon_id` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `index_spree_products_taxons_on_product_id` (`product_id`),
  KEY `index_spree_products_taxons_on_taxon_id` (`taxon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_products_taxons`
--

LOCK TABLES `spree_products_taxons` WRITE;
/*!40000 ALTER TABLE `spree_products_taxons` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_products_taxons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_promotion_action_line_items`
--

DROP TABLE IF EXISTS `spree_promotion_action_line_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_promotion_action_line_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `promotion_action_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_promotion_action_line_items`
--

LOCK TABLES `spree_promotion_action_line_items` WRITE;
/*!40000 ALTER TABLE `spree_promotion_action_line_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_promotion_action_line_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_promotion_actions`
--

DROP TABLE IF EXISTS `spree_promotion_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_promotion_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activator_id` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_promotion_actions`
--

LOCK TABLES `spree_promotion_actions` WRITE;
/*!40000 ALTER TABLE `spree_promotion_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_promotion_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_promotion_rules`
--

DROP TABLE IF EXISTS `spree_promotion_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_promotion_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activator_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_group_id` int(11) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_promotion_rules_on_product_group_id` (`product_group_id`),
  KEY `index_promotion_rules_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_promotion_rules`
--

LOCK TABLES `spree_promotion_rules` WRITE;
/*!40000 ALTER TABLE `spree_promotion_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_promotion_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_promotion_rules_users`
--

DROP TABLE IF EXISTS `spree_promotion_rules_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_promotion_rules_users` (
  `user_id` int(11) DEFAULT NULL,
  `promotion_rule_id` int(11) DEFAULT NULL,
  KEY `index_promotion_rules_users_on_promotion_rule_id` (`promotion_rule_id`),
  KEY `index_promotion_rules_users_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_promotion_rules_users`
--

LOCK TABLES `spree_promotion_rules_users` WRITE;
/*!40000 ALTER TABLE `spree_promotion_rules_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_promotion_rules_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_properties`
--

DROP TABLE IF EXISTS `spree_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `presentation` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_properties`
--

LOCK TABLES `spree_properties` WRITE;
/*!40000 ALTER TABLE `spree_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_properties_prototypes`
--

DROP TABLE IF EXISTS `spree_properties_prototypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_properties_prototypes` (
  `prototype_id` int(11) DEFAULT NULL,
  `property_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_properties_prototypes`
--

LOCK TABLES `spree_properties_prototypes` WRITE;
/*!40000 ALTER TABLE `spree_properties_prototypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_properties_prototypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_prototypes`
--

DROP TABLE IF EXISTS `spree_prototypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_prototypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_prototypes`
--

LOCK TABLES `spree_prototypes` WRITE;
/*!40000 ALTER TABLE `spree_prototypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_prototypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_return_authorizations`
--

DROP TABLE IF EXISTS `spree_return_authorizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_return_authorizations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `order_id` int(11) DEFAULT NULL,
  `reason` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `stock_location_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_return_authorizations`
--

LOCK TABLES `spree_return_authorizations` WRITE;
/*!40000 ALTER TABLE `spree_return_authorizations` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_return_authorizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_roles`
--

DROP TABLE IF EXISTS `spree_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_roles`
--

LOCK TABLES `spree_roles` WRITE;
/*!40000 ALTER TABLE `spree_roles` DISABLE KEYS */;
INSERT INTO `spree_roles` VALUES (1,'admin'),(2,'user');
/*!40000 ALTER TABLE `spree_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_roles_users`
--

DROP TABLE IF EXISTS `spree_roles_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_roles_users` (
  `role_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  KEY `index_spree_roles_users_on_role_id` (`role_id`),
  KEY `index_spree_roles_users_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_roles_users`
--

LOCK TABLES `spree_roles_users` WRITE;
/*!40000 ALTER TABLE `spree_roles_users` DISABLE KEYS */;
INSERT INTO `spree_roles_users` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `spree_roles_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_shipments`
--

DROP TABLE IF EXISTS `spree_shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_shipments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tracking` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cost` decimal(8,2) DEFAULT NULL,
  `shipped_at` datetime DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `stock_location_id` int(11) DEFAULT NULL,
  `address` text COLLATE utf8_unicode_ci,
  `shipment_json_dump` text COLLATE utf8_unicode_ci,
  `shipstation_order_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_shipments_on_number` (`number`),
  KEY `index_spree_shipments_on_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_shipments`
--

LOCK TABLES `spree_shipments` WRITE;
/*!40000 ALTER TABLE `spree_shipments` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_shipments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_shipping_categories`
--

DROP TABLE IF EXISTS `spree_shipping_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_shipping_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_shipping_categories`
--

LOCK TABLES `spree_shipping_categories` WRITE;
/*!40000 ALTER TABLE `spree_shipping_categories` DISABLE KEYS */;
INSERT INTO `spree_shipping_categories` VALUES (1,'Default','2014-08-04 10:38:14','2014-08-04 10:38:14');
/*!40000 ALTER TABLE `spree_shipping_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_shipping_method_categories`
--

DROP TABLE IF EXISTS `spree_shipping_method_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_shipping_method_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shipping_method_id` int(11) NOT NULL,
  `shipping_category_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_spree_shipping_method_categories` (`shipping_category_id`,`shipping_method_id`),
  KEY `index_spree_shipping_method_categories_on_shipping_method_id` (`shipping_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_shipping_method_categories`
--

LOCK TABLES `spree_shipping_method_categories` WRITE;
/*!40000 ALTER TABLE `spree_shipping_method_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_shipping_method_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_shipping_methods`
--

DROP TABLE IF EXISTS `spree_shipping_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_shipping_methods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `display_on` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tracking_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_shipping_methods`
--

LOCK TABLES `spree_shipping_methods` WRITE;
/*!40000 ALTER TABLE `spree_shipping_methods` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_shipping_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_shipping_methods_zones`
--

DROP TABLE IF EXISTS `spree_shipping_methods_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_shipping_methods_zones` (
  `shipping_method_id` int(11) DEFAULT NULL,
  `zone_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_shipping_methods_zones`
--

LOCK TABLES `spree_shipping_methods_zones` WRITE;
/*!40000 ALTER TABLE `spree_shipping_methods_zones` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_shipping_methods_zones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_shipping_rates`
--

DROP TABLE IF EXISTS `spree_shipping_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_shipping_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shipment_id` int(11) DEFAULT NULL,
  `shipping_method_id` int(11) DEFAULT NULL,
  `selected` tinyint(1) DEFAULT '0',
  `cost` decimal(8,2) DEFAULT '0.00',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `spree_shipping_rates_join_index` (`shipment_id`,`shipping_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_shipping_rates`
--

LOCK TABLES `spree_shipping_rates` WRITE;
/*!40000 ALTER TABLE `spree_shipping_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_shipping_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_skrill_transactions`
--

DROP TABLE IF EXISTS `spree_skrill_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_skrill_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `payment_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_skrill_transactions`
--

LOCK TABLES `spree_skrill_transactions` WRITE;
/*!40000 ALTER TABLE `spree_skrill_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_skrill_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_state_changes`
--

DROP TABLE IF EXISTS `spree_state_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_state_changes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `previous_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stateful_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `stateful_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `next_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_state_changes`
--

LOCK TABLES `spree_state_changes` WRITE;
/*!40000 ALTER TABLE `spree_state_changes` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_state_changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_states`
--

DROP TABLE IF EXISTS `spree_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `abbr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_states`
--

LOCK TABLES `spree_states` WRITE;
/*!40000 ALTER TABLE `spree_states` DISABLE KEYS */;
INSERT INTO `spree_states` VALUES (1,'Michigan','MI',49,'2014-08-04 10:39:30'),(2,'South Dakota','SD',49,'2014-08-04 10:39:30'),(3,'Washington','WA',49,'2014-08-04 10:39:30'),(4,'Wisconsin','WI',49,'2014-08-04 10:39:30'),(5,'Arizona','AZ',49,'2014-08-04 10:39:30'),(6,'Illinois','IL',49,'2014-08-04 10:39:30'),(7,'New Hampshire','NH',49,'2014-08-04 10:39:30'),(8,'North Carolina','NC',49,'2014-08-04 10:39:30'),(9,'Kansas','KS',49,'2014-08-04 10:39:30'),(10,'Missouri','MO',49,'2014-08-04 10:39:30'),(11,'Arkansas','AR',49,'2014-08-04 10:39:30'),(12,'Nevada','NV',49,'2014-08-04 10:39:30'),(13,'District of Columbia','DC',49,'2014-08-04 10:39:30'),(14,'Idaho','ID',49,'2014-08-04 10:39:31'),(15,'Nebraska','NE',49,'2014-08-04 10:39:31'),(16,'Pennsylvania','PA',49,'2014-08-04 10:39:31'),(17,'Hawaii','HI',49,'2014-08-04 10:39:31'),(18,'Utah','UT',49,'2014-08-04 10:39:31'),(19,'Vermont','VT',49,'2014-08-04 10:39:31'),(20,'Delaware','DE',49,'2014-08-04 10:39:31'),(21,'Rhode Island','RI',49,'2014-08-04 10:39:31'),(22,'Oklahoma','OK',49,'2014-08-04 10:39:31'),(23,'Louisiana','LA',49,'2014-08-04 10:39:31'),(24,'Montana','MT',49,'2014-08-04 10:39:31'),(25,'Tennessee','TN',49,'2014-08-04 10:39:31'),(26,'Maryland','MD',49,'2014-08-04 10:39:31'),(27,'Florida','FL',49,'2014-08-04 10:39:31'),(28,'Virginia','VA',49,'2014-08-04 10:39:31'),(29,'Minnesota','MN',49,'2014-08-04 10:39:32'),(30,'New Jersey','NJ',49,'2014-08-04 10:39:32'),(31,'Ohio','OH',49,'2014-08-04 10:39:32'),(32,'California','CA',49,'2014-08-04 10:39:32'),(33,'North Dakota','ND',49,'2014-08-04 10:39:32'),(34,'Maine','ME',49,'2014-08-04 10:39:32'),(35,'Indiana','IN',49,'2014-08-04 10:39:32'),(36,'Texas','TX',49,'2014-08-04 10:39:32'),(37,'Oregon','OR',49,'2014-08-04 10:39:32'),(38,'Wyoming','WY',49,'2014-08-04 10:39:32'),(39,'Alabama','AL',49,'2014-08-04 10:39:32'),(40,'Iowa','IA',49,'2014-08-04 10:39:32'),(41,'Mississippi','MS',49,'2014-08-04 10:39:32'),(42,'Kentucky','KY',49,'2014-08-04 10:39:32'),(43,'New Mexico','NM',49,'2014-08-04 10:39:32'),(44,'Georgia','GA',49,'2014-08-04 10:39:32'),(45,'Colorado','CO',49,'2014-08-04 10:39:32'),(46,'Massachusetts','MA',49,'2014-08-04 10:39:33'),(47,'Connecticut','CT',49,'2014-08-04 10:39:33'),(48,'New York','NY',49,'2014-08-04 10:39:33'),(49,'South Carolina','SC',49,'2014-08-04 10:39:33'),(50,'Alaska','AK',49,'2014-08-04 10:39:33'),(51,'West Virginia','WV',49,'2014-08-04 10:39:33'),(52,'U.S. Armed Forces - Americas','AA',49,'2014-08-04 10:39:33'),(53,'U.S. Armed Forces - Europe','AE',49,'2014-08-04 10:39:33'),(54,'U.S. Armed Forces - Pacific','AP',49,'2014-08-04 10:39:33');
/*!40000 ALTER TABLE `spree_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_stock_items`
--

DROP TABLE IF EXISTS `spree_stock_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_stock_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_location_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `count_on_hand` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `backorderable` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_spree_stock_items_on_stock_location_id` (`stock_location_id`),
  KEY `stock_item_by_loc_and_var_id` (`stock_location_id`,`variant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_stock_items`
--

LOCK TABLES `spree_stock_items` WRITE;
/*!40000 ALTER TABLE `spree_stock_items` DISABLE KEYS */;
INSERT INTO `spree_stock_items` VALUES (1,1,1,0,'2014-08-06 08:51:22','2014-08-21 12:53:19',1,'2014-08-21 12:53:19'),(2,1,2,0,'2014-08-06 08:53:53','2014-08-21 12:53:25',1,'2014-08-21 12:53:25'),(3,1,3,0,'2014-08-06 08:54:31','2014-08-21 12:53:29',1,'2014-08-21 12:53:29'),(4,1,4,0,'2014-08-06 08:55:06','2014-08-21 12:56:10',1,'2014-08-21 12:56:10'),(5,1,5,0,'2014-08-06 08:55:43','2014-08-21 12:56:17',1,'2014-08-21 12:56:17'),(6,1,6,0,'2014-08-06 08:57:36','2014-08-21 12:56:20',1,'2014-08-21 12:56:20'),(7,1,7,0,'2014-08-06 08:58:18','2014-08-21 12:53:15',1,'2014-08-21 12:53:15'),(8,1,8,0,'2014-08-22 04:15:39','2014-08-22 04:15:39',1,NULL),(9,1,9,0,'2014-08-22 04:16:46','2014-08-22 04:16:46',1,NULL),(10,1,10,0,'2014-08-22 04:17:44','2014-08-22 04:17:44',1,NULL),(11,1,11,0,'2014-08-22 04:18:29','2014-08-22 04:18:29',1,NULL),(12,1,12,0,'2014-08-22 04:19:37','2014-08-22 04:19:37',1,NULL),(13,1,13,0,'2014-08-22 04:20:25','2014-08-22 04:20:25',1,NULL);
/*!40000 ALTER TABLE `spree_stock_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_stock_locations`
--

DROP TABLE IF EXISTS `spree_stock_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_stock_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `address1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `state_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `zipcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `backorderable_default` tinyint(1) DEFAULT '0',
  `propagate_all_variants` tinyint(1) DEFAULT '1',
  `admin_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_stock_locations`
--

LOCK TABLES `spree_stock_locations` WRITE;
/*!40000 ALTER TABLE `spree_stock_locations` DISABLE KEYS */;
INSERT INTO `spree_stock_locations` VALUES (1,'default','2014-08-04 10:37:43','2014-08-04 10:37:43',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,NULL);
/*!40000 ALTER TABLE `spree_stock_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_stock_movements`
--

DROP TABLE IF EXISTS `spree_stock_movements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_stock_movements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_item_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT '0',
  `action` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `originator_id` int(11) DEFAULT NULL,
  `originator_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_spree_stock_movements_on_stock_item_id` (`stock_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_stock_movements`
--

LOCK TABLES `spree_stock_movements` WRITE;
/*!40000 ALTER TABLE `spree_stock_movements` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_stock_movements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_stock_transfers`
--

DROP TABLE IF EXISTS `spree_stock_transfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_stock_transfers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reference` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_location_id` int(11) DEFAULT NULL,
  `destination_location_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_spree_stock_transfers_on_number` (`number`),
  KEY `index_spree_stock_transfers_on_source_location_id` (`source_location_id`),
  KEY `index_spree_stock_transfers_on_destination_location_id` (`destination_location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_stock_transfers`
--

LOCK TABLES `spree_stock_transfers` WRITE;
/*!40000 ALTER TABLE `spree_stock_transfers` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_stock_transfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_tax_categories`
--

DROP TABLE IF EXISTS `spree_tax_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_tax_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_tax_categories`
--

LOCK TABLES `spree_tax_categories` WRITE;
/*!40000 ALTER TABLE `spree_tax_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_tax_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_tax_rates`
--

DROP TABLE IF EXISTS `spree_tax_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_tax_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` decimal(8,5) DEFAULT NULL,
  `zone_id` int(11) DEFAULT NULL,
  `tax_category_id` int(11) DEFAULT NULL,
  `included_in_price` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `show_rate_in_label` tinyint(1) DEFAULT '1',
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_tax_rates`
--

LOCK TABLES `spree_tax_rates` WRITE;
/*!40000 ALTER TABLE `spree_tax_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_tax_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_taxonomies`
--

DROP TABLE IF EXISTS `spree_taxonomies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_taxonomies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `position` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_taxonomies`
--

LOCK TABLES `spree_taxonomies` WRITE;
/*!40000 ALTER TABLE `spree_taxonomies` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_taxonomies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_taxons`
--

DROP TABLE IF EXISTS `spree_taxons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_taxons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT '0',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permalink` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `taxonomy_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `icon_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `icon_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `icon_file_size` int(11) DEFAULT NULL,
  `icon_updated_at` datetime DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `meta_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta_keywords` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_taxons_on_parent_id` (`parent_id`),
  KEY `index_taxons_on_permalink` (`permalink`),
  KEY `index_taxons_on_taxonomy_id` (`taxonomy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_taxons`
--

LOCK TABLES `spree_taxons` WRITE;
/*!40000 ALTER TABLE `spree_taxons` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_taxons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_tokenized_permissions`
--

DROP TABLE IF EXISTS `spree_tokenized_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_tokenized_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissable_id` int(11) DEFAULT NULL,
  `permissable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_tokenized_name_and_type` (`permissable_id`,`permissable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_tokenized_permissions`
--

LOCK TABLES `spree_tokenized_permissions` WRITE;
/*!40000 ALTER TABLE `spree_tokenized_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_tokenized_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_trackers`
--

DROP TABLE IF EXISTS `spree_trackers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_trackers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `environment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `analytics_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_trackers`
--

LOCK TABLES `spree_trackers` WRITE;
/*!40000 ALTER TABLE `spree_trackers` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_trackers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_user_authentications`
--

DROP TABLE IF EXISTS `spree_user_authentications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_user_authentications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_user_authentications`
--

LOCK TABLES `spree_user_authentications` WRITE;
/*!40000 ALTER TABLE `spree_user_authentications` DISABLE KEYS */;
/*!40000 ALTER TABLE `spree_user_authentications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_users`
--

DROP TABLE IF EXISTS `spree_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `encrypted_password` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_salt` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `persistence_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `perishable_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `failed_attempts` int(11) NOT NULL DEFAULT '0',
  `last_request_at` datetime DEFAULT NULL,
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ship_address_id` int(11) DEFAULT NULL,
  `bill_address_id` int(11) DEFAULT NULL,
  `authentication_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `unlock_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `spree_api_key` varchar(48) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telephone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_line_1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_line_2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zipcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ship_to_same_address` tinyint(1) DEFAULT NULL,
  `facebook_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subscription_id` int(11) DEFAULT NULL,
  `braintree_customer_id` int(11) DEFAULT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_idx_unique` (`email`),
  KEY `index_spree_users_on_spree_api_key` (`spree_api_key`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_users`
--

LOCK TABLES `spree_users` WRITE;
/*!40000 ALTER TABLE `spree_users` DISABLE KEYS */;
INSERT INTO `spree_users` VALUES (1,'b0b5c752f0c8dba5bbe167cf744b3a1fb2b4093025a38fdbf8cb50bcc3079af71702ad66a45c7556e4a96921f069a684fd67a69a6aa9ff7913a88f905c5e1a3c','EujvX9UF1ySUTpJys2oR','pardeep.kumar@trigma.in',NULL,NULL,NULL,NULL,12,0,NULL,'2014-08-28 09:18:02','2014-08-28 06:58:03','127.0.0.1','127.0.0.1','pardeep.kumar@trigma.in',NULL,NULL,NULL,NULL,NULL,NULL,'2014-08-04 10:40:27','2014-08-28 09:18:02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `spree_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_variants`
--

DROP TABLE IF EXISTS `spree_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `weight` decimal(8,2) DEFAULT '0.00',
  `height` decimal(8,2) DEFAULT NULL,
  `width` decimal(8,2) DEFAULT NULL,
  `depth` decimal(8,2) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `is_master` tinyint(1) DEFAULT '0',
  `product_id` int(11) DEFAULT NULL,
  `cost_price` decimal(8,2) DEFAULT NULL,
  `cost_currency` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `track_inventory` tinyint(1) DEFAULT '1',
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_spree_variants_on_product_id` (`product_id`),
  KEY `index_spree_variants_on_sku` (`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_variants`
--

LOCK TABLES `spree_variants` WRITE;
/*!40000 ALTER TABLE `spree_variants` DISABLE KEYS */;
INSERT INTO `spree_variants` VALUES (1,'',0.00,NULL,NULL,NULL,'2014-08-21 12:53:20',1,1,NULL,'USD',1,1,'2014-08-21 12:53:20'),(2,'',0.00,NULL,NULL,NULL,'2014-08-21 12:53:25',1,2,NULL,'USD',1,1,'2014-08-21 12:53:25'),(3,'',0.00,NULL,NULL,NULL,'2014-08-21 12:53:30',1,3,NULL,'USD',1,1,'2014-08-21 12:53:30'),(4,'',0.00,NULL,NULL,NULL,'2014-08-21 12:56:10',1,4,NULL,'USD',1,1,'2014-08-21 12:56:10'),(5,'',0.00,NULL,NULL,NULL,'2014-08-21 12:56:17',1,5,NULL,'USD',1,1,'2014-08-21 12:56:17'),(6,'',0.00,NULL,NULL,NULL,'2014-08-21 12:56:21',1,6,NULL,'USD',1,1,'2014-08-21 12:56:21'),(7,'',0.00,NULL,NULL,NULL,'2014-08-21 12:53:15',1,7,NULL,'USD',1,1,'2014-08-21 12:53:15'),(8,'',0.00,NULL,NULL,NULL,NULL,1,8,NULL,'INR',1,1,'2014-08-22 04:16:07'),(9,'',0.00,NULL,NULL,NULL,NULL,1,9,NULL,'INR',1,1,'2014-08-22 04:17:13'),(10,'',0.00,NULL,NULL,NULL,NULL,1,10,NULL,'INR',1,1,'2014-08-22 04:18:01'),(11,'',0.00,NULL,NULL,NULL,NULL,1,11,NULL,'INR',1,1,'2014-08-22 04:18:46'),(12,'',0.00,NULL,NULL,NULL,NULL,1,12,NULL,'INR',1,1,'2014-08-22 04:19:54'),(13,'',0.00,NULL,NULL,NULL,NULL,1,13,NULL,'INR',1,1,'2014-08-22 04:20:48');
/*!40000 ALTER TABLE `spree_variants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_zone_members`
--

DROP TABLE IF EXISTS `spree_zone_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_zone_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zoneable_id` int(11) DEFAULT NULL,
  `zoneable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zone_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_zone_members`
--

LOCK TABLES `spree_zone_members` WRITE;
/*!40000 ALTER TABLE `spree_zone_members` DISABLE KEYS */;
INSERT INTO `spree_zone_members` VALUES (1,72,'Spree::Country',1,'2014-08-04 10:39:33','2014-08-04 10:39:33'),(2,10,'Spree::Country',1,'2014-08-04 10:39:33','2014-08-04 10:39:33'),(3,76,'Spree::Country',1,'2014-08-04 10:39:33','2014-08-04 10:39:33'),(4,94,'Spree::Country',1,'2014-08-04 10:39:33','2014-08-04 10:39:33'),(5,155,'Spree::Country',1,'2014-08-04 10:39:33','2014-08-04 10:39:33'),(6,13,'Spree::Country',1,'2014-08-04 10:39:34','2014-08-04 10:39:34'),(7,164,'Spree::Country',1,'2014-08-04 10:39:34','2014-08-04 10:39:34'),(8,217,'Spree::Country',1,'2014-08-04 10:39:34','2014-08-04 10:39:34'),(9,167,'Spree::Country',1,'2014-08-04 10:39:34','2014-08-04 10:39:34'),(10,20,'Spree::Country',1,'2014-08-04 10:39:34','2014-08-04 10:39:34'),(11,111,'Spree::Country',1,'2014-08-04 10:39:34','2014-08-04 10:39:34'),(12,175,'Spree::Country',1,'2014-08-04 10:39:34','2014-08-04 10:39:34'),(13,24,'Spree::Country',1,'2014-08-04 10:39:34','2014-08-04 10:39:34'),(14,29,'Spree::Country',1,'2014-08-04 10:39:34','2014-08-04 10:39:34'),(15,98,'Spree::Country',1,'2014-08-04 10:39:34','2014-08-04 10:39:34'),(16,180,'Spree::Country',1,'2014-08-04 10:39:34','2014-08-04 10:39:34'),(17,182,'Spree::Country',1,'2014-08-04 10:39:34','2014-08-04 10:39:34'),(18,44,'Spree::Country',1,'2014-08-04 10:39:34','2014-08-04 10:39:34'),(19,206,'Spree::Country',1,'2014-08-04 10:39:34','2014-08-04 10:39:34'),(20,46,'Spree::Country',1,'2014-08-04 10:39:35','2014-08-04 10:39:35'),(21,211,'Spree::Country',1,'2014-08-04 10:39:35','2014-08-04 10:39:35'),(22,135,'Spree::Country',1,'2014-08-04 10:39:35','2014-08-04 10:39:35'),(23,56,'Spree::Country',1,'2014-08-04 10:39:35','2014-08-04 10:39:35'),(24,207,'Spree::Country',1,'2014-08-04 10:39:35','2014-08-04 10:39:35'),(25,210,'Spree::Country',1,'2014-08-04 10:39:35','2014-08-04 10:39:35'),(26,49,'Spree::Country',2,'2014-08-04 10:39:35','2014-08-04 10:39:35'),(27,204,'Spree::Country',2,'2014-08-04 10:39:35','2014-08-04 10:39:35');
/*!40000 ALTER TABLE `spree_zone_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spree_zones`
--

DROP TABLE IF EXISTS `spree_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spree_zones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `default_tax` tinyint(1) DEFAULT '0',
  `zone_members_count` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spree_zones`
--

LOCK TABLES `spree_zones` WRITE;
/*!40000 ALTER TABLE `spree_zones` DISABLE KEYS */;
INSERT INTO `spree_zones` VALUES (1,'EU_VAT','Countries that make up the EU VAT zone.',0,25,'2014-08-04 10:39:33','2014-08-04 10:39:33'),(2,'North America','USA + Canada',0,2,'2014-08-04 10:39:33','2014-08-04 10:39:33');
/*!40000 ALTER TABLE `spree_zones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) DEFAULT NULL,
  `subscription_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `plan_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `plan_price` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
INSERT INTO `subscriptions` VALUES (1,5,'Small','vegan_small_pack',50.00),(2,10,'Medium','vegan_medium_pack',100.00),(3,20,'Large','vegan_large_pack',200.00);
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tagname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'dsafads','2014-08-06 10:31:10','2014-08-06 10:31:10');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_subscriptions`
--

DROP TABLE IF EXISTS `user_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_subscriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subscription_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_to_id` int(11) DEFAULT '0',
  `braintree_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'active',
  `canceled_at` datetime DEFAULT NULL,
  `paused_at` datetime DEFAULT NULL,
  `resumed_at` datetime DEFAULT NULL,
  `blocked_at` datetime DEFAULT NULL,
  `is_blocked` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_subscriptions`
--

LOCK TABLES `user_subscriptions` WRITE;
/*!40000 ALTER TABLE `user_subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendors`
--

DROP TABLE IF EXISTS `vendors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8_unicode_ci,
  `deleted` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendors`
--

LOCK TABLES `vendors` WRITE;
/*!40000 ALTER TABLE `vendors` DISABLE KEYS */;
INSERT INTO `vendors` VALUES (1,'vendor1','vendor1@email.com','fkalsdjflkasdjflksadgfhasdjgho;sadflk jpifjsda',0,'2014-08-06 07:40:24','2014-08-06 07:40:24');
/*!40000 ALTER TABLE `vendors` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-08-28 16:41:41
