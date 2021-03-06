USE [dbClinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetDataFromPatientMetric]    Script Date: 5/11/2021 2:25:24 PM ******/
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



UPDATE RPMReportMaster 
SET 
    PatientID=PM.PatientID, 
    PatientName=PM.FirstName,
	Glucose= PM.HighGlucoseLimit,
	MobileNumber=PM.MobileNumber,
	BP=Pt.value_1+'/'+Pt.value_2,
	CreatedDate = Pt.created
	
	
FROM PatientMaster PM 
INNER JOIN
PatientMetric Pt
ON PM.DeviceId = @device_id 
where RPMReportMaster.DeviceID=@device_id and RPMReportMaster.CreatedDate=(
SELECT MAX(CreatedDate) FROM RPMReportMaster);

--insert into RPMReportMaster(PatientID,PatientName,Glucose,MobileNumber,DeviceID,BP) 
--select PM.PatientID,PM.FirstName,PM.HighGlucoseLimit,PM.MobileNumber,OK.device_id,OK.value_1 from PatientMaster as PM INNER JOIN PatientMetric as OK
--ON PM.DeviceId = @device_id;



END