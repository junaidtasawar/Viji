USE [dbClinic]
GO
/****** Object:  UserDefinedFunction [dbo].[SumTimeSpan]    Script Date: 3/19/2021 9:49:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[SumTimeSpan] (@PatientID int)
RETURNS varchar(max)
AS
BEGIN
DECLARE @Timespan VARCHAR(20) 
--SELECT @Timespan = CAST(t.time_sum/3600 AS VARCHAR(2)) + ':'
--     + CAST(t.time_sum%3600/60 AS VARCHAR(2)) + ':'
--     + CAST(((t.time_sum%3600)%60) AS VARCHAR(2))
--FROM ( SELECT [PatientID], SUM(DATEDIFF(S, '00:00:00', [TimeSpent])) AS time_sum
--       FROM [CCMNoteMaster] Where PatientID = @PatientID GROUP BY [PatientID] ) t ;

select @Timespan = convert(varchar, dateadd(second, sum(datediff(second, '00:00:00', Timespent)), '00:00:00'),108)
from    [dbo].[CCMNoteMaster]
WHERE   [PatientID] = 1
RETURN @Timespan
END