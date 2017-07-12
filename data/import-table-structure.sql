-- -----------------------------------------------------
-- Schema decodemtl_addressbook_import
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `decodemtl_addressbook_import` ;

-- -----------------------------------------------------
-- Schema decodemtl_addressbook_import
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `decodemtl_addressbook_import` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `decodemtl_addressbook_import` ;

DROP TABLE IF EXISTS `decodemtl_addressbook_import`.`Account` ;
DROP TABLE IF EXISTS `decodemtl_addressbook_import`.`AddressBook` ;
DROP TABLE IF EXISTS `decodemtl_addressbook_import`.`Entry` ;
DROP TABLE IF EXISTS `decodemtl_addressbook_import`.`Phone` ;
DROP TABLE IF EXISTS `decodemtl_addressbook_import`.`Address` ;
DROP TABLE IF EXISTS `decodemtl_addressbook_import`.`ElectronicMail` ;


CREATE TABLE IF NOT EXISTS `decodemtl_addressbook_import`.`Account`  (
  id INT AUTO_INCREMENT,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(20) NOT NULL,
  createdON DATETIME NOT NULL,
  modifiedON DATETIME,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS `decodemtl_addressbook_import`.`AddressBook`  (
  id INT AUTO_INCREMENT,
  accountId INT,
  name VARCHAR(255) NOT NULL,
  createdON DATETIME NOT NULL,
  modifiedON DATETIME,
  PRIMARY KEY (id),
  FOREIGN KEY (accountId) REFERENCES Account (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `decodemtl_addressbook_import`.`Entry`  (
  id INT AUTO_INCREMENT,
  addressBookId INT,
  firstName VARCHAR(255) NOT NULL,
  lastName VARCHAR(255),
  birthday DATETIME,
  type ENUM('phone', 'address', 'electronic-mail') NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (addressBookId) REFERENCES AddressBook (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `decodemtl_addressbook_import`.`Phone`  (
  id INT AUTO_INCREMENT,
  entryId INT,
  type ENUM('home', 'work', 'other') NOT NULL,
  subtype ENUM('landline', 'cellular', 'fax') NOT NULL,
  content VARCHAR(255) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (entryId) REFERENCES Entry (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `decodemtl_addressbook_import`.`Address`  (
  id INT AUTO_INCREMENT,
  entryId INT,
  type ENUM('home', 'work', 'other') NOT NULL,
  addressLine1 VARCHAR(255) NOT NULL,
  addressLine2 VARCHAR(255),
  city VARCHAR(255) NOT NULL,
  province VARCHAR(128) NOT NULL,
  country VARCHAR(128) NOT NULL,
  postalCode VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (entryId) REFERENCES Entry (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `decodemtl_addressbook_import`.`ElectronicMail`  (
  id INT AUTO_INCREMENT,
  entryId INT,
  type ENUM('home', 'work', 'other') NOT NULL,
  content VARCHAR(255) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (entryId) REFERENCES Entry (id) ON DELETE CASCADE
);
