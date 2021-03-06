USE [dbClinic]
GO
/****** Object:  UserDefinedFunction [dbo].[SumMinute]    Script Date: 3/19/2021 9:47:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[SumMinute] (@PatientID int)
RETURNS int
AS
BEGIN
DECLARE @Timespan int 
SELECT @Timespan = SUM([Minutes]) From [dbo].[TempTable] 
group by [PatientID]
RETURN @Timespan
END
