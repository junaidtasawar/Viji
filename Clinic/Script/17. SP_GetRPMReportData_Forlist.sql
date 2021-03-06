USE [Clinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetRPMReportData_Forlist]    Script Date: 4/16/2021 8:59:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetRPMReportData_Forlist]
@Status nvarchar(50) = null,
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@TotalCount int = 0 OUT 
AS
BEGIN
		SELECT @TotalCount = COUNT(RPMReportID)
		FROM [dbo].[RPMReportMaster] A 

		SELECT * 
		FROM ( 
		SELECT ROW_NUMBER() OVER(ORDER BY RPMReportID) AS NUMBER,
			[RPMReportID], 
			[DeviceID], 
			[PatientID], 
			[PatientName], 
			[BP], 
			[Glucose], 
			[MobileNumber], 
			[Status], 
			[Notes], 
			[CreatedDate],
			@TotalCount as TotalCount	
		FROM  [dbo].[RPMReportMaster]		
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
		order by TBL.[Status] ASC
END

