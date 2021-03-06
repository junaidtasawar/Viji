USE [dolfhin]
GO
/****** Object:  StoredProcedure [dbo].[SP_AddVitalData]    Script Date: 8/10/2021 11:57:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_AddVitalData]
@VitalID bigint, 
@PatientID bigint, 
@BloodPressure nvarchar(10) = null, 
@Height  nvarchar(10) = null, 
@Pain  nvarchar(10) = null, 
@Respiration  nvarchar(10) = null, 
@Temperature  nvarchar(10) = null, 
@Weight  nvarchar(10) = null,  
@Pulse  nvarchar(10) = null,
@BloodSuger  nvarchar(10) = null
AS
BEGIN
	IF(@VitalID = 0)
	BEGIN
		INSERT INTO VitalMaster 
		(	
			PatientID, 
			BloodPressure, 
			Height, 
			Pain, 
			Respiration, 
			Temperature, 
			[Weight], 
			Pulse, 
			BloodSuger
		)
		VALUES 
		(
			@PatientID, 
			@BloodPressure, 
			@Height, 
			@Pain, 
			@Respiration, 
			@Temperature, 
			@Weight,  
			@Pulse, 
			@BloodSuger
		)
	END
	ELSE
	BEGIN
		UPDATE  VitalMaster
		   SET  PatientID  = @PatientID,
				BloodPressure = @BloodPressure,
				Height = @Height,
				Pain = @Pain,
				Respiration = @Respiration,
				Temperature = @Temperature,
				[Weight] = @Weight,
				Pulse = @Pulse,
				BloodSuger = @BloodSuger
		WHERE   VitalID = @VitalID
	END
END