-- -----------------------------------------------------
-- Table `refdata_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refdata_status` ;

CREATE TABLE IF NOT EXISTS `refdata_status` (
  `StatusID` SMALLINT NOT NULL AUTO_INCREMENT,
  `StatusDescription` VARCHAR(45) NOT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `IDX_RefData_Status` ON `refdata_status` (`StatusID` ASC, `StatusDescription` ASC, `CreatedDate` ASC, `CreatedUser` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `auditing_dataplatform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auditing_dataplatform` ;

CREATE TABLE IF NOT EXISTS `auditing_dataplatform` (
  `DataPlatformID` BIGINT NOT NULL AUTO_INCREMENT,
  `DataProcessingDate` DATETIME(3) NULL DEFAULT NULL,
  `CreatedByUser` VARCHAR(20) NULL DEFAULT NULL,
  `Organizaton` VARCHAR(38) NULL DEFAULT NULL,
  `Application` VARCHAR(38) NULL DEFAULT NULL,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `RecCount` INT NULL DEFAULT NULL,
  `Component` VARCHAR(20) NULL DEFAULT NULL,
  `ActionName` VARCHAR(20) NULL DEFAULT NULL,
  `DurationToRun` INT NULL DEFAULT NULL,
  `ActivityDetail` VARCHAR(75) NULL DEFAULT NULL,
  PRIMARY KEY (`DataPlatformID`),
  CONSTRAINT `FK_platform_dataplatform_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_platform_dataplatform_status` ON `auditing_dataplatform` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IDX_platform_dataplatform` ON `auditing_dataplatform` (`DataPlatformID` ASC, `DataProcessingDate` ASC, `CreatedByUser` ASC, `Organizaton` ASC, `Application` ASC, `StatusID` ASC, `CreatedDate` ASC, `RecCount` ASC, `Component` ASC, `ActionName` ASC, `DurationToRun` ASC, `ActivityDetail` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `auditing_datarequest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auditing_datarequest` ;

CREATE TABLE IF NOT EXISTS `auditing_datarequest` (
  `DataRequestID` BIGINT NOT NULL AUTO_INCREMENT,
  `DataRequestDate` DATETIME(3) NULL DEFAULT NULL,
  `CreatedByUser` VARCHAR(20) NULL DEFAULT NULL,
  `Organizaton` VARCHAR(38) NULL DEFAULT NULL,
  `Application` VARCHAR(38) NULL DEFAULT NULL,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `RecCount` INT NULL DEFAULT NULL,
  `RecordDataRequest` VARCHAR(400) NULL DEFAULT NULL,
  PRIMARY KEY (`DataRequestID`),
  CONSTRAINT `FK_platform_datarequest_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_platform_datarequest_status` ON `auditing_datarequest` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IDX_platform_datarequest` ON `auditing_datarequest` (`DataRequestID` ASC, `DataRequestDate` ASC, `CreatedByUser` ASC, `Organizaton` ASC, `Application` ASC, `StatusID` ASC, `CreatedDate` ASC, `RecCount` ASC, `RecordDataRequest` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `refdata_vendor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refdata_vendor` ;

CREATE TABLE IF NOT EXISTS `refdata_vendor` (
  `VendorID` INT NOT NULL AUTO_INCREMENT,
  `VendorName` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_0900_ai_ci' NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `VendorGUID` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`VendorID`),
  CONSTRAINT `FK_refdata_vendors_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_refdata_vendors_status` ON `refdata_vendor` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IDX_RefData_Vendors` ON `refdata_vendor` (`VendorID` ASC, `VendorName` ASC, `StatusID` ASC, `VendorGUID` ASC, `CreatedDate` ASC, `CreatedUser` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `refdata_application`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refdata_application` ;

CREATE TABLE IF NOT EXISTS `refdata_application` (
  `AppGUID` CHAR(38) NOT NULL,
  `ApplicationCustomCode` VARCHAR(15) NULL DEFAULT NULL,
  `ApplicationDesc` VARCHAR(50) NULL DEFAULT NULL,
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `VendorID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`AppGUID`),
  CONSTRAINT `FK_refdata_application_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`),
  CONSTRAINT `FK_refdata_application_vendors`
    FOREIGN KEY (`VendorID`)
    REFERENCES `refdata_vendor` (`VendorID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_refdata_application_status` ON `refdata_application` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_refdata_application_vendors` ON `refdata_application` (`VendorID` ASC) VISIBLE;

CREATE INDEX `IDX_RefData_Application` ON `refdata_application` (`AppGUID` ASC, `ApplicationCustomCode` ASC, `ApplicationDesc` ASC, `CreatedUser` ASC, `CreatedDate` ASC, `StatusID` ASC, `VendorID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `databuilt_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `databuilt_address` ;

CREATE TABLE IF NOT EXISTS `databuilt_address` (
  `CompleteAddressID` BIGINT NOT NULL AUTO_INCREMENT,
  `Address1` VARCHAR(99) NULL DEFAULT NULL,
  `City` VARCHAR(70) NULL DEFAULT NULL,
  `StateID` VARCHAR(2) NULL DEFAULT NULL,
  `ZipCode` VARCHAR(10) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `RegisteredApp` VARCHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`CompleteAddressID`),
  CONSTRAINT `FK_databuilt_address_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_databuilt_address_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_databuilt_address` ON `databuilt_address` (`Address1` ASC, `City` ASC, `StateID` ASC, `ZipCode` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_databuilt_address_status` ON `databuilt_address` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IDX_databuilt_completeaddress` ON `databuilt_address` (`CompleteAddressID` ASC, `Address1` ASC, `City` ASC, `StateID` ASC, `ZipCode` ASC, `CreatedDate` ASC, `StatusID` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_databuilt_address_registeredapp` ON `databuilt_address` (`RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `databuilt_bankaccount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `databuilt_bankaccount` ;

CREATE TABLE IF NOT EXISTS `databuilt_bankaccount` (
  `DataBuiltBankAccountsID` BIGINT NOT NULL AUTO_INCREMENT,
  `BankAccountNumber` VARCHAR(12) NULL DEFAULT NULL,
  `BankAccountName` VARCHAR(75) NULL DEFAULT NULL,
  `BankRoutingID` VARCHAR(9) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `RegisteredApp` VARCHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`DataBuiltBankAccountsID`),
  CONSTRAINT `FK_databuilt_bankaccount_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `fk_databuilt_bankAccounts_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_databuilt_bankaccount` ON `databuilt_bankaccount` (`BankAccountNumber` ASC, `BankRoutingID` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `fk_databuilt_bankAccounts_status` ON `databuilt_bankaccount` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IX_databuilt_bankAccounts` ON `databuilt_bankaccount` (`DataBuiltBankAccountsID` ASC, `BankAccountName` ASC, `BankAccountNumber` ASC, `BankRoutingID` ASC, `StatusID` ASC, `CreatedDate` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_databuilt_bankaccount_registeredapp` ON `databuilt_bankaccount` (`RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `databuilt_corporations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `databuilt_corporations` ;

CREATE TABLE IF NOT EXISTS `databuilt_corporations` (
  `DataBuiltCorporationID` BIGINT NOT NULL AUTO_INCREMENT,
  `CorporationName` VARCHAR(99) NULL DEFAULT NULL,
  `Address1` VARCHAR(99) NULL DEFAULT NULL,
  `City` VARCHAR(70) NULL DEFAULT NULL,
  `StateID` VARCHAR(2) NULL DEFAULT NULL,
  `ZipCode` VARCHAR(10) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `RegisteredApp` VARCHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`DataBuiltCorporationID`),
  CONSTRAINT `FK_databuilt_corporations_resiteredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_databuilt_corporations_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_databuilt_corporations` ON `databuilt_corporations` (`CorporationName` ASC, `Address1` ASC, `City` ASC, `StateID` ASC, `ZipCode` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_databuilt_corporations_status` ON `databuilt_corporations` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_databuilt_corporations_resiteredapp` ON `databuilt_corporations` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_databuilt_corporations` ON `databuilt_corporations` (`DataBuiltCorporationID` ASC, `CorporationName` ASC, `Address1` ASC, `City` ASC, `StateID` ASC, `ZipCode` ASC, `CreatedDate` ASC, `StatusID` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `databuilt_names`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `databuilt_names` ;

CREATE TABLE IF NOT EXISTS `databuilt_names` (
  `DataBuiltNamesID` BIGINT NOT NULL AUTO_INCREMENT,
  `CompleteName` VARCHAR(100) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `RegisteredApp` VARCHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`DataBuiltNamesID`),
  CONSTRAINT `FK_databuilt_completenames_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`),
  CONSTRAINT `FK_databuilt_names_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_databuilt_completenames_status` ON `databuilt_names` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IX_databuilt_names_databuiltnamesid` ON `databuilt_names` (`DataBuiltNamesID` ASC, `CompleteName` ASC, `CreatedDate` ASC, `StatusID` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_databuilt_names_registeredapp` ON `databuilt_names` (`RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `databuilt_persondemographics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `databuilt_persondemographics` ;

CREATE TABLE IF NOT EXISTS `databuilt_persondemographics` (
  `PersonDemographicsID` BIGINT NOT NULL AUTO_INCREMENT,
  `DLN` VARCHAR(25) NULL DEFAULT NULL,
  `DLNState` VARCHAR(2) NULL DEFAULT NULL,
  `SSN` VARCHAR(11) NULL DEFAULT NULL,
  `DOBValue` VARCHAR(12) NULL DEFAULT NULL,
  `DOBDate` DATE NULL DEFAULT NULL,
  `Age` INT NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `RegisteredApp` VARCHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`PersonDemographicsID`),
  CONSTRAINT `FK_databuilt_persondemographics_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_databuilt_persondemographics_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_databuilt_persondemographics` ON `databuilt_persondemographics` (`DLN` ASC, `DLNState` ASC, `SSN` ASC, `DOBDate` ASC, `DOBValue` ASC, `Age` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_databuilt_persondemographics_status` ON `databuilt_persondemographics` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_databuilt_persondemographics_registeredapp` ON `databuilt_persondemographics` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_dataabuilt_persondemographics` ON `databuilt_persondemographics` (`PersonDemographicsID` ASC, `DLN` ASC, `DLNState` ASC, `SSN` ASC, `DOBValue` ASC, `DOBDate` ASC, `Age` ASC, `CreatedDate` ASC, `StatusID` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `databuilt_phonenumbers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `databuilt_phonenumbers` ;

CREATE TABLE IF NOT EXISTS `databuilt_phonenumbers` (
  `DataBuiltPhoneNumbersID` BIGINT NOT NULL AUTO_INCREMENT,
  `AreaCode` VARCHAR(3) NULL DEFAULT NULL,
  `PhoneNumber` VARCHAR(8) NULL DEFAULT NULL,
  `CompletePhoneNumber` VARCHAR(14) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `RegisteredApp` VARCHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`DataBuiltPhoneNumbersID`),
  CONSTRAINT `FK_databuilt_phonenumbers_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_databuilt_phonenumbers_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`),
  CONSTRAINT `IDX_databuilt_phonenumbers_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_databuilt_phonenumbers` ON `databuilt_phonenumbers` (`AreaCode` ASC, `PhoneNumber` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_databuilt_phonenumbers_status` ON `databuilt_phonenumbers` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_databuilt_phonenumbers_registeredapp` ON `databuilt_phonenumbers` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_databuilt_phonenumbers` ON `databuilt_phonenumbers` (`DataBuiltPhoneNumbersID` ASC, `AreaCode` ASC, `PhoneNumber` ASC, `CompletePhoneNumber` ASC, `StatusID` ASC, `CreatedDate` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `databuilt_products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `databuilt_products` ;

CREATE TABLE IF NOT EXISTS `databuilt_products` (
  `DatabuiltProductsID` BIGINT NOT NULL AUTO_INCREMENT,
  `ProductID` VARCHAR(20) NULL DEFAULT NULL,
  `ProductName` VARCHAR(99) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `RegisteredApp` VARCHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`DatabuiltProductsID`),
  CONSTRAINT `FK_databuilt_products_regsiteredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_databuilt_products_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_databuilt_products` ON `databuilt_products` (`ProductID` ASC, `ProductName` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_databuilt_products_status` ON `databuilt_products` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IDX_databuilt_products` ON `databuilt_products` (`DatabuiltProductsID` ASC, `ProductID` ASC, `ProductName` ASC, `CreatedDate` ASC, `StatusID` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_databuilt_products_regsiteredapp` ON `databuilt_products` (`RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `dataexisting_ababanking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dataexisting_ababanking` ;

CREATE TABLE IF NOT EXISTS `dataexisting_ababanking` (
  `ABABankingID` BIGINT NOT NULL AUTO_INCREMENT,
  `RoutingNumber` VARCHAR(9) NULL DEFAULT NULL,
  `TelegraphicName` VARCHAR(20) NULL DEFAULT NULL,
  `CustomerName` VARCHAR(36) NULL DEFAULT NULL,
  `City` VARCHAR(20) NULL DEFAULT NULL,
  `State` VARCHAR(2) NULL DEFAULT NULL,
  `ZipCode` VARCHAR(5) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`ABABankingID`),
  CONSTRAINT `FK_dataexisting_ababanking_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_dataexisting_ababanking_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 10115
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_dataexisting_ababanking_Status` ON `dataexisting_ababanking` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_ababanking_registeredapp` ON `dataexisting_ababanking` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_DataExisting_ABABanking` ON `dataexisting_ababanking` (`ABABankingID` ASC, `RoutingNumber` ASC, `TelegraphicName` ASC, `CustomerName` ASC, `City` ASC, `State` ASC, `ZipCode` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `refdata_timezones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refdata_timezones` ;

CREATE TABLE IF NOT EXISTS `refdata_timezones` (
  `TimeZoneValue` VARCHAR(3) NOT NULL,
  `TimeZoneDesc` VARCHAR(25) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  PRIMARY KEY (`TimeZoneValue`),
  CONSTRAINT `FK_TimeZones_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_TimeZones_Status` ON `refdata_timezones` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IDX_RefData_TimeZones` ON `refdata_timezones` (`TimeZoneValue` ASC, `TimeZoneDesc` ASC, `CreatedDate` ASC, `StatusID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `refdata_usstates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refdata_usstates` ;

CREATE TABLE IF NOT EXISTS `refdata_usstates` (
  `StateID` VARCHAR(2) NOT NULL,
  `StateDescription` VARCHAR(65) NULL DEFAULT NULL,
  `Lattitude` VARCHAR(12) NULL DEFAULT NULL,
  `Longitude` VARCHAR(12) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`StateID`),
  CONSTRAINT `FK_USStates_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_USStates_Status` ON `refdata_usstates` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IDX_RefData_USStates` ON `refdata_usstates` (`StateID` ASC, `StateDescription` ASC, `Lattitude` ASC, `Longitude` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `dataexisting_areacode`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dataexisting_areacode` ;

CREATE TABLE IF NOT EXISTS `dataexisting_areacode` (
  `AreaCodeID` BIGINT NOT NULL AUTO_INCREMENT,
  `AreaCodeValue` VARCHAR(3) NOT NULL,
  `TimeZone` VARCHAR(3) NULL DEFAULT NULL,
  `StateCode` VARCHAR(2) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`AreaCodeID`),
  CONSTRAINT `FK_dataexisting_areacode_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_dataexisting_areacode_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`),
  CONSTRAINT `FK_dataexisting_areacode_timezones`
    FOREIGN KEY (`TimeZone`)
    REFERENCES `refdata_timezones` (`TimeZoneValue`),
  CONSTRAINT `FK_dataexisting_areacode_USStates`
    FOREIGN KEY (`StateCode`)
    REFERENCES `refdata_usstates` (`StateID`))
ENGINE = InnoDB
AUTO_INCREMENT = 311
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_dataexisting_areacode` ON `dataexisting_areacode` (`AreaCodeValue` ASC, `TimeZone` ASC, `StateCode` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_areacode_Status` ON `dataexisting_areacode` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_areacode_USStates` ON `dataexisting_areacode` (`StateCode` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_areacode_registeredapp` ON `dataexisting_areacode` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_areacode_timezones` ON `dataexisting_areacode` (`TimeZone` ASC) VISIBLE;

CREATE INDEX `IDX_DataExisting_AreaCode` ON `dataexisting_areacode` (`AreaCodeValue` ASC, `TimeZone` ASC, `StateCode` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `refdata_countries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refdata_countries` ;

CREATE TABLE IF NOT EXISTS `refdata_countries` (
  `CountryID` SMALLINT NOT NULL AUTO_INCREMENT,
  `IDD` VARCHAR(5) NULL DEFAULT NULL,
  `CountryName` VARCHAR(59) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  PRIMARY KEY (`CountryID`),
  CONSTRAINT `FK_Countries_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_Countries_Status` ON `refdata_countries` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IX_Countries` ON `refdata_countries` (`CountryID` ASC, `IDD` ASC, `CountryName` ASC, `CreatedDate` ASC, `StatusID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `dataexisting_areacodeintl`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dataexisting_areacodeintl` ;

CREATE TABLE IF NOT EXISTS `dataexisting_areacodeintl` (
  `IDDCode` VARCHAR(5) NOT NULL,
  `CountryID` SMALLINT NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`IDDCode`),
  CONSTRAINT `FK_dataexisting_areacodeintl_Countries`
    FOREIGN KEY (`CountryID`)
    REFERENCES `refdata_countries` (`CountryID`),
  CONSTRAINT `FK_dataexisting_areacodeintl_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_dataexisting_areacodeintl_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_dataexisting_areacodeintl_Countries` ON `dataexisting_areacodeintl` (`CountryID` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_areacodeintl_Status` ON `dataexisting_areacodeintl` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_areacodeintl_registeredapp` ON `dataexisting_areacodeintl` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_DataExisting_AreaCodeIntl` ON `dataexisting_areacodeintl` (`IDDCode` ASC, `CountryID` ASC, `CreatedDate` ASC, `StatusID` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `dataexisting_companies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dataexisting_companies` ;

CREATE TABLE IF NOT EXISTS `dataexisting_companies` (
  `CompaniesID` BIGINT NOT NULL AUTO_INCREMENT,
  `CompanyName` VARCHAR(79) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`CompaniesID`),
  CONSTRAINT `FK_dataexisting_companies_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_dataexisting_companies_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 948
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_dataexisting_companies_Status` ON `dataexisting_companies` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_companies_registeredapp` ON `dataexisting_companies` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_DataExisting_Companies` ON `dataexisting_companies` (`CompaniesID` ASC, `CompanyName` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `dataexisting_namefirst`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dataexisting_namefirst` ;

CREATE TABLE IF NOT EXISTS `dataexisting_namefirst` (
  `FirstNameID` BIGINT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(39) NULL DEFAULT NULL,
  `Gender` VARCHAR(1) NULL DEFAULT NULL,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`FirstNameID`),
  CONSTRAINT `FK_dataexisting_namefirst_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_dataexisting_namefirst_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 301552
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_dataexisting_namefirst` ON `dataexisting_namefirst` (`FirstName` ASC, `Gender` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_namefirst_Status` ON `dataexisting_namefirst` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_namefirst_registeredapp` ON `dataexisting_namefirst` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_DataExistng_NameFirst` ON `dataexisting_namefirst` (`FirstNameID` ASC, `FirstName` ASC, `Gender` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `dataexisting_namelast`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dataexisting_namelast` ;

CREATE TABLE IF NOT EXISTS `dataexisting_namelast` (
  `LastNameID` BIGINT NOT NULL AUTO_INCREMENT,
  `LastName` VARCHAR(69) NULL DEFAULT NULL,
  `StatusID` SMALLINT NOT NULL DEFAULT '1',
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`LastNameID`),
  CONSTRAINT `FK_dataexisting_namelast_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_dataexisting_namelast_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 601224
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_DataExisting_NameLast` ON `dataexisting_namelast` (`LastName` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_namelast_Status` ON `dataexisting_namelast` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_namelast_registeredapp` ON `dataexisting_namelast` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_DataExisting_NameLast` ON `dataexisting_namelast` (`LastNameID` ASC, `LastName` ASC, `StatusID` ASC, `CreatedDate` ASC, `CreatedUser` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `dataexisting_upccodes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dataexisting_upccodes` ;

CREATE TABLE IF NOT EXISTS `dataexisting_upccodes` (
  `UPCCodeID` BIGINT NOT NULL AUTO_INCREMENT,
  `UPCCodeName` VARCHAR(15) NULL DEFAULT NULL,
  `UPCProductName` VARCHAR(150) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`UPCCodeID`),
  CONSTRAINT `FK_dataexisting_upccodes_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_dataexisting_upccodes_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 46529
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_dataexisting_upccodes_Status` ON `dataexisting_upccodes` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_upccodes_registeredapp` ON `dataexisting_upccodes` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_DataExisting_UPCCodes` ON `dataexisting_upccodes` (`UPCCodeID` ASC, `UPCCodeName` ASC, `UPCProductName` ASC, `CreatedDate` ASC, `StatusID` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `dataexisting_zipcodeintl`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dataexisting_zipcodeintl` ;

CREATE TABLE IF NOT EXISTS `dataexisting_zipcodeintl` (
  `ZipCodeIntnlID` INT NOT NULL AUTO_INCREMENT,
  `ZipCode` CHAR(10) NOT NULL,
  `ZipCodeType` VARCHAR(15) NULL DEFAULT NULL,
  `City` VARCHAR(75) NULL DEFAULT NULL,
  `Country` SMALLINT NULL DEFAULT NULL,
  `Lattitude` VARCHAR(10) NULL DEFAULT NULL,
  `Longitude` VARCHAR(10) NULL DEFAULT NULL,
  `Location` VARCHAR(99) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`ZipCodeIntnlID`),
  CONSTRAINT `FK_dataexisting_zipcodeIntl_Countries`
    FOREIGN KEY (`Country`)
    REFERENCES `refdata_countries` (`CountryID`),
  CONSTRAINT `FK_dataexisting_zipcodeintl_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_dataexisting_zipcodeIntl_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_dataexisting_zipcodeIntl_Countries` ON `dataexisting_zipcodeintl` (`Country` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_zipcodeIntl_Status` ON `dataexisting_zipcodeintl` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_zipcodeintl_registeredapp` ON `dataexisting_zipcodeintl` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_DataExisting_ZipcodeIntl` ON `dataexisting_zipcodeintl` (`ZipCodeIntnlID` ASC, `ZipCode` ASC, `ZipCodeType` ASC, `Country` ASC, `City` ASC, `Lattitude` ASC, `Longitude` ASC, `Location` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `dataexisting_zipcodeus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dataexisting_zipcodeus` ;

CREATE TABLE IF NOT EXISTS `dataexisting_zipcodeus` (
  `ZipCodeID` BIGINT NOT NULL AUTO_INCREMENT,
  `ZipCode` CHAR(5) NOT NULL,
  `ZipCodeType` VARCHAR(15) NULL DEFAULT NULL,
  `City` VARCHAR(75) NULL DEFAULT NULL,
  `State` VARCHAR(2) NULL DEFAULT NULL,
  `Lattitude` VARCHAR(10) NULL DEFAULT NULL,
  `Longitude` VARCHAR(10) NULL DEFAULT NULL,
  `Location` VARCHAR(99) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`ZipCodeID`),
  CONSTRAINT `FK_dataexisting_zipcodeus_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_dataexisting_zipcodeUS_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 41862
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `IDX_dataexisting_zipcodeus` ON `dataexisting_zipcodeus` (`ZipCodeID` ASC, `ZipCode` ASC, `ZipCodeType` ASC, `City` ASC, `State` ASC, `Lattitude` ASC, `Longitude` ASC, `Location` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_zipcodeUS_Status` ON `dataexisting_zipcodeus` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_dataexisting_zipcodeus_registeredapp` ON `dataexisting_zipcodeus` (`RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `datagenerated_accountnumbers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `datagenerated_accountnumbers` ;

CREATE TABLE IF NOT EXISTS `datagenerated_accountnumbers` (
  `AccountNumbersID` BIGINT NOT NULL AUTO_INCREMENT,
  `AccountNumberValue` VARCHAR(20) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`AccountNumbersID`),
  CONSTRAINT `FK_datagenerated_accountnumbers_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_datagenerated_accountnumbers_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_datagenerated_accountnumbers` ON `datagenerated_accountnumbers` (`AccountNumberValue` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_accountnumbers_status` ON `datagenerated_accountnumbers` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_accountnumbers_registeredapp` ON `datagenerated_accountnumbers` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_DataGenerated_AccountNumbers` ON `datagenerated_accountnumbers` (`AccountNumbersID` ASC, `AccountNumberValue` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `refdata_addressformattype`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refdata_addressformattype` ;

CREATE TABLE IF NOT EXISTS `refdata_addressformattype` (
  `AddressFormatTypeID` SMALLINT NOT NULL AUTO_INCREMENT,
  `AddressFormatTypeDesc` VARCHAR(35) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusId` SMALLINT NULL DEFAULT '1',
  PRIMARY KEY (`AddressFormatTypeID`),
  CONSTRAINT `FK_AddressFormatType_Status`
    FOREIGN KEY (`StatusId`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_AddressFormatType_Status` ON `refdata_addressformattype` (`StatusId` ASC) VISIBLE;

CREATE INDEX `IDX_refdata_addressformattype_AddressFormatTypeID` ON `refdata_addressformattype` (`AddressFormatTypeID` ASC, `AddressFormatTypeDesc` ASC, `CreatedDate` ASC, `StatusId` ASC) VISIBLE;

CREATE INDEX `IX_AddressFormatType` ON `refdata_addressformattype` (`AddressFormatTypeID` ASC, `AddressFormatTypeDesc` ASC, `CreatedDate` ASC, `StatusId` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `datagenerated_addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `datagenerated_addresses` ;

CREATE TABLE IF NOT EXISTS `datagenerated_addresses` (
  `AddressID` BIGINT NOT NULL AUTO_INCREMENT,
  `AddressStreet` VARCHAR(99) NULL DEFAULT NULL,
  `AddressStreet2` VARCHAR(59) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `AddressFormatTypeId` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`AddressID`),
  CONSTRAINT `FK_datagenerated_addresses_AddressFormatType`
    FOREIGN KEY (`AddressFormatTypeId`)
    REFERENCES `refdata_addressformattype` (`AddressFormatTypeID`),
  CONSTRAINT `FK_datagenerated_addresses_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_datagenerated_addresses_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 33110
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_DataGenerated_Addresses` ON `datagenerated_addresses` (`AddressStreet` ASC, `AddressStreet2` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_addresses_status` ON `datagenerated_addresses` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_addresses_AddressFormatType` ON `datagenerated_addresses` (`AddressFormatTypeId` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_addresses_registeredapp` ON `datagenerated_addresses` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_DataGenerated_Addresses` ON `datagenerated_addresses` (`AddressID` ASC, `AddressStreet` ASC, `AddressStreet2` ASC, `AddressFormatTypeId` ASC, `StatusID` ASC, `CreatedDate` ASC, `CreatedUser` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `datagenerated_bankaccount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `datagenerated_bankaccount` ;

CREATE TABLE IF NOT EXISTS `datagenerated_bankaccount` (
  `BankAccountsID` BIGINT NOT NULL AUTO_INCREMENT,
  `BankAccountValue` VARCHAR(17) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`BankAccountsID`),
  CONSTRAINT `FK_datagenerated_bankaccount_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_datagenerated_bankaccount_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 74998
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_DataGenerated_BankAccounts` ON `datagenerated_bankaccount` (`BankAccountValue` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_bankaccount_Status` ON `datagenerated_bankaccount` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_bankaccount_registeredapp` ON `datagenerated_bankaccount` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_DataGenerated_BankAccounts` ON `datagenerated_bankaccount` (`BankAccountsID` ASC, `BankAccountValue` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `datagenerated_creditcard`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `datagenerated_creditcard` ;

CREATE TABLE IF NOT EXISTS `datagenerated_creditcard` (
  `CreditCardID` BIGINT NOT NULL AUTO_INCREMENT,
  `CreditCardNumber` VARCHAR(20) NULL DEFAULT NULL,
  `CreditCardName` VARCHAR(10) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`CreditCardID`),
  CONSTRAINT `FK_datagenerated_creditcard_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_datagenerated_creditcard_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 75001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_datagenerated_creditcard` ON `datagenerated_creditcard` (`CreditCardName` ASC, `CreditCardNumber` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_creditcard_Status` ON `datagenerated_creditcard` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_creditcard_registeredapp` ON `datagenerated_creditcard` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_DataGenerated_CreditCard` ON `datagenerated_creditcard` (`CreditCardID` ASC, `CreditCardNumber` ASC, `CreditCardName` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `datagenerated_dateofbirth`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `datagenerated_dateofbirth` ;

CREATE TABLE IF NOT EXISTS `datagenerated_dateofbirth` (
  `DateofBirthsID` BIGINT NOT NULL AUTO_INCREMENT,
  `DateOfBirth` VARCHAR(12) NULL DEFAULT NULL,
  `DateOfBirthDate` DATE NULL DEFAULT NULL,
  `Age` INT NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`DateofBirthsID`),
  CONSTRAINT `FK_datagenerated_dateofbirth_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_datagenerated_dateofbirth_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 30000
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_DataGenerated_DateOfBirths` ON `datagenerated_dateofbirth` (`DateOfBirth` ASC, `DateOfBirthDate` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_dateofbirth_Status` ON `datagenerated_dateofbirth` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_dateofbirth_registeredapp` ON `datagenerated_dateofbirth` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_DataGenerated_DateOfBirths` ON `datagenerated_dateofbirth` (`DateofBirthsID` ASC, `DateOfBirth` ASC, `DateOfBirthDate` ASC, `Age` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `datagenerated_driverslicenses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `datagenerated_driverslicenses` ;

CREATE TABLE IF NOT EXISTS `datagenerated_driverslicenses` (
  `DriversLicensesID` BIGINT NOT NULL AUTO_INCREMENT,
  `DLN` VARCHAR(25) NULL DEFAULT NULL,
  `StateCode` VARCHAR(2) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CompleteDriversLicenseNumber` VARCHAR(30) NULL DEFAULT NULL,
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`DriversLicensesID`),
  CONSTRAINT `FK_datagenerated_driverslicenses_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_datagenerated_driverslicenses_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`),
  CONSTRAINT `FK_datagenerated_driverslicenses_USStates`
    FOREIGN KEY (`StateCode`)
    REFERENCES `refdata_usstates` (`StateID`))
ENGINE = InnoDB
AUTO_INCREMENT = 184000
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_DataGenerated_DriversLicenses` ON `datagenerated_driverslicenses` (`DLN` ASC, `StateCode` ASC, `CompleteDriversLicenseNumber` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_driverslicenses_Status` ON `datagenerated_driverslicenses` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_driverslicenses_USStates` ON `datagenerated_driverslicenses` (`StateCode` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_driverslicenses_registeredapp` ON `datagenerated_driverslicenses` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_DataGenerated_DriversLicenses` ON `datagenerated_driverslicenses` (`DriversLicensesID` ASC, `CreatedDate` ASC, `DLN` ASC, `StateCode` ASC, `StatusID` ASC, `CompleteDriversLicenseNumber` ASC, `CreatedUser` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `datagenerated_ein`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `datagenerated_ein` ;

CREATE TABLE IF NOT EXISTS `datagenerated_ein` (
  `EINID` BIGINT NOT NULL AUTO_INCREMENT,
  `EINValue` VARCHAR(10) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`EINID`),
  CONSTRAINT `FK_datagenerated_ein_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_datagenerated_ein_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_DataGenerated_EIN` ON `datagenerated_ein` (`EINValue` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_ein_Status` ON `datagenerated_ein` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_ein_registeredapp` ON `datagenerated_ein` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_DataGenerated_EIN` ON `datagenerated_ein` (`EINID` ASC, `EINValue` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `datagenerated_phonenumber`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `datagenerated_phonenumber` ;

CREATE TABLE IF NOT EXISTS `datagenerated_phonenumber` (
  `PhoneNumberID` BIGINT NOT NULL AUTO_INCREMENT,
  `PhoneNumberValue` VARCHAR(8) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`PhoneNumberID`),
  CONSTRAINT `FK_datagenerated_phonenumber_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_datagenerated_phonenumbers_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 74623
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_DataGeneratedPhoneNumbers` ON `datagenerated_phonenumber` (`PhoneNumberValue` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_phonenumber_registeredapp` ON `datagenerated_phonenumber` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_phonenumbers_Status` ON `datagenerated_phonenumber` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IDX_PhoneNumbers` ON `datagenerated_phonenumber` (`PhoneNumberID` ASC, `PhoneNumberValue` ASC, `RegisteredApp` ASC, `CreatedUser` ASC, `CreatedDate` ASC, `StatusID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `datagenerated_phonenumbersintl`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `datagenerated_phonenumbersintl` ;

CREATE TABLE IF NOT EXISTS `datagenerated_phonenumbersintl` (
  `PhoneNumberIntlID` BIGINT NOT NULL AUTO_INCREMENT,
  `PhoneNumberValue` VARCHAR(12) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CountryId` SMALLINT NULL DEFAULT NULL,
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`PhoneNumberIntlID`),
  CONSTRAINT `FK_datagenerated_phonenumbersintl_Country`
    FOREIGN KEY (`CountryId`)
    REFERENCES `refdata_countries` (`CountryID`),
  CONSTRAINT `FK_datagenerated_phonenumbersintl_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_datagenerated_phonenumbersintl_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_datagenerated_phonenumbersintl` ON `datagenerated_phonenumbersintl` (`PhoneNumberValue` ASC, `CountryId` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_phonenumbersintl_Country` ON `datagenerated_phonenumbersintl` (`CountryId` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_phonenumbersintl_Status` ON `datagenerated_phonenumbersintl` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_phonenumbersintl_registeredapp` ON `datagenerated_phonenumbersintl` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_PhoneNumbersIntl` ON `datagenerated_phonenumbersintl` (`PhoneNumberIntlID` ASC, `PhoneNumberValue` ASC, `CountryId` ASC, `CreatedDate` ASC, `CreatedUser` ASC, `StatusID` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `datagenerated_socialsecuritynumber`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `datagenerated_socialsecuritynumber` ;

CREATE TABLE IF NOT EXISTS `datagenerated_socialsecuritynumber` (
  `SocialSecurityNumberID` BIGINT NOT NULL AUTO_INCREMENT,
  `SocialSecurityNumberValue` VARCHAR(11) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`SocialSecurityNumberID`),
  CONSTRAINT `FK_datagenerated_socialsecuritynumber_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_datagenerated_socialsecuritynumber_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 78214
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_DataGenerated_SocialSecurityNumbers` ON `datagenerated_socialsecuritynumber` (`SocialSecurityNumberValue` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_socialsecuritynumber_Status` ON `datagenerated_socialsecuritynumber` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_socialsecuritynumber_registeredapp` ON `datagenerated_socialsecuritynumber` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_DataGenerated_SocialSecurityNumber` ON `datagenerated_socialsecuritynumber` (`SocialSecurityNumberID` ASC, `SocialSecurityNumberValue` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `datagenerated_useridentities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `datagenerated_useridentities` ;

CREATE TABLE IF NOT EXISTS `datagenerated_useridentities` (
  `UserIdentitiesID` BIGINT NOT NULL AUTO_INCREMENT,
  `UserIdentityValue` VARCHAR(20) NULL DEFAULT NULL,
  `UserDomain` VARCHAR(20) NULL DEFAULT NULL,
  `AdditionalAttributes` VARCHAR(40) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`UserIdentitiesID`),
  CONSTRAINT `FK_datagenerated_useridentities_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_datagenerated_useridentities_Status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE UNIQUE INDEX `IDX_UC_DataGenerated_UserIdentities` ON `datagenerated_useridentities` (`UserIdentityValue` ASC, `UserDomain` ASC, `RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_useridentities_Status` ON `datagenerated_useridentities` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_datagenerated_useridentities_registeredapp` ON `datagenerated_useridentities` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_DataGenerated_Identities` ON `datagenerated_useridentities` (`UserIdentitiesID` ASC, `UserIdentityValue` ASC, `UserDomain` ASC, `CreatedDate` ASC, `StatusID` ASC, `AdditionalAttributes` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `datamodel_datatables`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `datamodel_datatables` ;

CREATE TABLE IF NOT EXISTS `datamodel_datatables` (
  `TableName` VARCHAR(64) CHARACTER SET 'utf8' NOT NULL,
  `TableInformation` VARCHAR(249) NULL DEFAULT NULL,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`TableName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `IDX_datamodel_datatables` ON `datamodel_datatables` (`TableName` ASC, `TableInformation` ASC, `StatusID` ASC, `CreatedDate` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `platform_appsetting`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `platform_appsetting` ;

CREATE TABLE IF NOT EXISTS `platform_appsetting` (
  `AppSettingsID` SMALLINT NOT NULL AUTO_INCREMENT,
  `AppSettingName` VARCHAR(50) NULL DEFAULT NULL,
  `AppSettingValue` VARCHAR(199) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `RegisteredApp` VARCHAR(38) NULL DEFAULT NULL,
  `DefaultDataGenerationApp` VARCHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`AppSettingsID`),
  CONSTRAINT `FK_platform_appsetting_datagenapp`
    FOREIGN KEY (`DefaultDataGenerationApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_platform_appsettings_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_refdata_appsettings_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_refdata_appsettings_status` ON `platform_appsetting` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_platform_appsettings_registeredapp` ON `platform_appsetting` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_platform_appsetting_datagenapp` ON `platform_appsetting` (`DefaultDataGenerationApp` ASC) VISIBLE;

CREATE INDEX `IDX_PlatformData_AppSettings` ON `platform_appsetting` (`AppSettingsID` ASC, `AppSettingName` ASC, `AppSettingValue` ASC, `CreatedDate` ASC, `StatusID` ASC, `RegisteredApp` ASC, `DefaultDataGenerationApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `refdata_sensitivityflag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refdata_sensitivityflag` ;

CREATE TABLE IF NOT EXISTS `refdata_sensitivityflag` (
  `SensitiveFlagID` SMALLINT NOT NULL AUTO_INCREMENT,
  `SensitiveFlagDesc` VARCHAR(30) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  PRIMARY KEY (`SensitiveFlagID`),
  CONSTRAINT `FK_refdata_sensitivityflag_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_refdata_sensitivityflag_status` ON `refdata_sensitivityflag` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IDX_RefData_SensitivityFlag` ON `refdata_sensitivityflag` (`SensitiveFlagID` ASC, `SensitiveFlagDesc` ASC, `StatusID` ASC, `CreatedDate` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `platform_dataattributes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `platform_dataattributes` ;

CREATE TABLE IF NOT EXISTS `platform_dataattributes` (
  `PlatformDataAttributesID` SMALLINT NOT NULL AUTO_INCREMENT,
  `DataAttributeName` VARCHAR(50) NULL DEFAULT NULL,
  `SensitivityFlagID` SMALLINT NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `PlatformDataAttributeGUID` CHAR(38) NULL DEFAULT NULL,
  `RegisteredApp` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`PlatformDataAttributesID`),
  CONSTRAINT `FK_platform_dataattributes_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_platformdataattributes_sensitivtyflag`
    FOREIGN KEY (`SensitivityFlagID`)
    REFERENCES `refdata_sensitivityflag` (`SensitiveFlagID`),
  CONSTRAINT `FK_platformdataattributes_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_platformdataattributes_status` ON `platform_dataattributes` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_platformdataattributes_sensitivtyflag` ON `platform_dataattributes` (`SensitivityFlagID` ASC) VISIBLE;

CREATE INDEX `FK_platform_dataattributes_registeredapp` ON `platform_dataattributes` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_Platform_DataAttributes` ON `platform_dataattributes` (`PlatformDataAttributesID` ASC, `DataAttributeName` ASC, `SensitivityFlagID` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `PlatformDataAttributeGUID` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `platform_config_datagen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `platform_config_datagen` ;

CREATE TABLE IF NOT EXISTS `platform_config_datagen` (
  `DataGenConfigID` SMALLINT NOT NULL AUTO_INCREMENT,
  `DataTypeGenConfigName` VARCHAR(25) NULL DEFAULT NULL,
  `DataAttributeID` SMALLINT NULL DEFAULT NULL,
  `SpecialInstructions` VARCHAR(99) NULL DEFAULT NULL,
  `RunQuantity` INT NULL DEFAULT NULL,
  `MinuteInterval` SMALLINT NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `ApplicationID` CHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`DataGenConfigID`),
  CONSTRAINT `FK_platform_datagenconfig_dataattributes`
    FOREIGN KEY (`DataAttributeID`)
    REFERENCES `platform_dataattributes` (`PlatformDataAttributesID`),
  CONSTRAINT `FK_platform_datagenconfig_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`),
  CONSTRAINT `platform_config_datagen_registeredapp`
    FOREIGN KEY (`ApplicationID`)
    REFERENCES `refdata_application` (`AppGUID`))
ENGINE = InnoDB
AUTO_INCREMENT = 62
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_platform_datagenconfig_dataattributes` ON `platform_config_datagen` (`DataAttributeID` ASC) VISIBLE;

CREATE INDEX `FK_platform_datagenconfig_status` ON `platform_config_datagen` (`StatusID` ASC) VISIBLE;

CREATE INDEX `platform_config_datagen_registeredapp` ON `platform_config_datagen` (`ApplicationID` ASC) VISIBLE;

CREATE INDEX `IDX_PlatformConfigDataGen` ON `platform_config_datagen` (`DataGenConfigID` ASC, `DataAttributeID` ASC, `DataTypeGenConfigName` ASC, `RunQuantity` ASC, `MinuteInterval` ASC, `SpecialInstructions` ASC, `CreatedDate` ASC, `CreatedUser` ASC, `StatusID` ASC, `ApplicationID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `platform_datastructures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `platform_datastructures` ;

CREATE TABLE IF NOT EXISTS `platform_datastructures` (
  `PlatformDataStructuresID` SMALLINT NOT NULL AUTO_INCREMENT,
  `DataStructureName` VARCHAR(50) NULL DEFAULT NULL,
  `SensitivityFlagID` SMALLINT NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `PlatformDataStructuresGUID` CHAR(38) NULL DEFAULT NULL,
  `RegisteredApp` VARCHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`PlatformDataStructuresID`),
  CONSTRAINT `FK_platform_datastructures__registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_platform_datastructures_sensitivityflag`
    FOREIGN KEY (`SensitivityFlagID`)
    REFERENCES `refdata_sensitivityflag` (`SensitiveFlagID`),
  CONSTRAINT `FK_platform_datastructures_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_platform_datastructures_status` ON `platform_datastructures` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_platform_datastructures__registeredapp` ON `platform_datastructures` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_platform_datastructures_sensitivityflag` ON `platform_datastructures` (`SensitivityFlagID` ASC) VISIBLE;

CREATE INDEX `IDX_Platform_DataStructures` ON `platform_datastructures` (`PlatformDataStructuresID` ASC, `DataStructureName` ASC, `SensitivityFlagID` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `PlatformDataStructuresGUID` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `platform_datastructurestodataattributes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `platform_datastructurestodataattributes` ;

CREATE TABLE IF NOT EXISTS `platform_datastructurestodataattributes` (
  `PlatformDataStructuresToDataAttributesID` SMALLINT NOT NULL AUTO_INCREMENT,
  `PlatformDataStructuresID` SMALLINT NULL DEFAULT NULL,
  `CompositeDataStructureName` VARCHAR(50) NULL DEFAULT NULL,
  `SensitivityFlagID` SMALLINT NULL DEFAULT '1',
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `PlatformDataStructuresToDataAttributesGUID` CHAR(38) NULL DEFAULT NULL,
  `RegisteredApp` VARCHAR(38) NULL DEFAULT NULL,
  `PlatformDataAttributesID` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`PlatformDataStructuresToDataAttributesID`),
  CONSTRAINT `FK_platform_datastructurestodataattributes_dataattributes`
    FOREIGN KEY (`PlatformDataAttributesID`)
    REFERENCES `platform_dataattributes` (`PlatformDataAttributesID`),
  CONSTRAINT `FK_platform_datastructurestodataattributes_datastructure`
    FOREIGN KEY (`PlatformDataStructuresID`)
    REFERENCES `platform_datastructures` (`PlatformDataStructuresID`),
  CONSTRAINT `FK_platform_datastructurestodataattributes_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_platform_datastructurestodataattributes_sensitivityflag`
    FOREIGN KEY (`SensitivityFlagID`)
    REFERENCES `refdata_sensitivityflag` (`SensitiveFlagID`),
  CONSTRAINT `FK_platform_datastructurestodataattributes_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_platform_datastructurestodataattributes_dataattributes` ON `platform_datastructurestodataattributes` (`PlatformDataAttributesID` ASC) VISIBLE;

CREATE INDEX `FK_platform_datastructurestodataattributes_datastructure` ON `platform_datastructurestodataattributes` (`PlatformDataStructuresID` ASC) VISIBLE;

CREATE INDEX `FK_platform_datastructurestodataattributes_registeredapp` ON `platform_datastructurestodataattributes` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `FK_platform_datastructurestodataattributes_sensitivityflag` ON `platform_datastructurestodataattributes` (`SensitivityFlagID` ASC) VISIBLE;

CREATE INDEX `FK_platform_datastructurestodataattributes_status` ON `platform_datastructurestodataattributes` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IDX_Platform_DataStructuresToDataAttributes` ON `platform_datastructurestodataattributes` (`PlatformDataStructuresToDataAttributesID` ASC, `PlatformDataStructuresToDataAttributesGUID` ASC, `PlatformDataStructuresID` ASC, `CompositeDataStructureName` ASC, `SensitivityFlagID` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `RegisteredApp` ASC, `PlatformDataAttributesID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `platform_rulesets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `platform_rulesets` ;

CREATE TABLE IF NOT EXISTS `platform_rulesets` (
  `RuleID` BIGINT NOT NULL AUTO_INCREMENT,
  `RuleName` VARCHAR(65) NULL DEFAULT NULL,
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `ExpirationDate` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`RuleID`),
  CONSTRAINT `FK_platform_rulesets_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_platform_rulesets_status` ON `platform_rulesets` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IDX_Platform_RuleSets` ON `platform_rulesets` (`RuleID` ASC, `RuleName` ASC, `CreatedUser` ASC, `CreatedDate` ASC, `ExpirationDate` ASC, `StatusID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `refdata_operationtype`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refdata_operationtype` ;

CREATE TABLE IF NOT EXISTS `refdata_operationtype` (
  `OperationTypeID` VARCHAR(7) NOT NULL,
  `OperationTypeName` VARCHAR(60) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  PRIMARY KEY (`OperationTypeID`),
  CONSTRAINT `FK_refdata_operationtype_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_refdata_operationtype_status` ON `refdata_operationtype` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IDX_RefData_OperationType` ON `refdata_operationtype` (`OperationTypeID` ASC, `OperationTypeName` ASC, `StatusID` ASC, `CreatedDate` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `platform_rulesetsdefinitions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `platform_rulesetsdefinitions` ;

CREATE TABLE IF NOT EXISTS `platform_rulesetsdefinitions` (
  `RulesetDefinitionsID` CHAR(38) NOT NULL,
  `RulesetDefinitionName` VARCHAR(50) NULL DEFAULT NULL,
  `RuleSetID` BIGINT NULL DEFAULT NULL,
  `StepOrderID` SMALLINT NULL DEFAULT NULL,
  `OperationTypeID` VARCHAR(7) NULL DEFAULT NULL,
  `RulesetDefValue` CHAR(40) NULL DEFAULT NULL,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `EffectiveDate` TIMESTAMP NULL DEFAULT NULL,
  `ApplicationID` VARCHAR(38) NULL DEFAULT NULL,
  `TermDate` TIMESTAMP NULL DEFAULT NULL,
  `DataAttributeID` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`RulesetDefinitionsID`),
  CONSTRAINT `FK_platform_rulesetsdefinitions_dataattributes`
    FOREIGN KEY (`DataAttributeID`)
    REFERENCES `platform_dataattributes` (`PlatformDataAttributesID`),
  CONSTRAINT `FK_platform_rulesetsdefinitions_operationtype`
    FOREIGN KEY (`OperationTypeID`)
    REFERENCES `refdata_operationtype` (`OperationTypeID`),
  CONSTRAINT `FK_platform_rulesetsdefinitions_registeredapp`
    FOREIGN KEY (`ApplicationID`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_platform_rulesetsdefinitions_ruleset`
    FOREIGN KEY (`RuleSetID`)
    REFERENCES `platform_rulesets` (`RuleID`),
  CONSTRAINT `FK_platform_rulesetsdefinitions_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_platform_rulesetsdefinitions_operationtype` ON `platform_rulesetsdefinitions` (`OperationTypeID` ASC) VISIBLE;

CREATE INDEX `FK_platform_rulesetsdefinitions_registeredapp` ON `platform_rulesetsdefinitions` (`ApplicationID` ASC) VISIBLE;

CREATE INDEX `FK_platform_rulesetsdefinitions_ruleset` ON `platform_rulesetsdefinitions` (`RuleSetID` ASC) VISIBLE;

CREATE INDEX `FK_platform_rulesetsdefinitions_status` ON `platform_rulesetsdefinitions` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_platform_rulesetsdefinitions_dataattributes` ON `platform_rulesetsdefinitions` (`DataAttributeID` ASC) VISIBLE;

CREATE INDEX `IDX_Platform_RulesetsDefinitions` ON `platform_rulesetsdefinitions` (`RulesetDefinitionsID` ASC, `RuleSetID` ASC, `RulesetDefinitionName` ASC, `StepOrderID` ASC, `OperationTypeID` ASC, `RulesetDefValue` ASC, `CreatedDate` ASC, `EffectiveDate` ASC, `StatusID` ASC, `ApplicationID` ASC, `TermDate` ASC, `DataAttributeID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `refdata_industrystd`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refdata_industrystd` ;

CREATE TABLE IF NOT EXISTS `refdata_industrystd` (
  `IndustryStd` VARCHAR(6) NOT NULL,
  `IndustryStdDesc` VARCHAR(30) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  PRIMARY KEY (`IndustryStd`),
  CONSTRAINT `FK_refdata_industrystd_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_refdata_industrystd_status` ON `refdata_industrystd` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IDX_IndustryStd` ON `refdata_industrystd` (`IndustryStd` ASC, `IndustryStdDesc` ASC, `CreatedDate` ASC, `StatusID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `refdata_codeset`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refdata_codeset` ;

CREATE TABLE IF NOT EXISTS `refdata_codeset` (
  `CodeSetsID` BIGINT NOT NULL AUTO_INCREMENT,
  `CodeSetName` VARCHAR(50) NULL DEFAULT NULL,
  `IndustryStd` VARCHAR(6) NULL DEFAULT NULL,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `CodesetGUID` CHAR(38) NULL DEFAULT NULL,
  `FieldMapping` VARCHAR(20) NULL DEFAULT NULL,
  `SensitivityFlagID` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`CodeSetsID`),
  CONSTRAINT `FK_refdata_codeset_industrystd`
    FOREIGN KEY (`IndustryStd`)
    REFERENCES `refdata_industrystd` (`IndustryStd`),
  CONSTRAINT `FK_refdata_codeset_sensitivityflag`
    FOREIGN KEY (`SensitivityFlagID`)
    REFERENCES `refdata_sensitivityflag` (`SensitiveFlagID`),
  CONSTRAINT `FK_refdata_codesets_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 60
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_refdata_codesets_status` ON `refdata_codeset` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_refdata_codeset_industrystd` ON `refdata_codeset` (`IndustryStd` ASC) VISIBLE;

CREATE INDEX `FK_refdata_codeset_sensitivityflag` ON `refdata_codeset` (`SensitivityFlagID` ASC) VISIBLE;

CREATE INDEX `IDX_RefData_CodeSets` ON `refdata_codeset` (`CodeSetsID` ASC, `CodeSetName` ASC, `IndustryStd` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `CodesetGUID` ASC, `FieldMapping` ASC, `SensitivityFlagID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `refdata_codesetstructures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refdata_codesetstructures` ;

CREATE TABLE IF NOT EXISTS `refdata_codesetstructures` (
  `CodeSetStructuresID` BIGINT NOT NULL AUTO_INCREMENT,
  `CodeSetStructureName` VARCHAR(50) NULL DEFAULT NULL,
  `IndustryStd` VARCHAR(6) NULL DEFAULT NULL,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `CodesetStructureGUID` CHAR(38) NULL DEFAULT NULL,
  `Field1Value` VARCHAR(75) NULL DEFAULT NULL,
  `Field2Value` VARCHAR(75) NULL DEFAULT NULL,
  `Field3Value` VARCHAR(75) NULL DEFAULT NULL,
  `Field4Value` VARCHAR(75) NULL DEFAULT NULL,
  `Field5Value` VARCHAR(75) NULL DEFAULT NULL,
  `Field6Value` VARCHAR(75) NULL DEFAULT NULL,
  `Field7Value` VARCHAR(75) NULL DEFAULT NULL,
  `Field8Value` VARCHAR(75) NULL DEFAULT NULL,
  `Field9Value` VARCHAR(75) NULL DEFAULT NULL,
  `SensitivityFlagID` SMALLINT NULL DEFAULT NULL,
  `CodesetsID` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`CodeSetStructuresID`),
  CONSTRAINT `FK_refdata_codesetstructures_codesets`
    FOREIGN KEY (`CodesetsID`)
    REFERENCES `refdata_codeset` (`CodeSetsID`),
  CONSTRAINT `FK_refdata_codesetstructures_industrystd`
    FOREIGN KEY (`IndustryStd`)
    REFERENCES `refdata_industrystd` (`IndustryStd`),
  CONSTRAINT `FK_refdata_codesetstructures_sensitivityflag`
    FOREIGN KEY (`SensitivityFlagID`)
    REFERENCES `refdata_sensitivityflag` (`SensitiveFlagID`),
  CONSTRAINT `FK_refdata_codesetstructures_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_refdata_codesetstructures_industrystd` ON `refdata_codesetstructures` (`IndustryStd` ASC) VISIBLE;

CREATE INDEX `FK_refdata_codesetstructures_sensitivityflag` ON `refdata_codesetstructures` (`SensitivityFlagID` ASC) VISIBLE;

CREATE INDEX `FK_refdata_codesetstructures_status` ON `refdata_codesetstructures` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_refdata_codesetstructures_codesets` ON `refdata_codesetstructures` (`CodesetsID` ASC) VISIBLE;

CREATE INDEX `IDX_RefData_CodeSetStructure1` ON `refdata_codesetstructures` (`CodeSetStructuresID` ASC, `CodeSetStructureName` ASC, `IndustryStd` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `CodesetStructureGUID` ASC, `CodesetsID` ASC) VISIBLE;

CREATE INDEX `IDX_RefData_CodeSetStructure2` ON `refdata_codesetstructures` (`Field1Value` ASC, `Field2Value` ASC, `Field3Value` ASC, `Field4Value` ASC, `Field5Value` ASC, `Field6Value` ASC, `Field7Value` ASC, `Field8Value` ASC, `Field9Value` ASC, `SensitivityFlagID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `refdata_legalentity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refdata_legalentity` ;

CREATE TABLE IF NOT EXISTS `refdata_legalentity` (
  `LegalEntityGUID` CHAR(38) NOT NULL,
  `LocationName` VARCHAR(50) NULL DEFAULT NULL,
  `Address` VARCHAR(75) NULL DEFAULT NULL,
  `City` VARCHAR(60) NULL DEFAULT NULL,
  `StateID` VARCHAR(2) NULL DEFAULT NULL,
  `ZipCode` VARCHAR(12) NULL DEFAULT NULL,
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LocationURL` VARCHAR(99) NULL DEFAULT NULL,
  `LocationPhone` VARCHAR(12) NULL DEFAULT NULL,
  PRIMARY KEY (`LegalEntityGUID`),
  CONSTRAINT `FK_refdata_location_states`
    FOREIGN KEY (`StateID`)
    REFERENCES `refdata_usstates` (`StateID`),
  CONSTRAINT `FK_refdata_location_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_refdata_location_states` ON `refdata_legalentity` (`StateID` ASC) VISIBLE;

CREATE INDEX `FK_refdata_location_status` ON `refdata_legalentity` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IDX_RefData_LegalEntity2` ON `refdata_legalentity` (`LegalEntityGUID` ASC, `LocationName` ASC, `Address` ASC, `City` ASC, `StateID` ASC, `ZipCode` ASC, `CreatedUser` ASC, `StatusID` ASC, `CreatedDate` ASC, `LocationURL` ASC, `LocationPhone` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `refdata_organization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refdata_organization` ;

CREATE TABLE IF NOT EXISTS `refdata_organization` (
  `OrganizationGUID` CHAR(38) NOT NULL,
  `OrganizationInternalCode` VARCHAR(10) NULL DEFAULT NULL,
  `OrganizationInternalID` VARCHAR(10) NULL DEFAULT NULL,
  `OrganizationName` VARCHAR(50) NULL DEFAULT NULL,
  `Address` VARCHAR(75) NULL DEFAULT NULL,
  `City` VARCHAR(60) NULL DEFAULT NULL,
  `StateID` VARCHAR(2) NULL DEFAULT NULL,
  `ZipCode` VARCHAR(12) NULL DEFAULT NULL,
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LegalEntityGUID` VARCHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`OrganizationGUID`),
  CONSTRAINT `FK_refdata_organization_legalentity`
    FOREIGN KEY (`LegalEntityGUID`)
    REFERENCES `refdata_legalentity` (`LegalEntityGUID`),
  CONSTRAINT `FK_refdata_organization_states`
    FOREIGN KEY (`StateID`)
    REFERENCES `refdata_usstates` (`StateID`),
  CONSTRAINT `FK_refdata_organization_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_refdata_organization_status` ON `refdata_organization` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_refdata_organization_states` ON `refdata_organization` (`StateID` ASC) VISIBLE;

CREATE INDEX `FK_refdata_organization_legalentity` ON `refdata_organization` (`LegalEntityGUID` ASC) VISIBLE;

CREATE INDEX `IDX_RefData_Organization` ON `refdata_organization` (`OrganizationGUID` ASC, `OrganizationName` ASC, `Address` ASC, `City` ASC, `StateID` ASC, `ZipCode` ASC, `CreatedDate` ASC, `StatusID` ASC, `CreatedUser` ASC, `OrganizationInternalCode` ASC, `OrganizationInternalID` ASC, `LegalEntityGUID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `refdata_platformparams`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refdata_platformparams` ;

CREATE TABLE IF NOT EXISTS `refdata_platformparams` (
  `PlatformParamsID` SMALLINT NOT NULL AUTO_INCREMENT,
  `PlatformParamValues` VARCHAR(35) NULL DEFAULT NULL,
  `PlatformParamDesc` VARCHAR(70) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  PRIMARY KEY (`PlatformParamsID`),
  CONSTRAINT `FK_refdata_platformparams_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_refdata_platformparams_status` ON `refdata_platformparams` (`StatusID` ASC) VISIBLE;

CREATE INDEX `IDX_refdata_platformparams` ON `refdata_platformparams` (`PlatformParamsID` ASC, `PlatformParamDesc` ASC, `PlatformParamValues` ASC, `CreatedDate` ASC, `StatusID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `refdata_platformparamstodataattributes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `refdata_platformparamstodataattributes` ;

CREATE TABLE IF NOT EXISTS `refdata_platformparamstodataattributes` (
  `PlatformParamsToDataAttributeID` BIGINT NOT NULL AUTO_INCREMENT,
  `PlatformParamsID` SMALLINT NULL DEFAULT NULL,
  `DataAttributeID` SMALLINT NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `RegisteredApp` VARCHAR(38) NULL DEFAULT NULL,
  PRIMARY KEY (`PlatformParamsToDataAttributeID`),
  CONSTRAINT `FK_refdata_platformparamstodataattributes_dataattributes`
    FOREIGN KEY (`DataAttributeID`)
    REFERENCES `platform_dataattributes` (`PlatformDataAttributesID`),
  CONSTRAINT `FK_refdata_platformparamstodataattributes_platformparams`
    FOREIGN KEY (`PlatformParamsID`)
    REFERENCES `refdata_platformparams` (`PlatformParamsID`),
  CONSTRAINT `FK_refdata_platformparamstodataattributes_registeredapp`
    FOREIGN KEY (`RegisteredApp`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_refdata_platformparamstodataattributes_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_refdata_platformparamstodataattributes_platformparams` ON `refdata_platformparamstodataattributes` (`PlatformParamsID` ASC) VISIBLE;

CREATE INDEX `FK_refdata_platformparamstodataattributes_dataattributes` ON `refdata_platformparamstodataattributes` (`DataAttributeID` ASC) VISIBLE;

CREATE INDEX `FK_refdata_platformparamstodataattributes_status` ON `refdata_platformparamstodataattributes` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_refdata_platformparamstodataattributes_registeredapp` ON `refdata_platformparamstodataattributes` (`RegisteredApp` ASC) VISIBLE;

CREATE INDEX `IDX_refdata_platformparamstodataattributes` ON `refdata_platformparamstodataattributes` (`PlatformParamsToDataAttributeID` ASC, `PlatformParamsID` ASC, `DataAttributeID` ASC, `CreatedDate` ASC, `StatusID` ASC, `RegisteredApp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `terms_codesetstoapplication`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `terms_codesetstoapplication` ;

CREATE TABLE IF NOT EXISTS `terms_codesetstoapplication` (
  `CodeSetToApplicationID` BIGINT NOT NULL AUTO_INCREMENT,
  `CodeSetsID` BIGINT NOT NULL,
  `Domain` VARCHAR(50) NULL DEFAULT NULL,
  `IndustryStd` VARCHAR(6) NULL DEFAULT NULL,
  `SpecificDetails` VARCHAR(99) NULL DEFAULT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `OrganizationID` VARCHAR(38) NULL DEFAULT NULL,
  `ApplicationID` VARCHAR(38) NULL DEFAULT NULL,
  `VendorID` INT NULL DEFAULT NULL,
  `CodeValue` VARCHAR(20) NULL DEFAULT NULL,
  `CodeDesc` VARCHAR(129) NULL DEFAULT NULL,
  `SensitiveFlagID` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`CodeSetToApplicationID`),
  CONSTRAINT `FK_terms_codesetstoapplication_Application`
    FOREIGN KEY (`ApplicationID`)
    REFERENCES `refdata_application` (`AppGUID`),
  CONSTRAINT `FK_terms_codesetstoapplication_codeset`
    FOREIGN KEY (`CodeSetsID`)
    REFERENCES `refdata_codeset` (`CodeSetsID`),
  CONSTRAINT `FK_terms_codesetstoapplication_industrystd`
    FOREIGN KEY (`IndustryStd`)
    REFERENCES `refdata_industrystd` (`IndustryStd`),
  CONSTRAINT `FK_terms_codesetstoapplication_Org`
    FOREIGN KEY (`OrganizationID`)
    REFERENCES `refdata_organization` (`OrganizationGUID`),
  CONSTRAINT `FK_terms_codesetstoapplication_sensitiveflag`
    FOREIGN KEY (`SensitiveFlagID`)
    REFERENCES `refdata_sensitivityflag` (`SensitiveFlagID`),
  CONSTRAINT `FK_terms_codesetstoapplication_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`),
  CONSTRAINT `FK_terms_codesetstoapplication_Vendor`
    FOREIGN KEY (`VendorID`)
    REFERENCES `refdata_vendor` (`VendorID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_terms_codesetstoapplication_Application` ON `terms_codesetstoapplication` (`ApplicationID` ASC) VISIBLE;

CREATE INDEX `FK_terms_codesetstoapplication_Org` ON `terms_codesetstoapplication` (`OrganizationID` ASC) VISIBLE;

CREATE INDEX `FK_terms_codesetstoapplication_industrystd` ON `terms_codesetstoapplication` (`IndustryStd` ASC) VISIBLE;

CREATE INDEX `FK_terms_codesetstoapplication_status` ON `terms_codesetstoapplication` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_terms_codesetstoapplication_sensitiveflag` ON `terms_codesetstoapplication` (`SensitiveFlagID` ASC) VISIBLE;

CREATE INDEX `FK_terms_codesetstoapplication_codeset` ON `terms_codesetstoapplication` (`CodeSetsID` ASC) VISIBLE;

CREATE INDEX `FK_terms_codesetstoapplication_Vendor` ON `terms_codesetstoapplication` (`VendorID` ASC) VISIBLE;

CREATE INDEX `IDX_Terms_CodeSetsToApplication` ON `terms_codesetstoapplication` (`CodeSetToApplicationID` ASC, `CodeSetsID` ASC, `Domain` ASC, `IndustryStd` ASC, `SpecificDetails` ASC, `CreatedDate` ASC, `CreatedUser` ASC, `OrganizationID` ASC, `ApplicationID` ASC, `StatusID` ASC, `VendorID` ASC, `SensitiveFlagID` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `terms_codesetstoapplicationvalues`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `terms_codesetstoapplicationvalues` ;

CREATE TABLE IF NOT EXISTS `terms_codesetstoapplicationvalues` (
  `CodeSetToApplicationValuesID` BIGINT NOT NULL AUTO_INCREMENT,
  `CodeSetToApplicationID` BIGINT NULL DEFAULT NULL,
  `CodeSetsID` BIGINT NOT NULL,
  `CreatedDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `StatusID` SMALLINT NULL DEFAULT '1',
  `CreatedUser` VARCHAR(20) NULL DEFAULT NULL,
  `TermValue` VARCHAR(20) NULL DEFAULT NULL,
  `TermValueLow` VARCHAR(10) NULL DEFAULT NULL,
  `TermValueHigh` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`CodeSetToApplicationValuesID`),
  CONSTRAINT `FK_terms_codesetstoapplicationvalues_codeset`
    FOREIGN KEY (`CodeSetsID`)
    REFERENCES `refdata_codeset` (`CodeSetsID`),
  CONSTRAINT `FK_terms_codesetstoapplicationvalues_codesettoapp`
    FOREIGN KEY (`CodeSetToApplicationID`)
    REFERENCES `terms_codesetstoapplication` (`CodeSetToApplicationID`),
  CONSTRAINT `FK_terms_codesetstoapplicationvalues_status`
    FOREIGN KEY (`StatusID`)
    REFERENCES `refdata_status` (`StatusID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_terms_codesetstoapplicationvalues_codeset` ON `terms_codesetstoapplicationvalues` (`CodeSetsID` ASC) VISIBLE;

CREATE INDEX `FK_terms_codesetstoapplicationvalues_status` ON `terms_codesetstoapplicationvalues` (`StatusID` ASC) VISIBLE;

CREATE INDEX `FK_terms_codesetstoapplicationvalues_codesettoapp` ON `terms_codesetstoapplicationvalues` (`CodeSetToApplicationID` ASC) VISIBLE;

CREATE INDEX `IDX_Terms_CodeSetsToApplicationValues` ON `terms_codesetstoapplicationvalues` (`CodeSetToApplicationValuesID` ASC, `CodeSetToApplicationID` ASC, `CodeSetsID` ASC, `CreatedDate` ASC, `CreatedUser` ASC, `StatusID` ASC, `TermValue` ASC, `TermValueLow` ASC, `TermValueHigh` ASC) VISIBLE;

DELIMITER $$

DROP TRIGGER IF EXISTS `refdata_vendors_uuid` $$
CREATE
TRIGGER `refdata_vendors_uuid`
BEFORE INSERT ON `refdata_vendor`
FOR EACH ROW
BEGIN
  IF new.VendorGUID IS NULL THEN
    SET new.VendorGUID = UUID();
  END IF;
END$$

DROP TRIGGER IF EXISTS `refdata_application_uuid` $$
CREATE
TRIGGER `refdata_application_uuid`
BEFORE INSERT ON `refdata_application`
FOR EACH ROW
BEGIN
  IF new.AppGUID IS NULL THEN
    SET new.AppGUID = UUID();
  END IF;
END$$

DROP TRIGGER IF EXISTS `refdata_legalentity_uuid` $$
CREATE
TRIGGER `refdata_legalentity_uuid`
BEFORE INSERT ON `refdata_legalentity`
FOR EACH ROW
BEGIN
  IF new.LegalEntityGUID IS NULL THEN
    SET new.LegalEntityGUID = UUID();
  END IF;
END$$


DROP TRIGGER IF EXISTS `refdata_organization_uuid` $$
CREATE
TRIGGER `refdata_organization_uuid`
BEFORE INSERT ON `refdata_organization`
FOR EACH ROW
BEGIN
  IF new.OrganizationGUID IS NULL THEN
    SET new.OrganizationGUID = UUID();
  END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
