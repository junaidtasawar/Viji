USE [Clinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetDataFromPatientMetric]    Script Date: 6/10/2021 10:24:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[SP_GetDataFromPatientMetric]
(
	@device_id nvarchar(15) 
)
AS 
BEGIN
DECLARE @status nchar(10) 
DECLARE @LowBPLimit decimal(18,2)
DECLARE @HighBPLimit decimal(18,2)
DECLARE @ReadingLowBP decimal(18,2)
DECLARE @ReadingHighBP decimal(18,2)
SET @LowBPLimit		=	(SELECT [LowBPLimit] FROM [dbo].[PatientMaster] WHERE [DeviceId] = @device_id)
SET @HighBPLimit	=	(SELECT [HighBPLimit] FROM [dbo].[PatientMaster] WHERE [DeviceId] = @device_id)
SET @ReadingLowBP	=	(SELECT value_1 FROM PatientMetric WHERE device_id=@device_id)
SET @ReadingHighBP	=	(SELECT value_2 FROM PatientMetric WHERE device_id=@device_id)

IF (@ReadingLowBP < @LowBPLimit) OR (@HighBPLimit > @ReadingHighBP)
BEGIN
	SET @status = 'Critical'
END
ELSE
BEGIN
	SET @status = 'Normal'
END

UPDATE RPMReportMaster 
SET PatientID=PM.PatientID, 
    PatientName=PM.FirstName,
	Glucose= PM.HighGlucoseLimit,
	MobileNumber=PM.MobileNumber,
	BP=Pt.value_1+'/'+Pt.value_2,
	CreatedDate = Pt.created,
	[Status] = @status
FROM PatientMaster PM 
INNER JOIN PatientMetric Pt ON PM.DeviceId = @device_id 
where RPMReportMaster.DeviceID=@device_id 
and RPMReportMaster.CreatedDate=(SELECT MAX(CreatedDate) FROM RPMReportMaster);

--insert into RPMReportMaster(PatientID,PatientName,Glucose,MobileNumber,DeviceID,BP) 
--select PM.PatientID,PM.FirstName,PM.HighGlucoseLimit,PM.MobileNumber,OK.device_id,OK.value_1 from PatientMaster as PM INNER JOIN PatientMetric as OK
--ON PM.DeviceId = @device_id;
END