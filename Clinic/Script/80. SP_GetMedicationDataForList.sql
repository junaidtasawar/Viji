USE [dolfhin]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetMedicationDataForList]    Script Date: 8/11/2021 12:20:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetMedicationDataForList]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@PatientID bigint,
@TotalCount int = 0 OUT 
AS
BEGIN
		SELECT @TotalCount = COUNT(MedicationID) FROM MedicationMaster 
		
		SELECT * 
		FROM (
		SELECT ROW_NUMBER() OVER(ORDER BY MedicationID) AS NUMBER,
		MedicationID, PatientID, Medication, RxNorms, Diagnosis, Quantity, RefillAllowed, [Source], OrderGeneratedBy, [Provider], [Status], Comments, [Frequency]
		,
		RIGHT('00' + CAST(DATEPART(DAY, StartDate) AS VARCHAR(2)), 2) + ' ' +
		DATENAME(MONTH, StartDate) + ' ' +
		CAST(DATEPART(YEAR, StartDate)  AS VARCHAR(4)) 'StartDate'
		,
		RIGHT('00' + CAST(DATEPART(DAY, EndDate) AS VARCHAR(2)), 2) + ' ' +
		DATENAME(MONTH, EndDate) + ' ' +
		CAST(DATEPART(YEAR, EndDate)  AS VARCHAR(4)) 'EndDate'
		,
		@TotalCount as TotalCount	
		FROM MedicationMaster A
		Where PatientID = @PatientID
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
END