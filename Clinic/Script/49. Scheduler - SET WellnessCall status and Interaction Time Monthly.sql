DECLARE @CursorPatientID INT;
DECLARE @RunningTotal BIGINT = 0;
 
DECLARE CUR_TEST CURSOR FAST_FORWARD FOR
    SELECT [PatientID]
    FROM   [dbo].[RPMReportMaster]
    ORDER BY [RPMReportID];
 
OPEN CUR_TEST
FETCH NEXT FROM CUR_TEST INTO @CursorPatientID
 
WHILE @@FETCH_STATUS = 0
BEGIN
	Declare @RPMInteractionTime varchar(20)
	Declare @RemainingBlockTime varchar(20)
	SET @RPMInteractionTime = [dbo].[SumTimeSpan](@CursorPatientID)
	SET @RemainingBlockTime = (SELECT 
			CASE 
				  WHEN ((datepart(minute, [dbo].[SumTimeSpan](@CursorPatientID))) > 00 AND (datepart(minute, [dbo].[SumTimeSpan](@CursorPatientID)) <= 19))  THEN (SELECT convert(time(0),dateadd(second,datediff(second,[dbo].[SumTimeSpan](@CursorPatientID),'00:20:00'),0)))
				  WHEN ((datepart(minute, [dbo].[SumTimeSpan](@CursorPatientID))) > 20 AND (datepart(minute, [dbo].[SumTimeSpan](@CursorPatientID)) <= 39))  THEN (SELECT convert(time(0),dateadd(second,datediff(second,[dbo].[SumTimeSpan](@CursorPatientID),'00:40:00'),0)))
				  WHEN ((datepart(minute, [dbo].[SumTimeSpan](@CursorPatientID))) > 40 AND (datepart(minute, [dbo].[SumTimeSpan](@CursorPatientID)) <= 59))  THEN (SELECT convert(time(0),dateadd(second,datediff(second,[dbo].[SumTimeSpan](@CursorPatientID),'00:59:59'),0)))
			END)

		UPDATE	RPMReportMaster
		SET		[RPMInteractionTime] = @RPMInteractionTime,
				[RemainingBlockTime] = @RemainingBlockTime,
				[WellnessCall] = 'Pending'
		WHERE	PatientID = @CursorPatientID 

   SET @RunningTotal += @CursorPatientID

   FETCH NEXT FROM CUR_TEST INTO @CursorPatientID
END
CLOSE CUR_TEST
DEALLOCATE CUR_TEST
GO