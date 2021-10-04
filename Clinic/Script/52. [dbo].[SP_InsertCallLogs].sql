USE [dbClinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertPatientMetric]    Script Date: 5/26/2021 12:21:48 AM ******/
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


insert into [dbo].[CallLogs](PatientID,startTime,EndTime,Duration) values (@PatientID,@startTime,@EndTime,@Duration)
