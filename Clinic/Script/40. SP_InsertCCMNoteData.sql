USE [Clinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertCCMNoteData]    Script Date: 5/6/2021 1:48:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE  [dbo].[SP_InsertCCMNoteData]
	@CCMNoteID bigint,
	@PatientID bigint,
	@Description nvarchar(max)  = null,
	@CCMDate datetime = null,
	@CCMTime varchar(20) = null,
	@TimeSpent varchar(20) = null,
	@PatientStatus varchar(100) = null,
	@IsBillable bit = false,
	@CreatedBy bigint	
	AS
BEGIN
	
	DECLARE @CCMMINUTE INT
	DECLARE @MINUTE INT 
	SET @MINUTE = Cast(RIGHT(@TimeSpent,2) AS INT) 
	IF ( @MINUTE > 30 )
	
	BEGIN
		SET @CCMMINUTE =  Datediff(mi,convert(datetime,'00:00:00',108), convert(datetime,@TimeSpent,108)) + 1
	END
	ELSE 
	BEGIN
		SET @CCMMINUTE = Datediff(mi,convert(datetime,'00:00:00',108), convert(datetime,@TimeSpent,108))
	END

	IF(@CCMNoteID = 0)
	BEGIN
		INSERT INTO CCMNoteMaster
		(
			PatientID, 
			Description, 
			CCMDate, 
			CCMTime, 
			TimeSpent, 
			IsBillable, 
			CreatedOn, 
			CreatedBy,
			CCMMINUTES,
			PatientStatus
		) 
		VALUES
			(
				@PatientID,
				@Description,
				@CCMDate,
				@CCMTime,
				@TimeSpent,
				@IsBillable,
				GETDATE(),
				@CreatedBy,
				@CCMMINUTE,
				@PatientStatus
			)		

			SELECT SCOPE_IDENTITY()
	END
	ELSE
	BEGIN
		UPDATE [dbo].[CCMNoteMaster] 
		SET PatientID = @PatientID, 
			[Description] = @Description,
			CCMDate = @CCMDate,
			CCMTime = @CCMTime,
			TimeSpent = @TimeSpent,
			IsBillable =@IsBillable, 
			[UpdatedBy] = @CreatedBy,
			PatientStatus = @PatientStatus
		WHERE CCMNoteID = @CCMNoteID
	END

		Declare @RPMInteractionTime varchar(20)
		Declare @RemainingBlockTime varchar(20)
		SET @RPMInteractionTime = [dbo].[SumTimeSpan](@PatientID)
		SET @RemainingBlockTime = (SELECT 
			CASE 
				  WHEN ((datepart(minute, [dbo].[SumTimeSpan](@PatientID))) > 00 AND (datepart(minute, [dbo].[SumTimeSpan](@PatientID)) <= 19))  THEN (SELECT convert(time(0),dateadd(second,datediff(second,[dbo].[SumTimeSpan](@PatientID),'00:20:00'),0)))
				  WHEN ((datepart(minute, [dbo].[SumTimeSpan](@PatientID))) > 20 AND (datepart(minute, [dbo].[SumTimeSpan](@PatientID)) <= 39))  THEN (SELECT convert(time(0),dateadd(second,datediff(second,[dbo].[SumTimeSpan](@PatientID),'00:40:00'),0)))
				  WHEN ((datepart(minute, [dbo].[SumTimeSpan](@PatientID))) > 40 AND (datepart(minute, [dbo].[SumTimeSpan](@PatientID)) <= 59))  THEN (SELECT convert(time(0),dateadd(second,datediff(second,[dbo].[SumTimeSpan](@PatientID),'00:59:59'),0)))
			END)

		UPDATE	RPMReportMaster
		SET		[RPMInteractionTime] = @RPMInteractionTime,
				[RemainingBlockTime] = @RemainingBlockTime,
				[Status] = @PatientStatus
		WHERE	PatientID = @PatientID 

END
	
