USE [dbClinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUserData_Forlist]    Script Date: 4/26/2021 12:36:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SP_GetUserData_Forlist @CurrentPage=1,@NumberOfRecords=10,@OrderBy=N' ',@LoginUserID=4
ALTER PROCEDURE [dbo].[SP_GetUserData_Forlist]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@LoginUserID bigint
AS
BEGIN
			DECLARE @SQLQUERY NVARCHAR(MAX)
			DECLARE @sqlCommand NVARCHAR(MAX)
			DECLARE @indexNumber INT
			DECLARE @CLINICNAME NVARCHAR(1000)
			DECLARE @clinic1 NVARCHAR(250)
			DECLARE @clinic2 NVARCHAR(250)
			SET		@CLINICNAME = (SELECT REPLACE(CLINICNAME, ', ', ',') FROM [dbo].[UserMaster] WHERE UserID = @LoginUserID AND [IsActive] = 1)
			SET     @indexNumber =(SELECT CHARINDEX(',', @CLINICNAME))
			Print @indexNumber 
			Print @CLINICNAME 
			IF @indexNumber > 0 
			BEGIN	
				SET @clinic1 = CAST(LEFT(@CLINICNAME,CHARINDEX(',',@CLINICNAME)-1) AS nvarchar(250))
				SET @clinic2 = CAST(RIGHT(@CLINICNAME,LEN(@CLINICNAME) - CHARINDEX(',',@CLINICNAME)+2) AS nvarchar(250))
			END
			ELSE
			BEGIN
				SET	@CLINICNAME = ''''+replace(@CLINICNAME,',',''',''')+''''
			END
			
			SET @sqlCommand = N'SELECT COUNT(UserID) AS TotalCount
								FROM [dbo].[UserMaster] 
								Where [IsActive] = 1'
			IF @LoginUserID > 1 and @indexNumber = 0
			BEGIN
				SET @sqlCommand = @sqlCommand + N' AND [ClinicName] IN (' + @CLINICNAME + ')'
			END
			ELSE IF @LoginUserID > 1 and @indexNumber > 0
			BEGIN 
				SET @sqlCommand = @sqlCommand + N' AND [ClinicName] LIKE ''%' + @clinic1 + '%'' OR [ClinicName] LIKE ''%' +RTRIM(@clinic2) + '%'''
			END
			print @sqlCommand
			EXECUTE sp_executesql @sqlCommand, N'@CLINICNAME nvarchar(1000)', @CLINICNAME = @CLINICNAME

			SET @SQLQUERY = N'
								SELECT ROW_NUMBER() OVER(ORDER BY [UserID]) AS NUMBER,
								[UserID],
								[FirstName] + '' '' + [LastName] ''Name'', 
								CASE 
									WHEN [Gender] = 1 THEN ''MALE''
									WHEN [Gender] = 2 THEN ''FEMALE''
									ELSE NULL
								END ''Gender'', 
								[EmailID],
								[MobileNumber],
								[Address],
								[ClinicName]
								FROM UserMaster
								WHERE [IsActive] = 1'

			IF @LoginUserID > 1 and @indexNumber = 0
			BEGIN
				SET @SQLQUERY = @SQLQUERY + N' AND [ClinicName] IN (' + @CLINICNAME + ')'
			End 
			ELSE IF @LoginUserID > 1 and @indexNumber > 0
			BEGIN
				SET @SQLQUERY = @SQLQUERY + N' AND [ClinicName] LIKE ''%' + @clinic1 + '%'' OR [ClinicName] LIKE ''%' +RTRIM(@clinic2) + '%'''
			END

			Print	@SQLQUERY
			EXEC (' SELECT * FROM ( '+ @SQLQUERY +' ) AS TBL
			WHERE NUMBER BETWEEN (('+ @CurrentPage +' - 1) * '+ @NumberOfRecords +' +1) AND ('+ @CurrentPage +' * '+ @NumberOfRecords +')
			ORDER BY TBL.Name' );
END
