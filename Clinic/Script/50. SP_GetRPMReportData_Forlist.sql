USE [Clinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetRPMReportData_Forlist]    Script Date: 5/22/2021 11:37:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetRPMReportData_Forlist]
@Status nvarchar(50) = null,
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@LoginUserID bigint,
@clinic1 nvarchar(250) = null,
@clinic2 nvarchar(250) = null,
@clinic3 nvarchar(250) = null
AS
BEGIN
	
	IF @LoginUserID = 1
	BEGIN
		SELECT COUNT(RPMReportID) AS TotalCount
		FROM [dbo].[RPMReportMaster] RPM
		INNER JOIN [dbo].[PatientMaster] PM ON PM.[PatientID] = RPM.[PatientID]
		
		SELECT 
				RPM.[RPMReportID], 
				RPM.[DeviceID], 
				RPM.[PatientID], 
				RPM.[PatientName], 
				RPM.[BP], 
				RPM.[Glucose], 
				RPM.[MobileNumber], 
				RPM.[Status], 
				RPM.[Notes], 
				RPM.[CreatedDate],
				RPM.[RPMInteractionTime],
				RPM.[RemainingBlockTime],
				RPM.[MissedReadingDays],
				RPM.[WellnessCall],
				PM.[ClinicName]
			 FROM  [dbo].[RPMReportMaster] RPM
			 JOIN  [dbo].[PatientMaster] PM ON PM.PatientID = RPM.PatientID
	END
	ELSE
	BEGIN
		SELECT COUNT(RPMReportID) AS TotalCount
		FROM [dbo].[RPMReportMaster] RPM
		INNER JOIN [dbo].[PatientMaster] PM ON PM.[PatientID] = RPM.[PatientID]
		WHERE PM.[ClinicName] like '%' + @clinic1 + '%' OR PM.[ClinicName] like '%' + @clinic2 + '%' OR  PM.[ClinicName] like '%' + @clinic3 + '%'

		SELECT 
				RPM.[RPMReportID], 
				RPM.[DeviceID], 
				RPM.[PatientID], 
				RPM.[PatientName], 
				RPM.[BP], 
				RPM.[Glucose], 
				RPM.[MobileNumber], 
				RPM.[Status], 
				RPM.[Notes], 
				RPM.[CreatedDate],
				RPM.[RPMInteractionTime],
				RPM.[RemainingBlockTime],
				RPM.[MissedReadingDays],
				RPM.[WellnessCall],
				PM.[ClinicName]
			 FROM  [dbo].[RPMReportMaster] RPM
			 JOIN  [dbo].[PatientMaster] PM ON PM.PatientID = RPM.PatientID
		 WHERE PM.[ClinicName] like '%' + @clinic1 + '%' OR PM.[ClinicName] like '%' + @clinic2 + '%'  OR  PM.[ClinicName] like '%' + @clinic3 + '%' --+ @clinic1 + '%' OR PM.[ClinicName] LIKE '%' +RTRIM(@clinic2) + '%'
	END
	END
