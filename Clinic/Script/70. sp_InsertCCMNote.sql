USE [Clinic]
GO

/****** Object:  StoredProcedure [dbo].[SP_InsertCCMNoteData]    Script Date: 7/3/2021 12:59:00 PM ******/
DROP PROCEDURE [dbo].[SP_InsertCCMNoteData]
GO

/****** Object:  StoredProcedure [dbo].[SP_InsertCCMNoteData]    Script Date: 7/3/2021 12:59:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[sp_InsertCCMNote]
	@CCMNoteID bigint,
	@PatientID bigint,
	@Description nvarchar(max)  = null,
	@CCMDate datetime = null,
	@CCMTime varchar(20) = null,
	@TimeSpent varchar(20) = null,
	@PatientStatus varchar(100) = null,
	@IsBillable bit = false,
	@CreatedBy bigint,
	@WellnessStatus nvarchar(20) = null,
	@CallLogId bigint
	AS
BEGIN
	DECLARE @CallHour int
	DECLARE @CallMinute int
	DECLARE @RPMPatientStatus varchar(20)

	IF (@WellnessStatus IS NOT NULL)
	BEGIN
		SET @TimeSpent = '00:20:00';
	END
	IF @CallLogId > 0 
	BEGIN
		SET @CallHour	= (SELECT DATEPART(hh,(select duration from CallLogs where [CallLogId] = @CallLogId)))
		SET @CallMinute	= (SELECT DATEPART(MI,(select duration from CallLogs where [CallLogId] = @CallLogId)))
		SET @RPMPatientStatus = (SELECT [Status] FROM RPMReportMaster WHERE PatientID = @PatientID)
	END

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
			[Description], 
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

			IF @CallLogId > 0 
			BEGIN
				IF (@CallMinute > 2 AND @RPMPatientStatus = 'Critical')
				BEGIN
					UPDATE	RPMReportMaster
					SET		[Status] = 'Normal'
					WHERE	PatientID = @PatientID

					SET		@PatientStatus = 'Normal'
				END 
			END

			SELECT SCOPE_IDENTITY()
	END
	ELSE
	BEGIN
		UPDATE	[dbo].[CCMNoteMaster] 
		   SET	PatientID = @PatientID, 
				[Description] = @Description,
				CCMDate = @CCMDate,
				CCMTime = @CCMTime,
				TimeSpent = @TimeSpent,
				IsBillable =@IsBillable, 
				[UpdatedBy] = @CreatedBy,
				PatientStatus = @PatientStatus
		WHERE	CCMNoteID = @CCMNoteID
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

			IF (@WellnessStatus IS NOT NULL AND @CallMinute > 2)
			BEGIN
				UPDATE	RPMReportMaster
				SET		[RPMInteractionTime] = @RPMInteractionTime,
						[RemainingBlockTime] = @RemainingBlockTime,
						[Status] = @PatientStatus,
						[WellnessCall] = 'Complete'
				WHERE	PatientID = @PatientID 
			END
			ELSE
			BEGIN
				UPDATE	RPMReportMaster
				SET		[RPMInteractionTime] = @RPMInteractionTime,
						[RemainingBlockTime] = @RemainingBlockTime,
						[Status] = @PatientStatus
				WHERE	PatientID = @PatientID 
			END
END
GO


