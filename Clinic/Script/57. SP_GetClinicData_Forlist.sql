USE [Clinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetClinicData_Forlist]    Script Date: 6/2/2021 10:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetClinicData_Forlist]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250) = null,
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
			
			SET @sqlCommand = N'SELECT COUNT(ClinicID) AS TotalCount
								FROM [dbo].[ClinicMaster] 
								Where [IsActive] = 1'
			IF @LoginUserID > 1 and @indexNumber = 0
			BEGIN
				SET @sqlCommand = @sqlCommand + N' AND [Name] IN (' + @CLINICNAME + ')'
			END
			ELSE IF @LoginUserID > 1 and @indexNumber > 0
			BEGIN 
				SET @sqlCommand = @sqlCommand + N' AND [Name] LIKE ''%' + @clinic1 + '%'' OR [Name] LIKE ''%' +RTRIM(@clinic2) + '%'''
			END
			print @sqlCommand
			EXECUTE sp_executesql @sqlCommand, N'@CLINICNAME nvarchar(1000)', @CLINICNAME = @CLINICNAME

			--select @counts as Counts

			SET @SQLQUERY = N'
			SELECT	ROW_NUMBER() OVER(ORDER BY ClinicID) AS NUMBER,
					ClinicID,
					Name,
					Address
			FROM	ClinicMaster A
			Where	[IsActive] = 1'  

			IF @LoginUserID > 1 and @indexNumber = 0
			BEGIN
				SET @SQLQUERY = @SQLQUERY + N' AND [Name] IN (' + @CLINICNAME + ')'
			End 
			ELSE IF @LoginUserID > 1 and @indexNumber > 0
			BEGIN
				SET @SQLQUERY = @SQLQUERY + N' AND [Name] LIKE ''%' + @clinic1 + '%'' OR [Name] LIKE ''%' +RTRIM(@clinic2) + '%'''
			END

			Print	@SQLQUERY
			EXEC (' SELECT * FROM ( '+ @SQLQUERY +' ) AS TBL
			WHERE NUMBER BETWEEN (('+ @CurrentPage +' - 1) * '+ @NumberOfRecords +' +1) AND ('+ @CurrentPage +' * '+ @NumberOfRecords +')
			ORDER BY TBL.Name' );
END

--exec SP_GetClinicData_Forlist @CurrentPage=1,@NumberOfRecords=10,@OrderBy=N' ',@LoginUserID=50
