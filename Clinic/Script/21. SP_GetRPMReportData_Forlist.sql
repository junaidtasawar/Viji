USE [dbClinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetRPMReportData_Forlist]    Script Date: 4/19/2021 5:02:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SP_GetRPMReportData_Forlist @Status=default,@CurrentPage=1,@NumberOfRecords=10,@OrderBy=N' ',@LoginUserID=3
ALTER PROCEDURE [dbo].[SP_GetRPMReportData_Forlist]
@Status nvarchar(50) = null,
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@LoginUserID bigint,
@TotalCount int = 0 OUT 
AS
BEGIN
	IF @LoginUserID = 1
	BEGIN
		SELECT @TotalCount = COUNT(RPMReportID)
		FROM [dbo].[RPMReportMaster]  

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
	ELSE
	BEGIN
		DECLARE @CLINICNAME NVARCHAR(50)
		SET		@CLINICNAME = (SELECT CLINICNAME FROM [dbo].[UserMaster] WHERE UserID = @LoginUserID)
		SELECT	@TotalCount = COUNT(RPMReportID)
		FROM	[dbo].[RPMReportMaster]  
		JOIN	[dbo].[PatientMaster] ON [PatientMaster].PatientID = [RPMReportMaster].PatientID
		WHERE	[PatientMaster].ClinicName = @CLINICNAME

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
		FROM	[dbo].[RPMReportMaster] RPM
		JOIN	[dbo].[PatientMaster] PM ON PM.PatientID = RPM.PatientID
		WHERE	PM.ClinicName IN (@CLINICNAME)
		) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
		order by TBL.[Status] ASC
	END
END

