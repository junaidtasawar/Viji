USE [Clinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPatientDetailsByPatientID]    Script Date: 3/25/2021 7:29:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetPatientDetailsByPatientID]
@PatientID bigint
AS
BEGIN
	SELECT	PM.[PatientID], 
			PM.[FirstName], 
			PM.[MiddleName], 
			PM.[LastName], 
			PM.[MRNNumber], 
			PM.[Gender], 
			PM.[DOB], 
			PM.[Age], 
			PM.[MobileNumber], 
			PM.[ClinicName], 
			PM.[BloodGroup], 
			PM.[Address], 
			PM.[City], 
			PM.[State], 
			PM.[COUNTRY], 
			PM.[PostalCode], 
			PM.[DoctorsName], 
			PM.[StatusName],
			PM.[Email],
			PM.[PrimaryContactNumber],
			PM.[AlternateContactNumber],
			PM.[PrimaryLanguage],
			PM.[SecondaryLanguage],
			PM.[Ethnicity],
			PM.[MaritalStatus],
			PM.[EmergencyName1],
			PM.[EmergencyRelationship1],
			PM.[EmergencyPhoneNo1],
			PM.[EmergencyName2],
			PM.[EmergencyRelationship2],
			PM.[EmergencyPhoneNo2],
			IM.[Name],
			IM.[MemberID],
			IM.[GroupID],
			IM.[PlanName],
			PM.[Races],
			PM.[HomePhone],
			PM.[GuardianName],
			PM.[DriverLicenseId],
			PM.[DriverLicenseState],
			PM.[SSN],
			PM.[Comments],
			PM.[DoctorsName],
			PM.[CellPhone],
			PM.[CustomPatientID],
			PM.[DeviceId],
			PM.[LowBPLimit],
			PM.[HighBPLimit],
			PM.[LowGlucoseLimit],
			PM.[HighGlucoseLimit]
	FROM	PatientMaster PM LEFT JOIN InsuranceMaster IM 
	ON		IM.PatientID = PM.PatientID
	WHERE	PM.[PatientID] = @PatientID
END

