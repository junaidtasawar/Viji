ALTER TABLE [dbo].[PatientMaster]
ADD DeviceId nvarchar(15) null

ALTER TABLE [dbo].[PatientMaster]
ADD LowBPLimit int null

ALTER TABLE [dbo].[PatientMaster]
ADD HighBPLimit int null

ALTER TABLE [dbo].[PatientMaster]
ADD LowGlucoseLimit int null

ALTER TABLE [dbo].[PatientMaster]
ADD HighGlucoseLimit int null