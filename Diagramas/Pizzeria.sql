-- MySQL Script generated by MySQL Workbench
-- Mon Feb  5 17:19:41 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8mb4 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`bebida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`bebida` (
  `id_bebida` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_bebida`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Pizzeria`.`burger`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`burger` (
  `id_burger` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_burger`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Pizzeria`.`categoria_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`categoria_pizza` (
  `id_categoria` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `nombre` INT(50) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Pizzeria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`cliente` (
  `id_cliente` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(70) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `codigo_postal` VARCHAR(10) NOT NULL,
  `localidad` VARCHAR(50) NOT NULL,
  `provincia` VARCHAR(50) NOT NULL,
  `telefono` INT(12) NOT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Pizzeria`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`tienda` (
  `id_tienda` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(70) NOT NULL,
  `codigo_postal` VARCHAR(12) NOT NULL,
  `localidad` VARCHAR(50) NOT NULL,
  `provincia` VARCHAR(50) NOT NULL,
  `id_empleado` SMALLINT(5) NOT NULL,
  PRIMARY KEY (`id_tienda`),
  UNIQUE INDEX `id_empleado` (`id_empleado` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Pizzeria`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`empleado` (
  `id_empleado` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `id_tienda` SMALLINT(5) NOT NULL,
  `departamento` ENUM('cocinero', 'repartidor') NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `apellidos` INT(70) NOT NULL,
  `nif` VARCHAR(20) NOT NULL,
  `telefono` SMALLINT(12) NOT NULL,
  PRIMARY KEY (`id_empleado`),
  UNIQUE INDEX `id_tienda` (`id_tienda` ASC) VISIBLE,
  CONSTRAINT `empleado_ibfk_1`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `Pizzeria`.`tienda` (`id_tienda`)
    ON DELETE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Pizzeria`.`pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`pizza` (
  `id_pizza` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `id_categoria` SMALLINT(5) NOT NULL,
  PRIMARY KEY (`id_pizza`),
  UNIQUE INDEX `id_categoria` (`id_categoria` ASC) VISIBLE,
  CONSTRAINT `id_categoria`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `Pizzeria`.`categoria_pizza` (`id_categoria`)
    ON DELETE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Pizzeria`.`unidad_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`unidad_producto` (
  `id_producto` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` INT(100) NOT NULL,
  `imagen` VARCHAR(50) NOT NULL,
  `precio` SMALLINT(3) NOT NULL,
  `id_pizza` SMALLINT(5) NULL DEFAULT NULL,
  `id_burger` SMALLINT(5) NULL DEFAULT NULL,
  `id_bebida` SMALLINT(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  UNIQUE INDEX `id_pizza` (`id_pizza` ASC) VISIBLE,
  UNIQUE INDEX `id_burger` (`id_burger` ASC) VISIBLE,
  UNIQUE INDEX `id_bebida` (`id_bebida` ASC) VISIBLE,
  CONSTRAINT `id_bebida`
    FOREIGN KEY (`id_bebida`)
    REFERENCES `Pizzeria`.`bebida` (`id_bebida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_burger`
    FOREIGN KEY (`id_burger`)
    REFERENCES `Pizzeria`.`burger` (`id_burger`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_pizza`
    FOREIGN KEY (`id_pizza`)
    REFERENCES `Pizzeria`.`pizza` (`id_pizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Pizzeria`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`pedido` (
  `id_pedido` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `hora` TIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `tipo_entrega` ENUM('recogida tienda', 'domicilio') NOT NULL,
  `cantidad_productos` SMALLINT(3) NOT NULL,
  `precio_total` SMALLINT(4) NOT NULL,
  `id_cliente` SMALLINT(5) NOT NULL,
  `id_tienda` SMALLINT(5) NOT NULL,
  `id_producto` SMALLINT(5) NOT NULL,
  PRIMARY KEY (`id_pedido`),
  UNIQUE INDEX `id_tienda` (`id_tienda` ASC) VISIBLE,
  UNIQUE INDEX `id_producto` (`id_producto` ASC) VISIBLE,
  INDEX `id_cliente` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `id_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `Pizzeria`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_producto`
    FOREIGN KEY (`id_producto`)
    REFERENCES `Pizzeria`.`unidad_producto` (`id_producto`)
    ON UPDATE NO ACTION,
  CONSTRAINT `id_tienda`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `Pizzeria`.`tienda` (`id_tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Pizzeria`.`entrega_domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`entrega_domicilio` (
  `id_entrega` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `id_pedido` SMALLINT(5) NOT NULL,
  `id_repartidor` SMALLINT(5) NOT NULL,
  `hora_entrega` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (`id_entrega`),
  UNIQUE INDEX `id_repartidor` (`id_repartidor` ASC) VISIBLE,
  INDEX `id_pedido` (`id_pedido` ASC) VISIBLE,
  CONSTRAINT `id_pedido`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `Pizzeria`.`pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_repartidor`
    FOREIGN KEY (`id_repartidor`)
    REFERENCES `Pizzeria`.`empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
