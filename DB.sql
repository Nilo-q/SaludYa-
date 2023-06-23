-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SaludYA
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SaludYA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SaludYA` DEFAULT CHARACTER SET utf8 ;
USE `SaludYA` ;

-- -----------------------------------------------------
-- Table `SaludYA`.`Tipo de usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SaludYA`.`Tipo de usuarios` (
  `IdTipoUsuario` INT NOT NULL,
  `Administrador` INT NULL,
  `Medico` INT NULL,
  `Paciente` INT NULL,
  PRIMARY KEY (`IdTipoUsuario`),
  INDEX `TipUsuario_idx` (`Paciente` ASC, `Medico` ASC, `Administrador` ASC) VISIBLE,
  CONSTRAINT `TipUsuario`
    FOREIGN KEY (`Paciente` , `Medico` , `Administrador`)
    REFERENCES `SaludYA`.`Usuario` (`IdUsuario` , `IdUsuario` , `IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SaludYA`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SaludYA`.`Usuario` (
  `IdUsuario` INT NOT NULL AUTO_INCREMENT,
  `Nombres` VARCHAR(45) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Fecha de nacimiento` VARCHAR(45) NOT NULL,
  `Telefono` INT(13) NOT NULL,
  `Correo` VARCHAR(45) NOT NULL,
  `Contraseña` INT(6) NOT NULL,
  `IdTipoUsuario` INT NOT NULL,
  `TarjetaProfesional` INT NOT NULL,
  PRIMARY KEY (`IdUsuario`),
  INDEX `TipUsuario_idx` (`IdTipoUsuario` ASC) VISIBLE,
  INDEX `Tarjeta _idx` (`TarjetaProfesional` ASC) VISIBLE,
  CONSTRAINT `TipUsuario`
    FOREIGN KEY (`IdTipoUsuario`)
    REFERENCES `SaludYA`.`Tipo de usuarios` (`IdTipoUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Tarjeta `
    FOREIGN KEY (`TarjetaProfesional`)
    REFERENCES `SaludYA`.`Tipo de usuarios` (`Medico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SaludYA`.`H clinica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SaludYA`.`H clinica` (
  `IdHClinica` INT NOT NULL,
  `FechaCreacion` DATE NULL,
  `Diagnostico` VARCHAR(45) NULL,
  `Tratamiento` VARCHAR(45) NULL,
  `Procedimiento` VARCHAR(45) NULL,
  `AntecedentesPersonales` VARCHAR(45) NULL,
  `IdUsuario` INT NOT NULL,
  PRIMARY KEY (`IdHClinica`),
  INDEX `IdUsuario_idx` (`IdUsuario` ASC) VISIBLE,
  CONSTRAINT `IdUsuario`
    FOREIGN KEY (`IdUsuario`)
    REFERENCES `SaludYA`.`Usuario` (`IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SaludYA`.`Formula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SaludYA`.`Formula` (
  `IdFormula` INT NOT NULL,
  `fecha` DATE NULL,
  `Medicamentos` VARCHAR(45) GENERATED ALWAYS AS () VIRTUAL,
  `Dosis` VARCHAR(45) NULL,
  `Cantidad` VARCHAR(45) NULL,
  `Duracion` VARCHAR(45) NULL,
  `IdUsuario` INT NOT NULL,
  PRIMARY KEY (`IdFormula`),
  INDEX `IdUsuario_idx` (`IdUsuario` ASC) VISIBLE,
  CONSTRAINT `IdUsuario`
    FOREIGN KEY (`IdUsuario`)
    REFERENCES `SaludYA`.`Usuario` (`IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'IdUsuario';


-- -----------------------------------------------------
-- Table `SaludYA`.`Factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SaludYA`.`Factura` (
  `IdFactura` INT NOT NULL,
  `FechaEmision` DATE NOT NULL,
  `Valor` VARCHAR(45) NULL,
  `IdUsuario` INT NOT NULL,
  INDEX `IdUsuario_idx` (`IdUsuario` ASC) VISIBLE,
  PRIMARY KEY (`IdFactura`),
  CONSTRAINT `IdUsuario`
    FOREIGN KEY (`IdUsuario`)
    REFERENCES `SaludYA`.`Usuario` (`IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SaludYA`.`Atencion Medica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SaludYA`.`Atencion Medica` (
  `IdAtencionMedica` INT NOT NULL,
  `FechaAtencion` VARCHAR(45) NOT NULL,
  `IdFormula` INT NOT NULL,
  `Diagnostico` VARCHAR(45) NOT NULL,
  `Observaciones` VARCHAR(45) NULL,
  PRIMARY KEY (`IdAtencionMedica`),
  INDEX `IdFormula_idx` (`IdFormula` ASC) VISIBLE,
  CONSTRAINT `IdFormula`
    FOREIGN KEY (`IdFormula`)
    REFERENCES `SaludYA`.`Formula` (`IdFormula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
