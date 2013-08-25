SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `db timesheet` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `db timesheet` ;

-- -----------------------------------------------------
-- Table `db timesheet`.`statut`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db timesheet`.`statut` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nom` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db timesheet`.`utilisateur`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db timesheet`.`utilisateur` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nom` VARCHAR(45) NULL ,
  `prenom` VARCHAR(45) NULL ,
  `mail` VARCHAR(100) NULL ,
  `id_statut_util` INT NOT NULL ,
  `login` VARCHAR(45) NOT NULL ,
  `mdp` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `mail_UNIQUE` (`mail` ASC) ,
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) ,
  INDEX `fk_statut_utilisateur_idx` (`id_statut_util` ASC) ,
  CONSTRAINT `fk_statut_utilisateur`
    FOREIGN KEY (`id_statut_util` )
    REFERENCES `db timesheet`.`statut` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db timesheet`.`projet`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db timesheet`.`projet` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `description` TEXT NULL ,
  `id_chef_projet` INT NOT NULL ,
  `id_statut_proj` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_projet_statut_idx` (`id_statut_proj` ASC) ,
  CONSTRAINT `fk_projet_statut`
    FOREIGN KEY (`id_statut_proj` )
    REFERENCES `db timesheet`.`statut` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db timesheet`.`proj_util`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db timesheet`.`proj_util` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `id_projet` INT NOT NULL ,
  `id_utilisateur` INT NOT NULL ,
  `id_chef_projet` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_projet_utilisateur_idx` (`id_chef_projet` ASC) ,
  INDEX `fk_utilisateur_projutil_utilisateur_idx` (`id_utilisateur` ASC) ,
  INDEX `fk_projet_projutil_projet_idx` (`id_projet` ASC) ,
  CONSTRAINT `fk_chefprojet_projutil_util`
    FOREIGN KEY (`id_chef_projet` )
    REFERENCES `db timesheet`.`utilisateur` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_utilisateur_projutil_utilisateur`
    FOREIGN KEY (`id_utilisateur` )
    REFERENCES `db timesheet`.`utilisateur` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projet_projutil_projet`
    FOREIGN KEY (`id_projet` )
    REFERENCES `db timesheet`.`projet` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db timesheet`.`tache`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db timesheet`.`tache` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `id_projet` INT NOT NULL ,
  `description` TEXT NULL ,
  `nbr_heures_prevues` INT NOT NULL ,
  `id_statut` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_tache_projet_idx` (`id_projet` ASC) ,
  INDEX `fk_tache_statut_idx` (`id_statut` ASC) ,
  CONSTRAINT `fk_tache_projet`
    FOREIGN KEY (`id_projet` )
    REFERENCES `db timesheet`.`projet` (`id_statut_proj` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tache_statut`
    FOREIGN KEY (`id_statut` )
    REFERENCES `db timesheet`.`statut` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db timesheet`.`tache_util`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db timesheet`.`tache_util` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `id_tache` INT NOT NULL ,
  `id_utilisateur` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_tacheutil_tache_idx` (`id_tache` ASC) ,
  INDEX `fk_tacheutil_utilisateur_idx` (`id_utilisateur` ASC) ,
  CONSTRAINT `fk_tacheutil_tache`
    FOREIGN KEY (`id_tache` )
    REFERENCES `db timesheet`.`tache` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tacheutil_utilisateur`
    FOREIGN KEY (`id_utilisateur` )
    REFERENCES `db timesheet`.`utilisateur` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db timesheet`.`prestation`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db timesheet`.`prestation` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `id_tache` INT NOT NULL ,
  `date_debut` DATETIME NOT NULL ,
  `date_fin` DATETIME NOT NULL ,
  `id_statut` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_prestation_tache_idx` (`id_tache` ASC) ,
  INDEX `fk_prestation_statut_idx` (`id_statut` ASC) ,
  CONSTRAINT `fk_prestation_tache`
    FOREIGN KEY (`id_tache` )
    REFERENCES `db timesheet`.`tache` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prestation_statut`
    FOREIGN KEY (`id_statut` )
    REFERENCES `db timesheet`.`statut` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `db timesheet` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
