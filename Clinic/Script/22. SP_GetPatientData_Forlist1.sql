USE [dbClinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPatientData_Forlist1]    Script Date: 4/19/2021 4:46:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetPatientData_Forlist1]
@ClinicName NVARCHAR(50),
@FirstName NVARCHAR(50) = null,
@LastName NVARCHAR(50)= null,
@CurrentPage VARCHAR(10),
@NumberOfRecords VARCHAR(10),
@OrderBy nvarchar(250),
@LoginUserID int = 0,
@TotalCount int = 0 OUT
AS
BEGIN
		DECLARE @SQLQUERY NVARCHAR(MAX)
			
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
		sum(e.[CCMMINUTES]) as TotalMinute,
		(SELECT COUNT([PatientID]) FROM [dbo].[PatientMaster] where ClinicName = ''' + @ClinicName + ''') AS TotalCount
		FROM [PatientMaster] PM LEFT JOIN [CCMNoteMaster] as e on e.[PatientID]= PM.[PatientID] 
		Where PM.ClinicName = ''' + @ClinicName + ''''
		IF @FirstName IS NOT NULL AND @FirstName <> ''
		BEGIN
			SET @SQLQUERY = @SQLQUERY + N' AND PM.FirstName = ''' + @FirstName + ''''
		End 
		IF @LastName IS NOT NULL AND @LastName <> ''
		BEGIN
			SET @SQLQUERY = @SQLQUERY + N' AND PM.LastName = ''' + @LastName + ''''
		End 
		IF @LoginUserID > 1
		BEGIN
			DECLARE @LoginClinicName NVARCHAR(50)
			SET		@LoginClinicName = (SELECT CLINICNAME FROM [dbo].[UserMaster] WHERE UserID = @LoginUserID)
			SET @SQLQUERY = @SQLQUERY + N' AND PM.ClinicName = ''' + @LoginClinicName + ''''
		END
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
			PM.MRNNumber'
		
		--PRINT (' SELECT * FROM ( '+@SQLQUERY+' ) AS TBL
		--WHERE NUMBER BETWEEN (('+@CurrentPage+' - 1) * '+@NumberOfRecords+' +1) AND ('+@CurrentPage+' * '+@NumberOfRecords+')
		--ORDER BY TBL.Name' );

		EXEC (' SELECT * FROM ( '+@SQLQUERY+' ) AS TBL
		WHERE NUMBER BETWEEN (('+@CurrentPage+' - 1) * '+@NumberOfRecords+' +1) AND ('+@CurrentPage+' * '+@NumberOfRecords+')
		ORDER BY TBL.Name' );
	END
