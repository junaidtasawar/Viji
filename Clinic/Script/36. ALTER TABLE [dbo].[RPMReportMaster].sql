USE [Clinic]
GO

ALTER TABLE [dbo].[RPMReportMaster]
ADD [FirstName] [nvarchar](50) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [MiddleName] [nvarchar](50) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [LastName] [nvarchar](50) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [Gender] [int] NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [DOB] [datetime] NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [Age] [int] NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [ClinicName] [nvarchar](50) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [BloodGroup] [nvarchar](10) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [Address] [nvarchar](250) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [City] [nvarchar](50) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [State] [nvarchar](50) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [COUNTRY] [nvarchar](50) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [PostalCode] [nvarchar](50) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [CreatedBy] [bigint] NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [CreatedOn] [datetime] NULL;
ALTER TABLE [dbo].[RPMReportMaster]
ADD [UpdatedBy] [bigint] NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [UpdatedOn] [datetime] NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [IsActive] [bit] NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [DoctorsName] [nvarchar](max) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [MRNNumber] [nvarchar](10) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [Email] [nvarchar](50) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [PrimaryContactNumber] [nvarchar](15) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [AlternateContactNumber] [nvarchar](15) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [PrimaryLanguage] [nvarchar](30) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [SecondaryLanguage] [nvarchar](30) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [Ethnicity] [nvarchar](30) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [MaritalStatus] [nvarchar](20) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [EmergencyName1] [nvarchar](50) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [EmergencyRelationship1] [nvarchar](50) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [EmergencyPhoneNo1] [nvarchar](20) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [EmergencyName2] [nvarchar](50) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [EmergencyRelationship2] [nvarchar](50) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [EmergencyPhoneNo2] [nvarchar](20) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [Races] [nvarchar](200) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [HomePhone] [nvarchar](20) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [CellPhone] [nvarchar](20) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [Comments] [nvarchar](max) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [GuardianName] [nvarchar](200) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [DriverLicenseID] [nvarchar](200) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [DriverLicenseState] [bit] NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [SSN] [nvarchar](200) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [CustomPatientID] [nvarchar](200) NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [LowBPLimit] [int] NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [HighBPLimit] [int] NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [LowGlucoseLimit] [int] NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [HighGlucoseLimit] [int] NULL;

ALTER TABLE [dbo].[RPMReportMaster]
ADD [DeviceReceivedDate] [datetime] NULL;