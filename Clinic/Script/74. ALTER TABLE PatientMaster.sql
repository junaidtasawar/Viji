USE [dbClinic]
GO

ALTER TABLE PatientMaster
ADD DeviceName NVARCHAR(50) NULL

ALTER TABLE PatientMaster
ADD IsDeviceActive bit NULL DEFAULT(0)


