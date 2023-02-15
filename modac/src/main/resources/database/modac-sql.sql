-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema modac
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema modac
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `modac` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `modac` ;

-- -----------------------------------------------------
-- Table `modac`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modac`.`users` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(30) NOT NULL,
  `id` VARCHAR(20) NOT NULL,
  `nickname` VARCHAR(20) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `cat_skin` INT NOT NULL,
  `single_theme` VARCHAR(45) NOT NULL,
  `total_second` INT NOT NULL,
  `membership_level` VARCHAR(20) NOT NULL,
  `point` INT NOT NULL,
  `max_point` INT NOT NULL,
  PRIMARY KEY (`seq`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modac`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modac`.`categories` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `template_filepath` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`seq`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modac`.`todos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modac`.`todos` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `users_seq` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `status` INT NOT NULL,
  `total_second` INT NOT NULL,
  `categories_seq` INT NOT NULL,
  PRIMARY KEY (`seq`),
  INDEX `fk_todos_users_idx` (`users_seq` ASC) VISIBLE,
  INDEX `fk_todos_categories1_idx` (`categories_seq` ASC) VISIBLE,
  CONSTRAINT `fk_todos_users`
    FOREIGN KEY (`users_seq`)
    REFERENCES `modac`.`users` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_todos_categories1`
    FOREIGN KEY (`categories_seq`)
    REFERENCES `modac`.`categories` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modac`.`articles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modac`.`articles` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(50) NOT NULL,
  `filepath` VARCHAR(150) NULL,
  `registered_time` DATETIME NOT NULL,
  `public_type` INT NOT NULL,
  `view_count` INT NOT NULL,
  `like_count` INT NOT NULL,
  `comment_count` INT NOT NULL,
  `total_second` INT NOT NULL,
  `users_seq` INT NOT NULL,
  `categories_seq` INT NOT NULL,
  PRIMARY KEY (`seq`),
  INDEX `fk_articles_users1_idx` (`users_seq` ASC) VISIBLE,
  INDEX `fk_articles_categories1_idx` (`categories_seq` ASC) VISIBLE,
  CONSTRAINT `fk_articles_users1`
    FOREIGN KEY (`users_seq`)
    REFERENCES `modac`.`users` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_articles_categories1`
    FOREIGN KEY (`categories_seq`)
    REFERENCES `modac`.`categories` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modac`.`likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modac`.`likes` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `users_seq` INT NOT NULL,
  `articles_seq` INT NOT NULL,
  PRIMARY KEY (`seq`),
  INDEX `fk_likes_articles1_idx` (`articles_seq` ASC) VISIBLE,
  INDEX `fk_likes_users1_idx` (`users_seq` ASC) VISIBLE,
  CONSTRAINT `fk_likes_articles1`
    FOREIGN KEY (`articles_seq`)
    REFERENCES `modac`.`articles` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_likes_users1`
    FOREIGN KEY (`users_seq`)
    REFERENCES `modac`.`users` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modac`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modac`.`comments` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(100) NOT NULL,
  `registered_time` DATETIME NOT NULL,
  `articles_seq` INT NOT NULL,
  `users_seq` INT NOT NULL,
  PRIMARY KEY (`seq`),
  INDEX `fk_comment_articles1_idx` (`articles_seq` ASC) VISIBLE,
  INDEX `fk_comment_users1_idx` (`users_seq` ASC) VISIBLE,
  CONSTRAINT `fk_comment_articles1`
    FOREIGN KEY (`articles_seq`)
    REFERENCES `modac`.`articles` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_users1`
    FOREIGN KEY (`users_seq`)
    REFERENCES `modac`.`users` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modac`.`chat_rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modac`.`chat_rooms` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `last_message_seq` INT NULL,
  `last_message_time` DATETIME NULL,
  PRIMARY KEY (`seq`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modac`.`rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modac`.`rooms` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(30) NOT NULL,
  `description` VARCHAR(100) NULL,
  `max_size` INT NOT NULL,
  `current_size` INT NOT NULL,
  `multi_theme` VARCHAR(30) NULL,
  `public_type` INT NOT NULL,
  `invitation_code` VARCHAR(20) NULL,
  `users_seq` INT NOT NULL,
  `chat_rooms_seq` INT NOT NULL,
  PRIMARY KEY (`seq`),
  INDEX `fk_rooms_users1_idx` (`users_seq` ASC) VISIBLE,
  INDEX `fk_rooms_chat_rooms1_idx` (`chat_rooms_seq` ASC) VISIBLE,
  CONSTRAINT `fk_rooms_users1`
    FOREIGN KEY (`users_seq`)
    REFERENCES `modac`.`users` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rooms_chat_rooms1`
    FOREIGN KEY (`chat_rooms_seq`)
    REFERENCES `modac`.`chat_rooms` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modac`.`followings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modac`.`followings` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `from_seq` INT NOT NULL,
  `to_seq` INT NOT NULL,
  `chat_rooms_seq` INT NOT NULL,
  PRIMARY KEY (`seq`),
  INDEX `fk_following_users1_idx` (`from_seq` ASC) VISIBLE,
  INDEX `fk_following_users2_idx` (`to_seq` ASC) VISIBLE,
  INDEX `fk_following_chat_rooms1_idx` (`chat_rooms_seq` ASC) VISIBLE,
  CONSTRAINT `fk_following_users1`
    FOREIGN KEY (`from_seq`)
    REFERENCES `modac`.`users` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_following_users2`
    FOREIGN KEY (`to_seq`)
    REFERENCES `modac`.`users` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_following_chat_rooms1`
    FOREIGN KEY (`chat_rooms_seq`)
    REFERENCES `modac`.`chat_rooms` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modac`.`chat_messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modac`.`chat_messages` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `users_seq` INT NOT NULL,
  `chat_rooms_seq` INT NOT NULL,
  `send_time` DATETIME NULL DEFAULT now(),
  `message` VARCHAR(200) NULL,
  PRIMARY KEY (`seq`),
  INDEX `fk_chat_logs_users1_idx` (`users_seq` ASC) VISIBLE,
  INDEX `fk_chat_logs_chat_rooms1_idx` (`chat_rooms_seq` ASC) VISIBLE,
  CONSTRAINT `fk_chat_logs_users1`
    FOREIGN KEY (`users_seq`)
    REFERENCES `modac`.`users` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_chat_logs_chat_rooms1`
    FOREIGN KEY (`chat_rooms_seq`)
    REFERENCES `modac`.`chat_rooms` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modac`.`notifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modac`.`notifications` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `registered_time` DATETIME NOT NULL,
  `is_read` TINYINT(1) NOT NULL,
  `type` VARCHAR(45) NULL,
  `articles_seq` INT NULL,
  `from_users_seq` INT NULL,
  `to_users_seq` INT NOT NULL,
  PRIMARY KEY (`seq`),
  INDEX `fk_notification_articles1_idx` (`articles_seq` ASC) VISIBLE,
  INDEX `fk_notification_users1_idx` (`from_users_seq` ASC) VISIBLE,
  INDEX `fk_notification_users2_idx` (`to_users_seq` ASC) VISIBLE,
  CONSTRAINT `fk_notification_articles1`
    FOREIGN KEY (`articles_seq`)
    REFERENCES `modac`.`articles` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notification_users1`
    FOREIGN KEY (`from_users_seq`)
    REFERENCES `modac`.`users` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notification_users2`
    FOREIGN KEY (`to_users_seq`)
    REFERENCES `modac`.`users` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modac`.`musics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modac`.`musics` (
  `name` VARCHAR(50) NULL,
  `filepath` VARCHAR(50) NULL,
  `seq` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`seq`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modac`.`participants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modac`.`participants` (
  `rooms_seq` INT NOT NULL,
  `users_seq` INT NOT NULL,
  `nickname` VARCHAR(20) NULL,
  `status` INT NOT NULL,
  `attend` INT NOT NULL,
  `cat_skin` INT NOT NULL,
  `categories_name` VARCHAR(30) NULL,
  `registered_time` DATETIME NOT NULL,
  PRIMARY KEY (`rooms_seq`, `users_seq`),
  INDEX `fk_participants_rooms1_idx` (`rooms_seq` ASC) VISIBLE,
  CONSTRAINT `fk_participants_rooms1`
    FOREIGN KEY (`rooms_seq`)
    REFERENCES `modac`.`rooms` (`seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- 더미데이터 삽입
INSERT INTO `modac`.`categories` values (0, '알고리즘', 'markdown_templates/알고리즘.md');
INSERT INTO `modac`.`categories` values (0, 'CS', 'markdown_templates/CS.md');
INSERT INTO `modac`.`categories` values (0, '개발', 'markdown_templates/개발.md');
INSERT INTO `modac`.`categories` values (0, '면접', 'markdown_templates/면접.md');
INSERT INTO `modac`.`categories` values (0, '공통','markdown_templates/공통.md');

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
