USE [Clinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertCallLogs]    Script Date: 6/13/2021 10:12:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_InsertCallLogs]
(
@PatientID bigint,
@startTime  datetime,
@EndTime datetime,
@Duration datetime
)
AS
BEGIN
	INSERT INTO [dbo].[CallLogs]
	(
		PatientID
		,startTime
		,EndTime
		,Duration
	) 
	VALUES 
	(
		@PatientID
		,@startTime
		,@EndTime
		,@Duration
	)

	SELECT @@Identity
END


