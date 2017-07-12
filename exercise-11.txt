-- Setting Up Schema
DROP SCHEMA IF EXISTS `Store` ;

CREATE SCHEMA IF NOT EXISTS `Store` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;

-- Use the newly created database
USE `Store` ;

-- Drop Existing Tables
DROP TABLE IF EXISTS `Store`.`ProductInventory`;
DROP TABLE IF EXISTS `Store`.`Customer`;
DROP TABLE IF EXISTS `Store`.`Invoices`;
DROP TABLE IF EXISTS `Store`.`InvoiceItem`;

-- Create Tables

CREATE TABLE IF NOT EXISTS `Store`.`ProductInventory` (
    `productId` INT AUTO_INCREMENT,
    `productStock` INT NOT NULL,
    `company` VARCHAR(255) NOT NULL,
    `productPrice` INT NOT NULL,
    
    PRIMARY KEY (`productId`)
);

CREATE TABLE IF NOT EXISTS `Store`.`Customer` (
    `customerId` INT AUTO_INCREMENT,
    `customerName` VARCHAR(255),
    
    PRIMARY KEY (`customerId`)
);

CREATE TABLE IF NOT EXISTS `Store`.`Invoice` (
    `invoiceId` INT AUTO_INCREMENT,
    `customerId` INT NOT NULL,
    `amount` INT NOT NULL,
    `date` DATETIME NOT NULL,
    `saleType` ENUM ('Internal','External') NOT NULL,
    
    PRIMARY KEY (`invoiceId`),
    FOREIGN KEY (`customerId`) REFERENCES `Store`.`Customer` (`customerId`) ON DELETE CASCADE 
);

CREATE TABLE IF NOT EXISTS `Store`.`InvoiceItem` (
    `invoiceItemId` INT AUTO_INCREMENT,
    `invoiceId` INT NOT NULL,
    `customerId` INT NOT NULL,
    `productId` INT NOT NULL,
    `refundDate` DATETIME,
    `refunded` BOOLEAN NOT NULL DEFAULT False,
    
    PRIMARY KEY (`invoiceItemId`),
    FOREIGN KEY (`customerId`) REFERENCES `Store`.`Customer` (`customerId`) ON DELETE CASCADE, 
    FOREIGN KEY (`invoiceId`) REFERENCES `Store`.`Invoice` (`invoiceId`) ON DELETE CASCADE
);