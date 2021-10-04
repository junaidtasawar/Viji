Alter table [dbo].[RPMReportMaster]
ADD WellnessCall NVARCHAR(20) null

UPDATE [dbo].[RPMReportMaster]
SET WellnessCall = 'Pending'