USE [dbClinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetClinicData_Forlist]    Script Date: 2/1/2021 10:32:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetClinicData_Forlist]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@TotalCount int = 0 OUT 
AS
BEGIN
		SELECT @TotalCount = COUNT(ClinicID)
		FROM ClinicMaster A WHERE [IsActive] = 1

		SELECT * 
		FROM (
		SELECT ROW_NUMBER() OVER(ORDER BY ClinicID) AS NUMBER,
		ClinicID,
		Name,Address,
		@TotalCount as TotalCount	
		FROM ClinicMaster A
		WHERE [IsActive] = 1
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
END

