USE [Clinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUserData_Forlist]    Script Date: 4/16/2021 9:08:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetUserData_Forlist]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@TotalCount int = 0 OUT 

AS
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
		[ClinicName]
		
		FROM UserMaster A