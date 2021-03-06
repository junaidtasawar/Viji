USE [Clinic]
GO

/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteDataForList]    Script Date: 7/3/2021 12:36:51 PM ******/
DROP PROCEDURE [dbo].[SP_GetCCMNoteDataForList]
GO

/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteDataForList]    Script Date: 7/3/2021 12:36:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_GetCCMNoteByPatientIdForList]
@CurrentPage int,
@NumberOfRecords int,
@PatientID bigint,
@TotalCount int = 0 OUT 
AS
BEGIN
		SELECT @TotalCount = COUNT(CCMNoteID) FROM [dbo].[CCMNoteMaster] WHERE PatientID = @PatientID
		
		SELECT * 
		FROM (
			SELECT ROW_NUMBER() OVER(ORDER BY CCMNoteID) AS NUMBER,[CCMNoteMaster].[PatientID],
			CCMNoteID,[Description],[CCMTime],[TimeSpent],[IsBillable],
			PM.[FirstName] + ' ' + PM.[LastName] 'PatientName',
			RIGHT('00' + CAST(DATEPART(DAY, [CCMDate]) AS VARCHAR(2)), 2) + ' ' +
			DATENAME(MONTH, [CCMDate]) + ' ' +
			CAST(DATEPART(YEAR, [CCMDate])  AS VARCHAR(4)) 'CCMDate',
			@TotalCount as TotalCount	
			FROM [dbo].[CCMNoteMaster] INNER JOIN [dbo].[PatientMaster] PM
			ON PM.PatientID = CCMNoteMaster.PatientID
			Where CCMNoteMaster.PatientID = @PatientID
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
END
GO


