-- MySQL Script generated by MySQL Workbench
-- 05/10/17 18:59:11
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `idUsers` INT NOT NULL,
  `UserName` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `PhoneNumber` VARCHAR(45) NOT NULL,
  `Level` INT NOT NULL,
  `PictureURL` VARCHAR(45) NULL,
  PRIMARY KEY (`idUsers`, `UserName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tenant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tenant` (
  `idTenant` INT NOT NULL,
  PRIMARY KEY (`idTenant`),
  CONSTRAINT `idUsers`
    FOREIGN KEY (`idTenant`)
    REFERENCES `mydb`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Host`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Host` (
  `idHost` INT NOT NULL,
  `Approved` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idHost`),
  CONSTRAINT `idUsers`
    FOREIGN KEY (`idHost`)
    REFERENCES `mydb`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Houses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Houses` (
  `idHouses` INT NOT NULL,
  `idHost` INT NOT NULL,
  `available_from` DATE NOT NULL,
  `available_to` DATE NOT NULL,
  `Price` INT NOT NULL,
  `Photo` VARCHAR(45) NOT NULL,
  `Type` INT NOT NULL,
  `Number_of_reviews` INT NOT NULL,
  `Stars` INT NOT NULL,
  `Location` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idHouses`, `idHost`),
  INDEX `idHost_idx` (`idHost` ASC),
  CONSTRAINT `idHost`
    FOREIGN KEY (`idHost`)
    REFERENCES `mydb`.`Host` (`idHost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reviews` (
  `idReviews` INT NOT NULL,
  `Houses_idHouses` INT NOT NULL,
  `Houses_idHost` INT NOT NULL,
  `rented_from` DATE NOT NULL,
  `rented_to` DATE NOT NULL,
  `Review` LONGTEXT NOT NULL,
  `Tenant_idTenant` INT NOT NULL,
  `Stars` INT NOT NULL,
  PRIMARY KEY (`idReviews`, `Houses_idHouses`, `Houses_idHost`, `Tenant_idTenant`),
  INDEX `fk_Reviews_Houses1_idx` (`Houses_idHouses` ASC, `Houses_idHost` ASC),
  INDEX `fk_Reviews_Tenant1_idx` (`Tenant_idTenant` ASC),
  CONSTRAINT `fk_Reviews_Houses1`
    FOREIGN KEY (`Houses_idHouses` , `Houses_idHost`)
    REFERENCES `mydb`.`Houses` (`idHouses` , `idHost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reviews_Tenant1`
    FOREIGN KEY (`Tenant_idTenant`)
    REFERENCES `mydb`.`Tenant` (`idTenant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Booked`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Booked` (
  `FROM` DATE NOT NULL,
  `TO` DATE NOT NULL,
  `Houses_idHouses` INT NOT NULL,
  `Houses_idHost` INT NOT NULL,
  PRIMARY KEY (`Houses_idHouses`, `Houses_idHost`),
  CONSTRAINT `fk_Booked_Houses1`
    FOREIGN KEY (`Houses_idHouses` , `Houses_idHost`)
    REFERENCES `mydb`.`Houses` (`idHouses` , `idHost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tenant_has_Booked`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tenant_has_Booked` (
  `Tenant_idTenant` INT NOT NULL,
  `Booked_Houses_idHouses` INT NOT NULL,
  `Booked_Houses_idHost` INT NOT NULL,
  PRIMARY KEY (`Tenant_idTenant`, `Booked_Houses_idHouses`, `Booked_Houses_idHost`),
  INDEX `fk_Tenant_has_Booked_Booked1_idx` (`Booked_Houses_idHouses` ASC, `Booked_Houses_idHost` ASC),
  INDEX `fk_Tenant_has_Booked_Tenant1_idx` (`Tenant_idTenant` ASC),
  CONSTRAINT `fk_Tenant_has_Booked_Tenant1`
    FOREIGN KEY (`Tenant_idTenant`)
    REFERENCES `mydb`.`Tenant` (`idTenant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tenant_has_Booked_Booked1`
    FOREIGN KEY (`Booked_Houses_idHouses` , `Booked_Houses_idHost`)
    REFERENCES `mydb`.`Booked` (`Houses_idHouses` , `Houses_idHost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`House_Details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`House_Details` (
  `Houses_idHouses` INT NOT NULL,
  `Houses_idHost` INT NOT NULL,
  `WiFi` TINYINT(1) NULL,
  `Cool` TINYINT(1) NULL,
  `Heat` TINYINT(1) NULL,
  `TV` TINYINT(1) NULL,
  `Parking` TINYINT(1) NULL,
  `Elevator` TINYINT(1) NULL,
  `Number_of_beds` INT NOT NULL,
  `Number_of_bathrooms` INT NOT NULL,
  `Number_of_bedrooms` INT NOT NULL,
  `Livingroom` TINYINT(1) NOT NULL,
  `Surface` INT NOT NULL,
  `Details` MEDIUMTEXT NOT NULL,
  `Smoking` TINYINT(1) NULL,
  `Pets` TINYINT(1) NULL,
  `Fests` TINYINT(1) NULL,
  `Min_rent_days` INT NOT NULL,
  `Location_URL` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Houses_idHouses`, `Houses_idHost`),
  CONSTRAINT `fk_House_Details_Houses1`
    FOREIGN KEY (`Houses_idHouses` , `Houses_idHost`)
    REFERENCES `mydb`.`Houses` (`idHouses` , `idHost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
