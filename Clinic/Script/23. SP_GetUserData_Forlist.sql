USE [dbClinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUserData_Forlist]    Script Date: 4/19/2021 5:05:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetUserData_Forlist]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@LoginUserID nvarchar(50),
@TotalCount int = 0 OUT 
AS
BEGIN
	IF @LoginUserID > 1
	BEGIN
		SELECT @TotalCount = COUNT(UserID)
		FROM UserMaster A 
		
		SELECT * 
		FROM (
			SELECT ROW_NUMBER() OVER(ORDER BY [UserID]) AS NUMBER,
			[UserID],
			[FirstName] + ' ' + [LastName] 'Name', 
			CASE 
				WHEN [Gender] = 1 THEN 'MALE'
				WHEN [Gender] = 2 THEN 'FEMALE'
				ELSE NULL
			END 'Gender', 
			[EmailID],
			[MobileNumber],
			[Address],
			[ClinicName],
			@TotalCount as TotalCount	
			FROM UserMaster A
			WHERE [IsActive] = 1
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
	END
	ELSE
	BEGIN
		DECLARE @CLINICNAME NVARCHAR(50)
		SET		@CLINICNAME = (SELECT CLINICNAME FROM [dbo].[UserMaster] WHERE UserID = @LoginUserID)

		SELECT	@TotalCount = COUNT(UserID)
		FROM	UserMaster A 
		WHERE	[ClinicName] IN (@CLINICNAME)
		
		SELECT * 
		FROM (
		SELECT ROW_NUMBER() OVER(ORDER BY [UserID]) AS NUMBER,
		[UserID],
		[FirstName] + ' ' + [LastName] 'Name', 
		CASE 
			WHEN [Gender] = 1 THEN 'MALE'
            WHEN [Gender] = 2 THEN 'FEMALE'
			ELSE NULL
        END 'Gender', 
		[EmailID],
		[MobileNumber],
		[Address],
		[ClinicName],
		@TotalCount as TotalCount	
		FROM	UserMaster A
		WHERE	[IsActive] = 1
		AND		[ClinicName] IN (@CLINICNAME)
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
	END
END
