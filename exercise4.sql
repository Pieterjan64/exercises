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
-- Table `mydb`.`doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`doctor` (
  `doctor_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `date_of_birth` DATE NULL,
  `address` VARCHAR(45) NULL,
  `phone_number` INT NULL,
  `salary` INT NULL,
  PRIMARY KEY (`doctor_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`medical` (
  `medical_id` INT NOT NULL,
  `doctor_id` INT NOT NULL,
  `overtime_rate` TIME NULL,
  PRIMARY KEY (`medical_id`),
  INDEX `doctor_id_idx` (`doctor_id` ASC),
  CONSTRAINT `doctor_for`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `mydb`.`doctor` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`specialist` (
  `specialist_id` INT NOT NULL,
  `doctor_id` INT NOT NULL,
  `field_area` VARCHAR(45) NULL,
  PRIMARY KEY (`specialist_id`),
  INDEX `doctor_id_idx` (`doctor_id` ASC),
  CONSTRAINT `doctor_for`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `mydb`.`doctor` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`patient` (
  `patient_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `date_of_birth` DATE NULL,
  `address` VARCHAR(45) NULL,
  `phone_number` INT NULL,
  PRIMARY KEY (`patient_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `payment_id` INT NOT NULL,
  `details` VARCHAR(45) NULL,
  `method` VARCHAR(45) NULL,
  PRIMARY KEY (`payment_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`appointment` (
  `appointment_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  `doctor_id` INT NOT NULL,
  `date` DATE NULL,
  `time` TIME NULL,
  `payment_id` INT NOT NULL,
  PRIMARY KEY (`appointment_id`),
  INDEX `patient_id_idx` (`patient_id` ASC),
  INDEX `doctor_id_idx` (`doctor_id` ASC),
  INDEX `payment_id_idx` (`payment_id` ASC),
  CONSTRAINT `patient_for`
    FOREIGN KEY (`patient_id`)
    REFERENCES `mydb`.`patient` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `doctor_for`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `mydb`.`doctor` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `payment_for`
    FOREIGN KEY (`payment_id`)
    REFERENCES `mydb`.`Payment` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bill` (
  `bill_id` INT NOT NULL,
  `total` INT NULL,
  PRIMARY KEY (`bill_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`payment_bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`payment_bill` (
  `payment_bill_id` INT NOT NULL,
  `payment_id` INT NOT NULL,
  `bill_id` INT NOT NULL,
  PRIMARY KEY (`payment_bill_id`),
  INDEX `fk_payment_bill_1_idx` (`payment_id` ASC),
  INDEX `fk_payment_bill_2_idx` (`bill_id` ASC),
  CONSTRAINT `fk_payment_bill_1`
    FOREIGN KEY (`payment_id`)
    REFERENCES `mydb`.`Payment` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_bill_2`
    FOREIGN KEY (`bill_id`)
    REFERENCES `mydb`.`bill` (`bill_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
