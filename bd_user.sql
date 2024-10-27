-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_users
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_users
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_users` ;
USE `db_users` ;

-- -----------------------------------------------------
-- Table `db_users`.`permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_users`.`permisos` (
  `idPermiso` INT NOT NULL AUTO_INCREMENT,
  `nombrePermiso` VARCHAR(45) NULL,
  `permisos_perfil` JSON NULL,
  PRIMARY KEY (`idPermiso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_users`.`perfiles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_users`.`perfiles` (
  `idPerfiles` INT NOT NULL AUTO_INCREMENT,
  `nombre_perfil` VARCHAR(45) NULL,
  `idPermiso` INT NOT NULL,
  PRIMARY KEY (`idPerfiles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_users`.`datosPersonales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_users`.`datosPersonales` (
  `idDatosPersonales` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(150) NULL,
  `telefono` INT NULL,
  `direccion` VARCHAR(100) NULL,
  `correo_electronico` VARCHAR(75) NULL,
  `fecha_hora` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDatosPersonales`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_users`.`estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_users`.`estados` (
  `idEstados` INT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstados`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_users`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_users`.`usuarios` (
  `idUsuarios` INT NOT NULL AUTO_INCREMENT,
  `idEstados` INT NOT NULL,
  `idPerfiles` INT NOT NULL,
  `idDatosPersonales` INT NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `contrasena` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`idUsuarios`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idEstados_UNIQUE` ON `db_users`.`usuarios` (`idEstados` ASC) VISIBLE;

CREATE UNIQUE INDEX `idPerfiles_UNIQUE` ON `db_users`.`usuarios` (`idPerfiles` ASC) VISIBLE;

CREATE UNIQUE INDEX `idDatosPersonales_UNIQUE` ON `db_users`.`usuarios` (`idDatosPersonales` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `db_users`.`logUsuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_users`.`logUsuarios` (
  `idLogUsuarios` INT NOT NULL AUTO_INCREMENT,
  `idReferencia` INT NOT NULL,
  `log` JSON NULL,
  `fecha_hora` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idLogUsuarios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_users`.`aplicaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_users`.`aplicaciones` (
  `idAplicacion` INT NOT NULL AUTO_INCREMENT,
  `nombreAplacacion` VARCHAR(45) NULL,
  PRIMARY KEY (`idAplicacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_users`.`modulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_users`.`modulos` (
  `idModulo` INT NOT NULL AUTO_INCREMENT,
  `idAplicacion` INT NOT NULL,
  `nombreModulo` VARCHAR(45) NULL,
  `rutaModulo` VARCHAR(45) NULL,
  `estado` TINYINT NULL,
  `urlIcono` VARCHAR(45) NULL,
  `aplicaciones_idAplicacion` VARCHAR(45) NULL,
  `fechaRegistro` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idModulo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_users`.`acciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_users`.`acciones` (
  `idAccion` INT NOT NULL AUTO_INCREMENT,
  `idModulo` INT NOT NULL,
  `accion` VARCHAR(45) NULL,
  `estado` TINYINT NULL,
  PRIMARY KEY (`idAccion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_users`.`sessionLogin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_users`.`sessionLogin` (
  `idSession` INT NOT NULL AUTO_INCREMENT,
  `idUsuarios` INT NOT NULL,
  `token` VARCHAR(500) NULL,
  `estado` TINYINT NULL,
  `fechaLogeo` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idSession`, `idUsuarios`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idUsuarios_UNIQUE` ON `db_users`.`sessionLogin` (`idUsuarios` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `db_users`.`aplicaciones_has_permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_users`.`aplicaciones_has_permisos` (
  `idAplicacion` INT NOT NULL,
  `idPermiso` INT NOT NULL,
  `permisos_app` JSON NULL,
  PRIMARY KEY (`idAplicacion`, `idPermiso`))
ENGINE = InnoDB;

USE `db_users` ;

-- -----------------------------------------------------
-- Placeholder table for view `db_users`.`vstUsuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_users`.`vstUsuarios` (`idUsuarios` INT, `idEstados` INT, `estado` INT, `idPerfiles` INT, `nombre_perfil` INT, `permisos_perfil` INT, `idDatosPersonales` INT, `nombres` INT, `telefono` INT, `direccion` INT, `correo_electronico` INT, `fecha_hora` INT);

-- -----------------------------------------------------
-- procedure prGuardarUsuario
-- -----------------------------------------------------

DELIMITER $$
USE `db_users`$$
CREATE PROCEDURE prGuardarUsuario(
	IN accion varchar(12),
    IN p_nombre VARCHAR(50),
    IN p_telefono INT,
    IN p_direccion varchar(50),
    IN p_usuario VARCHAR(50),
    IN p_correo VARCHAR(100),
    IN p_contrasena VARCHAR(250),
    IN p_idEstado INT,
    IN p_idPerfil INT
)
BEGIN
	DECLARE usuario_existente INT;
    DECLARE correo_existe INT;
	IF accion = 'insert' THEN
		-- Verificar si el usuario ya existe
		SELECT COUNT(*) INTO usuario_existente
			FROM usuarios
		WHERE usuario = p_usuario;
        SELECT COUNT(*) INTO correo_existe
			FROM datosPersonales
		WHERE correo_electronico = p_correo;
		
		-- Si el usuario no existe, insertarlo en la tabla
		IF usuario_existente = 0 AND correo_existe = 0 THEN
			START TRANSACTION;

				INSERT INTO `db_users`.`datosPersonales` (`nombres`, `telefono`, `direccion`, `correo_electronico`) 
				VALUES (p_nombre, p_telefono, p_direccion, p_correo);

				SET @idDatosPersonales = LAST_INSERT_ID();

				INSERT INTO `db_users`.`usuarios` (`idEstados`, `idPerfiles`, `idDatosPersonales`, `usuario`, `contrasena`) 
				VALUES (p_idEstado, p_idPerfil, @idDatosPersonales, p_usuario, p_contrasena);

			COMMIT;
			
			SELECT 'Usuario creado exitosamente.' AS mensaje, 'success' AS respuesta;
		ELSE
			SELECT 'El usuario ya existe.' AS mensaje, 'info' AS respuesta;
		END IF;
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure prLogin
-- -----------------------------------------------------

DELIMITER $$
USE `db_users`$$
CREATE PROCEDURE prLogin(
	IN _usuario varchar(100),
    IN _contrasena varchar(100)
)
BEGIN
	DECLARE login INT;
	SELECT idUsuarios INTO login FROM usuarios WHERE usuario = _usuario AND contrasena = _contrasena;
    IF isnull(login) THEN
		SELECT 'Usuario o Cotraseña incorrecta.' AS mensaje, "info" AS respuesta;
    ELSE
		SELECT 'Logeado exitosamente.' AS mensaje, "success" AS respuesta, login AS "idUsuario";
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure prSession
-- -----------------------------------------------------

DELIMITER $$
USE `db_users`$$
CREATE PROCEDURE prSession(
	IN _idUsuario INT,
    IN _token varchar(500),
    IN _estado INT
)
BEGIN
	DELETE FROM sessionLogin WHERE idUsuarios = _idUsuario;
	INSERT INTO sessionLogin (`idUsuarios`, `token`, `estado`) VALUES (_idUsuario,_token, _estado);
	
    SELECT 'Logeado exitosamente.' AS mensaje, "success" AS respuesta, LAST_INSERT_ID() AS "idSession";
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `db_users`.`vstUsuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db_users`.`vstUsuarios`;
USE `db_users`;
CREATE  OR REPLACE VIEW `vstUsuarios` AS
SELECT 
	us.idUsuarios,
    us.idEstados,
    es.estado,
    us.idPerfiles,
    per.nombre_perfil,
    pm.permisos_perfil,
	dp.*
FROM
	usuarios AS us
        JOIN
    datosPersonales dp ON us.idDatosPersonales = dp.idDatosPersonales
		JOIN
	estados es ON us.idEstados = es.idEstados
		JOIN 
	perfiles per ON us.idPerfiles = per.idPerfiles
		JOIN 
	permisos pm ON per.idPermiso = pm.idPermiso;

-- -----------------------------------------------------
-- Data for table `db_users`.`permisos`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_users`;
INSERT INTO `db_users`.`permisos` (`idPermiso`, `nombrePermiso`, `permisos_perfil`) VALUES (1, 'admin', '{\"admin\":\"1\",\"acercade\":\"1\"}');
INSERT INTO `db_users`.`permisos` (`idPermiso`, `nombrePermiso`, `permisos_perfil`) VALUES (2, 'invitado', '{\"acercade\":\"1\"}');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_users`.`perfiles`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_users`;
INSERT INTO `db_users`.`perfiles` (`idPerfiles`, `nombre_perfil`, `idPermiso`) VALUES (1, 'Administrador', 1);
INSERT INTO `db_users`.`perfiles` (`idPerfiles`, `nombre_perfil`, `idPermiso`) VALUES (2, 'Usuario', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db_users`.`estados`
-- -----------------------------------------------------
START TRANSACTION;
USE `db_users`;
INSERT INTO `db_users`.`estados` (`idEstados`, `estado`) VALUES (1, 'Activo');
INSERT INTO `db_users`.`estados` (`idEstados`, `estado`) VALUES (2, 'Inactivo');
INSERT INTO `db_users`.`estados` (`idEstados`, `estado`) VALUES (5, 'eliminado');

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
