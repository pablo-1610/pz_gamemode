-- Db init
CREATE DATABASE pz_gamemode;
-- Table users
CREATE TABLE `pz_gamemode`.`pz_users` ( `id` INT NOT NULL AUTO_INCREMENT , `license` VARCHAR(80) NOT NULL , `name` TEXT NOT NULL , `rank` INT NOT NULL , `rolePlayIdentity` TEXT NOT NULL , `createdAt` TEXT NOT NULL , `updatedAt` INT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
-- Table ranks
CREATE TABLE `pz_gamemode`.`pz_ranks` ( `id` INT NOT NULL AUTO_INCREMENT , `identifier` TEXT NOT NULL , `display` TEXT NOT NULL , `color` TEXT NOT NULL , `permissions` TEXT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
