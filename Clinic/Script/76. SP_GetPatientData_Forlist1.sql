USE [dbClinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPatientData_Forlist1]    Script Date: 7/23/2021 11:56:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SP_GetPatientData_Forlist1 @ClinicName=N'Clinic A',@FirstName=default,@LastName=default,@CurrentPage=1,@NumberOfRecords=10,@OrderBy=N' ',@LoginUserID=1
ALTER PROCEDURE [dbo].[SP_GetPatientData_Forlist1]
@ClinicName NVARCHAR(50),
@FirstName NVARCHAR(50) = null,
@LastName NVARCHAR(50)= null,
@CurrentPage VARCHAR(10),
@NumberOfRecords VARCHAR(10),
@OrderBy nvarchar(250),
@LoginUserID int = 0
AS
BEGIN
		DECLARE @SQLQUERY NVARCHAR(MAX)
		DECLARE @sqlCommand NVARCHAR(MAX)
		DECLARE @indexNumber INT
		DECLARE @CLINICNAME1 NVARCHAR(1000)
		DECLARE @clinic1 NVARCHAR(250)
		DECLARE @clinic2 NVARCHAR(250)
		SET		@CLINICNAME1 = (SELECT REPLACE(CLINICNAME, ', ', ',') FROM [dbo].[UserMaster] WHERE UserID = @LoginUserID AND [IsActive] = 1)
		SET     @indexNumber =(SELECT CHARINDEX(',', @CLINICNAME1))
		Print @indexNumber 
		Print @CLINICNAME1
		IF @indexNumber > 0 
		BEGIN	
			SET @clinic1 = CAST(LEFT(@CLINICNAME1,CHARINDEX(',',@CLINICNAME1)-1) AS nvarchar(250))
			SET @clinic2 = CAST(RIGHT(@CLINICNAME1,LEN(@CLINICNAME1) - CHARINDEX(',',@CLINICNAME1)+2) AS nvarchar(250))
		END
		ELSE
		BEGIN
			SET	@CLINICNAME1 = ''''+replace(@CLINICNAME1,',',''',''')+''''
		END
		SET @sqlCommand = N'SELECT COUNT(PM.PatientID) AS TotalCount
							FROM [dbo].[PatientMaster] PM LEFT JOIN [CCMNoteMaster] as e on e.[PatientID]= PM.[PatientID] 
							Where PM.[IsActive] = 1 AND PM.[ClinicName] IN (''' + @CLINICNAME + ''')
							GROUP BY PM.PatientID'
			--IF @LoginUserID > 1 and @indexNumber = 0
			--BEGIN
			--	SET @sqlCommand = @sqlCommand + N' AND PM.[ClinicName] IN (' + @CLINICNAME1 + ')'
			--END
			--ELSE IF @LoginUserID > 1 and @indexNumber > 0
			--BEGIN 
			--	SET @sqlCommand = @sqlCommand + N' AND PM.[ClinicName] LIKE ''%' + @clinic1 + '%'' OR PM.[ClinicName] LIKE ''%' +RTRIM(@clinic2) + '%'''
			--END
			--IF @LoginUserID = 1
			--BEGIN
			--	SET @sqlCommand = @sqlCommand + N' AND PM.ClinicName IN (''' + @ClinicName + ''')'
			--END
			--SET @sqlCommand = @sqlCommand + N' GROUP BY PM.PatientID'

			print @sqlCommand
			EXECUTE sp_executesql @sqlCommand, N'@CLINICNAME1 nvarchar(1000)', @CLINICNAME1 = @CLINICNAME1

		SET @SQLQUERY = N'
		SELECT 
		ROW_NUMBER() OVER(ORDER BY PM.PatientID) AS NUMBER,
		PM.PatientID, 
		PM.MobileNumber, 
		PM.MRNNumber,
		PM.FirstName + '' '' + PM.LastName AS Name,
		CAST(
             CASE 
                  WHEN PM.Gender = 1  THEN ''Male''
				  WHEN PM.Gender = 2  THEN ''Female''
             END AS nvarchar(10)) as Gender, 
		RIGHT(''00'' + CAST(DATEPART(DAY, PM.DOB) AS VARCHAR(2)), 2) + '' '' +
		DATENAME(MONTH, PM.DOB) + '' '' +
		CAST(DATEPART(YEAR, PM.DOB)  AS VARCHAR(4)) ''DOB'',
		PM.[BloodGroup],
		PM.Age, 
		PM.Address,
		PM.[DoctorsName],
		PM.StatusName,
		PM.ClinicName,
		PM.DeviceId,
		PM.DeviceName,
		PM.IsDeviceActive,
		sum(e.[CCMMINUTES]) as TotalMinute
		FROM [PatientMaster] PM LEFT JOIN [CCMNoteMaster] as e on e.[PatientID]= PM.[PatientID]
		Where PM.[IsActive] = 1'
		IF @FirstName IS NOT NULL AND @FirstName <> ''
		BEGIN
			SET @SQLQUERY = @SQLQUERY + N' AND PM.FirstName = ''' + @FirstName + ''''
		End 
		IF @LastName IS NOT NULL AND @LastName <> ''
		BEGIN
			SET @SQLQUERY = @SQLQUERY + N' AND PM.LastName = ''' + @LastName + ''''
		End 
		--IF @LoginUserID > 1 and @indexNumber = 0
		--BEGIN
		--	SET @SQLQUERY = @SQLQUERY + N' AND PM.[ClinicName] IN (' + @CLINICNAME1 + ')'
		--END
		--ELSE IF @LoginUserID > 1 and @indexNumber > 0
		--BEGIN 
		--	SET @SQLQUERY = @SQLQUERY + N' AND PM.[ClinicName] LIKE ''%' + @clinic1 + '%'' OR PM.[ClinicName] LIKE ''%' +RTRIM(@clinic2) + '%'''
		--END
		--IF @LoginUserID = 1
		--BEGIN
			SET @SQLQUERY = @SQLQUERY + N' AND PM.ClinicName IN (''' + @ClinicName + ''')'
		--END
		SET @SQLQUERY = @SQLQUERY + N'
		GROUP BY 
			PM.PatientID, 
			PM.MobileNumber, 
			PM.FirstName, 
			PM.LastName, 
			PM.Gender, 
			PM.DOB,PM.[BloodGroup],
			PM.Age, 
			PM.Address,
			PM.[DoctorsName],
			PM.StatusName,
			PM.ClinicName,
			PM.MRNNumber,
			PM.DeviceId,
			PM.DeviceName,
			PM.IsDeviceActive'
		
		PRINT (' SELECT * FROM ( '+@SQLQUERY+' ) AS TBL
		WHERE NUMBER BETWEEN (('+@CurrentPage+' - 1) * '+@NumberOfRecords+' +1) AND ('+@CurrentPage+' * '+@NumberOfRecords+')
		ORDER BY TBL.Name' );

		EXEC (' SELECT * FROM ( '+@SQLQUERY+' ) AS TBL
		WHERE NUMBER BETWEEN (('+@CurrentPage+' - 1) * '+@NumberOfRecords+' +1) AND ('+@CurrentPage+' * '+@NumberOfRecords+')
		ORDER BY TBL.Name' );
	END
