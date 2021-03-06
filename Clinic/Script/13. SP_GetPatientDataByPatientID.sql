USE [Clinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPatientDataByPatientID]    Script Date: 4/7/2021 4:24:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetPatientDataByPatientID]
@PatientID bigint  = 0 
AS
BEGIN
	
	SET NOCOUNT ON;
	SELECT
		PM.PatientID, 
		PM.FirstName + ' ' + PM.LastName 'Name', 
		PM.Gender, 
		DATEDIFF(yy, PM.[DOB], getdate()) 'age',
		RIGHT('00' + CAST(DATEPART(DAY, PM.DOB) AS VARCHAR(2)), 2) + ' ' +
		DATENAME(MONTH, PM.DOB) + ' ' +
		CAST(DATEPART(YEAR, PM.DOB)  AS VARCHAR(4)) 'DOB'
		, 
		PM.[BloodGroup],
		PM.[MRNNumber],
		PM.Address,
		PM.City,
		PM.State,
		PM.COUNTRY,
		PM.MobileNumber,
		PM.ClinicName,
		PM.BloodGroup,
		PM.PostalCode,
		PM.DoctorsName,
		PM.StatusName,
		PM.MRNNumber,
		PM.Email,
		PM.PrimaryContactNumber,
		PM.[AlternateContactNumber],
		PM.PrimaryLanguage,
		PM.SecondaryLanguage,
		PM.Ethnicity,
		PM.MaritalStatus,
		PM.Races,
		PM.HomePhone,
		PM.Comments,
		PM.GuardianName,
		PM.DriverLicenseID,
		PM.DriverLicenseState,
		PM.[SSN],
		PM.[Comments],
		PM.[DoctorsName],
		PM.[CellPhone],
		PM.[CustomPatientID],
		PM.[DeviceId],
		PM.[DeviceReceivedDate],
		PM.[LowBPLimit],
		PM.[HighBPLimit],
		PM.[LowGlucoseLimit],
		PM.[HighGlucoseLimit],
		CCMNote.CCMNoteID
		FROM PatientMaster PM
		LEFT JOIN [CCMNoteMaster] CCMNote
		ON CCMNote.PatientID = PM.PatientID
		Where PM.PatientID = @PatientID
END



