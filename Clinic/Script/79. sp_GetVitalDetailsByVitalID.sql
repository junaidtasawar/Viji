USE [dolfhin]
GO
/****** Object:  StoredProcedure [dbo].[GetVitalDetailsByVitalID_SP]    Script Date: 8/11/2021 12:00:22 AM ******/
--DROP PROCEDURE IF EXISTS [dbo].[GetVitalDetailsByVitalID_SP] 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetVitalDetailsByVitalID] 
	@VitalID bigint
AS
BEGIN
	
	SELECT	VitalID, 
			PatientID, 
			BloodPressure, 
			Height,
			Pain, 
			Respiration, 
			Temperature, 
			[Weight], 
			[ChectCircumference/Girth], 
			PulseOximetry, 
			Pulse, 
			BloodSuger, 
			AbnormalCircumference
	FROM	[dbo].[VitalMaster]
	WHERE	VitalID = @VitalID
END