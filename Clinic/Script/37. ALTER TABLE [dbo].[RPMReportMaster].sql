USE [Clinic]
GO

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [FirstName];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [MiddleName];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [LastName];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [Gender];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [DOB];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [Age];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [ClinicName];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [BloodGroup];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [Address];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [City];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [State];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [COUNTRY];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [PostalCode];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [CreatedBy];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [CreatedOn];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [UpdatedBy];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [UpdatedOn];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [IsActive];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [DoctorsName];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [MRNNumber];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [Email];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [PrimaryContactNumber];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [AlternateContactNumber];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [PrimaryLanguage];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [SecondaryLanguage];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [Ethnicity];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [MaritalStatus];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [EmergencyName1];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [EmergencyRelationship1] ;

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [EmergencyPhoneNo1];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [EmergencyName2];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [EmergencyRelationship2] ;

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [EmergencyPhoneNo2];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [Races];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [HomePhone];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [CellPhone];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [Comments];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [GuardianName];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [DriverLicenseID];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [DriverLicenseState];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [SSN];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [CustomPatientID];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [LowBPLimit];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [HighBPLimit];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [LowGlucoseLimit];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [HighGlucoseLimit];

ALTER TABLE [dbo].[RPMReportMaster]
DROP COLUMN [DeviceReceivedDate];

ALTER TABLE [dbo].[RPMReportMaster]
ADD RPMInteractionTime NVARCHAR(20) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD RemainingBlockTime NVARCHAR(20) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD MissedReadingDays int NULL;
