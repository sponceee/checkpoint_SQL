-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema laAprobacion
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema laAprobacion
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `laAprobacion` DEFAULT CHARACTER SET utf8 ;
USE `laAprobacion` ;

-- -----------------------------------------------------
-- Table `laAprobacion`.`clasesHabitaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laAprobacion`.`clasesHabitaciones` (
  `idClasesHabitaciones` TINYINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  `costoDiarioPersona` FLOAT(8,2) NOT NULL,
  PRIMARY KEY (`idClasesHabitaciones`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laAprobacion`.`decoracionHabitaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laAprobacion`.`decoracionHabitaciones` (
  `idDecoracionHabitacion` TINYINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDecoracionHabitacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laAprobacion`.`formaDePago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laAprobacion`.`formaDePago` (
  `idFormaDePago` TINYINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFormaDePago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laAprobacion`.`checkIn`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laAprobacion`.`checkIn` (
  `idCheckIn` INT NOT NULL AUTO_INCREMENT,
  `fechaEntrada` DATE NOT NULL,
  `fechaSalida` DATE NOT NULL,
  `importe` FLOAT(8,2) NOT NULL,
  `formaDePago_idFormaDePago` TINYINT NOT NULL,
  PRIMARY KEY (`idCheckIn`),
  INDEX `fk_checkIn_formaDePago1_idx` (`formaDePago_idFormaDePago` ASC) VISIBLE,
  CONSTRAINT `fk_checkIn_formaDePago1`
    FOREIGN KEY (`formaDePago_idFormaDePago`)
    REFERENCES `laAprobacion`.`formaDePago` (`idFormaDePago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laAprobacion`.`habitaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laAprobacion`.`habitaciones` (
  `idHabitaciones` TINYINT NOT NULL AUTO_INCREMENT,
  `capacidadMaxima` TINYINT NOT NULL,
  `clasesHabitaciones_idClasesHabitaciones` TINYINT NOT NULL,
  `decoracionHabitaciones_idDecoracionHabitacion` TINYINT NOT NULL,
  `checkIn_idCheckIn` INT NOT NULL,
  PRIMARY KEY (`idHabitaciones`),
  INDEX `fk_habitaciones_clasesHabitaciones_idx` (`clasesHabitaciones_idClasesHabitaciones` ASC) VISIBLE,
  INDEX `fk_habitaciones_decoracionHabitaciones1_idx` (`decoracionHabitaciones_idDecoracionHabitacion` ASC) VISIBLE,
  INDEX `fk_habitaciones_checkIn1_idx` (`checkIn_idCheckIn` ASC) VISIBLE,
  CONSTRAINT `fk_habitaciones_clasesHabitaciones`
    FOREIGN KEY (`clasesHabitaciones_idClasesHabitaciones`)
    REFERENCES `laAprobacion`.`clasesHabitaciones` (`idClasesHabitaciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_habitaciones_decoracionHabitaciones1`
    FOREIGN KEY (`decoracionHabitaciones_idDecoracionHabitacion`)
    REFERENCES `laAprobacion`.`decoracionHabitaciones` (`idDecoracionHabitacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_habitaciones_checkIn1`
    FOREIGN KEY (`checkIn_idCheckIn`)
    REFERENCES `laAprobacion`.`checkIn` (`idCheckIn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laAprobacion`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laAprobacion`.`pais` (
  `idPais` TINYINT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laAprobacion`.`sectorTrabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laAprobacion`.`sectorTrabajo` (
  `idSectorTrabajo` TINYINT NOT NULL AUTO_INCREMENT,
  `nombreDeSector` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSectorTrabajo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laAprobacion`.`estadoEmpleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laAprobacion`.`estadoEmpleado` (
  `idEstadoEmpleado` TINYINT NOT NULL AUTO_INCREMENT,
  `descripcionEstado` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idEstadoEmpleado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laAprobacion`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laAprobacion`.`empleados` (
  `idLegajo` INT NOT NULL,
  `apellido` VARCHAR(80) NOT NULL,
  `nombre` VARCHAR(80) NOT NULL,
  `documento` INT NOT NULL,
  `fechaDeNacimiento` DATE NOT NULL,
  `domicilio` VARCHAR(150) NULL,
  `telefono` VARCHAR(20) NULL,
  `email` VARCHAR(100) NULL,
  `pais_idPais` INT NOT NULL,
  `sectorTrabajo_idSectorTrabajo` TINYINT NOT NULL,
  `estadoEmpleado_idEstadoEmpleado` TINYINT NOT NULL,
  PRIMARY KEY (`idLegajo`),
  INDEX `fk_empleados_pais1_idx` (`pais_idPais` ASC) VISIBLE,
  INDEX `fk_empleados_sectorTrabajo1_idx` (`sectorTrabajo_idSectorTrabajo` ASC) VISIBLE,
  INDEX `fk_empleados_estadoEmpleado1_idx` (`estadoEmpleado_idEstadoEmpleado` ASC) VISIBLE,
  CONSTRAINT `fk_empleados_pais1`
    FOREIGN KEY (`pais_idPais`)
    REFERENCES `laAprobacion`.`pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleados_sectorTrabajo1`
    FOREIGN KEY (`sectorTrabajo_idSectorTrabajo`)
    REFERENCES `laAprobacion`.`sectorTrabajo` (`idSectorTrabajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleados_estadoEmpleado1`
    FOREIGN KEY (`estadoEmpleado_idEstadoEmpleado`)
    REFERENCES `laAprobacion`.`estadoEmpleado` (`idEstadoEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laAprobacion`.`reservaExtras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laAprobacion`.`reservaExtras` (
  `idReservaExtras` INT NOT NULL AUTO_INCREMENT,
  `fechaYHora` DATETIME NOT NULL,
  `cantidadDeHorasReservadas` TINYINT NOT NULL,
  `importe` FLOAT(6,2) NOT NULL,
  `formaDePago_idFormaDePago` TINYINT NOT NULL,
  PRIMARY KEY (`idReservaExtras`),
  INDEX `fk_reservaExtras_formaDePago1_idx` (`formaDePago_idFormaDePago` ASC) VISIBLE,
  CONSTRAINT `fk_reservaExtras_formaDePago1`
    FOREIGN KEY (`formaDePago_idFormaDePago`)
    REFERENCES `laAprobacion`.`formaDePago` (`idFormaDePago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laAprobacion`.`huespedes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laAprobacion`.`huespedes` (
  `idHuespedes` INT NOT NULL AUTO_INCREMENT,
  `apellido` VARCHAR(80) NOT NULL,
  `nombre` VARCHAR(80) NOT NULL,
  `pasaporte` VARCHAR(45) NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `domicilio` VARCHAR(150) NULL,
  `telefono` VARCHAR(20) NULL,
  `email` VARCHAR(100) NOT NULL,
  `reservaExtras_idReservaExtras` INT NOT NULL,
  `checkIn_idCheckIn` INT NOT NULL,
  `pais_idPais` TINYINT NOT NULL,
  PRIMARY KEY (`idHuespedes`),
  INDEX `fk_huespedes_reservaExtras1_idx` (`reservaExtras_idReservaExtras` ASC) VISIBLE,
  INDEX `fk_huespedes_checkIn1_idx` (`checkIn_idCheckIn` ASC) VISIBLE,
  INDEX `fk_huespedes_pais1_idx` (`pais_idPais` ASC) VISIBLE,
  CONSTRAINT `fk_huespedes_reservaExtras1`
    FOREIGN KEY (`reservaExtras_idReservaExtras`)
    REFERENCES `laAprobacion`.`reservaExtras` (`idReservaExtras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_huespedes_checkIn1`
    FOREIGN KEY (`checkIn_idCheckIn`)
    REFERENCES `laAprobacion`.`checkIn` (`idCheckIn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_huespedes_pais1`
    FOREIGN KEY (`pais_idPais`)
    REFERENCES `laAprobacion`.`pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laAprobacion`.`serviciosBasicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laAprobacion`.`serviciosBasicos` (
  `idServiciosBasicos` TINYINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idServiciosBasicos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laAprobacion`.`serviciosExtra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laAprobacion`.`serviciosExtra` (
  `idServiciosExtra` TINYINT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  `costoPorHora` FLOAT(6,2) NOT NULL,
  PRIMARY KEY (`idServiciosExtra`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laAprobacion`.`serviciosXHabitacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laAprobacion`.`serviciosXHabitacion` (
  `idServiciosXHabitacion` INT NOT NULL AUTO_INCREMENT,
  `serviciosBasicos_idServiciosBasicos` TINYINT NOT NULL,
  `habitaciones_idHabitaciones` TINYINT NOT NULL,
  PRIMARY KEY (`idServiciosXHabitacion`),
  INDEX `fk_serviciosXHabitacion_serviciosBasicos1_idx` (`serviciosBasicos_idServiciosBasicos` ASC) VISIBLE,
  INDEX `fk_serviciosXHabitacion_habitaciones1_idx` (`habitaciones_idHabitaciones` ASC) VISIBLE,
  CONSTRAINT `fk_serviciosXHabitacion_serviciosBasicos1`
    FOREIGN KEY (`serviciosBasicos_idServiciosBasicos`)
    REFERENCES `laAprobacion`.`serviciosBasicos` (`idServiciosBasicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_serviciosXHabitacion_habitaciones1`
    FOREIGN KEY (`habitaciones_idHabitaciones`)
    REFERENCES `laAprobacion`.`habitaciones` (`idHabitaciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laAprobacion`.`serviciosExtrasXReserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laAprobacion`.`serviciosExtrasXReserva` (
  `idServiciosExtrasXReserva` INT NOT NULL AUTO_INCREMENT,
  `serviciosExtra_idServiciosExtra` TINYINT NOT NULL,
  `reservaExtras_idReservaExtras` INT NOT NULL,
  PRIMARY KEY (`idServiciosExtrasXReserva`),
  INDEX `fk_serviciosExtrasXReserva_serviciosExtra1_idx` (`serviciosExtra_idServiciosExtra` ASC) VISIBLE,
  INDEX `fk_serviciosExtrasXReserva_reservaExtras1_idx` (`reservaExtras_idReservaExtras` ASC) VISIBLE,
  CONSTRAINT `fk_serviciosExtrasXReserva_serviciosExtra1`
    FOREIGN KEY (`serviciosExtra_idServiciosExtra`)
    REFERENCES `laAprobacion`.`serviciosExtra` (`idServiciosExtra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_serviciosExtrasXReserva_reservaExtras1`
    FOREIGN KEY (`reservaExtras_idReservaExtras`)
    REFERENCES `laAprobacion`.`reservaExtras` (`idReservaExtras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
