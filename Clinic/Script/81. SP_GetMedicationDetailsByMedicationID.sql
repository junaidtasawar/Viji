USE [dolfhin]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetMedicationDetailsByMedicationID]    Script Date: 8/11/2021 12:23:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetMedicationDetailsByMedicationID]
@MedicationID bigint
AS
BEGIN
	SELECT	MedicationID, 
			PatientID, 
			Medication, 
			RxNorms, 
			Diagnosis, 
			Quantity, 
			RefillAllowed, 
			StartDate, 
			EndDate, 
			Source, 
			OrderGeneratedBy, 
			[Provider], 
			[Status], 
			Comments,
			Frequency
	FROM	MedicationMaster
	WHERE	MedicationID = @MedicationID
END