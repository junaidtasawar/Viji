USE [dbClinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetRPMReportData_Forlist]    Script Date: 4/17/2021 4:41:41 AM ******/
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
			[dbo].[SumTimeSpan](RPM.[PatientID]) AS 'RPMInteractionTime',
            CASE 
                  WHEN ((datepart(minute, [dbo].[SumTimeSpan](RPM.PatientID))) > 00 AND (datepart(minute, [dbo].[SumTimeSpan](RPM.PatientID)) <= 19))  THEN (SELECT convert(time(0),dateadd(second,datediff(second,[dbo].[SumTimeSpan](RPM.PatientID),'00:20:00'),0)))
				  WHEN ((datepart(minute, [dbo].[SumTimeSpan](RPM.PatientID))) > 20 AND (datepart(minute, [dbo].[SumTimeSpan](RPM.PatientID)) <= 39))  THEN (SELECT convert(time(0),dateadd(second,datediff(second,[dbo].[SumTimeSpan](RPM.PatientID),'00:40:00'),0)))
				  WHEN ((datepart(minute, [dbo].[SumTimeSpan](RPM.PatientID))) > 40 AND (datepart(minute, [dbo].[SumTimeSpan](RPM.PatientID)) <= 59))  THEN (SELECT convert(time(0),dateadd(second,datediff(second,[dbo].[SumTimeSpan](RPM.PatientID),'00:59:59'),0)))
	        END AS 'RemainingBlockTime',
			DATEDIFF(d, [ReadingDateTime], GETDATE()) AS 'MissedReadingDays',
			@TotalCount as TotalCount	
		FROM  [dbo].[RPMReportMaster] RPM) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
		order by TBL.[Status] ASC
END

