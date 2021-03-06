USE [dbClinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertCCMNoteData]    Script Date: 4/19/2021 6:08:33 AM ******/
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

	UPDATE	RPMReportMaster
	SET		[Status] = @PatientStatus
	WHERE	PatientID = @PatientID

END
	
