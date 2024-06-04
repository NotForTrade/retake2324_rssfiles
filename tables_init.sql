-- Adminer 4.8.1 MySQL 10.11.3-MariaDB-1 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

CREATE DATABASE `test` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `test`;


DROP TABLE IF EXISTS `attendance`;
CREATE TABLE `attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tutor_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `component_id` int(11) NOT NULL,
  `value` VARCHAR(255) NOT NULL,
  `session` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tutor_id` (`tutor_id`),
  KEY `student_id` (`student_id`),
  KEY `component_id` (`component_id`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`tutor_id`) REFERENCES `user` (`id`),
  CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `user` (`id`),
  CONSTRAINT `attendance_ibfk_3` FOREIGN KEY (`component_id`) REFERENCES `component` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `component`;
CREATE TABLE `component` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `module_id` (`module_id`),
  CONSTRAINT `component_ibfk_1` FOREIGN KEY (`module_id`) REFERENCES `module` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer` varchar(255),
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `tutor_mapping`;
CREATE TABLE `tutor_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tutor_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `component_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tutor_id` (`tutor_id`),
  KEY `group_id` (`group_id`),
  KEY `component_id` (`component_id`),
  CONSTRAINT `tutor_mapping_ibfk_1` FOREIGN KEY (`tutor_id`) REFERENCES `user` (`id`),
  CONSTRAINT `tutor_mapping_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`),
  CONSTRAINT `tutor_mapping_ibfk_3` FOREIGN KEY (`component_id`) REFERENCES `component` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `group_observation`;
CREATE TABLE `group_observation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `skill_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `observation` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `skill_id` (`skill_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `group_observation_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`),
  CONSTRAINT `group_observation_ibfk_2` FOREIGN KEY (`skill_id`) REFERENCES `skill` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `module`;
CREATE TABLE `module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `skill`;
CREATE TABLE `skill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `component_id` int(11) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `coefficient` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `score`;
CREATE TABLE `score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `value` int(11),
  `observation` VARCHAR(255),
  `active` BOOLEAN NOT NULL,
  `datetime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  KEY `skill_id` (`skill_id`),
  CONSTRAINT `score_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `user` (`id`),
  CONSTRAINT `score_ibfk_2` FOREIGN KEY (`skill_id`) REFERENCES `skill` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `group_id` int(11),
  `module_id` int(11),
  `component_id` int(11),
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `photo` LONGTEXT,
  `password` CHAR(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `component_id` (`component_id`),
  KEY `module_id` (`module_id`),
  KEY `group_id` (`group_id`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `user_ibfk_4` FOREIGN KEY (`component_id`) REFERENCES `component` (`id`),
  CONSTRAINT `user_ibfk_5` FOREIGN KEY (`module_id`) REFERENCES `module` (`id`),
  CONSTRAINT `user_ibfk_6` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tutor_id` int(11) NOT NULL,
  `group_id` int(11),
  `title` VARCHAR(255) NOT NULL,
  `content` longtext NOT NULL,
  `datetime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tutor_id` (`tutor_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `announcement_ibfk_1` FOREIGN KEY (`tutor_id`) REFERENCES `user` (`id`),
  CONSTRAINT `announcement_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `reassessment`;
CREATE TABLE `reassessment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `score_id` int(11),
  `document` longtext NOT NULL,
  `datetime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `treated` BOOLEAN NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  KEY `skill_id` (`skill_id`),
  KEY `score_id` (`score_id`),
  CONSTRAINT `reassessment_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `user` (`id`),
  CONSTRAINT `reassessment_ibfk_2` FOREIGN KEY (`skill_id`) REFERENCES `skill` (`id`),
  CONSTRAINT `reassessment_ibfk_3` FOREIGN KEY (`score_id`) REFERENCES `score` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
