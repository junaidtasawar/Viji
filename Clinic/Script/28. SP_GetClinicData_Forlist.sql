USE [dbClinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetClinicData_Forlist]    Script Date: 4/20/2021 9:25:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetClinicData_Forlist]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@LoginUserID bigint,
@TotalCount int = 0 OUT 
AS
BEGIN
		IF @LoginUserID > 1
		BEGIN
			DECLARE @CLINICNAME NVARCHAR(50)
			SET		@CLINICNAME = (SELECT CLINICNAME FROM [dbo].[UserMaster] WHERE UserID = @LoginUserID)

			SELECT @TotalCount = COUNT(ClinicID)
			FROM ClinicMaster A WHERE [IsActive] = 1 and Name = @CLINICNAME

			SELECT * 
			FROM (
			SELECT ROW_NUMBER() OVER(ORDER BY ClinicID) AS NUMBER,
			ClinicID,
			Name,Address,
			@TotalCount as TotalCount	
			FROM ClinicMaster A
			WHERE [IsActive] = 1
			and Name = @CLINICNAME
			) AS TBL
			WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
		END
		ELSE
		BEGIN
			SELECT @TotalCount = COUNT(ClinicID)
			FROM ClinicMaster A WHERE [IsActive] = 1

			SELECT * 
			FROM (
			SELECT ROW_NUMBER() OVER(ORDER BY ClinicID) AS NUMBER,
			ClinicID,
			Name,Address,
			@TotalCount as TotalCount	
			FROM ClinicMaster A
			WHERE [IsActive] = 1
			) AS TBL
			WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
		END
END

