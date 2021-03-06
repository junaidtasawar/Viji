USE [dbClinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetClinicData]    Script Date: 4/26/2021 10:49:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--exec SP_GetClinicData @LoginUserID=1
ALTER PROCEDURE [dbo].[SP_GetClinicData] 
@LoginUserID bigint
AS
BEGIN
	IF @LoginUserId = 1
	BEGIN
		SELECT [Name] FROM [dbo].[ClinicMaster] where IsActive = 1
	END
	ELSE
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

		SET @SQLQUERY = N'
						SELECT [Name] 
						FROM   [dbo].[ClinicMaster] 
						where  IsActive = 1'
		IF @indexNumber = 0
		BEGIN
			SET @SQLQUERY = @SQLQUERY + N' AND [Name] IN (' + @CLINICNAME + ')'
		End 
		ELSE 
		BEGIN
			SET @SQLQUERY = @SQLQUERY + N' AND [Name] LIKE ''%' + @clinic1 + '%'' OR [Name] LIKE ''%' +RTRIM(@clinic2) + '%'''
		END
		PRINT @SQLQUERY
		EXECUTE sp_executesql @SQLQUERY
	END
END

