USE [master]
GO
/****** Object:  Database [dbClinic]    Script Date: 4/27/2021 4:18:00 PM ******/
CREATE DATABASE [dbClinic]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbClinic', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\dbClinic.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'dbClinic_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\dbClinic_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [dbClinic] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbClinic].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbClinic] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbClinic] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbClinic] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbClinic] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbClinic] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbClinic] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbClinic] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [dbClinic] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbClinic] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbClinic] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbClinic] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbClinic] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbClinic] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbClinic] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbClinic] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbClinic] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dbClinic] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbClinic] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbClinic] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbClinic] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbClinic] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbClinic] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbClinic] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbClinic] SET RECOVERY FULL 
GO
ALTER DATABASE [dbClinic] SET  MULTI_USER 
GO
ALTER DATABASE [dbClinic] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbClinic] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbClinic] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbClinic] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'dbClinic', N'ON'
GO
USE [dbClinic]
GO
/****** Object:  StoredProcedure [dbo].[GetAllergyDetailByAllergyID_SP]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAllergyDetailByAllergyID_SP]
@AllergyID bigint 
AS
BEGIN
	SELECT AllergyID, [Type], Agent, SNOMED, Reaction, Severity, [Source], [Status], PatientID
	FROM  [AllergyMaster]
	WHERE [AllergyID] = @AllergyID
END


GO
/****** Object:  StoredProcedure [dbo].[GetAllergyDetailsByAllergyID_SP]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAllergyDetailsByAllergyID_SP]
@AllergyID bigint 
AS
BEGIN
	SELECT AllergyID, [Type], Agent, SNOMED, Reaction, Severity, [Source], [Status], PatientID
	FROM  [AllergyMaster]
	WHERE [AllergyID] = @AllergyID
END


GO
/****** Object:  StoredProcedure [dbo].[GetAllergyDetailsByPatientID_SP]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAllergyDetailsByPatientID_SP]
@AllergyID bigint 
AS
BEGIN
	SELECT AllergyID, [Type], Agent, SNOMED, Reaction, Severity, [Source], [Status], PatientID
	FROM  [AllergyMaster]
	WHERE [AllergyID] = @AllergyID
END


GO
/****** Object:  StoredProcedure [dbo].[GetDiagnosisDetailsByDiagnosisID_SP]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDiagnosisDetailsByDiagnosisID_SP] 
@DiagnosisID bigint
AS
BEGIN
	SELECT DiagnosisID, PatientID, DiagnosisName, [SNOMEDCT], [DiagnosisStartDate],[DiagnosisEndDate],[Source],[Status],[Occurrence],[Comment]
	FROM [dbo].[DiagnosisMaster]
	WHERE DiagnosisID = @DiagnosisID
END


GO
/****** Object:  StoredProcedure [dbo].[GetVitalDetailsByVitalID_SP]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetVitalDetailsByVitalID_SP] 
	@VitalID bigint
AS
BEGIN
	
	SELECT VitalID, PatientID, BloodPressure, Height, Pain, Respiration, Temperature, Weight, [ChectCircumference/Girth], PulseOximetry, Pulse, BloodSuger, AbnormalCircumference
	FROM [dbo].[VitalMaster]
	WHERE VitalID = @VitalID
END


GO
/****** Object:  StoredProcedure [dbo].[InsertCCMNotesInfoData]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertCCMNotesInfoData]
 @CCMNoteText nvarchar(250), 
 @CCMNoteDescription nvarchar(max)
 AS
BEGIN
	Insert into CCMNotesInfoMaster (CCMNoteText,CCMNoteDescription)
	Values (@CCMNoteText,@CCMNoteDescription)
END


GO
/****** Object:  StoredProcedure [dbo].[SP_AddMedicationData]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_AddMedicationData]
	@MedicationID bigint,
	@PatientID bigint,
	@Medication nvarchar(200) = null,
	@RxNorms nvarchar(200) = null,
	@Diagnosis nvarchar (200)  = null,
	@Quantity int = 0,
	@RefillAllowed nvarchar(200) = null,
	@StartDate DateTime = null,
	@EndDate DateTime = null,
	@Comments nvarchar(max)  = null,
	@Source nvarchar(200)  = null,
	@OrderGeneratedBy nvarchar(200)  = null,
	@Provider nvarchar(200)  = null,
	@Status nvarchar(200) = null,
	@DosaseCount nvarchar(200) = null,
	@Measure nvarchar(200) = null,
	@Route nvarchar(200) = null,
	@Frequency nvarchar(200) = null,
	@Instruction nvarchar(200) = null
	AS
BEGIN
	IF(@MedicationID = 0)
	BEGIN
		INSERT INTO [dbo].[MedicationMaster]
		(
			PatientID, Medication, RxNorms, Diagnosis, Quantity, 
			RefillAllowed, StartDate, EndDate, [Source], OrderGeneratedBy, 
			Provider, [Status], Comments, DosaseCount, Measure, [Route],Frequency,Instruction
		) 
		VALUES
			(
				@PatientID,
				@Medication,
				@RxNorms,
				@Diagnosis,
				@Quantity,
				@RefillAllowed,
				@StartDate,
				@EndDate,
				@Source,
				@OrderGeneratedBy,
				@Provider,
				@Status,
				@Comments,
				@DosaseCount,
				@Measure,
				@Route,
				@Frequency,
				@Instruction
			)
			SELECT SCOPE_IDENTITY()
	END
	ELSE
	BEGIN
		UPDATE [dbo].[MedicationMaster]
		SET PatientID = @PatientID,
		Medication = @Medication, 
		RxNorms = @RxNorms,
		Diagnosis = @Diagnosis,
		Quantity=@Quantity,
		RefillAllowed = @RefillAllowed,
		StartDate=@StartDate,
		EndDate=@EndDate,
		[Source] = @Source,
		[Status] = @Status,
		OrderGeneratedBy = @OrderGeneratedBy,
		Provider = @Provider,
		Comments = @Comments,
		DosaseCount = @DosaseCount,
		Measure = @Measure,
		[Route] = @Route,
		Frequency =	@Frequency,
		Instruction =	@Instruction
		WHERE MedicationID = @MedicationID
	END
	END

GO
/****** Object:  StoredProcedure [dbo].[SP_AddPatientPreference]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[SP_AddPatientPreference]
@PatientId bigint,
@PrimaryCarePhysican nvarchar(200),
@PreferredContactMethod nvarchar(200),
@AlternateEmailAddress nvarchar(50),
@HIPAANoticePeriod bit,
@ImmunizationRegistryUser bit,
@ImmunicationSharing bit,
@HealthInformationExchange bit,
@ReferredByDoctor nvarchar(200),
@FromFriend nvarchar(200),
@FromInternet nvarchar(200),
@Other nvarchar(200)
AS
BEGIN
	INSERT INTO [dbo].[PatientPreference]
           ([PatientId]
           ,[PrimaryCarePhysican]
           ,[PreferredContactMethod]
           ,[AlternateEmailAddress]
           ,[HIPAANoticePeriod]
           ,[ImmunizationRegistryUser]
           ,[ImmunicationSharing]
           ,[HealthInformationExchange]
           ,[ReferredByDoctor]
           ,[FromFriend]
           ,[FromInternet]
           ,[Other])
     VALUES
           (
				@PatientId
				,@PrimaryCarePhysican
				,@PreferredContactMethod
				,@AlternateEmailAddress
				,@HIPAANoticePeriod
				,@ImmunizationRegistryUser
				,@ImmunicationSharing
				,@HealthInformationExchange
				,@ReferredByDoctor
				,@FromFriend
				,@FromInternet
				,@Other
		   )
END


GO
/****** Object:  StoredProcedure [dbo].[SP_AddPatientSurveyReport]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AddPatientSurveyReport]
@PatientID BIGINT, 
@FirstName NVARCHAR(50),
@LastName NVARCHAR(50),
@MRN NVARCHAR(50),
@InitialCallDate DATETIME = NULL,
@InitialCallAnswer NVARCHAR(50),
@SecondCallDate DATETIME = NULL,
@SecondCallAnswer NVARCHAR(50),
@ThirdCallDate DATETIME = NULL,
@ThirdCallAnswer NVARCHAR(50),
@HRAStatus  NVARCHAR(50),
@IsMemberEligible  NVARCHAR(50),
@HRACompletedDate DATETIME = NULL,
@LivioNurseVisit NVARCHAR(50),
@NurseVisitScheduleDate DATETIME = NULL,
@NurseVisitCompletionDate DATETIME = NULL
AS
BEGIN
	
	SET NOCOUNT ON;
	INSERT INTO [dbo].[SurveyReportMaster] 
	(
			[PatientID], 
			[FirstName], 
			[LastName], 
			[MRN], 
			[InitialCallDate], 
			[InitialCallAnswer], 
			[SecondCallDate], 
			[SecondCallAnswer], 
			[ThirdCallDate], 
			[ThirdCallAnswer], 
			[HRAStatus], 
			[IsMemberEligible], 
			[HRACompletedDate], 
			[LivioNurseVisit], 
			[NurseVisitScheduleDate], 
			[NurseVisitCompletionDate]
		)
	VALUES 
		(
			@PatientID,
			@FirstName,
			@LastName,
			@MRN,
			@InitialCallDate,
			@InitialCallAnswer,
			@SecondCallDate,
			@SecondCallAnswer,
			@ThirdCallDate,
			@ThirdCallAnswer,
			@HRAStatus,
			@IsMemberEligible,
			@HRACompletedDate,
			@LivioNurseVisit,
			@NurseVisitScheduleDate,
			@NurseVisitCompletionDate
		)
END


GO
/****** Object:  StoredProcedure [dbo].[SP_AddUser]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AddUser]
@FirstName nvarchar(50),
@LastName nvarchar(50),
@MiddleName nvarchar(50),
@Username nvarchar(50),
@EmailID nvarchar(50),
@password nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    Insert into UserMaster (FirstName,MiddleName,LastName,EmailID,Username,[password])
	values (@FirstName,@MiddleName,@LastName,@EmailID,@Username,@password)
END


GO
/****** Object:  StoredProcedure [dbo].[SP_AddVitalData]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AddVitalData]
@VitalID bigint, 
@PatientID bigint, 
@BloodPressure bigint = null, 
@Height int = null, 
@Pain int = null, 
@Respiration int = null, 
@Temperature decimal(18,2) = null, 
@Weight int = null,  
@Pulse int = null,
@BloodSuger int = null
AS
BEGIN
	IF(@VitalID = 0)
	BEGIN
		INSERT INTO VitalMaster (PatientID, BloodPressure, Height, Pain, Respiration, Temperature, Weight, Pulse,BloodSuger)
		VALUES (@PatientID, @BloodPressure, @Height, @Pain, @Respiration, @Temperature, @Weight,  @Pulse,@BloodSuger)
	END
	ELSE
	BEGIN
		UPDATE  VitalMaster
		SET PatientID  = @PatientID,
		BloodPressure = @BloodPressure,
		Height =@Height,
		Pain =@Pain,
		Respiration = @Respiration,
		Temperature = @Temperature,
		Weight = @Weight,
		Pulse = @Pulse,
		BloodSuger = @BloodSuger
		WHERE 
		VitalID = @VitalID
	END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_AuthorizeUser]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AuthorizeUser]
	 @Username nvarchar(50),
	 @Password nvarchar(50)
AS
BEGIN
	SELECT 
	UserID, 
	FirstName, 
	LastName, 
	EmailID, 
	Username,
	ClinicName
	from UserMaster WHERE Username = @Username AND password = @Password
END


GO
/****** Object:  StoredProcedure [dbo].[SP_ChangeUserPassword]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SP_ChangeUserPassword]
	 @UserID bigint,
	 @Password nvarchar(250),
	 @NewPassword nvarchar(250),
	 @Count int = 0 OUT
AS
BEGIN
	DECLARE @CurrentPassword nvarchar(250)

	SELECT @CurrentPassword = usr.[Password] from UserMaster usr where usr.UserID = @UserID

	IF(@CurrentPassword = @Password)
	BEGIN
		UPDATE UserMaster SET Password = @NewPassword
		WHERE UserID = @UserID
	END
	ELSE
	BEGIN
		SET @Count = -1
		SELECT @Count
	END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_CreateUser]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CreateUser]
@FirstName nvarchar(50), 
@MiddleName nvarchar(50), 
@LastName nvarchar(50), 
@EmailID nvarchar(50), 
@Username nvarchar(50), 
@password nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    Insert into UserMaster (FirstName, MiddleName, LastName, EmailID, Username, password)
	VALUES (@FirstName, @MiddleName, @LastName, @EmailID, @Username, @password)
END


GO
/****** Object:  StoredProcedure [dbo].[SP_ForgotUsernamePassword]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ForgotUsernamePassword]
@Username nvarchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT 
	UserID, 
	Username,
	password,
	EmailID
	from UserMaster WHERE EmailID = @Username 

END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllergyDataForList]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllergyDataForList]
@CurrentPage int,
@NumberOfRecords int,
@PatientID bigint,
@TotalCount int = 0 OUT 
AS
BEGIN
		SELECT @TotalCount = COUNT(AllergyID)
		FROM [dbo].[AllergyMaster] 
		WHERE [PatientID] = @PatientID
		
		SELECT * 
		FROM (
		SELECT ROW_NUMBER() OVER(ORDER BY AllergyID) AS NUMBER,
		AllergyID,
		[Type], 
		PatientID,
		Agent, 
		SNOMED, 
		Reaction, 
		Severity, 
		[Source], 
		[Status],
		@TotalCount as TotalCount	
		FROM [dbo].[AllergyMaster]  
		Where PatientID = @PatientID
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllPatientReportDetailForList]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllPatientReportDetailForList]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250) = null,
@FromDate DateTime = null,
@ToDate DateTime = null,
@CCMTimeSpan int = 0,
@IsBillable bit = null,
@TotalCount int = 0 OUT 
AS
BEGIN
	
	SELECT @TotalCount = COUNT(A.[PatientID])
		FROM PatientMaster A INNER JOIN  [CCMNoteMaster] CM
		ON			CM.PatientID = A.PatientID
		WHERE		([CCMDate] >=  CONVERT(date, @FromDate) OR @FromDate IS NULL)
					AND ([CCMDate] <=  CONVERT(date, @ToDate) OR @ToDate IS NULL) 
					AND [CCMDate] BETWEEN ISNULL(CONVERT(date, @FromDate), '1900-01-01') AND ISNULL(CONVERT(date, @ToDate), '9999-12-31') 
					AND IsBillable = @IsBillable
	
	BEGIN
	SELECT * 
		FROM (
			SELECT	ROW_NUMBER() OVER(ORDER BY PM.[PatientID]) AS NUMBER,
						PM.[PatientID], 
						PM.FirstName + ' ' + PM.LastName + ' ' + PM.MobileNumber 'PatientName',
						PM.MRNNumber,
						SUM(CM.[CCMMINUTES]) as TotalMinute,
						[dbo].[CCMNoteCommaSeprated] (PM.[PatientID]) 'CCMNote',
						@TotalCount as TotalCount
			FROM		PatientMaster PM INNER JOIN [CCMNoteMaster] CM
			ON			CM.PatientID = PM.PatientID
			WHERE		([CCMDate] >=  CONVERT(date, @FromDate) OR @FromDate IS NULL)
						AND ([CCMDate] <=  CONVERT(date, @ToDate) OR @ToDate IS NULL) 
						AND [CCMDate] BETWEEN ISNULL(CONVERT(date, @FromDate), '1900-01-01') AND ISNULL(CONVERT(date, @ToDate), '9999-12-31') 
						AND IsBillable = @IsBillable
			GROUP BY	PM.PatientID, 
						PM.MobileNumber, 
						PM.FirstName,  
						PM.LastName, 
						PM.MRNNumber
			) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
	
	END
END



GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllSurveyReportForList]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetAllSurveyReportForList]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@HRAStatus NVARCHAR(50),
@InitialCallAnswer NVARCHAR(50),
@TotalCount int = 0 OUT 
AS
BEGIN
	SELECT @TotalCount = COUNT([SurveyID])
		FROM [dbo].[SurveyReportMaster] 
		
		SELECT * 
		FROM (
		SELECT ROW_NUMBER() OVER(ORDER BY [SurveyID]) AS NUMBER,
		SurveyID as [ID], 
		PatientID, 
		FirstName, 
		LastName, 
		MRN as [MRNNumber], 
		InitialCallDate, 
		InitialCallAnswer,
		HRAStatus, 
		IsMemberEligible, 
		@TotalCount as TotalCount	
		FROM [dbo].[SurveyReportMaster] 
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllSurveyReportHRACallForList]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetAllSurveyReportHRACallForList]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@HRAStatus NVARCHAR(50),
@InitialCallAnswer NVARCHAR(50),
@TotalCount int = 0 OUT 
AS
BEGIN
	SELECT @TotalCount = COUNT([SurveyID])
		FROM [dbo].[SurveyReportMaster] 
		
		SELECT * 
		FROM (
		SELECT ROW_NUMBER() OVER(ORDER BY [SurveyID]) AS NUMBER,
		SurveyID as [ID], 
		PatientID, 
		FirstName, 
		LastName, 
		MRN as [MRNNumber], 
		InitialCallDate, 
		InitialCallAnswer,
		HRAStatus, 
		IsMemberEligible, 
		@TotalCount as TotalCount	
		FROM [dbo].[SurveyReportMaster] 
		Where  HRAStatus = @HRAStatus AND InitialCallAnswer = @InitialCallAnswer
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllSurveyReportHRAForList]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetAllSurveyReportHRAForList]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@HRAStatus NVARCHAR(50),
@InitialCallAnswer NVARCHAR(50),
@TotalCount int = 0 OUT 
AS
BEGIN
	SELECT @TotalCount = COUNT([SurveyID])
		FROM [dbo].[SurveyReportMaster] 
		
		SELECT * 
		FROM (
		SELECT ROW_NUMBER() OVER(ORDER BY [SurveyID]) AS NUMBER,
		SurveyID as [ID], 
		PatientID, 
		FirstName, 
		LastName, 
		MRN as [MRNNumber], 
		InitialCallDate, 
		InitialCallAnswer,
		HRAStatus, 
		IsMemberEligible, 
		@TotalCount as TotalCount	
		FROM [dbo].[SurveyReportMaster] 
		Where  HRAStatus = @HRAStatus
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllSurveyReportInitialCallForList]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetAllSurveyReportInitialCallForList]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@HRAStatus NVARCHAR(50),
@InitialCallAnswer NVARCHAR(50),
@TotalCount int = 0 OUT 
AS
BEGIN
	SELECT @TotalCount = COUNT([SurveyID])
		FROM [dbo].[SurveyReportMaster] 
		
		SELECT * 
		FROM (
		SELECT ROW_NUMBER() OVER(ORDER BY [SurveyID]) AS NUMBER,
		SurveyID as [ID], 
		PatientID, 
		FirstName, 
		LastName, 
		MRN as [MRNNumber], 
		InitialCallDate, 
		InitialCallAnswer,
		HRAStatus, 
		IsMemberEligible, 
		@TotalCount as TotalCount	
		FROM [dbo].[SurveyReportMaster] 
		Where  InitialCallAnswer = @InitialCallAnswer
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetBillingReportDetailForList]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetBillingReportDetailForList]
@CurrentPage int,
@NumberOfRecords int,
@FromDate DateTime = null,
@ToDate DateTime = null,
@BillingTimeSpan int = 0,
@IsBillable bit = null,
@TotalCount int = 0 OUT 
AS
BEGIN

SELECT @TotalCount = COUNT(A.[PatientID])
		FROM PatientMaster A INNER JOIN  [CCMNoteMaster] CM
		ON			CM.PatientID = A.PatientID
		WHERE		([CCMDate] >=  CONVERT(date, @FromDate) OR @FromDate IS NULL)
					AND ([CCMDate] <=  CONVERT(date, @ToDate) OR @ToDate IS NULL) 
					AND [CCMDate] BETWEEN ISNULL(CONVERT(date, @FromDate), '1900-01-01') AND ISNULL(CONVERT(date, @ToDate), '9999-12-31') 
					AND IsBillable = @IsBillable
	
	IF (@BillingTimeSpan = '19')
	BEGIN
	SELECT * 
		FROM (
		SELECT	ROW_NUMBER() OVER(ORDER BY PM.[PatientID]) AS NUMBER,
					PM.[PatientID], 
					PM.FirstName + ' ' + PM.LastName + ' ' + PM.MobileNumber 'PatientName',
					PM.MRNNumber,
					PM.ClinicName,
					SUM(CM.[CCMMINUTES]) as TotalMinute,
					[dbo].[CCMNoteCommaSeprated] (PM.[PatientID]) 'CCMNote',
					(STUFF((SELECT CAST(', ' + [DiagnosisName] AS VARCHAR(MAX)) 
					FROM DiagnosisMaster 
					WHERE (PatientID = PM.PatientID)
					FOR XML PATH ('')), 1, 2, '')) AS Diagnosis,
					@TotalCount as TotalCount
		FROM		PatientMaster PM INNER JOIN [CCMNoteMaster] CM
		ON			CM.PatientID = PM.PatientID
		WHERE		([CCMDate] >=  CONVERT(date, @FromDate) OR @FromDate IS NULL)
					AND ([CCMDate] <=  CONVERT(date, @ToDate) OR @ToDate IS NULL) 
					AND [CCMDate] BETWEEN ISNULL(CONVERT(date, @FromDate), '1900-01-01') AND ISNULL(CONVERT(date, @ToDate), '9999-12-31') 
					AND IsBillable = @IsBillable
		GROUP BY	PM.PatientID, 
					PM.MobileNumber, 
					PM.FirstName,  
					PM.LastName, 
					PM.MRNNumber,
					PM.ClinicName
		HAVING SUM(CM.[CCMMINUTES]) <= 20
			) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
	END
	ELSE
	BEGIN
		SELECT * 
		FROM (
		SELECT	ROW_NUMBER() OVER(ORDER BY PM.[PatientID]) AS NUMBER,
					PM.[PatientID], 
					PM.FirstName + ' ' + PM.LastName + ' ' + PM.MobileNumber 'PatientName',
					PM.MRNNumber,
					PM.ClinicName,
					SUM(CM.[CCMMINUTES]) as TotalMinute,
					[dbo].[CCMNoteCommaSeprated] (PM.[PatientID]) 'CCMNote',
					(STUFF((SELECT CAST(', ' + [DiagnosisName] AS VARCHAR(MAX)) 
					FROM DiagnosisMaster 
					WHERE (PatientID = PM.PatientID)
					FOR XML PATH ('')), 1, 2, '')) AS Diagnosis,
					@TotalCount as TotalCount
		FROM		PatientMaster PM INNER JOIN [CCMNoteMaster] CM
		ON			CM.PatientID = PM.PatientID
		WHERE		([CCMDate] >=  CONVERT(date, @FromDate) OR @FromDate IS NULL)
					AND ([CCMDate] <=  CONVERT(date, @ToDate) OR @ToDate IS NULL) 
					AND [CCMDate] BETWEEN ISNULL(CONVERT(date, @FromDate), '1900-01-01') AND ISNULL(CONVERT(date, @ToDate), '9999-12-31') 
					AND IsBillable = @IsBillable
		GROUP BY	PM.PatientID, 
					PM.MobileNumber, 
					PM.FirstName,  
					PM.LastName, 
					PM.MRNNumber,
					PM.ClinicName
		HAVING SUM(CM.[CCMMINUTES]) >= @BillingTimeSpan
		) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
		
	END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetCCMIndividualReportDetailForList]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCCMIndividualReportDetailForList]
@FromDate DateTime = null,
@ToDate DateTime = null,
@CCMTimeSpan nvarchar(250) = null,
@IsBillable bit = null
AS
BEGIN
IF (@CCMTimeSpan = '19')
	BEGIN
		SELECT	ROW_NUMBER() OVER(ORDER BY PM.[PatientID]) AS NUMBER,
						PM.[PatientID], 
						PM.FirstName + ' ' + PM.LastName + ' ' + PM.MobileNumber 'PatientName',
						PM.MRNNumber,
						SUM(CM.[CCMMINUTES]) as TotalMinute,
						[dbo].[CCMNoteCommaSeprated] (PM.[PatientID]) 'CCMNote',
						PM.ClinicName
			FROM		PatientMaster PM INNER JOIN [CCMNoteMaster] CM
			ON			CM.PatientID = PM.PatientID
			WHERE		([CCMDate] >=  CONVERT(date, @FromDate) OR @FromDate IS NULL)
						AND ([CCMDate] <=  CONVERT(date, @ToDate) OR @ToDate IS NULL) 
						AND [CCMDate] BETWEEN ISNULL(CONVERT(date, @FromDate), '1900-01-01') AND ISNULL(CONVERT(date, @ToDate), '9999-12-31') 
						AND IsBillable = @IsBillable
			GROUP BY	PM.PatientID, 
						PM.MobileNumber, 
						PM.FirstName,  
						PM.LastName, 
						PM.MRNNumber,
						PM.ClinicName
		HAVING SUM(CM.[CCMMINUTES]) <= 20
	END
	ELSE
	BEGIN
		SELECT	ROW_NUMBER() OVER(ORDER BY PM.[PatientID]) AS NUMBER,
						PM.[PatientID], 
						PM.FirstName + ' ' + PM.LastName + ' ' + PM.MobileNumber 'PatientName',
						PM.MRNNumber,
						SUM(CM.[CCMMINUTES]) as TotalMinute,
						[dbo].[CCMNoteCommaSeprated] (PM.[PatientID]) 'CCMNote',
						PM.ClinicName
			FROM		PatientMaster PM INNER JOIN [CCMNoteMaster] CM
			ON			CM.PatientID = PM.PatientID
			WHERE		([CCMDate] >=  CONVERT(date, @FromDate) OR @FromDate IS NULL)
						AND ([CCMDate] <=  CONVERT(date, @ToDate) OR @ToDate IS NULL) 
						AND [CCMDate] BETWEEN ISNULL(CONVERT(date, @FromDate), '1900-01-01') AND ISNULL(CONVERT(date, @ToDate), '9999-12-31') 
						AND IsBillable = @IsBillable
			GROUP BY	PM.PatientID, 
						PM.MobileNumber, 
						PM.FirstName,  
						PM.LastName, 
						PM.MRNNumber,
						PM.ClinicName
			HAVING SUM(CM.[CCMMINUTES]) > @CCMTimeSpan
	END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteByID]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_GetCCMNoteByID]
@CCMNoteID bigint,
@PatientID bigint
AS
BEGIN
	SELECT * FROM [dbo].[CCMNoteMaster] WHERE [PatientID] = @PatientID AND [CCMNoteID] = @CCMNoteID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteByPatientID]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCCMNoteByPatientID]
@PatientID bigint
AS
BEGIN
	SELECT * FROM [dbo].[CCMNoteMaster] WHERE [PatientID] = @PatientID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteData]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetCCMNoteData]
	
AS
BEGIN
	
	SELECT [CCMNoteInfoId],[CCMNoteText],[CCMNoteDescription]
	FROM [dbo].[CCMNotesInfoMaster]
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteDataForList]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GetCCMNoteDataForList]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@PatientID bigint,
@TotalCount int = 0 OUT 
AS
BEGIN
		SELECT @TotalCount = COUNT(CCMNoteID) FROM [dbo].[CCMNoteMaster] WHERE PatientID = @PatientID
		
		SELECT * 
		FROM (
		SELECT ROW_NUMBER() OVER(ORDER BY CCMNoteID) AS NUMBER,[CCMNoteMaster].[PatientID],
		CCMNoteID,[Description],[CCMTime],[TimeSpent],[IsBillable],
		PM.[FirstName] + ' ' + PM.[LastName] 'PatientName',
		RIGHT('00' + CAST(DATEPART(DAY, [CCMDate]) AS VARCHAR(2)), 2) + ' ' +
		DATENAME(MONTH, [CCMDate]) + ' ' +
		CAST(DATEPART(YEAR, [CCMDate])  AS VARCHAR(4)) 'CCMDate',
		@TotalCount as TotalCount	
		FROM [dbo].[CCMNoteMaster] INNER JOIN [dbo].[PatientMaster] PM
		ON PM.PatientID = CCMNoteMaster.PatientID
		Where CCMNoteMaster.PatientID = @PatientID
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteDescription]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetCCMNoteDescription]
@CCMNoteID bigint
AS
BEGIN
	SELECT CCMNoteDescription From CCMNotesInfoMaster 
	WHERE CCMNoteInfoId = @CCMNoteID 
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteMasterData]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCCMNoteMasterData]
@PatientID	bigint
AS
BEGIN
	SELECT CCMNoteID, [Description], CCMDate, CCMTime, TimeSpent, IsBillable, IsInitialVisti
	FROM CCMNoteMaster
	WHERE [PatientID] = @PatientID
END 


GO
/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteReportByPatientID]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCCMNoteReportByPatientID]
@PatientID bigint,
@FromDate datetime,
@ToDate datetime,
@IsBillable bit = null
AS
BEGIN
	SELECT 
		CAST(
             CASE 
                  WHEN (CAST(SUBSTRING(TimeSpent, 7, 2) AS INT)) > 30 
                     THEN (CAST(SUBSTRING(TimeSpent, 4, 2) AS INT)) + 1
                  ELSE (CAST(SUBSTRING(TimeSpent, 4, 2) AS INT))
             END AS INT) as IntMinutes,*,
		[dbo].[SumTimeSpan](PatientID) 'TotalMinute',
		UserMaster.FirstName + ' ' + UserMaster.LastName 'CreatedBy'
	FROM [dbo].[CCMNoteMaster] INNER JOIN UserMaster ON UserMaster.UserID = CCMNoteMaster.CreatedBy 
	WHERE [PatientID] = @PatientID
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetCityData]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCityData]
	 @StateID bigint
AS
BEGIN
	SELECT 
	*
	from MST_City
	WHERE @StateID IS NULL OR RegionID = @StateID
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetCityDataAutocomplete]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GetCityDataAutocomplete]
@SearchString nvarchar(500) = null
AS
BEGIN
	IF(@SearchString = '' OR @SearchString = null)
	BEGIN
		SELECT 
		top 10 *
		from MST_City
	END
	ELSE
	BEGIN
		SELECT top 10 * from MST_City where CityName like @SearchString+'%'
	END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetClinicData]    Script Date: 4/27/2021 4:18:01 PM ******/
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
CREATE PROCEDURE [dbo].[SP_GetClinicData] 
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


GO
/****** Object:  StoredProcedure [dbo].[SP_GetClinicData_Forlist]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetClinicData_Forlist]
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

GO
/****** Object:  StoredProcedure [dbo].[SP_GetClinicDataAutocomplete]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetClinicDataAutocomplete]
@SearchString nvarchar(500) = null,
@LoginUserID NVARCHAR(200) 
AS
BEGIN
	
	IF @LoginUserID = 1
	BEGIN
		IF(@SearchString = '' OR @SearchString = null)
		BEGIN
			SELECT 
			top 10 *
			from ClinicMaster 
		END
		ELSE
		BEGIN
			SELECT top 10 * from ClinicMaster where Name like @SearchString+'%'
		END
	END
	ELSE
	BEGIN
		SELECT TOP 10 * FROM dbo.BreakStringIntoRows((SELECT ClinicName From UserMaster Where [UserID] = @LoginUserID AND ClinicName like @SearchString+'%'))
	END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetClinicDetailsByClinicID]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GetClinicDetailsByClinicID]
@ClinicID bigint 
AS
BEGIN

	SET NOCOUNT ON;

    
	SELECT ClinicID, Name, Address 
	FROM [dbo].[ClinicMaster]
	Where ClinicID = @ClinicID
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetCountryDataAutocomplete]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCountryDataAutocomplete]
@SearchString nvarchar(500) = null
AS
BEGIN
	IF(@SearchString = '' OR @SearchString = null)
	BEGIN
		SELECT 
		top 10 *
		from MST_Countries
	END
	ELSE
	BEGIN
		SELECT top 10 * from MST_Countries where Country like @SearchString+'%'
	END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetDashboardData]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetDashboardData]
@CreatedBy bigint = 0
AS
BEGIN
	IF(@CreatedBy = 0)
	BEGIN
		SET @CreatedBy = NULL
	END

	Declare @TotalClinic int = 0, @TotalPatient int = 0, @TotalUser int = 0

	create table #DashboardTemp
	(
		TotalClinic int, 
		TotalUser int,
		TotalPatient int
	)

	IF @CreatedBy = 1
	BEGIN

		Select @TotalClinic = COUNT(ClinicID) from ClinicMaster 

		Select @TotalUser = COUNT(UserID) from UserMaster 

		Select @TotalPatient = COUNT(PatientID) from PatientMaster
	END
	ELSE
	BEGIN
		
		SELECT @TotalClinic = SUM(len(ClinicName) - len(replace(ClinicName, ',', ''))) FROM [dbo].[UserMaster] where [UserID] = @CreatedBy

		Select @TotalUser = COUNT(UserID) from UserMaster 

		Select @TotalPatient = COUNT(PatientID) from PatientMaster WHERE ClinicName in (SELECT * FROM dbo.BreakStringIntoRows((SELECT ClinicName From UserMaster Where [UserID] = @CreatedBy)))
	END


	INSERT INTO #DashboardTemp(TotalClinic,TotalUser,TotalPatient)
	VALUES (@TotalClinic,@TotalUser,@TotalPatient)

	SELECT * from #DashboardTemp

	DROP TABLE #DashboardTemp
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetDiagnosisDataForList]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetDiagnosisDataForList]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@PatientID bigint,
@TotalCount int = 0 OUT 
AS
BEGIN
		SELECT @TotalCount = COUNT(DiagnosisID) FROM DiagnosisMaster 
		
		SELECT * 
		FROM (
		SELECT ROW_NUMBER() OVER(ORDER BY DiagnosisID) AS NUMBER,
		DiagnosisID,
		[DiagnosisName],
		[SNOMEDCT],
		RIGHT('00' + CAST(DATEPART(DAY, DiagnosisStartDate) AS VARCHAR(2)), 2) + ' ' +
		DATENAME(MONTH, DiagnosisStartDate) + ' ' +
		CAST(DATEPART(YEAR, DiagnosisStartDate)  AS VARCHAR(4)) 'DiagnosisStartDate'
		,
		RIGHT('00' + CAST(DATEPART(DAY, DiagnosisEndDate) AS VARCHAR(2)), 2) + ' ' +
		DATENAME(MONTH, DiagnosisEndDate) + ' ' +
		CAST(DATEPART(YEAR, DiagnosisEndDate)  AS VARCHAR(4)) 'DiagnosisEndDate'
		,
		[Source],
		[Status],
		[Occurrence],
		[Comment],
		@TotalCount as TotalCount	
		FROM DiagnosisMaster A
		Where PatientID = @PatientID
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetDoctorData_Forlist]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetDoctorData_Forlist]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@TotalCount int = 0 OUT 
AS
BEGIN
		SELECT @TotalCount = COUNT(DoctorID)
		FROM DoctorMaster A 
		
		SELECT * 
		FROM (
		SELECT ROW_NUMBER() OVER(ORDER BY [DoctorID]) AS NUMBER,
		[DoctorID],
		[Name], 
		[Address], 
		[Specility], 
		[PhoneNo], 
		[Email], 
		[WebAddress],
		@TotalCount as TotalCount
		FROM DoctorMaster 
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetDoctorDataAutoComplete]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GetDoctorDataAutoComplete]
@SearchString nvarchar(500) = null
AS
BEGIN
	IF(@SearchString = '' OR @SearchString = null)
	BEGIN
		SELECT 
		top 10 [DoctorID], [Name] + '-' + [PhoneNo] 'Name'
		from DoctorMaster
	END
	ELSE
	BEGIN
		SELECT top 10 [DoctorID], [Name] + '-' + [PhoneNo] 'Name' from DoctorMaster where Name like @SearchString+'%'
	END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetDoctorDetailsByDoctorID]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GetDoctorDetailsByDoctorID]
@DoctorID bigint
AS
BEGIN
	SELECT DoctorID, Name, Address, Specility, PhoneNo, Email, WebAddress
	FROM [dbo].[DoctorMaster]
	WHERE DoctorID = @DoctorID
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetDoctorsNameIDsByPatientID]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetDoctorsNameIDsByPatientID]
--@PatientID INT = 0
AS
BEGIN
	--IF @PatientID > 1
	--BEGIN
		SELECT DoctorID,Name from DoctorMaster 
	--END
	--ELSE
	--BEGIN
	--	SELECT DoctorID,Name from DoctorMaster
	--END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetMedicationDataByPatientID]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetMedicationDataByPatientID]
@PatientID bigint  = 0 
AS
BEGIN
	
	SET NOCOUNT ON;
	SELECT MedicationID, PatientID, Medication, RxNorms, Diagnosis, Quantity, RefillAllowed, StartDate, EndDate, [Source], OrderGeneratedBy, Provider, [Status], Comments
		FROM [dbo].[MedicationMaster]
		Where PatientID = @PatientID
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetMedicationDataForList]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetMedicationDataForList]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@PatientID bigint,
@TotalCount int = 0 OUT 
AS
BEGIN
		SELECT @TotalCount = COUNT(MedicationID) FROM MedicationMaster 
		
		SELECT * 
		FROM (
		SELECT ROW_NUMBER() OVER(ORDER BY MedicationID) AS NUMBER,
		MedicationID, PatientID, Medication, RxNorms, Diagnosis, Quantity, RefillAllowed, [Source], OrderGeneratedBy, Provider, [Status], Comments
		,
		RIGHT('00' + CAST(DATEPART(DAY, StartDate) AS VARCHAR(2)), 2) + ' ' +
		DATENAME(MONTH, StartDate) + ' ' +
		CAST(DATEPART(YEAR, StartDate)  AS VARCHAR(4)) 'StartDate'
		,
		RIGHT('00' + CAST(DATEPART(DAY, EndDate) AS VARCHAR(2)), 2) + ' ' +
		DATENAME(MONTH, EndDate) + ' ' +
		CAST(DATEPART(YEAR, EndDate)  AS VARCHAR(4)) 'EndDate'
		,
		@TotalCount as TotalCount	
		FROM MedicationMaster A
		Where PatientID = @PatientID
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetMedicationDetailsByMedicationID]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetMedicationDetailsByMedicationID]
@MedicationID bigint
AS
BEGIN
	SELECT MedicationID, PatientID, Medication, RxNorms, Diagnosis, Quantity, RefillAllowed, StartDate, EndDate, Source, OrderGeneratedBy, Provider, Status, Comments
	FROM MedicationMaster
	WHERE MedicationID = @MedicationID
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetPatientData_Forlist]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GetPatientData_Forlist]
@ClinicName NVARCHAR(50),
@FirstName NVARCHAR(50) = '',
@LastName NVARCHAR(50) = '',
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@LoginUserID int = 0,
@TotalCount int = 0 OUT
AS
BEGIN
	IF @LoginUserID = 1
	BEGIN
		SELECT @TotalCount = COUNT([PatientID])
		FROM [dbo].[PatientMaster] Where ClinicName = @ClinicName
		
		SELECT * 
		FROM (
		SELECT 
		ROW_NUMBER() OVER(ORDER BY PM.PatientID) AS NUMBER,
		PM.PatientID, 
		PM.MobileNumber, 
		PM.MRNNumber,
		PM.LastName,
		PM.FirstName + ' ' + PM.LastName 'Name', 
		CAST(
             CASE 
                  WHEN PM.Gender = 1  THEN 'Male'
				  WHEN PM.Gender = 2  THEN 'Female' 
             END AS nvarchar(10)) as Gender, 
		RIGHT('00' + CAST(DATEPART(DAY, PM.DOB) AS VARCHAR(2)), 2) + ' ' +
		DATENAME(MONTH, PM.DOB) + ' ' +
		CAST(DATEPART(YEAR, PM.DOB)  AS VARCHAR(4)) 'DOB',
		PM.[BloodGroup],
		PM.Age, 
		PM.Address,
		PM.[DoctorsName],
		PM.StatusName,
		PM.ClinicName,
		sum(e.[CCMMINUTES]) as TotalMinute,
		@TotalCount as TotalCount 
		FROM [PatientMaster] PM LEFT JOIN [CCMNoteMaster] as e on e.[PatientID]= PM.[PatientID] 
		Where PM.ClinicName = @ClinicName
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
			PM.MRNNumber		
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
		ORDER BY TBL.LastName	
	END
	ELSE
	BEGIN
		SELECT @TotalCount = COUNT([PatientID])
		FROM [dbo].[PatientMaster] WHERE ClinicName in (SELECT * FROM dbo.BreakStringIntoRows((SELECT ClinicName From UserMaster Where [UserID] = @LoginUserID)))

		SELECT * 
		FROM (
		SELECT 
		ROW_NUMBER() OVER(ORDER BY PM.PatientID) AS NUMBER,
		PM.PatientID, 
		PM.MobileNumber, 
		PM.MRNNumber,
		PM.ClinicName,
		PM.LastName,
		PM.FirstName + ' ' + PM.LastName 'Name', 
		CAST(
             CASE 
                  WHEN PM.Gender = 1  THEN 'Male'
				  WHEN PM.Gender = 2  THEN 'Female' 
             END AS nvarchar(10)) as Gender, 
		RIGHT('00' + CAST(DATEPART(DAY, PM.DOB) AS VARCHAR(2)), 2) + ' ' +
		DATENAME(MONTH, PM.DOB) + ' ' +
		CAST(DATEPART(YEAR, PM.DOB)  AS VARCHAR(4)) 'DOB',
		PM.[BloodGroup],
		PM.Age, 
		PM.Address,
		PM.[DoctorsName],
		PM.StatusName,
		sum(e.[CCMMINUTES]) as TotalMinute,
		@TotalCount as TotalCount 
		FROM [PatientMaster] PM LEFT JOIN [CCMNoteMaster] as e on e.[PatientID]= PM.[PatientID] 
		WHERE PM.ClinicName in (SELECT * FROM dbo.BreakStringIntoRows((SELECT ClinicName From UserMaster Where [UserID] = @LoginUserID)))
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
			PM.MRNNumber,
			PM.ClinicName
		
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
		ORDER BY TBL.LastName	
	END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetPatientData_Forlist1]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SP_GetPatientData_Forlist1 @ClinicName=N'Clinic A',@FirstName=default,@LastName=default,@CurrentPage=1,@NumberOfRecords=10,@OrderBy=N' ',@LoginUserID=1
CREATE PROCEDURE [dbo].[SP_GetPatientData_Forlist1]
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
			PM.MRNNumber'
		
		PRINT (' SELECT * FROM ( '+@SQLQUERY+' ) AS TBL
		WHERE NUMBER BETWEEN (('+@CurrentPage+' - 1) * '+@NumberOfRecords+' +1) AND ('+@CurrentPage+' * '+@NumberOfRecords+')
		ORDER BY TBL.Name' );

		EXEC (' SELECT * FROM ( '+@SQLQUERY+' ) AS TBL
		WHERE NUMBER BETWEEN (('+@CurrentPage+' - 1) * '+@NumberOfRecords+' +1) AND ('+@CurrentPage+' * '+@NumberOfRecords+')
		ORDER BY TBL.Name' );
	END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetPatientDataByPatientID]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetPatientDataByPatientID]
@PatientID bigint  = 0 
AS
BEGIN
	
	SET NOCOUNT ON;
	SELECT
		PM.PatientID, 
		PM.FirstName + ' ' + PM.LastName 'Name', 
		PM.Gender, 
		DATEDIFF(yy, PM.[DOB], getdate()) 'age',
		RIGHT('00' + CAST(DATEPART(DAY, PM.DOB) AS VARCHAR(2)), 2) + ' ' +
		DATENAME(MONTH, PM.DOB) + ' ' +
		CAST(DATEPART(YEAR, PM.DOB)  AS VARCHAR(4)) 'DOB'
		, 
		PM.[BloodGroup],
		PM.[MRNNumber],
		PM.Address,
		PM.City,
		PM.State,
		PM.COUNTRY,
		PM.MobileNumber,
		PM.ClinicName,
		PM.BloodGroup,
		PM.PostalCode,
		PM.DoctorsName,
		PM.StatusName,
		PM.MRNNumber,
		PM.Email,
		PM.PrimaryContactNumber,
		PM.[AlternateContactNumber],
		PM.PrimaryLanguage,
		PM.SecondaryLanguage,
		PM.Ethnicity,
		PM.MaritalStatus,
		PM.Races,
		PM.HomePhone,
		PM.Comments,
		PM.GuardianName,
		PM.DriverLicenseID,
		PM.DriverLicenseState,
		PM.[SSN],
		PM.[Comments],
		PM.[DoctorsName],
		PM.[CellPhone],
		PM.[CustomPatientID],
		PM.[DeviceId],
		PM.[LowBPLimit],
		PM.[HighBPLimit],
		PM.[LowGlucoseLimit],
		PM.[HighGlucoseLimit],
		CCMNote.CCMNoteID
		FROM PatientMaster PM
		LEFT JOIN [CCMNoteMaster] CCMNote
		ON CCMNote.PatientID = PM.PatientID
		Where PM.PatientID = @PatientID
END




GO
/****** Object:  StoredProcedure [dbo].[SP_GetPatientDetailsByPatientID]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GetPatientDetailsByPatientID]
@PatientID bigint
AS
BEGIN
	SELECT	PM.[PatientID], 
			PM.[FirstName], 
			PM.[MiddleName], 
			PM.[LastName], 
			PM.[MRNNumber], 
			PM.[Gender], 
			PM.[DOB], 
			PM.[Age], 
			PM.[MobileNumber], 
			PM.[ClinicName], 
			PM.[BloodGroup], 
			PM.[Address], 
			PM.[City], 
			PM.[State], 
			PM.[COUNTRY], 
			PM.[PostalCode], 
			PM.[DoctorsName], 
			PM.[StatusName],
			PM.[Email],
			PM.[PrimaryContactNumber],
			PM.[AlternateContactNumber],
			PM.[PrimaryLanguage],
			PM.[SecondaryLanguage],
			PM.[Ethnicity],
			PM.[MaritalStatus],
			PM.[EmergencyName1],
			PM.[EmergencyRelationship1],
			PM.[EmergencyPhoneNo1],
			PM.[EmergencyName2],
			PM.[EmergencyRelationship2],
			PM.[EmergencyPhoneNo2],
			IM.[Name],
			IM.[MemberID],
			IM.[GroupID],
			IM.[PlanName],
			PM.[Races],
			PM.[HomePhone],
			PM.[GuardianName],
			PM.[DriverLicenseId],
			PM.[DriverLicenseState],
			PM.[SSN],
			PM.[Comments],
			PM.[DoctorsName],
			PM.[CellPhone],
			PM.[CustomPatientID],
			PM.[DeviceId],
			PM.[DeviceReceivedDate],
			PM.[LowBPLimit],
			PM.[HighBPLimit],
			PM.[LowGlucoseLimit],
			PM.[HighGlucoseLimit]
	FROM	PatientMaster PM LEFT JOIN InsuranceMaster IM 
	ON		IM.PatientID = PM.PatientID
	WHERE	PM.[PatientID] = @PatientID
END



GO
/****** Object:  StoredProcedure [dbo].[SP_GetPatientProfileData]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetPatientProfileData] 
@ClinicName nvarchar(250)  = null 
AS
BEGIN
	
	SET NOCOUNT ON;
	SELECT
		PatientID, 
		FirstName + ' ' + LastName 'Name', 
		Gender, 
		RIGHT('00' + CAST(DATEPART(DAY, DOB) AS VARCHAR(2)), 2) + ' ' +
		DATENAME(MONTH, DOB) + ' ' +
		CAST(DATEPART(YEAR, DOB)  AS VARCHAR(4)) 'DOB'
		, 
		[BloodGroup],
		Age, 
		Address,
		MobileNumber
		FROM PatientMaster
		Where ClinicName = @ClinicName OR @ClinicName IS NULL
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetPatientReportDetailForList]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetPatientReportDetailForList]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250) = null,
@FromDate DateTime = null,
@ToDate DateTime = null,
@CCMTimeSpan int = 0,
@IsBillable bit = null,
@TotalCount int = 0 OUT 
AS
BEGIN
	
	SELECT @TotalCount = COUNT(A.[PatientID])
		FROM PatientMaster A INNER JOIN  [CCMNoteMaster] CM
		ON			CM.PatientID = A.PatientID
		WHERE		([CCMDate] >=  CONVERT(date, @FromDate) OR @FromDate IS NULL)
					AND ([CCMDate] <=  CONVERT(date, @ToDate) OR @ToDate IS NULL) 
					AND [CCMDate] BETWEEN ISNULL(CONVERT(date, @FromDate), '1900-01-01') AND ISNULL(CONVERT(date, @ToDate), '9999-12-31') 
					AND IsBillable = @IsBillable
	
	IF (@CCMTimeSpan < 21)
	BEGIN
	SELECT * 
		FROM (
			SELECT	ROW_NUMBER() OVER(ORDER BY PM.[PatientID]) AS NUMBER,
						PM.[PatientID], 
						PM.FirstName + ' ' + PM.LastName + ' ' + PM.MobileNumber 'PatientName',
						PM.MRNNumber,
						SUM(CM.[CCMMINUTES]) as TotalMinute,
						[dbo].[CCMNoteCommaSeprated] (PM.[PatientID]) 'CCMNote',
						@TotalCount as TotalCount
			FROM		PatientMaster PM INNER JOIN [CCMNoteMaster] CM
			ON			CM.PatientID = PM.PatientID
			WHERE		([CCMDate] >=  CONVERT(date, @FromDate) OR @FromDate IS NULL)
						AND ([CCMDate] <=  CONVERT(date, @ToDate) OR @ToDate IS NULL) 
						AND [CCMDate] BETWEEN ISNULL(CONVERT(date, @FromDate), '1900-01-01') AND ISNULL(CONVERT(date, @ToDate), '9999-12-31') 
						AND IsBillable = @IsBillable
			GROUP BY	PM.PatientID, 
						PM.MobileNumber, 
						PM.FirstName,  
						PM.LastName, 
						PM.MRNNumber
		HAVING SUM(CM.[CCMMINUTES]) <= 21
			) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
	END
	ELSE
	BEGIN
		SELECT * 
		FROM (
		SELECT	ROW_NUMBER() OVER(ORDER BY PM.[PatientID]) AS NUMBER,
					PM.[PatientID], 
					PM.FirstName + ' ' + PM.LastName + ' ' + PM.MobileNumber 'PatientName',
					PM.MRNNumber,
					SUM(CM.[CCMMINUTES]) as TotalMinute,
					[dbo].[CCMNoteCommaSeprated] (PM.[PatientID]) 'CCMNote',
					@TotalCount as TotalCount
		FROM		PatientMaster PM INNER JOIN [CCMNoteMaster] CM
		ON			CM.PatientID = PM.PatientID
		WHERE		([CCMDate] >=  CONVERT(date, @FromDate) OR @FromDate IS NULL)
					AND ([CCMDate] <=  CONVERT(date, @ToDate) OR @ToDate IS NULL) 
					AND [CCMDate] BETWEEN ISNULL(CONVERT(date, @FromDate), '1900-01-01') AND ISNULL(CONVERT(date, @ToDate), '9999-12-31') 
					AND IsBillable = @IsBillable
		GROUP BY	PM.PatientID, 
					PM.MobileNumber, 
					PM.FirstName,  
					PM.LastName, 
					PM.MRNNumber
		HAVING SUM(CM.[CCMMINUTES]) > @CCMTimeSpan
		) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
		
	END
END



GO
/****** Object:  StoredProcedure [dbo].[SP_GetPatientShortDataByPatientID]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetPatientShortDataByPatientID]
@PatientID BIGINT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [PatientID],[FirstName],[LastName],[MRNNumber] 
	From [dbo].[PatientMaster]
	Where [PatientID] = @PatientID
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetRPMReportData_Forlist]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SP_GetRPMReportData_Forlist @Status=default,@CurrentPage=1,@NumberOfRecords=10,@OrderBy=N' ',@LoginUserID=1
CREATE PROCEDURE [dbo].[SP_GetRPMReportData_Forlist]
@Status nvarchar(50) = null,
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
	Print	@indexNumber 
	Print	@CLINICNAME 
	IF @indexNumber > 0 
	BEGIN	
		SET @clinic1 = CAST(LEFT(@CLINICNAME,CHARINDEX(',',@CLINICNAME)-1) AS nvarchar(250))
		SET @clinic2 = CAST(RIGHT(@CLINICNAME,LEN(@CLINICNAME) - CHARINDEX(',',@CLINICNAME)+2) AS nvarchar(250))
	END
	ELSE
	BEGIN
		SET	@CLINICNAME = ''''+replace(@CLINICNAME,',',''',''')+''''
	END
	
	SET @sqlCommand = N'SELECT COUNT(RPMReportID) AS TotalCount
						FROM [dbo].[RPMReportMaster] RPM
						INNER JOIN [dbo].[PatientMaster] PM ON PM.[PatientID] = RPM.[PatientID]'
	IF @LoginUserID > 1 and @indexNumber = 0
	BEGIN
		SET @sqlCommand = @sqlCommand + N' WHERE PM.[ClinicName] IN (' + @CLINICNAME + ')'
	END
	ELSE IF @LoginUserID > 1 and @indexNumber > 0
	BEGIN 
		SET @sqlCommand = @sqlCommand + N' WHERE PM.[ClinicName] LIKE ''%' + @clinic1 + '%'' OR PM.[ClinicName] LIKE ''%' +RTRIM(@clinic2) + '%'''
	END
	print @sqlCommand
	EXECUTE sp_executesql @sqlCommand, N'@CLINICNAME nvarchar(1000)', @CLINICNAME = @CLINICNAME

	SET @SQLQUERY = N'
		SELECT ROW_NUMBER() OVER(ORDER BY RPMReportID) AS NUMBER,
			RPM.[RPMReportID], 
			RPM.[DeviceID], 
			RPM.[PatientID], 
			RPM.[PatientName], 
			RPM.[BP], 
			RPM.[Glucose], 
			RPM.[MobileNumber], 
			RPM.[Status], 
			RPM.[Notes], 
			RPM.[CreatedDate],
			[dbo].[SumTimeSpan](RPM.[PatientID]) AS ''RPMInteractionTime'',
            CASE 
                  WHEN ((datepart(minute, [dbo].[SumTimeSpan](RPM.PatientID))) > 00 AND (datepart(minute, [dbo].[SumTimeSpan](RPM.PatientID)) <= 19))  THEN (SELECT convert(time(0),dateadd(second,datediff(second,[dbo].[SumTimeSpan](RPM.PatientID),''00:20:00''),0)))
				  WHEN ((datepart(minute, [dbo].[SumTimeSpan](RPM.PatientID))) > 20 AND (datepart(minute, [dbo].[SumTimeSpan](RPM.PatientID)) <= 39))  THEN (SELECT convert(time(0),dateadd(second,datediff(second,[dbo].[SumTimeSpan](RPM.PatientID),''00:40:00''),0)))
				  WHEN ((datepart(minute, [dbo].[SumTimeSpan](RPM.PatientID))) > 40 AND (datepart(minute, [dbo].[SumTimeSpan](RPM.PatientID)) <= 59))  THEN (SELECT convert(time(0),dateadd(second,datediff(second,[dbo].[SumTimeSpan](RPM.PatientID),''00:59:59''),0)))
	        END AS ''RemainingBlockTime'',
			DATEDIFF(d, [ReadingDateTime], GETDATE()) AS ''MissedReadingDays'',
			PM.ClinicName
		 FROM  [dbo].[RPMReportMaster] RPM
		 JOIN  [dbo].[PatientMaster] PM ON PM.PatientID = RPM.PatientID'
		IF @LoginUserID > 1 and @indexNumber = 0
		BEGIN
			SET @SQLQUERY = @SQLQUERY + N' WHERE PM.[ClinicName] IN (' + @CLINICNAME + ')'
		END
		ELSE IF @LoginUserID > 1 and @indexNumber > 0
		BEGIN 
			SET @SQLQUERY = @SQLQUERY + N' WHERE PM.[ClinicName] LIKE ''%' + @clinic1 + '%'' OR PM.[ClinicName] LIKE ''%' +RTRIM(@clinic2) + '%'''
		END
		Print	@SQLQUERY
		EXEC (' SELECT * FROM ( '+ @SQLQUERY +' ) AS TBL
			WHERE NUMBER BETWEEN (('+ @CurrentPage +' - 1) * '+ @NumberOfRecords +' + 1) AND ('+ @CurrentPage +' * '+ @NumberOfRecords +')
			ORDER BY TBL.Status' );
	END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetStateData]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetStateData]
	 @CountryID bigint
AS
BEGIN
	SELECT 
	*
	from MST_Regions_State
	WHERE @CountryID IS NULL OR CountryID = @CountryID
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetStateDataAutocomplete]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetStateDataAutocomplete]
@SearchString nvarchar(500) = null
AS
BEGIN
	IF(@SearchString = '' OR @SearchString = null)
	BEGIN
		SELECT 
		top 10 *
		from MST_Regions_State
	END
	ELSE
	BEGIN
		SELECT top 10 * from MST_Regions_State where Region like @SearchString+'%'
	END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetUserData_Forlist]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SP_GetUserData_Forlist @CurrentPage=1,@NumberOfRecords=10,@OrderBy=N' ',@LoginUserID=4
CREATE PROCEDURE [dbo].[SP_GetUserData_Forlist]
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

GO
/****** Object:  StoredProcedure [dbo].[SP_GetUserDetailsByUserID]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetUserDetailsByUserID]
@UserID bigint
AS
BEGIN
	SELECT	[UserID], 
			[FirstName], 
			[MiddleName], 
			[LastName], 
			[Gender], 
			[EmailID], 
			[MobileNumber], 
			[Address], 
			[City], 
			[State], 
			[Country], 
			[Pincode], 
			[ClinicName],
			[Username],
			[Password]
	FROM [dbo].[UserMaster]
	WHERE [UserID] = @UserID
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetVitalDataForList]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetVitalDataForList]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@PatientID bigint,
@TotalCount int = 0 OUT 
AS
BEGIN
		SELECT @TotalCount = COUNT(VitalID)
		FROM VitalMaster A 
		
		SELECT * 
		FROM (
		SELECT ROW_NUMBER() OVER(ORDER BY VitalID) AS NUMBER,
		VitalID,
		BloodPressure, 
		Height, 
		Pain, 
		Respiration, 
		Temperature, 
		Weight, 
		[ChectCircumference/Girth], 
		PulseOximetry, 
		Pulse,	
		BloodSuger,
		AbnormalCircumference,	
		@TotalCount as TotalCount	
		FROM VitalMaster A
		Where PatientID = @PatientID
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_InsertAllergyDetails]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_InsertAllergyDetails]
	@PatientID bigint,
	@AllergyID bigint,
	@Type nvarchar(200),
	@Agent NVARCHAR(200),
	@SNOMED NVARCHAR(1000),
	@Reaction1 nvarchar(200),
	@Serverity NVARCHAR(200),
	@Source NVARCHAR(200),
	@Status nvarchar(200)
	AS
BEGIN
If (@AllergyID > 0)
	BEGIN
	 UPDATE [dbo].[AllergyMaster] SET Agent= @Agent, [Type]= @Type, SNOMED = @SNOMED, Reaction=@Reaction1, Severity = @Serverity, [Source] = @Source, [Status]= @Status
	 WHERE [AllergyID] = @AllergyID
	END
ELSE
		BEGIN
		INSERT INTO [dbo].[AllergyMaster]
		(
			PatientID, [Type], Agent, SNOMED, Reaction, Severity, [Source], [Status]
		) 
		VALUES
		(
			@PatientID, @Type, @Agent, @SNOMED, @Reaction1, @Serverity, @Source, @Status
		)
			SELECT SCOPE_IDENTITY()
		END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_InsertCCMNoteData]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_InsertCCMNoteData]
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
	

GO
/****** Object:  StoredProcedure [dbo].[SP_InsertClinicData]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_InsertClinicData]
@ClinicID bigint = 0,
@Name nvarchar(50) = NULL,
@Address nvarchar(250) = NULL,
@CreatedBy bigint,
@IsActive bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF ( @ClinicID = 0 )
	BEGIN
      INSERT INTO ClinicMaster 
	  (
		[Name], 
		[Address],
		[CreatedBy],
		[CreatedOn],
		[IsActive]
	  ) 
	  VALUES 
	  (
		@Name,
		@Address,
		@CreatedBy,
		GETDATE(),
		@IsActive
	  )
	  SELECT SCOPE_IDENTITY()
	END
	ELSE 
	BEGIN
		UPDATE ClinicMaster
		SET [Name]  = @Name,
			[Address] = @Address,
			[UpdatedBy] = @CreatedBy,
			[UpdatedOn] = GETDATE(),
			[IsActive] = @IsActive
		WHERE [ClinicID] = @ClinicID
	END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_InsertDiagnosisData]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[SP_InsertDiagnosisData]
	@DiagnosisID bigint,
	@PatientID bigint,
	@DiagnosisName nvarchar(50),
	@SNOMEDCT nvarchar(200) = null,
	@DiagnosisStartDate DateTime = null,
	@DiagnosisEndDate DateTime = null,
	@Source NVARCHAR(100) = null,
	@Status NVARCHAR(100) = null,
	@Occurrence NVARCHAR(100) = null,
	@Comment NVARCHAR(100) = null
	AS
BEGIN
	IF @DiagnosisID = 0
	BEGIN
		INSERT INTO [dbo].[DiagnosisMaster]
		(
			PatientID, 
			DiagnosisName, 
			[SNOMEDCT],
			[DiagnosisStartDate],
			[DiagnosisEndDate],
			[Source],
			[Status],
			[Occurrence],
			[Comment]
		) 
		VALUES
		(
			@PatientID, 
			@DiagnosisName, 
			@SNOMEDCT, 
			@DiagnosisStartDate,
			@DiagnosisEndDate,
			@Source,
			@Status,
			@Occurrence,
			@Comment
		)
			SELECT SCOPE_IDENTITY()
		END
		ELSE
		BEGIN
			UPDATE [dbo].[DiagnosisMaster]
			SET PatientID=@PatientID, 
			DiagnosisName=@DiagnosisName, 
			[SNOMEDCT]=@SNOMEDCT, 
			[DiagnosisStartDate] = @DiagnosisStartDate,
			[DiagnosisEndDate] = @DiagnosisEndDate,
			[Source] = @Source,
			[Status] = @Status,
			[Occurrence] = @Occurrence,
			[Comment] = @Comment
			WHERE DiagnosisID=@DiagnosisID
		END
	END

GO
/****** Object:  StoredProcedure [dbo].[SP_InsertDoctorData]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_InsertDoctorData]
	@DoctorID bigint = 0,
	@Name nvarchar(50) = null,
	@Address nvarchar(max) = null,
	@PhoneNo nvarchar(50) = null,
	@Specility nvarchar(50)= null,
	@WebAddress nvarchar(50)= null,
	@Email nvarchar(50)= null,
	@CreatedBy int,
	@IsActive bit = 1
	AS
BEGIN
	IF(@DoctorID = 0)
	BEGIN
		INSERT INTO DoctorMaster
		(
			[Name], 
			[Address], 
			[Specility], 
			[PhoneNo], 
			[Email], 
			[WebAddress], 
			[CreatedBy], 
			[CreatedOn],
			[IsActive]
		) 
		VALUES
			(
			@Name, 
			@Address, 
			@Specility, 
			@PhoneNo, 
			@Email, 
			@WebAddress, 
			@CreatedBy, 
			GETDATE(),
			@IsActive
			)
			SELECT SCOPE_IDENTITY()
	END
	ELSE
	BEGIN
		UPDATE DoctorMaster
		SET [Name] = @Name,
			[Address] = @Address,
			[PhoneNo]= @PhoneNo, 
			[Email] = @Email, 
			[WebAddress] = @WebAddress,
			[UpdatedBy] = @CreatedBy,
			[UpdatedOn] = GETDATE(),
			[IsActive] = @IsActive
		WHERE [DoctorID] = @DoctorID
	END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_InsertMedicationData]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_InsertMedicationData]
	@MedicationID bigint,
	@PatientID bigint,
	@Medication nvarchar(200) = null,
	@RxNorms nvarchar(200) = null,
	@Diagnosis nvarchar (200)  = null,
	@Quantity int = 0,
	@RefillAllowed nvarchar(200)  = null,
	@StartDate DateTime = null,
	@EndDate DateTime = null,
	@Comments nvarchar(max)  = null,
	@Source nvarchar(200)  = null,
	@OrderGeneratedBy nvarchar(200)  = null,
	@Provider nvarchar(200)  = null,
	@Status nvarchar(200) = null
	AS
BEGIN
	IF(@MedicationID = 0)
	BEGIN
		INSERT INTO [dbo].[MedicationMaster]
		(
			PatientID, Medication, RxNorms, Diagnosis, Quantity, 
			RefillAllowed, StartDate, EndDate, [Source], OrderGeneratedBy, 
			Provider, [Status], Comments
		) 
		VALUES
			(
				@PatientID,
				@Medication,
				@RxNorms,
				@Diagnosis,
				@Quantity,
				@RefillAllowed,
				@StartDate,
				@EndDate,
				@Source,
				@OrderGeneratedBy,
				@Provider,
				@Status,
				@Comments
			)
			SELECT SCOPE_IDENTITY()
	END
	ELSE
	BEGIN
		UPDATE [dbo].[MedicationMaster]
		SET PatientID = @PatientID,
		Medication = @Medication, 
		RxNorms = @RxNorms,
		Diagnosis = @Diagnosis,
		Quantity=@Quantity,
		RefillAllowed = @RefillAllowed,
		StartDate=@StartDate,
		EndDate=@EndDate,
		[Source] = @Source,
		[Status] = @Status,
		OrderGeneratedBy = @OrderGeneratedBy,
		Provider = @Provider,
		Comments = @Comments
		WHERE MedicationID = @MedicationID
	END
	END

GO
/****** Object:  StoredProcedure [dbo].[SP_InsertPatientData]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[SP_InsertPatientData]
	@PatientID bigint,
	@FirstName nvarchar(250)  = null,
	@MiddleName nvarchar(250) = null,
	@LastName nvarchar(250)= null,
	@Gender int = null,
	@DOB DATETIME = null,
	@MobileNumber nvarchar(15)= null,
	@AddressLine1 nvarchar(250)= null,
	@CityID	nvarchar(250)= null,
	@CountryID nvarchar(250)= null,
	@StateID nvarchar(250)= null,
	@Pincode varchar(10)= null,
	@BloodGroup nvarchar(50) = null,
	@ClinicName nvarchar(250) = null,
	@DoctorsName nvarchar(max) = null,
	@StatusName nvarchar(50) = null,
	@MRNNumber nvarchar(10) = null,
	@Email nvarchar(50) = null,		
	@PrimaryContactNumber nvarchar(15) = null,
	@AlternateContactNumber	nvarchar(15) = null,
	@PrimaryLanguage nvarchar(30) = null,	
	@SecondaryLanguage nvarchar(30) = null,
	@Ethnicity nvarchar(30) = null,
	@MaritalStatus nvarchar(20) = null,
	@EmergencyName1 Nvarchar(50) = null,
	@EmergencyRelationship1 NVARCHAR(50) = NULL,
	@EmergencyPhoneNo1 NVARCHAR(20) = NULL,
	@EmergencyName2 Nvarchar(50) = null,
	@EmergencyRelationship2 NVARCHAR(50) = NULL,
	@EmergencyPhoneNo2 NVARCHAR(20) = NULL,
	@InsuranceName NVARCHAR(50) = NULL,
	@InsurancePlanName NVARCHAR(50) = NULL,
	@InsuranceStartDate DATETIME = NULL,
	@InsuranceEndDate DateTime = NULL,
	@InsuranceMemberID nvarchar(30) = NULL,
	@InsuranceGroupID NVARCHAR(30) = NULL,
	@CreatedBy int = null,
	@IsActive bit,
	@Races NVARCHAR(200) = null,
	@HomePhone NVARCHAR(20) = NULL,
	@WorkPhone NvARCHAR(20) = NULL,
	@SSN NVARCHAR(200) = NULL,
	@GuardianName NVARCHAR(200) = NULL,
	@DriverLicenseID NVARCHAR(200) = nULL,
	@DriverLicenseState bit = 0,
	@Comments NVARCHAR(max) = null,
	@CustomPatientID NVARCHAR(100) = null,
	@DeviceID NVARCHAR(15) = null,
	@DeviceReceivedDate DATETIME = NULL,
	@LowBPLimit INT = null,
	@HighBPLimit INT = null,
	@LowGlucoseLimit INT = null,
	@HighGlucoseLimit INT = null
	AS
BEGIN
	DECLARE @Age INT
	SELECT @Age = DATEDIFF(hour,@DOB,GETDATE())/8766
	

	IF(@PatientID = 0)
	BEGIN
		DECLARE @InsertedPatientID BIGINT
		INSERT INTO PatientMaster
		(
			FirstName, MiddleName, LastName, Gender,[DOB],[Age], MobileNumber, [Address], City, Country, [State],PostalCode,ClinicName,
			BloodGroup, DoctorsName, StatusName, MRNNumber,	[Email], [PrimaryContactNumber], [AlternateContactNumber],	[PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus],	[EmergencyName1], [EmergencyRelationship1],	[EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2],
			[Races],[HomePhone],[CellPhone],[Comments],[GuardianName],[DriverLicenseID],[DriverLicenseState],[CreatedBy],[CreatedOn],[SSN],[IsActive],[CustomPatientID],
			[DeviceId],[LowBPLimit],[HighBPLimit],[LowGlucoseLimit],[HighGlucoseLimit],[DeviceReceivedDate]
		) 
		VALUES
		(
			@FirstName,	@MiddleName, @LastName, @Gender,@DOB,@Age, @MobileNumber,	@AddressLine1,	@CityID, @CountryID, @StateID, @Pincode, @ClinicName,
			@BloodGroup, @DoctorsName, @StatusName, @MRNNumber, @Email, @PrimaryContactNumber,	@AlternateContactNumber, @PrimaryLanguage,
			@SecondaryLanguage, @Ethnicity, @MaritalStatus, @EmergencyName1, @EmergencyRelationship1, @EmergencyPhoneNo1, @EmergencyName2,
			@EmergencyRelationship2, @EmergencyPhoneNo2,@Races,@HomePhone,@WorkPhone,@Comments,@GuardianName,@DriverLicenseID,@DriverLicenseState,@CreatedBy,GETDATE(),@SSN,
			@IsActive,@CustomPatientID, @DeviceID, @LowBPLimit, @HighBPLimit, @LowGlucoseLimit, @HighGlucoseLimit, @DeviceReceivedDate 
		)
		
			set @InsertedPatientID = @@Identity

			IF (@InsuranceName IS NOT NULL)
			BEGIN
				INSERT INTO [dbo].[InsuranceMaster] (Name,[PatientID], PlanName, StartDate, EndDate, MemberID, GroupID)
				VALUES (@InsuranceName,@InsertedPatientID,@InsurancePlanName,@InsuranceStartDate,@InsuranceEndDate,@InsuranceMemberID,@InsuranceGroupID)
			END 

			SELECT @InsertedPatientID
	END
	ELSE
	BEGIN
		UPDATE PatientMaster
		SET FirstName = @FirstName, MiddleName = @MiddleName , LastName = @LastName, Gender=@Gender,[DOB]=@DOB,[Age]=@Age, MobileNumber=@MobileNumber, [Address]=@AddressLine1, City=@CityID, Country=@CountryID, [State]=@StateID,PostalCode=@Pincode,ClinicName=@ClinicName,
			BloodGroup=@BloodGroup, DoctorsName=@DoctorsName, StatusName=@StatusName, MRNNumber=@MRNNumber,	[Email]=@Email, [PrimaryContactNumber]=@PrimaryContactNumber, [AlternateContactNumber]=@AlternateContactNumber,	[PrimaryLanguage]=@PrimaryLanguage, 
			[SecondaryLanguage]=@SecondaryLanguage, [Ethnicity]=@Ethnicity, [MaritalStatus]=@MaritalStatus,	[EmergencyName1]=@EmergencyName1, [EmergencyRelationship1]=@EmergencyRelationship1,	[EmergencyPhoneNo1]=@EmergencyPhoneNo1, [EmergencyName2]=@EmergencyName2, 
			[EmergencyRelationship2]=@EmergencyRelationship2, [EmergencyPhoneNo2]=@EmergencyPhoneNo2,
			[Races]=@Races,[HomePhone]=@HomePhone,[CellPhone]=@WorkPhone,[Comments]=@Comments,[GuardianName]=@GuardianName,[DriverLicenseID]=@DriverLicenseID,[DriverLicenseState]=@DriverLicenseState,[UpdatedBy]=@CreatedBy,[UpdatedOn]=GETDATE(),[SSN]=@SSN,[IsActive]=@IsActive,[CustomPatientID]=@CustomPatientID,[DeviceId]=@DeviceID,
			LowBPLimit = @LowBPLimit, HighBPLimit = @HighBPLimit,LowGlucoseLimit = @LowGlucoseLimit,HighGlucoseLimit= @HighGlucoseLimit, DeviceReceivedDate=@DeviceReceivedDate
		WHERE PatientID = @PatientID

		UPDATE  [dbo].[InsuranceMaster] 
		SET		[Name]=@InsuranceName,PlanName=@InsurancePlanName, StartDate=@InsuranceStartDate, EndDate=@InsuranceEndDate, MemberID=@InsuranceMemberID, GroupID=@InsuranceGroupID
		WHERE	PatientID = @PatientID
	END
	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_InsertPatientData1]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[SP_InsertPatientData1]
	@PatientID bigint,
	@FirstName nvarchar(250)  = null,
	@MiddleName nvarchar(250) = null,
	@LastName nvarchar(250)= null,
	@Gender int = null,
	@DOB DATETIME = null,
	@MobileNumber nvarchar(15)= null,
	@AddressLine1 nvarchar(250)= null,
	@CityID	nvarchar(250)= null,
	@CountryID nvarchar(250)= null,
	@StateID nvarchar(250)= null,
	@Pincode varchar(10)= null,
	@BloodGroup nvarchar(50) = null,
	@ClinicName nvarchar(250) = null,
	@DoctorsName nvarchar(max) = null,
	@StatusName nvarchar(50) = null,
	@MRNNumber nvarchar(10) = null,
	@Email nvarchar(50) = null,		
	@PrimaryContactNumber nvarchar(15) = null,
	@AlternateContactNumber	nvarchar(15) = null,
	@PrimaryLanguage nvarchar(30) = null,	
	@SecondaryLanguage nvarchar(30) = null,
	@Ethnicity nvarchar(30) = null,
	@MaritalStatus nvarchar(20) = null,
	@EmergencyName1 Nvarchar(50) = null,
	@EmergencyRelationship1 NVARCHAR(50) = NULL,
	@EmergencyPhoneNo1 NVARCHAR(20) = NULL,
	@EmergencyName2 Nvarchar(50) = null,
	@EmergencyRelationship2 NVARCHAR(50) = NULL,
	@EmergencyPhoneNo2 NVARCHAR(20) = NULL,
	@InsuranceName NVARCHAR(50) = NULL,
	@InsurancePlanName NVARCHAR(50) = NULL,
	@InsuranceStartDate DATETIME = NULL,
	@InsuranceEndDate DateTime = NULL,
	@InsuranceMemberID nvarchar(30) = NULL,
	@InsuranceGroupID NVARCHAR(30) = NULL,
	@CreatedBy int = null,
	@IsActive bit,
	@Races NVARCHAR(200) = null,
	@HomePhone NVARCHAR(20) = NULL,
	@WorkPhone NvARCHAR(20) = NULL,
	@SSN NVARCHAR(200) = NULL,
	@GuardianName NVARCHAR(200) = NULL
	AS
BEGIN
	DECLARE @Age INT
	SELECT @Age = DATEDIFF(hour,@DOB,GETDATE())/8766
	

	IF(@PatientID = 0)
	BEGIN
		DECLARE @InsertedPatientID BIGINT
		INSERT INTO PatientMaster
		(
			FirstName, MiddleName, LastName, Gender,[DOB],[Age], MobileNumber, [Address], City, Country, [State],PostalCode,ClinicName,
			BloodGroup, DoctorsName, StatusName, MRNNumber,	[Email], [PrimaryContactNumber], [AlternateContactNumber],	[PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus],	[EmergencyName1], [EmergencyRelationship1],	[EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2],
			[Races],[HomePhone],[CellPhone],[Comments],[GuardianName]
		) 
		VALUES
		(
			@FirstName,	@MiddleName, @LastName, @Gender,@DOB,@Age, @MobileNumber,	@AddressLine1,	@CityID, @CountryID, @StateID, @Pincode, @ClinicName,
			@BloodGroup, @DoctorsName, @StatusName, @MRNNumber, @Email, @PrimaryContactNumber,	@AlternateContactNumber, @PrimaryLanguage,
			@SecondaryLanguage, @Ethnicity, @MaritalStatus, @EmergencyName1, @EmergencyRelationship1, @EmergencyPhoneNo1, @EmergencyName2,
			@EmergencyRelationship2, @EmergencyPhoneNo2,@Races,@HomePhone,@WorkPhone,@SSN,@GuardianName
		)
		
			SELECT @InsertedPatientID = SCOPE_IDENTITY()

			INSERT INTO [dbo].[InsuranceMaster] (Name,[PatientID], PlanName, StartDate, EndDate, MemberID, GroupID)
			VALUES (@InsuranceName,@InsertedPatientID,@InsurancePlanName,@InsuranceStartDate,@InsuranceEndDate,@InsuranceMemberID,@InsuranceGroupID)

	END
	
	END

GO
/****** Object:  StoredProcedure [dbo].[SP_InsertUserData]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_InsertUserData]
	@UserID bigint,
	@FirstName nvarchar(250)  = null,
	@MiddleName nvarchar(250) = null,
	@LastName nvarchar(250)= null,
	@Gender int = null,
	@EmailID nvarchar(100)= null,
	@MobileNumber nvarchar(15)= null,
	@Address nvarchar(250)= null,
	@CityID	nvarchar(250)= null,
	@CountryID nvarchar(250)= null,
	@StateID nvarchar(250)= null,
	@Pincode varchar(10)= null,
	@Username varchar(20) = null,
	@Password nvarchar(250) = null,
	@ClinicName nvarchar(250) = null,
	@IsActive bit,
	@CreatedBy bit
AS
BEGIN
	IF(@UserID = 0)
	BEGIN
		INSERT INTO [dbo].[UserMaster]
			(
			[FirstName], 
			[MiddleName], 
			[LastName], 
			[Gender], 
			[EmailID], 
			[MobileNumber], 
			[Address], 
			[City], 
			[Country], 
			[State], 
			[Pincode], 
			[Username],
			[Password], 
			[IsActive],
			[ClinicName],
			[CreatedBy],
			[CreatedOn]
			) 
		VALUES
			(
			@FirstName,
			@MiddleName,
			@LastName,
			@Gender,
			@EmailID,
			@MobileNumber,
			@Address,
			@CityID,
			@CountryID,
			@StateID,
			@Pincode,
			@Username,
			@Password,
			@IsActive,
			@ClinicName,
			@CreatedBy,
			GETDATE()
			)
		SELECT SCOPE_IDENTITY()
	END
	ELSE
	BEGIN
		UPDATE dbo.UserMaster
		SET
		[FirstName] = @FirstName,
		[MiddleName] = @MiddleName,
		[LastName] = @LastName,
		[Gender] = @Gender,
		[EmailID] = @EmailID,
		[MobileNumber] = @MobileNumber,
		[Address] = @Address,
		[City] = @CityID,
		[Country] = @CountryID,
		[State] = @StateID,
		[Pincode] = @Pincode,
		[ClinicName] = @ClinicName,
		[UpdatedBy] = @CreatedBy,
		[UpdatedOn] = GETDATE(),
		[IsActive] = @IsActive
		where [UserID] = @UserID
	END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateStatusOnPatientID]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateStatusOnPatientID]
@PatientID bigint,
@StatusName NVARCHAR(50)
AS
BEGIN
	UPDATE PatientMaster
	SET [StatusName] = @StatusName
	WHERE [PatientID] = @PatientID
END


GO
/****** Object:  UserDefinedFunction [dbo].[BreakStringIntoRows]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[BreakStringIntoRows] (@CommadelimitedString   varchar(1000))
RETURNS   @Result TABLE (Name   VARCHAR(100))
AS
BEGIN
        DECLARE @IntLocation INT
        WHILE (CHARINDEX(',',    @CommadelimitedString, 0) > 0)
        BEGIN
              SET @IntLocation =   CHARINDEX(',',    @CommadelimitedString, 0)      
              INSERT INTO   @Result (Name)
              --LTRIM and RTRIM to ensure blank spaces are   removed
              SELECT RTRIM(LTRIM(SUBSTRING(@CommadelimitedString,   0, @IntLocation)))   
              SET @CommadelimitedString = STUFF(@CommadelimitedString,   1, @IntLocation,   '') 
        END
        INSERT INTO   @Result (Name)
        SELECT RTRIM(LTRIM(@CommadelimitedString))--LTRIM and RTRIM to ensure blank spaces are removed
        RETURN 
END


GO
/****** Object:  UserDefinedFunction [dbo].[CCMNoteCommaSeprated]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CCMNoteCommaSeprated] (@PatientID int)
RETURNS varchar(max)
AS
BEGIN
DECLARE @Names VARCHAR(MAX)  
SELECT @Names = COALESCE(@Names + ', ', '') + [Description] FROM  [dbo].[CCMNoteMaster]
WHERE   [PatientID] = @PatientID
RETURN @Names
END


GO
/****** Object:  UserDefinedFunction [dbo].[SumMinute]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SumMinute] (@PatientID int)
RETURNS int
AS
BEGIN
DECLARE @Timespan int 
SELECT @Timespan = SUM([Minutes]) From [dbo].[TempTable] 
group by [PatientID]
RETURN @Timespan
END

GO
/****** Object:  UserDefinedFunction [dbo].[SumTimeSpan]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SumTimeSpan] (@PatientID int)
RETURNS varchar(max)
AS
BEGIN
DECLARE @Timespan VARCHAR(20) 
--SELECT @Timespan = CAST(t.time_sum/3600 AS VARCHAR(2)) + ':'
--     + CAST(t.time_sum%3600/60 AS VARCHAR(2)) + ':'
--     + CAST(((t.time_sum%3600)%60) AS VARCHAR(2))
--FROM ( SELECT [PatientID], SUM(DATEDIFF(S, '00:00:00', [TimeSpent])) AS time_sum
--       FROM [CCMNoteMaster] Where PatientID = @PatientID GROUP BY [PatientID] ) t ;

select @Timespan = convert(varchar, dateadd(second, sum(datediff(second, '00:00:00', Timespent)), '00:00:00'),108)
from    [dbo].[CCMNoteMaster]
WHERE   [PatientID] = @PatientID
RETURN @Timespan
END

GO
/****** Object:  Table [dbo].[AllergyMaster]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AllergyMaster](
	[AllergyID] [bigint] IDENTITY(1,1) NOT NULL,
	[PatientID] [bigint] NOT NULL,
	[Type] [nvarchar](200) NULL,
	[Agent] [nvarchar](200) NULL,
	[SNOMED] [nvarchar](max) NULL,
	[Reaction] [nvarchar](max) NULL,
	[Severity] [nvarchar](200) NULL,
	[Source] [nvarchar](200) NULL,
	[Status] [nvarchar](200) NULL,
 CONSTRAINT [PK_AllergyMaster] PRIMARY KEY CLUSTERED 
(
	[AllergyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CCMNoteMaster]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CCMNoteMaster](
	[CCMNoteID] [bigint] IDENTITY(1,1) NOT NULL,
	[PatientID] [bigint] NULL,
	[Description] [nvarchar](max) NULL,
	[CCMDate] [date] NULL,
	[CCMTime] [varchar](20) NULL,
	[TimeSpent] [nvarchar](20) NULL,
	[IsBillable] [bit] NULL,
	[IsInitialVisti] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [bigint] NULL,
	[CCMMINUTES] [int] NULL,
	[PatientStatus] [nvarchar](100) NULL,
 CONSTRAINT [PK_CCMNoteMaster] PRIMARY KEY CLUSTERED 
(
	[CCMNoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CCMNotesInfoMaster]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CCMNotesInfoMaster](
	[CCMNoteInfoId] [bigint] IDENTITY(1,1) NOT NULL,
	[CCMNoteText] [nvarchar](250) NULL,
	[CCMNoteDescription] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_CCMNotesInfoMaster] PRIMARY KEY CLUSTERED 
(
	[CCMNoteInfoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClinicMaster]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClinicMaster](
	[ClinicID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Address] [nvarchar](250) NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_ClinicMaster] PRIMARY KEY CLUSTERED 
(
	[ClinicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DiagnosisMaster]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiagnosisMaster](
	[DiagnosisID] [bigint] IDENTITY(1,1) NOT NULL,
	[PatientID] [bigint] NULL,
	[DiagnosisName] [nvarchar](50) NULL,
	[SNOMEDCT] [nvarchar](200) NULL,
	[DiagnosisStartDate] [datetime] NULL,
	[DiagnosisEndDate] [datetime] NULL,
	[Source] [nvarchar](200) NULL,
	[Status] [nvarchar](200) NULL,
	[Occurrence] [nvarchar](200) NULL,
	[Comment] [nvarchar](300) NULL,
 CONSTRAINT [PK_DiagnosisMaster] PRIMARY KEY CLUSTERED 
(
	[DiagnosisID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DoctorMaster]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoctorMaster](
	[DoctorID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Address] [nvarchar](max) NULL,
	[Specility] [nvarchar](50) NULL,
	[PhoneNo] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[WebAddress] [nvarchar](50) NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_DoctorMaster1] PRIMARY KEY CLUSTERED 
(
	[DoctorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InsuranceMaster]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InsuranceMaster](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[PatientID] [bigint] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[PlanName] [nvarchar](50) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[MemberID] [nvarchar](20) NULL,
	[GroupID] [nvarchar](20) NULL,
 CONSTRAINT [PK_InsuranceMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MedicationMaster]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicationMaster](
	[MedicationID] [bigint] IDENTITY(1,1) NOT NULL,
	[PatientID] [bigint] NULL,
	[Medication] [nvarchar](200) NULL,
	[RxNorms] [nvarchar](200) NULL,
	[Diagnosis] [nvarchar](200) NULL,
	[Quantity] [int] NULL,
	[RefillAllowed] [nvarchar](200) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Source] [nvarchar](200) NULL,
	[OrderGeneratedBy] [nvarchar](200) NULL,
	[Provider] [nvarchar](200) NULL,
	[Status] [nvarchar](200) NULL,
	[Comments] [nvarchar](max) NULL,
	[DosaseCount] [nvarchar](200) NULL,
	[Measure] [nvarchar](200) NULL,
	[Route] [nvarchar](200) NULL,
	[Frequency] [nvarchar](200) NULL,
	[Instruction] [nvarchar](200) NULL,
 CONSTRAINT [PK_MedicationMaster] PRIMARY KEY CLUSTERED 
(
	[MedicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MST_City]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MST_City](
	[CityID] [bigint] IDENTITY(1,1) NOT NULL,
	[CityName] [varchar](100) NOT NULL,
	[RegionID] [bigint] NOT NULL,
	[CountryID] [bigint] NOT NULL,
 CONSTRAINT [PK_MST_City] PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MST_Countries]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MST_Countries](
	[CountryID] [bigint] NOT NULL,
	[Country] [varchar](300) NULL,
	[FIPS104] [varchar](50) NULL,
	[ISO2] [varchar](50) NULL,
	[ISO3] [varchar](50) NULL,
	[ISON] [varchar](50) NULL,
	[Internet] [varchar](50) NULL,
	[Capital] [varchar](50) NULL,
	[MapReference] [varchar](50) NULL,
	[NationalitySingular] [varchar](50) NULL,
	[NationalityPlural] [varchar](50) NULL,
	[Currency] [varchar](50) NULL,
	[CurrencyCode] [varchar](50) NULL,
	[Poppulation] [varchar](50) NULL,
	[Title] [varchar](200) NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL,
	[DeleteFlag] [bit] NULL,
 CONSTRAINT [PK_MST_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MST_Regions_State]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MST_Regions_State](
	[RegionID] [bigint] NOT NULL,
	[CountryID] [bigint] NULL,
	[Region] [varchar](250) NULL,
	[Code] [varchar](50) NULL,
	[ADM1Code] [varchar](50) NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL,
	[DeleteFlag] [bit] NULL,
 CONSTRAINT [PK_MST_Regions] PRIMARY KEY CLUSTERED 
(
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientMaster]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientMaster](
	[PatientID] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Gender] [int] NULL,
	[DOB] [datetime] NULL,
	[Age] [int] NULL,
	[MobileNumber] [nvarchar](15) NULL,
	[ClinicName] [nvarchar](50) NULL,
	[BloodGroup] [nvarchar](10) NULL,
	[Address] [nvarchar](250) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[COUNTRY] [nvarchar](50) NULL,
	[PostalCode] [nvarchar](50) NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
	[DoctorsName] [nvarchar](max) NULL,
	[StatusName] [nvarchar](50) NULL,
	[MRNNumber] [nvarchar](10) NULL,
	[Email] [nvarchar](50) NULL,
	[PrimaryContactNumber] [nvarchar](15) NULL,
	[AlternateContactNumber] [nvarchar](15) NULL,
	[PrimaryLanguage] [nvarchar](30) NULL,
	[SecondaryLanguage] [nvarchar](30) NULL,
	[Ethnicity] [nvarchar](30) NULL,
	[MaritalStatus] [nvarchar](20) NULL,
	[EmergencyName1] [nvarchar](50) NULL,
	[EmergencyRelationship1] [nvarchar](50) NULL,
	[EmergencyPhoneNo1] [nvarchar](20) NULL,
	[EmergencyName2] [nvarchar](50) NULL,
	[EmergencyRelationship2] [nvarchar](50) NULL,
	[EmergencyPhoneNo2] [nvarchar](20) NULL,
	[Races] [nvarchar](200) NULL,
	[HomePhone] [nvarchar](20) NULL,
	[CellPhone] [nvarchar](20) NULL,
	[Comments] [nvarchar](max) NULL,
	[GuardianName] [nvarchar](200) NULL,
	[DriverLicenseID] [nvarchar](200) NULL,
	[DriverLicenseState] [bit] NULL,
	[SSN] [nvarchar](200) NULL,
	[CustomPatientID] [nvarchar](200) NULL,
	[DeviceId] [nvarchar](15) NULL,
	[LowBPLimit] [int] NULL,
	[HighBPLimit] [int] NULL,
	[LowGlucoseLimit] [int] NULL,
	[HighGlucoseLimit] [int] NULL,
	[DeviceReceivedDate] [datetime] NULL,
 CONSTRAINT [PK_PatientMaster] PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientPreference]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientPreference](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[PatientId] [bigint] NULL,
	[PrimaryCarePhysican] [nvarchar](200) NULL,
	[PreferredContactMethod] [nvarchar](200) NULL,
	[AlternateEmailAddress] [nvarchar](50) NULL,
	[HIPAANoticePeriod] [bit] NULL,
	[ImmunizationRegistryUser] [bit] NULL,
	[ImmunicationSharing] [bit] NULL,
	[HealthInformationExchange] [bit] NULL,
	[ReferredByDoctor] [nvarchar](200) NULL,
	[FromFriend] [nvarchar](200) NULL,
	[FromInternet] [nvarchar](200) NULL,
	[Other] [nvarchar](200) NULL,
 CONSTRAINT [PK_PatientPreference] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RPMReportMaster]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RPMReportMaster](
	[RPMReportID] [bigint] IDENTITY(1,1) NOT NULL,
	[DeviceID] [nvarchar](15) NULL,
	[PatientID] [bigint] NULL,
	[PatientName] [nvarchar](50) NULL,
	[BP] [int] NULL,
	[Glucose] [int] NULL,
	[MobileNumber] [nvarchar](15) NULL,
	[Status] [nchar](10) NULL,
	[Notes] [nvarchar](250) NULL,
	[CreatedDate] [datetime] NULL,
	[ReadingDateTime] [varchar](15) NULL,
 CONSTRAINT [PK_RPMReportMaster] PRIMARY KEY CLUSTERED 
(
	[RPMReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SurveyReportMaster]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyReportMaster](
	[SurveyID] [bigint] IDENTITY(1,1) NOT NULL,
	[PatientID] [bigint] NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[MRN] [nvarchar](50) NULL,
	[InitialCallDate] [datetime] NULL,
	[InitialCallAnswer] [nvarchar](50) NULL,
	[SecondCallDate] [datetime] NULL,
	[SecondCallAnswer] [nvarchar](50) NULL,
	[ThirdCallDate] [datetime] NULL,
	[ThirdCallAnswer] [nvarchar](50) NULL,
	[HRAStatus] [nvarchar](50) NULL,
	[IsMemberEligible] [nvarchar](50) NULL,
	[HRACompletedDate] [datetime] NULL,
	[LivioNurseVisit] [nvarchar](50) NULL,
	[NurseVisitScheduleDate] [datetime] NULL,
	[NurseVisitCompletionDate] [datetime] NULL,
 CONSTRAINT [PK_SurveyReportMaster] PRIMARY KEY CLUSTERED 
(
	[SurveyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Temp]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Temp](
	[PatientID] [bigint] NULL,
	[Name] [nvarchar](50) NULL,
	[MRNNumber] [nvarchar](50) NULL,
	[ClinicName] [nvarchar](50) NULL,
	[DOB] [datetime] NULL,
	[Address] [nvarchar](max) NULL,
	[Note] [nvarchar](max) NULL,
	[CCMDate] [datetime] NULL,
	[Timespent] [time](7) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Diagnosis] [nvarchar](max) NULL,
	[Minutes] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TempTable]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempTable](
	[PatientID] [bigint] NULL,
	[Name] [nvarchar](50) NULL,
	[MRNNumber] [nvarchar](50) NULL,
	[ClinicName] [nvarchar](50) NULL,
	[DOB] [datetime] NULL,
	[Address] [nvarchar](max) NULL,
	[Note] [nvarchar](max) NULL,
	[CCMDate] [datetime] NULL,
	[Timespent] [time](7) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Minutes] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserMaster]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserMaster](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Gender] [int] NULL,
	[EmailID] [nvarchar](100) NULL,
	[MobileNumber] [nvarchar](15) NULL,
	[Address] [nvarchar](250) NULL,
	[City] [nvarchar](250) NULL,
	[State] [nvarchar](250) NULL,
	[Country] [nvarchar](250) NULL,
	[Pincode] [varchar](10) NULL,
	[ClinicName] [nvarchar](250) NULL,
	[Username] [nvarchar](10) NULL,
	[Password] [nvarchar](250) NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [bigint] NULL,
	[UpdatedOn] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_UserMaster] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VitalMaster]    Script Date: 4/27/2021 4:18:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VitalMaster](
	[VitalID] [bigint] IDENTITY(1,1) NOT NULL,
	[PatientID] [bigint] NULL,
	[BloodPressure] [bigint] NULL,
	[Height] [int] NULL,
	[Pain] [int] NULL,
	[Respiration] [int] NULL,
	[Temperature] [decimal](18, 2) NULL,
	[Weight] [int] NULL,
	[ChectCircumference/Girth] [int] NULL,
	[PulseOximetry] [int] NULL,
	[Pulse] [int] NULL,
	[BloodSuger] [int] NULL,
	[AbnormalCircumference] [int] NULL,
 CONSTRAINT [PK_VitalMaster] PRIMARY KEY CLUSTERED 
(
	[VitalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[AllergyMaster] ON 

INSERT [dbo].[AllergyMaster] ([AllergyID], [PatientID], [Type], [Agent], [SNOMED], [Reaction], [Severity], [Source], [Status]) VALUES (1, 1, N'Type', N'Agent', N'Snomed', N'reaction', N'servity', N'source', N'status')
INSERT [dbo].[AllergyMaster] ([AllergyID], [PatientID], [Type], [Agent], [SNOMED], [Reaction], [Severity], [Source], [Status]) VALUES (2, 1, N'Allergy Type 1', N'Agent', N'418038007 - Propensity to adverse reactions to substance (disorder)', N'rEactiohn', N'Severity 1', N'Source 1', N'Allergy status 1')
INSERT [dbo].[AllergyMaster] ([AllergyID], [PatientID], [Type], [Agent], [SNOMED], [Reaction], [Severity], [Source], [Status]) VALUES (3, 1, N'Allergy Type 3', N'Agent 12', N'420134006 - Propensity to adverse reactions (disorder)', N'REaction1', N'Severity 3', N'Source 3', N'Allergy status 3')
INSERT [dbo].[AllergyMaster] ([AllergyID], [PatientID], [Type], [Agent], [SNOMED], [Reaction], [Severity], [Source], [Status]) VALUES (4, 1, N'Allergy Type 1', N'sss', N'419511003 - Propensity to adverse reactions to drug (disorder)', N'sdf', N'Severity 2', N'Source 2', N'Allergy status 2')
INSERT [dbo].[AllergyMaster] ([AllergyID], [PatientID], [Type], [Agent], [SNOMED], [Reaction], [Severity], [Source], [Status]) VALUES (5, 1, N'Allergy Type 3', N'Agent 12', N'420134006 - Propensity to adverse reactions (disorder)', N'REaction1', N'Severity 1', N'Source 3', N'Allergy status 3')
INSERT [dbo].[AllergyMaster] ([AllergyID], [PatientID], [Type], [Agent], [SNOMED], [Reaction], [Severity], [Source], [Status]) VALUES (6, 1, N'Drug', N'sss', N'420134006 - Propensity to adverse reactions (disorder)', N'dd', N'Mild', N'Allergy History', N'Allergy status 1')
INSERT [dbo].[AllergyMaster] ([AllergyID], [PatientID], [Type], [Agent], [SNOMED], [Reaction], [Severity], [Source], [Status]) VALUES (7, 1, N'Drug', N'sdf', N'420134006 - Propensity to adverse reactions (disorder)', N'sdf', N'Mild', N'Patient Reported', N'Allergy status 1')
INSERT [dbo].[AllergyMaster] ([AllergyID], [PatientID], [Type], [Agent], [SNOMED], [Reaction], [Severity], [Source], [Status]) VALUES (8, 1, N'Plant', N'dsdfgdfg', N'416098002 - Drug allergy (disorder)', N'sdfsdf', N'Severe', N'Transition of Care/Referral', N'Allergy status 3')
INSERT [dbo].[AllergyMaster] ([AllergyID], [PatientID], [Type], [Agent], [SNOMED], [Reaction], [Severity], [Source], [Status]) VALUES (9, 1, N'Environment', N'sdf', N'419511003 - Propensity to adverse reactions to drug (disorder)', N'sdf', N'Severe', N'Patient Reported', N'Allergy status 2')
INSERT [dbo].[AllergyMaster] ([AllergyID], [PatientID], [Type], [Agent], [SNOMED], [Reaction], [Severity], [Source], [Status]) VALUES (10007, 1, N'Drug', N'sdf', N'418038007 - Propensity to adverse reactions to substance (disorder)', N'sdf', N'Mild', N'Allergy History', N'Active')
INSERT [dbo].[AllergyMaster] ([AllergyID], [PatientID], [Type], [Agent], [SNOMED], [Reaction], [Severity], [Source], [Status]) VALUES (10008, 6, N'Food', N'Agent 1', N'414285001 - Drug allergy (disorder)', N'Reaction 1', N'Moderate', N'Patient Reported', N'Active')
INSERT [dbo].[AllergyMaster] ([AllergyID], [PatientID], [Type], [Agent], [SNOMED], [Reaction], [Severity], [Source], [Status]) VALUES (10009, 11, N'Environment', N'AGent1', N'418038007 - Propensity to adverse reactions to substance (disorder)', N'Reaction1', N'Mild', N'Patient Reported', N'Active')
INSERT [dbo].[AllergyMaster] ([AllergyID], [PatientID], [Type], [Agent], [SNOMED], [Reaction], [Severity], [Source], [Status]) VALUES (10010, 34, N'Drug', N'Agent', N'418038007 - Propensity to adverse reactions to substance (disorder)', N'Reaction', N'Mild', N'Patient Reported', N'Active')
SET IDENTITY_INSERT [dbo].[AllergyMaster] OFF
SET IDENTITY_INSERT [dbo].[CCMNoteMaster] ON 

INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (1, 1, N'Care plan management,Arrange Communication,Education,rajehq,In Med. Auth......', CAST(0x763D0B00 AS Date), N'12:59 pm', N'00:03:20', 1, 1, CAST(0x0000A79C008D3E89 AS DateTime), 1, NULL, 1, 3, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (2, 4, N'CC Social Council,CC W/ Provide,FORMs DME', CAST(0x1A3D0B00 AS Date), N'00:00:17.0000000', N'00:22:17', 1, 0, CAST(0x0000A7A10157A30E AS DateTime), 1, NULL, NULL, 22, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (3, 5, N'Test 1 Description,Review Discha,Med Reconcili', CAST(0x763D0B00 AS Date), N'4:53 pm', N'00:11:49', 1, 0, CAST(0x0000A7A10158931D AS DateTime), 1, NULL, 1, 12, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (4, 2, N'Education,CC Social Council,CC W/ Provide', CAST(0x1A3D0B00 AS Date), N'00:00:27.0000000', N'00:43:27', 1, 0, CAST(0x0000A7A101776A23 AS DateTime), 1, NULL, NULL, 43, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (5, 3, N',In Med. Auth......,Med Reconcili', CAST(0xF73C0B00 AS Date), N'00:00:15.0000000', N'00:12:15.0000000', 1, 1, CAST(0x0000A79C008D3E89 AS DateTime), 1, NULL, NULL, 12, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (6, 6, N' D', CAST(0x16420B00 AS Date), N'6:32 pm', N'00:05:32', 1, 0, CAST(0x0000A7A10157A30E AS DateTime), 1, NULL, 1, 2, N'')
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (7, 7, N'Test 1 Description,Review Discha,Med Reconcili', CAST(0x1A3D0B00 AS Date), N'00:01:35.0000000', N'00:16:35.0000000', 1, 0, CAST(0x0000A7A10158931D AS DateTime), 1, NULL, NULL, 17, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (8, 8, N'Education,Monitor Cond,Q & A', CAST(0x763D0B00 AS Date), N'5:06 pm', N'00:35:12', 1, 0, CAST(0x0000A7A101776A23 AS DateTime), 1, NULL, 1, 33, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (11, 11, N'Test 1 Description,Review Discha,Med Reconcili', CAST(0x393D0B00 AS Date), N'00:01:35.0000000', N'00:10:35.0000000', 1, 0, CAST(0x0000A7A10158931D AS DateTime), 1, NULL, NULL, 12, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (12, 12, N'Education,CC Social Council,CC W/ Provide', CAST(0x1A3D0B00 AS Date), N'00:00:27.0000000', N'00:20:27.0000000', 1, 0, CAST(0x0000A7A101776A23 AS DateTime), 1, NULL, NULL, 20, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (13, 13, N',In Med. Auth......,Med Reconcili', CAST(0x533D0B00 AS Date), N'00:00:15.0000000', N'00:12:15.0000000', 1, 1, CAST(0x0000A79C008D3E89 AS DateTime), 1, NULL, NULL, 12, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (14, 14, N'CC Social Council,CC W/ Provide,FORMs DME', CAST(0x393D0B00 AS Date), N'00:00:17.0000000', N'00:02:17.0000000', 1, 0, CAST(0x0000A7A10157A30E AS DateTime), 1, NULL, NULL, 3, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (24, 1, N'Care plan management,Arrange Communication,Education', CAST(0x523D0B00 AS Date), N'28:00', N'00:01:22.0000000', 1, 1, CAST(0x0000A79C008D3E89 AS DateTime), 1, NULL, NULL, 1, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (25, 9, N'Monitor Cond,CC W/ Provide', CAST(0x4D3D0B00 AS Date), N'1:12 am', N'00:00:27.0000000', 1, 0, CAST(0x0000A7F20013993F AS DateTime), 1, NULL, NULL, 0, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (26, 4, N'CC Social Council,CC W/ Provide,FORMs DME', CAST(0x1A3D0B00 AS Date), N'00:00:17.0000000', N'00:22:17.0000000', 1, 0, CAST(0x0000A7A10157A30E AS DateTime), 1, NULL, NULL, 22, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (27, 1, N'Education,CC Social Council,CC W/ Provide', CAST(0x533D0B00 AS Date), N'7:12 pm', N'00:00:36.0000000', 1, 0, CAST(0x0000A7F8013CC3C0 AS DateTime), 1, NULL, NULL, 1, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (28, 1, N'Review Pt Info', CAST(0x533D0B00 AS Date), N'7:14 pm', N'00:00:13.0000000', 1, 0, CAST(0x0000A7F8013D0710 AS DateTime), 1, NULL, NULL, 0, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (29, 1, N'Education', CAST(0x533D0B00 AS Date), N'9:06 pm', N'00:00:05.0000000', 1, 0, CAST(0x0000A7F8015BE0A9 AS DateTime), 1, NULL, NULL, 5, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (30, 1, N'Education,CC Social Council,CC W/ Provide', CAST(0x593D0B00 AS Date), N'8:33 am', N'00:00:08.0000000', 1, 0, CAST(0x0000A7FE008D0526 AS DateTime), 1, NULL, NULL, 0, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (31, 1, NULL, CAST(0x593D0B00 AS Date), N'8:57 am', N'00:00:11', 1, 0, CAST(0x0000A7FE00940920 AS DateTime), 1, NULL, NULL, 0, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (32, 1, N'Med Reconcili,Review Pt Info', CAST(0x593D0B00 AS Date), N'9:01 am', N'00:00:11', 1, 0, CAST(0x0000A7FE0095930A AS DateTime), 1, NULL, NULL, 0, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (33, 1, N'Review Pt Info,Med Reconcili', CAST(0x593D0B00 AS Date), N'9:18 am', N'00:00:40', 1, 0, CAST(0x0000A7FE009972BD AS DateTime), 1, NULL, NULL, 1, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (34, 1, N'Monitor Cond', CAST(0x593D0B00 AS Date), N'9:49 am', N'00:00:07', 1, 0, CAST(0x0000A7FE00A20C43 AS DateTime), 1, NULL, NULL, 0, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (35, 1, N'Self med mgmt', CAST(0x6A3D0B00 AS Date), N'12:01 am', N'00:03:03', 0, 1, CAST(0x0000A80F0000FDEB AS DateTime), 1, NULL, NULL, 3, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (36, 1, N'Med Reconcili,CC W/ Provide', CAST(0x6F3D0B00 AS Date), N'8:43 am', N'00:00:30', 1, NULL, CAST(0x0000A814009003D2 AS DateTime), 1, NULL, NULL, 0, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (37, 29, N'CC Social Council,CC W/ Provide', CAST(0x763D0B00 AS Date), N'1:06 pm', N'00:00:18', 1, NULL, CAST(0x0000A81B00D81CAE AS DateTime), 1, NULL, NULL, 0, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (38, 7, N'FORMs DME,Q & A,Review Pt Info', CAST(0x763D0B00 AS Date), N'3:44 pm', N'00:00:49', 1, NULL, CAST(0x0000A81B0103502F AS DateTime), 1, NULL, 1, 0, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (39, 27, N'CC W/ Provide,Monitor Cond', CAST(0x763D0B00 AS Date), N'5:07 pm', N'00:00:13', 1, NULL, CAST(0x0000A81B011A5BF7 AS DateTime), 1, NULL, NULL, 0, NULL)
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (40, 6, N'  Arrange Communication....test,  Education,  CC Social Council,  Arrange Communication,  Education,  CC Social Council', CAST(0x35420B00 AS Date), N'11:10 am', N'00:00:15', 1, NULL, CAST(0x0000AC86009A9AA9 AS DateTime), 1, NULL, 1, 1, N'')
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (41, 6, N'  CC W/ Provide....test', CAST(0x2D420B00 AS Date), N'10:03 am', N'00:05:08', 0, NULL, CAST(0x0000AC8600B71EB1 AS DateTime), 1, NULL, 1, 1, N'')
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (42, 6, N' , ', CAST(0x2D420B00 AS Date), N'9:59 am', N'00:02:38', 0, NULL, CAST(0x0000ACBB00A8247A AS DateTime), 1, NULL, 1, 27, N'')
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (43, 6, N' In Med. Auth......, Med Reconcili', CAST(0x16420B00 AS Date), N'10:12 am', N'00:00:13', 0, NULL, CAST(0x0000ACBB00A84EF3 AS DateTime), 1, NULL, NULL, 0, N'On Hold-Hospitalized')
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (44, 6, N' Arrange Communication, Education...Test', CAST(0x1D420B00 AS Date), N'10:04 am', N'00:00:41', 0, NULL, CAST(0x0000ACC200A64F49 AS DateTime), 1, NULL, NULL, 1, N'On Hold-Hospitalized')
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (45, 11, N' Arrange Communication...Test, Education....Test', CAST(0x1D420B00 AS Date), N'10:23 am', N'00:12:10', 1, NULL, CAST(0x0000ACC200AB5597 AS DateTime), 1, NULL, NULL, 12, N'On Hold-Hospitalized')
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (46, 6, N'  Arrange Communication.....test,  Education', CAST(0x2D420B00 AS Date), N'9:53 am', N'00:00:15', 0, NULL, CAST(0x0000ACC500BACB50 AS DateTime), 1, NULL, 1, 1, N'')
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (47, 1, N' Med Reconcili..lll, Review Discha, CCM NOTE BUTTON1, Description', CAST(0x24420B00 AS Date), N'7:19 am', N'00:00:57', 0, NULL, CAST(0x0000ACC90078E30D AS DateTime), 1, NULL, NULL, 1, N'On Hold-Hospitalized')
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (48, 1, N'  Self med mgmt....Test,  Test 1 Description', CAST(0x2D420B00 AS Date), N'10:06 am', N'00:00:20', 0, NULL, CAST(0x0000ACD200A668E9 AS DateTime), 1, NULL, 1, 0, N'')
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (49, 6, N' Self med mgmt, Test 1 Description', CAST(0x35420B00 AS Date), N'11:10 am', N'00:00:20', 0, NULL, CAST(0x0000ACDA00B81903 AS DateTime), 1, NULL, NULL, 0, N'On Hold-Home Health')
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (50, 35, N' note added, note added', CAST(0x51420B00 AS Date), N'5:47 am', N'00:01:35', 0, NULL, CAST(0x0000ACF6005F9CAD AS DateTime), 1, NULL, NULL, 2, N'')
INSERT [dbo].[CCMNoteMaster] ([CCMNoteID], [PatientID], [Description], [CCMDate], [CCMTime], [TimeSpent], [IsBillable], [IsInitialVisti], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy], [CCMMINUTES], [PatientStatus]) VALUES (51, 35, N' Monitor Cond, Review Pt Info', CAST(0x19420B00 AS Date), N'5:37 pm', N'00:00:07', 0, NULL, CAST(0x0000ACF901228D34 AS DateTime), 1, NULL, NULL, 0, N'')
SET IDENTITY_INSERT [dbo].[CCMNoteMaster] OFF
SET IDENTITY_INSERT [dbo].[CCMNotesInfoMaster] ON 

INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (1, N'Care Plan Mgmt', N'Care plan management', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (2, N'Arrange communication', N'Arrange Communication', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (3, N'Education', N'Education', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (4, N'CC Social/Council', N'CC Social Council', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (5, N'CC W/ Provide', N'CC W/ Provide', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (6, N'FORMs - DME', N'FORMs DME', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (7, N'HH Communication', N'HH Communication', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (8, N'ID Communication Residen', N'ID Communication Residen', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (9, N'In Med. Auth......', N'In Med. Auth......', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (10, N'Med Reconcili', N'Med Reconcili', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (11, N'Monitor Cond', N'Monitor Cond', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (12, N'Q & A', N'Q & A', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (13, N'Receipt - Prev', N'Receipt - Prev', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (14, N'Review Discha', N'Review Discha', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (15, N'Review Pt Info', N'Review Pt Info', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (16, N'Review Pt Info', N'Review Pt Info', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (17, N'Review/Order...', N'Review/Order....
', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (18, N'Self Med mgmt', N'Self med mgmt', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (70, N'Test CCM Note Button', N'Test CCM Note Button', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (71, N'Test CCM Note Button1', N'Test CCM Note Button1', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (72, N'Test CCM Note Button 2', N'Test CCM Note Button 2', NULL, NULL, NULL, NULL)
INSERT [dbo].[CCMNotesInfoMaster] ([CCMNoteInfoId], [CCMNoteText], [CCMNoteDescription], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn]) VALUES (73, N'CCM NOTE BUTTON 4', N'CCM NOTE BUTTON 4', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[CCMNotesInfoMaster] OFF
SET IDENTITY_INSERT [dbo].[ClinicMaster] ON 

INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (1, N'Clinic A', N'Pune
', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (2, N'Clinic B', N'Mumbai', NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (3, N'Clinic C', N'Banglore', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (4, N'Clinic D', N'Punjab', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (5, N'Clinic E', N'Hydrabad', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (6, N'Clinic 5', N'USA', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (7, N'ffffff', N'fffffff', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (8, N'CLINIC 10', N'PUNE', 1, CAST(0x0000A80500C7E015 AS DateTime), 1, CAST(0x0000A805012A2DDE AS DateTime), 1)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (9, N'Clinic 23', N'solapur', 1, CAST(0x0000A8060180C7DE AS DateTime), NULL, NULL, 1)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (10, N'sdfsdf', N'sdfsdf', 1, CAST(0x0000A8060180FB9A AS DateTime), NULL, NULL, 1)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (11, N'f', N'd', 1, CAST(0x0000A80601810EFD AS DateTime), NULL, NULL, 1)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (12, N'sdfsfd', N'sdfsdf', 1, CAST(0x0000A80601816903 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (13, N'sdfsf', N'sdfsfd', 1, CAST(0x0000A80601817706 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (14, N'dfsdf', N'sdfsdf', 1, CAST(0x0000A8060181A158 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (15, N'Clinic 10', N'sadfsaf', 1, CAST(0x0000A81101182879 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (16, N'jj', N'hh', 1, CAST(0x0000A84000AC0984 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (17, N'fdk', N'sdkl', 1, CAST(0x0000A84000AC796F AS DateTime), NULL, NULL, 1)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (18, N'Clinicxyz', N'sdfsd', 1, CAST(0x0000A87F0099F759 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (19, N'sdfsdfsdf', N'sdfsdfsdf', 1, CAST(0x0000A87F009B22C0 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (20, N'sdfsdfsdf', N'sdfsdfsdf', 1, CAST(0x0000A87F009B9D3E AS DateTime), NULL, NULL, 1)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (21, N'sdfsd', N'sdfsdfasdf', 1, CAST(0x0000A87F009BBD94 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[ClinicMaster] ([ClinicID], [Name], [Address], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (22, N'Clinic 10', N'Pune', 1, CAST(0x0000ACA0014A545D AS DateTime), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[ClinicMaster] OFF
SET IDENTITY_INSERT [dbo].[DiagnosisMaster] ON 

INSERT [dbo].[DiagnosisMaster] ([DiagnosisID], [PatientID], [DiagnosisName], [SNOMEDCT], [DiagnosisStartDate], [DiagnosisEndDate], [Source], [Status], [Occurrence], [Comment]) VALUES (1, 1, N'diag', N'sno', CAST(0x0000A87A00000000 AS DateTime), CAST(0x0000A86400000000 AS DateTime), N'Patient Reported', N'Active', N'Active', NULL)
INSERT [dbo].[DiagnosisMaster] ([DiagnosisID], [PatientID], [DiagnosisName], [SNOMEDCT], [DiagnosisStartDate], [DiagnosisEndDate], [Source], [Status], [Occurrence], [Comment]) VALUES (2, 6, N'Problem 1', N'ICD 10', CAST(0x0000AC6100000000 AS DateTime), CAST(0x0000AC9800000000 AS DateTime), N'Patient Reported', N'Active', N'Acute on Chronic', NULL)
INSERT [dbo].[DiagnosisMaster] ([DiagnosisID], [PatientID], [DiagnosisName], [SNOMEDCT], [DiagnosisStartDate], [DiagnosisEndDate], [Source], [Status], [Occurrence], [Comment]) VALUES (3, 34, N'Problem 1', N'ICD 10', CAST(0x0000ACDE00000000 AS DateTime), CAST(0x0000ACFB00000000 AS DateTime), N'Patient Reported', NULL, N'Acute on Chronic', NULL)
SET IDENTITY_INSERT [dbo].[DiagnosisMaster] OFF
SET IDENTITY_INSERT [dbo].[DoctorMaster] ON 

INSERT [dbo].[DoctorMaster] ([DoctorID], [Name], [Address], [Specility], [PhoneNo], [Email], [WebAddress], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (1, N'John Lincon', N'34, ', N'Heart ', N'4545454545', N'john@gmail.com', N'45', 1, CAST(0x0000A7B101196561 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[DoctorMaster] ([DoctorID], [Name], [Address], [Specility], [PhoneNo], [Email], [WebAddress], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (2, N'56', N'56', N'c', N'565', N'ff', NULL, 1, CAST(0x0000A7B1011A84AB AS DateTime), NULL, NULL, 1)
INSERT [dbo].[DoctorMaster] ([DoctorID], [Name], [Address], [Specility], [PhoneNo], [Email], [WebAddress], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (3, N'sdf', N'sdf', N'df', N'23', N'df', N'23', 1, CAST(0x0000A7B200678F66 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[DoctorMaster] ([DoctorID], [Name], [Address], [Specility], [PhoneNo], [Email], [WebAddress], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (4, N'sdfewwew', N'werwerwer', N'werwe', N'2423423423', N'rwer', N'234', 1, CAST(0x0000A7B20069484B AS DateTime), NULL, NULL, 1)
INSERT [dbo].[DoctorMaster] ([DoctorID], [Name], [Address], [Specility], [PhoneNo], [Email], [WebAddress], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (5, N'dfgdfg', N'sdfsadf', N'sadf', NULL, N'asdfsdf', NULL, 1, CAST(0x0000A7B2006A8D90 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[DoctorMaster] ([DoctorID], [Name], [Address], [Specility], [PhoneNo], [Email], [WebAddress], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (6, NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(0x0000A7C00006FA7A AS DateTime), NULL, NULL, 1)
INSERT [dbo].[DoctorMaster] ([DoctorID], [Name], [Address], [Specility], [PhoneNo], [Email], [WebAddress], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (7, N'Dr vijay', NULL, N'gyno', N'53423423', N'abc@gmail', N'233422', 1, CAST(0x0000A7C1012E679F AS DateTime), NULL, NULL, 1)
INSERT [dbo].[DoctorMaster] ([DoctorID], [Name], [Address], [Specility], [PhoneNo], [Email], [WebAddress], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (8, N'ssdfsdf', N'sdfsd', N'sdsdfsd', N'23234234', N'ss@g.co', N'http://yourwebsite.com', 1, CAST(0x0000A7C700D88077 AS DateTime), NULL, NULL, 1)
INSERT [dbo].[DoctorMaster] ([DoctorID], [Name], [Address], [Specility], [PhoneNo], [Email], [WebAddress], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (9, N'raj', N'sd', N's', N'2342', N'S@s.com', N'http://ww.gm', 1, CAST(0x0000A7CD0182682F AS DateTime), NULL, NULL, 1)
INSERT [dbo].[DoctorMaster] ([DoctorID], [Name], [Address], [Specility], [PhoneNo], [Email], [WebAddress], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (10, N'r', N'sdf', N'sdfsdf', N'23423', N'ss@df.com', N'http://xyz.com', 1, CAST(0x0000A805014237C5 AS DateTime), 1, CAST(0x0000A80501425149 AS DateTime), 1)
INSERT [dbo].[DoctorMaster] ([DoctorID], [Name], [Address], [Specility], [PhoneNo], [Email], [WebAddress], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (11, N'fkddkg', N'dfgk', N'dfg', N'345353', N'r@gma.om', N'http://website.com', 1, CAST(0x0000A80A0004533F AS DateTime), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[DoctorMaster] OFF
SET IDENTITY_INSERT [dbo].[InsuranceMaster] ON 

INSERT [dbo].[InsuranceMaster] ([ID], [PatientID], [Name], [PlanName], [StartDate], [EndDate], [MemberID], [GroupID]) VALUES (1, 20, N'insur', N'p', CAST(0x0000A80100000000 AS DateTime), CAST(0x0000A81200000000 AS DateTime), N'234', N'434')
INSERT [dbo].[InsuranceMaster] ([ID], [PatientID], [Name], [PlanName], [StartDate], [EndDate], [MemberID], [GroupID]) VALUES (2, 21, N'eklrq', N'dkl', CAST(0x0000A80300000000 AS DateTime), CAST(0x0000A81800000000 AS DateTime), N'sfdlk', N'dfkjl')
INSERT [dbo].[InsuranceMaster] ([ID], [PatientID], [Name], [PlanName], [StartDate], [EndDate], [MemberID], [GroupID]) VALUES (3, 24, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[InsuranceMaster] ([ID], [PatientID], [Name], [PlanName], [StartDate], [EndDate], [MemberID], [GroupID]) VALUES (4, 28, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[InsuranceMaster] ([ID], [PatientID], [Name], [PlanName], [StartDate], [EndDate], [MemberID], [GroupID]) VALUES (5, 29, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[InsuranceMaster] ([ID], [PatientID], [Name], [PlanName], [StartDate], [EndDate], [MemberID], [GroupID]) VALUES (6, 30, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[InsuranceMaster] ([ID], [PatientID], [Name], [PlanName], [StartDate], [EndDate], [MemberID], [GroupID]) VALUES (7, 31, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[InsuranceMaster] ([ID], [PatientID], [Name], [PlanName], [StartDate], [EndDate], [MemberID], [GroupID]) VALUES (8, 32, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[InsuranceMaster] ([ID], [PatientID], [Name], [PlanName], [StartDate], [EndDate], [MemberID], [GroupID]) VALUES (9, 33, N'adsf', N'asdf', CAST(0x0000A87900000000 AS DateTime), CAST(0x0000A87F00000000 AS DateTime), N'34234', N'234234')
INSERT [dbo].[InsuranceMaster] ([ID], [PatientID], [Name], [PlanName], [StartDate], [EndDate], [MemberID], [GroupID]) VALUES (10, 34, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[InsuranceMaster] OFF
SET IDENTITY_INSERT [dbo].[MedicationMaster] ON 

INSERT [dbo].[MedicationMaster] ([MedicationID], [PatientID], [Medication], [RxNorms], [Diagnosis], [Quantity], [RefillAllowed], [StartDate], [EndDate], [Source], [OrderGeneratedBy], [Provider], [Status], [Comments], [DosaseCount], [Measure], [Route], [Frequency], [Instruction]) VALUES (1, 6, N'Medication 1', N'RxNorms 1', N'Diagnosis 1', 10, NULL, NULL, NULL, N'Allergy History', NULL, NULL, N'Active', N'This is comments', N'4', N'tsp', N'Otic', N'TID', N'With Food')
INSERT [dbo].[MedicationMaster] ([MedicationID], [PatientID], [Medication], [RxNorms], [Diagnosis], [Quantity], [RefillAllowed], [StartDate], [EndDate], [Source], [OrderGeneratedBy], [Provider], [Status], [Comments], [DosaseCount], [Measure], [Route], [Frequency], [Instruction]) VALUES (2, 6, N'Medication 2', N'RxNorms 2', N'Diagnosis 2', 20, N'12', CAST(0x0000ACA600000000 AS DateTime), NULL, N'Allergy History', N'order Gen', N'Provider 1', N'Active', N'Comments', N'2', N'Spray(s)', N'Topical', N'Q2', N'Sparingly')
INSERT [dbo].[MedicationMaster] ([MedicationID], [PatientID], [Medication], [RxNorms], [Diagnosis], [Quantity], [RefillAllowed], [StartDate], [EndDate], [Source], [OrderGeneratedBy], [Provider], [Status], [Comments], [DosaseCount], [Measure], [Route], [Frequency], [Instruction]) VALUES (3, 11, N'Medication 1', N'RxNorms 1', N'Diagnosis 1', 10, N'12', CAST(0x0000ACC200000000 AS DateTime), CAST(0x0000ACC200000000 AS DateTime), N'Allergy History', N'order Gen', N'Provider 1', N'Active', N'Test', N'4', N'mg', N'Sublingual', N'Q4', N'Sparingly')
INSERT [dbo].[MedicationMaster] ([MedicationID], [PatientID], [Medication], [RxNorms], [Diagnosis], [Quantity], [RefillAllowed], [StartDate], [EndDate], [Source], [OrderGeneratedBy], [Provider], [Status], [Comments], [DosaseCount], [Measure], [Route], [Frequency], [Instruction]) VALUES (4, 34, N'Medication 1', N'RxNorms 1', N'Diagnosis 1', 10, N'12', CAST(0x0000ACDE00000000 AS DateTime), CAST(0x0000ACEC00000000 AS DateTime), NULL, N'order Gen', N'Provider 1', N'Discontinued', N'test', N'1-2', N'Capsule', N'Subq', N'Q1', N'Sparingly')
SET IDENTITY_INSERT [dbo].[MedicationMaster] OFF
SET IDENTITY_INSERT [dbo].[MST_City] ON 

INSERT [dbo].[MST_City] ([CityID], [CityName], [RegionID], [CountryID]) VALUES (1, N'Mumbai', 1, 1)
INSERT [dbo].[MST_City] ([CityID], [CityName], [RegionID], [CountryID]) VALUES (2, N'Pune', 1, 1)
INSERT [dbo].[MST_City] ([CityID], [CityName], [RegionID], [CountryID]) VALUES (3, N'karnatak', 2, 1)
INSERT [dbo].[MST_City] ([CityID], [CityName], [RegionID], [CountryID]) VALUES (4, N'Chandigad', 3, 1)
SET IDENTITY_INSERT [dbo].[MST_City] OFF
INSERT [dbo].[MST_Countries] ([CountryID], [Country], [FIPS104], [ISO2], [ISO3], [ISON], [Internet], [Capital], [MapReference], [NationalitySingular], [NationalityPlural], [Currency], [CurrencyCode], [Poppulation], [Title], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [DeleteFlag]) VALUES (1, N'India', NULL, NULL, NULL, NULL, NULL, N'Delhi', NULL, N'', NULL, NULL, NULL, NULL, N'India', NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[MST_Regions_State] ([RegionID], [CountryID], [Region], [Code], [ADM1Code], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [DeleteFlag]) VALUES (1, 1, N'Maharashtra', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[MST_Regions_State] ([RegionID], [CountryID], [Region], [Code], [ADM1Code], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [DeleteFlag]) VALUES (2, 1, N'Karnataka', NULL, NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[MST_Regions_State] ([RegionID], [CountryID], [Region], [Code], [ADM1Code], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [DeleteFlag]) VALUES (3, 1, N'Punjab', NULL, NULL, NULL, NULL, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[PatientMaster] ON 

INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (1, N'Sagar', N'S', N'Mane', 1, CAST(0x00007CD700000000 AS DateTime), 0, N'7897897897', N'Clinic A', N'A-', N'Mahatama Gadhi Road', N'Mumbai', N'Maharashtra', N'India', N'413441', NULL, NULL, NULL, NULL, 1, N'sdsf', N'On Hold-Hospitalized', N'2342342342', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'DWYUYT1', NULL, NULL, NULL, NULL, CAST(0x0000ACA400000000 AS DateTime))
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (2, N'Anil', N'S', N'Patil', 1, CAST(0x00007D7900000000 AS DateTime), 30, N'4567891311', N'Clinic B', N'A+', N'Pune', N'Pune', N'Maharashtra', N'India', N'45645678', NULL, NULL, NULL, NULL, 1, NULL, N'On Hold-Hospitalized', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'FGRDAY7', NULL, NULL, NULL, NULL, CAST(0x0000ACA500000000 AS DateTime))
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (3, N'Aarti', N'R', N'Kumbhare', 2, CAST(0x0000892C00000000 AS DateTime), 20, N'7845454545', N'Clinic C', N'AB-', N'Pune', N'Mumbai', N'Maharashtra', N'India', N'123546', NULL, NULL, NULL, NULL, 1, NULL, N'Enrolled', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'YUYYRS4', NULL, NULL, NULL, NULL, CAST(0x0000ACA600000000 AS DateTime))
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (4, N'Snehal', N'R', N'Nalawade', 1, CAST(0x00007C0100000000 AS DateTime), 30, N'9986898978', N'Clinic D', N'AB+', N'Pune', N'karnatak', N'Karnataka', N'India', N'5612345', NULL, NULL, NULL, NULL, 1, NULL, N'On Hold-Hospitalized', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'GDASL4D', NULL, NULL, NULL, NULL, CAST(0x0000ACC300000000 AS DateTime))
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (5, N'Achal', N'S', N'Sawariya', 1, CAST(0x0000916B00000000 AS DateTime), 17, N'8797898787', N'Clinic E', N'O+', N'Pune', N'Pune', N'Maharashtra', N'India', N'456457', NULL, NULL, NULL, NULL, 1, NULL, N'On Hold-Home Health', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'VBGHJS4', NULL, NULL, NULL, NULL, CAST(0x0000ACC400000000 AS DateTime))
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (6, N'Reshma', N'R', N'Kulkarni', 2, CAST(0x00008A0C00000000 AS DateTime), 21, N'2334454545', N'Clinic A', N'O-', N'Punr', N'Mumbai', N'Maharashtra', N'India', N'7897877777', NULL, NULL, NULL, NULL, 1, NULL, N'On Hold-Home Health', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'OIEWZKJ7', NULL, NULL, NULL, NULL, CAST(0x0000ACC400000000 AS DateTime))
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (7, N'Ashwini', N'S', N'Kulal', 2, CAST(0x00008F4700000000 AS DateTime), 17, N'4561231234', N'Clinic B', N'B+', N'Kolhapur', N'Mumbai', N'Maharashtra', N'India', N'561234564', NULL, NULL, NULL, NULL, 1, NULL, N'On Hold-Home Health', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'BVSEZCK', NULL, NULL, NULL, NULL, CAST(0x0000ACC400000000 AS DateTime))
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (8, N'Vijaykumar', N'S', N'Swami', 2, CAST(0x00008D0900000000 AS DateTime), 19, N'7895467897', N'Clinic C', N'B-', N'Pune', N'Pune', N'Maharashtra', N'India', N'7897897897', NULL, NULL, NULL, NULL, 1, NULL, N'On Hold-Hospitalized', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'VCZUDX6', NULL, NULL, NULL, NULL, CAST(0x0000ACC400000000 AS DateTime))
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (9, N'Ravi', N'R', N'Pawar', 1, CAST(0x00006D4A00000000 AS DateTime), 40, N'7897897878', N'Clinic D', N'A-', N'Kochi', N'Chandigad', N'Punjab', N'India', N'7897897897', NULL, NULL, NULL, NULL, 1, NULL, N'Discharged from CCM-other reason', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'VCXHJ79', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (10, N'Rupali', N'V', N'Hundekari', 1, CAST(0x0000738000000000 AS DateTime), 37, N'892342423422', N'Clinic E', N'AB+', N'Pune', N'Pune', N'Maharashtra', N'India', N'789789', NULL, NULL, NULL, NULL, 1, NULL, N'Declined', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'XCVKJY7', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (11, N'Sandy', NULL, N'Sharma', 0, CAST(0x0000790200000000 AS DateTime), 0, N'9637128866', N'Clinic A', N'A+', NULL, N'Pune', N'Maharashtra', N'India', N'411014', NULL, NULL, NULL, NULL, 1, NULL, N'Enrolled', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'GHHJKKL', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (12, N'Steve ', NULL, N'Jobs', 1, CAST(0x00005DE400000000 AS DateTime), 55, N'8938894955', N'Clinic B', N'0', NULL, N'Mumbai', N'Maharashtra', N'India', NULL, NULL, NULL, NULL, NULL, 1, NULL, N'On TCM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'VBMNKJL', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (13, N'Charu', NULL, N'Sharma', 1, CAST(0x0000415A00000000 AS DateTime), 45, N'9876776776', N'Clinic C', N'0', NULL, N'Mumbai', N'Maharashtra', N'India', N'3433445', NULL, NULL, NULL, NULL, 1, NULL, N'On Hold-Home Health', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'XGFHKJM', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (14, N'Sonu', NULL, N'Sharma', 2, CAST(0x0000914000000000 AS DateTime), 27, N'887939445', NULL, N'AB-', NULL, N'Mumbai', N'Maharashtra', N'India', N'4110101', NULL, NULL, NULL, NULL, 1, NULL, N'Discharged from CCM-other reason', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'BCTRAH', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (15, N'Suraj', N'Shivaji', N'Khote', 1, CAST(0x00007BCD00000000 AS DateTime), 0, N'234234234234', N'Clinic D', N'B', N'Pune', N'Pune', N'Maharashtra', N'India', N'41223234', NULL, NULL, NULL, NULL, 1, N'Rajesh,Madhava,Vijaykumar', N'On Hold-Home Health', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'TYIODFSI', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (18, N'ssdf', NULL, N'sdf', 0, CAST(0x0000A7AC00000000 AS DateTime), 0, N'234234234', N'Clinic A', N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, N'234,erwer', N'0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'RESFGHK', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (19, N'Abc', N'pqr', N'Xyz', 1, CAST(0x0000865A00000000 AS DateTime), 0, N'90909099090', N'ssf', NULL, N'address line 1', N's', N'd', N'd', N'35345', 1, CAST(0x0000A803018B7EC6 AS DateTime), NULL, NULL, 1, N'sfd', N'Enrolled', N'Mrn0123123', N'rj@gmail.com', N'234234234', N'234234234', N'Marthi', N'English', N'Ashiayan', N'Single', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'UIOTVKJK', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (20, N'hjsdafjk', N'sdf', N'sdf', 1, CAST(0x0000A80D00000000 AS DateTime), 0, N'34234', N'Clinic 5, Clinic C,', NULL, N'sd', N'Mumbai', N'Maharashtra', N'India', N'234234', 1, CAST(0x0000A806011C4337 AS DateTime), NULL, NULL, 1, N'raj, sdf,', N'Enrolled', N'sdf', N'rajvhadlure@gmail.com', N'234890234', N'89034', N'englsih', N'martahi', N'ajkdfjks', N'Divorced', N'rupesh', N'bro', N'sdjklf', N'sks', N'sjf', N'234234', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'YUGGGCV', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (21, N'Rajesh', N's', N'Vhadlur', 1, CAST(0x0000A81100000000 AS DateTime), 0, N'224234', N's', NULL, N'sdklf', N'dsjkl', N'sdfjk', N'sdkjf', N'23', 1, CAST(0x0000A80901647F6C AS DateTime), NULL, NULL, 1, N'John Lincon-4545454545,', N'Enrolled', N'32423', N'rajvhadlure@gmail.com', N'ksdfkasf', N'skljdfkj', N'dsjjk', N'sdfkjsaj', N'sdkmlf', N'Divorced', N'sdkfl', N'dsfjk', N'dsfkjl', N'sdfjkl', N'dfsjkl', N'sdjklf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'POIUOUOI', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (22, N'sdf', N'd', N'sdf', 2, CAST(0x00004C2900000000 AS DateTime), 0, N'2323232322', N'sdfsdf', N'', N'sdfsdf', N'sdfsd', N'sdf', N'sdf', N'23234', 1, CAST(0x0000A80D00F0F067 AS DateTime), NULL, NULL, 1, N'', N'sdf', N'sdfsdf', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'RTYUGHSF', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (23, N'jdfskldf', N'sfsdf', N'sfdsdf', 1, CAST(0x0000A80D013150E7 AS DateTime), 0, N'234234234', N'Clinic A,', NULL, N'd', N'sdf', N'd', N'df', N'4234', 1, CAST(0x0000A80D013150E7 AS DateTime), NULL, NULL, 1, N'sd', N'Enrolled', N'sdfsdf', N'sk@gma.com', N'sdfkl', N'324234`', N'sfd', N'sd', N'jkf', N'Divorced', N'234', N'sdf', N'sdf', N'sdf', N'dfs', N'dfs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'HYUDXGK', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (24, N'raj', N'', N'vhadlure', 1, CAST(0x0000A80D0132CABA AS DateTime), 1, N'1234567894', N'sd', NULL, N'111, sdf hm, ghghghg', N'sd', N'sd', N'sdsd', N'sdsds', NULL, CAST(0x0000A80D0132CABA AS DateTime), NULL, NULL, 1, NULL, N'sdsdsd', N'sdsd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'GFYUDSYU', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (25, N'Rajesh', N'Shivarya', N'Vhadlure', 1, NULL, NULL, N'7787878787', NULL, NULL, N'Solapur', N'Solapur', N'Maharashtra', N'India', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'GHOUDFS', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (26, N'Shrishal', N'M', N'Bodhale', 1, NULL, NULL, N'23424234', N'sd', NULL, N'sdfs', N'sd', N'd', N'sd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Enrolled', N'MRn1010', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'HGOIPRT', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (27, N'ksd', N'sf', N'sdf', 1, NULL, NULL, N'234234234', N'', NULL, N'dsf', N'fs', N'sdf', N'f', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'On Hold-Hospitalized', N'sdf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'GHILHPP', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (28, N'kjdg', N'dd', N'dg', 1, NULL, NULL, N'24232', N'sdfsdf,', NULL, N'assd', N'Mumbai', N'Maharashtra', N'India', N'23', NULL, NULL, NULL, NULL, NULL, NULL, N'On Hold-Hospitalized', N'dfg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'XFUYSHJO', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (29, N'jsjs', N'sjsj', N'sjs', 1, CAST(0x0000A70D00000000 AS DateTime), NULL, N'232323', N'Clinic A,', NULL, N'sdf', N'sdf', N'dsf', N'sdf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'0', N'sjs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'GHYUKGH', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (30, N'ankita ', NULL, N'habbu', 2, CAST(0x00007AB300000000 AS DateTime), 31, N'787897897787', N'df', NULL, N'fdsf', N'df', N'dsf', N'dfs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Enrolled', N'MRn1212', NULL, NULL, NULL, NULL, NULL, N'df', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'CVFYTDYRTS', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (31, N'dksdf', N'sdf', N'dsf', 1, CAST(0x0000A7FB00000000 AS DateTime), 0, N'234234234', N'sd', NULL, N'sdf', N'dsf', N'df', N'dsf', N'234', NULL, NULL, NULL, NULL, NULL, NULL, N'On Hold-Home Health', N'sdf', N'r@gma.com', NULL, NULL, NULL, NULL, N'sdf', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'GKIYOYU', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (32, N'sdf', NULL, N'sdf', 1, CAST(0x0000A85B00000000 AS DateTime), 0, N'234234', N'sdfsf,', NULL, N'sdf', N'sdf', N'Maharashtra', N'sdf', N'324', 1, CAST(0x0000A8780101BEF1 AS DateTime), NULL, NULL, NULL, N'John Lincon-4545454545,', N'New', N'sdf', N'r.vhadl@gmail.com', N'234234', N'234234', N'sdf', N'sdf', N'sdf', N'Divorced', N'sdf', N'sdf', N'sdf', N'sdf', N'sdf', N'sdf', N'sdf', N'sdf', N'sdf', N'Comments', N'Guardian name', N'234234', 0, N'SSN', NULL, N'TSYIHGH', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (33, N'sdsdf', N'sdfdfs', N'sdf', 1, CAST(0x0000A87900000000 AS DateTime), 0, N'234234234234', N'sdfsdf,', NULL, N'sdf', N'Pune', N'Maharashtra', N'India', N'34', 1, CAST(0x0000A87F009AC26C AS DateTime), NULL, NULL, 1, N'John Lincon-4545454545,', N'Active', N'sdffdfd', N'rajvh.cg@gmail.com', N'sdf', N'asdf', N'sdf', N'sdf', N'Hispanic/ Latino', N'Divorced', N'asdf', N'asdf', N'asdf', N'sdf', N'afd', N'adf', N'Asian', N'34234234', N'234234234', N'sdfsdf', N'sdfsdf', N'34234', 0, N'sdfsdf', N'dfd', N'ZGDDHK', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (34, N'Rajesh', NULL, N'Vhadlure', 1, CAST(0x0000ACDE00000000 AS DateTime), 0, NULL, N'Clinic A', NULL, NULL, N'Mumbai', NULL, NULL, NULL, 1, CAST(0x0000ACEC0068D3DB AS DateTime), NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, N'BKJJKKLL', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (35, N'Manasvi', NULL, N'Vhadlure', 1, CAST(0x0000ACDE00000000 AS DateTime), 0, NULL, N'Clinic A', NULL, NULL, N'Mumbai', N'Maharashtra', N'India', N'413223', 1, CAST(0x0000ACF200743DD0 AS DateTime), NULL, NULL, 1, NULL, NULL, NULL, N'mark@gmail.com', NULL, NULL, N'English', N'Marathi', N'Hispanic/ Latino', N'Domestic Partner', NULL, NULL, NULL, NULL, NULL, NULL, N'American Indian or Alaska Native', N'0217-200000', NULL, NULL, NULL, NULL, 0, NULL, NULL, N'DHGKJKL', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (36, N'Mansi', NULL, N'Shinde', 1, CAST(0x0000ACE200000000 AS DateTime), 0, NULL, N'Clinic B, ', NULL, NULL, N'Mumbai', N'Maharashtra', N'India', N'413223', 1, CAST(0x0000ACF6006523CF AS DateTime), NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, N'English', NULL, N'Hispanic/ Latino', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Asian', N'0217-200000', NULL, NULL, NULL, NULL, 0, NULL, NULL, N'HDGHJHK', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (37, N'Rajesh', NULL, N'Vhadlure', 1, CAST(0x0000ACE200000000 AS DateTime), 0, NULL, N'Clinic', NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(0x0000ACF60073AC14 AS DateTime), NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, N'GHYJGJ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (38, N'Rajesh', NULL, N'Vhadlure', 1, CAST(0x0000ACE200000000 AS DateTime), 0, NULL, N'Clinic E', NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(0x0000ACF60074E7C8 AS DateTime), NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, N'YUOPUU', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (39, N'Manasvi', NULL, N'Vhadlure', 1, CAST(0x0000ACDE00000000 AS DateTime), 0, NULL, N'Clinic C, Clinic E', NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(0x0000ACF60075094A AS DateTime), NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, N'DTFKGJ', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (40, N'test', NULL, N'sdfdf', 1, CAST(0x0000ACDE00000000 AS DateTime), 0, NULL, N'Clinic A', NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(0x0000ACF60075428F AS DateTime), NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, N'FYUGGKUK', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (41, N'Test Device', NULL, N'Vhadlure', 1, CAST(0x0000ACE200000000 AS DateTime), 0, NULL, N'Clinic A', NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(0x0000ACF6007DBB27 AS DateTime), 1, CAST(0x0000ACF600845D13 AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, N'ADFGSGF', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PatientMaster] ([PatientID], [FirstName], [MiddleName], [LastName], [Gender], [DOB], [Age], [MobileNumber], [ClinicName], [BloodGroup], [Address], [City], [State], [COUNTRY], [PostalCode], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive], [DoctorsName], [StatusName], [MRNNumber], [Email], [PrimaryContactNumber], [AlternateContactNumber], [PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus], [EmergencyName1], [EmergencyRelationship1], [EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2], [Races], [HomePhone], [CellPhone], [Comments], [GuardianName], [DriverLicenseID], [DriverLicenseState], [SSN], [CustomPatientID], [DeviceId], [LowBPLimit], [HighBPLimit], [LowGlucoseLimit], [HighGlucoseLimit], [DeviceReceivedDate]) VALUES (42, N'Rajesh', NULL, N'Vhadlure', 1, CAST(0x0000ACA800004650 AS DateTime), 0, NULL, N'Clinic A', NULL, NULL, NULL, NULL, NULL, NULL, 1, CAST(0x0000ACF700C89E1E AS DateTime), 1, CAST(0x0000AD03004B3BC6 AS DateTime), 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, N'CGHHJ', 69, 122, 78, 155, CAST(0x0000ACC400000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[PatientMaster] OFF
SET IDENTITY_INSERT [dbo].[RPMReportMaster] ON 

INSERT [dbo].[RPMReportMaster] ([RPMReportID], [DeviceID], [PatientID], [PatientName], [BP], [Glucose], [MobileNumber], [Status], [Notes], [CreatedDate], [ReadingDateTime]) VALUES (2, N'DWYUYT1', 1, N'Sagar Mane', 45, 112, N'7897897897', N'Critical  ', N'Test1', CAST(0x0000ACFB00000000 AS DateTime), NULL)
INSERT [dbo].[RPMReportMaster] ([RPMReportID], [DeviceID], [PatientID], [PatientName], [BP], [Glucose], [MobileNumber], [Status], [Notes], [CreatedDate], [ReadingDateTime]) VALUES (3, N'FGRDAY7', 2, N'Anil Patil', 67, 109, N'4567891311', N'Normal    ', N'Test 2', CAST(0x0000ACFB00000000 AS DateTime), NULL)
INSERT [dbo].[RPMReportMaster] ([RPMReportID], [DeviceID], [PatientID], [PatientName], [BP], [Glucose], [MobileNumber], [Status], [Notes], [CreatedDate], [ReadingDateTime]) VALUES (4, N'YUYYRS4', 3, N'Aarti Kumbhar', 69, 98, N'7845454545', N'Normal    ', N'Test 3', CAST(0x0000ACFB00000000 AS DateTime), NULL)
INSERT [dbo].[RPMReportMaster] ([RPMReportID], [DeviceID], [PatientID], [PatientName], [BP], [Glucose], [MobileNumber], [Status], [Notes], [CreatedDate], [ReadingDateTime]) VALUES (5, N'GDASL4D', 4, N'Snehal Nalawade', 78, 87, N'9986898978', N'Normal    ', N'Test 4', CAST(0x0000ACFB00000000 AS DateTime), NULL)
INSERT [dbo].[RPMReportMaster] ([RPMReportID], [DeviceID], [PatientID], [PatientName], [BP], [Glucose], [MobileNumber], [Status], [Notes], [CreatedDate], [ReadingDateTime]) VALUES (6, N'VBGHJS4', 5, N'Achal Sawariya', 89, 99, N'8797898787', N'Normal    ', N'Test 5', CAST(0x0000ACFB00000000 AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[RPMReportMaster] OFF
SET IDENTITY_INSERT [dbo].[SurveyReportMaster] ON 

INSERT [dbo].[SurveyReportMaster] ([SurveyID], [PatientID], [FirstName], [LastName], [MRN], [InitialCallDate], [InitialCallAnswer], [SecondCallDate], [SecondCallAnswer], [ThirdCallDate], [ThirdCallAnswer], [HRAStatus], [IsMemberEligible], [HRACompletedDate], [LivioNurseVisit], [NurseVisitScheduleDate], [NurseVisitCompletionDate]) VALUES (1, 1, N'Sagard', N'Mane', N'2342342342', CAST(0x0000A9AD00000000 AS DateTime), N'Patient', CAST(0x0000A9AE00000000 AS DateTime), N'Patient', CAST(0x0000A9BC00000000 AS DateTime), N'Patient', N'Member declined Phone HRA', N'YES', CAST(0x0000A9C200000000 AS DateTime), N'YES', CAST(0x0000A9BA00000000 AS DateTime), CAST(0x0000A9C900000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[SurveyReportMaster] OFF
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (1, N'Sagard Mane - 7897897897', N'2342342342', N'Clinic A', CAST(0x00007CD700000000 AS DateTime), N'Mahatama Gadhi Road', N'Care plan management,Arrange Communication,Education', CAST(0x0000A7F600000000 AS DateTime), CAST(0x07003D8F60000000 AS Time), N'Admin Admin', N'Diagnosis, BLood', 2)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (4, N'Snehal Nalawade - 9986898978', NULL, N'Clinic A', CAST(0x00007C0100000000 AS DateTime), N'Pune', N'CC Social Council,CC W/ Provide,FORMs DME', CAST(0x0000A7BF00000000 AS DateTime), CAST(0x078002EA1C030000 AS Time), N'Admin Admin', NULL, 22)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (5, N'Achal Sawariya - 8797898787', NULL, N'Clinic A', CAST(0x0000916B00000000 AS DateTime), N'Pune', N'Test 1 Description,Review Discha,Med Reconcili', CAST(0x0000A7DE00000000 AS DateTime), CAST(0x078095409E010000 AS Time), N'Admin Admin', NULL, 11)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (2, N'Anil Patil - 4567891311', NULL, N'Clinic A', CAST(0x00007D7900000000 AS DateTime), N'Pune', N'Education,CC Social Council,CC W/ Provide', CAST(0x0000A7BF00000000 AS DateTime), CAST(0x0780A1E411060000 AS Time), N'Admin Admin', NULL, 43)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (3, N'Aarti Kumbhare - 7845454545', NULL, N'Clinic A', CAST(0x0000892C00000000 AS DateTime), N'Pune', N',In Med. Auth......,Med Reconcili', CAST(0x0000A79C00000000 AS DateTime), CAST(0x07801918B6010000 AS Time), N'Admin Admin', NULL, 12)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (6, N'Reshma Kulkarni - 2334454545', NULL, N'Clinic B', CAST(0x00008A0C00000000 AS DateTime), N'Punr', N'CC Social Council,CC W/ Provide,FORMs DME', CAST(0x0000A7DE00000000 AS DateTime), CAST(0x07808AA851000000 AS Time), N'Admin Admin', NULL, 2)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (7, N'Ashwini Kulal - 4561231234', NULL, N'Clinic B', CAST(0x00008F4700000000 AS DateTime), N'Kolhapur', N'Test 1 Description,Review Discha,Med Reconcili', CAST(0x0000A7BF00000000 AS DateTime), CAST(0x0780F31051020000 AS Time), N'Admin Admin', NULL, 16)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (8, N'Vijaykumar Swami - 7895467897', NULL, N'Clinic B', CAST(0x00008D0900000000 AS DateTime), N'Pune', N'Education,CC Social Council,CC W/ Provide', CAST(0x0000A7DE00000000 AS DateTime), CAST(0x0780E543AC040000 AS Time), N'Admin Admin', NULL, 33)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (11, N'Sandy Sharma - 9637128866', NULL, N'Clinic A', CAST(0x0000790200000000 AS DateTime), NULL, N'Test 1 Description,Review Discha,Med Reconcili', CAST(0x0000A7DE00000000 AS DateTime), CAST(0x07804F7D7A010000 AS Time), N'Admin Admin', NULL, 10)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (12, N'Steve  Jobs - 8938894955', NULL, N'Clinic C', CAST(0x00005DE400000000 AS DateTime), NULL, N'Education,CC Social Council,CC W/ Provide', CAST(0x0000A7BF00000000 AS DateTime), CAST(0x07805759DB020000 AS Time), N'Admin Admin', NULL, 20)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (13, N'Charu Sharma - 9876776776', NULL, N'Clinic C', CAST(0x0000415A00000000 AS DateTime), NULL, N',In Med. Auth......,Med Reconcili', CAST(0x0000A7F800000000 AS DateTime), CAST(0x07801918B6010000 AS Time), N'Admin Admin', NULL, 12)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (14, N'Sonu Sharma - 887939445', NULL, NULL, CAST(0x0000914000000000 AS DateTime), NULL, N'CC Social Council,CC W/ Provide,FORMs DME', CAST(0x0000A7DE00000000 AS DateTime), CAST(0x07808AA851000000 AS Time), N'Admin Admin', NULL, 2)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (1, N'Sagard Mane - 7897897897', N'2342342342', N'Clinic A', CAST(0x00007CD700000000 AS DateTime), N'Mahatama Gadhi Road', N'Care plan management,Arrange Communication,Education', CAST(0x0000A7F700000000 AS DateTime), CAST(0x070035E030000000 AS Time), N'Admin Admin', N'Diagnosis, BLood', 1)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (9, N'Ravi Pawar - 7897897878', NULL, N'Clinic B', CAST(0x00006D4A00000000 AS DateTime), N'Kochi', N'Monitor Cond,CC W/ Provide', CAST(0x0000A7F200000000 AS DateTime), CAST(0x0780DF1710000000 AS Time), N'Admin Admin', NULL, 0)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (4, N'Snehal Nalawade - 9986898978', NULL, N'Clinic A', CAST(0x00007C0100000000 AS DateTime), N'Pune', N'CC Social Council,CC W/ Provide,FORMs DME', CAST(0x0000A7BF00000000 AS DateTime), CAST(0x078002EA1C030000 AS Time), N'Admin Admin', NULL, 22)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (1, N'Sagard Mane - 7897897897', N'2342342342', N'Clinic A', CAST(0x00007CD700000000 AS DateTime), N'Mahatama Gadhi Road', N'Education,CC Social Council,CC W/ Provide', CAST(0x0000A7F800000000 AS DateTime), CAST(0x07002A7515000000 AS Time), N'Admin Admin', N'Diagnosis, BLood', 0)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (1, N'Sagard Mane - 7897897897', N'2342342342', N'Clinic A', CAST(0x00007CD700000000 AS DateTime), N'Mahatama Gadhi Road', N'Review Pt Info', CAST(0x0000A7F800000000 AS DateTime), CAST(0x0780A4BF07000000 AS Time), N'Admin Admin', N'Diagnosis, BLood', 0)
INSERT [dbo].[Temp] ([PatientID], [Name], [MRNNumber], [ClinicName], [DOB], [Address], [Note], [CCMDate], [Timespent], [CreatedBy], [Diagnosis], [Minutes]) VALUES (1, N'Sagard Mane - 7897897897', N'2342342342', N'Clinic A', CAST(0x00007CD700000000 AS DateTime), N'Mahatama Gadhi Road', N'Education', CAST(0x0000A7F800000000 AS DateTime), CAST(0x0780F0FA02000000 AS Time), N'Admin Admin', N'Diagnosis, BLood', 0)
SET IDENTITY_INSERT [dbo].[UserMaster] ON 

INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (1, N'Admin', NULL, N'Admin', 1, N'admin@gmail.com', NULL, N'Pune', N'Pune', N'Maharashtra', N'India', N'9890601545', N'Clinic A', N'admin', N'7QIGM2Z0tmvcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (2, N'Rajesh', N'S', N'Vhadlure', 1, N'rajvhadlure@gmail.com', N'8797878774545', N'Pune', N'Pune', N'Maharashtra', N'India', N'7391821943', N'Clinic A, Clinic B', N'Rajesh.Vha', N'7QIGM2Z0tmvcpNLjA2lfvQ==', NULL, NULL, 1, CAST(0x0000A80500D8047D AS DateTime), 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (3, N'Vijay', NULL, N'Gaur', 1, N'vijayendra.gaur@gmail.com', N'987885554', NULL, N'Pune', NULL, N'India', NULL, N'Clinic B', N'Vijay.Gaur', N'mxMxcFSexwyTVtgPFKs/6A==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (4, N'Sujata', NULL, N'K', 0, N'sujata@gmail.com', N'553543534', NULL, NULL, N'Maharashtra', N'India', NULL, N'Clinic C', N'Sujata.K', N'bQuqhjKeBv2TVtgPFKs/6A==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (5, N'Rajesh', N'S', N'Vhadlure', 1, N'rajvhadlure@gmail.com', N'7721017722', NULL, NULL, NULL, NULL, NULL, NULL, N'Rajesh.Vha', N'PPoV/izI1+CTVtgPFKs/6A==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (6, N'vijay', NULL, N'gaur', 1, N'vijay@gmail.com', N'838385', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'WdiN6onsHFKTVtgPFKs/6A==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (7, N'Vijay', NULL, N'Gaur', 0, N'vijayendra.gaur@gmail.com', N'9633883384', NULL, NULL, NULL, NULL, NULL, NULL, N'Vijay.Gaur', N'144U93tEBbeTVtgPFKs/6A==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (8, N'Rudresh', NULL, N'Vhadlure', 1, N'vhadlure@gmail.com', N'4564564545', NULL, NULL, NULL, NULL, NULL, NULL, N'Rudresh.Vh', N'Dp9Tt6rAV1+TVtgPFKs/6A==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (10, N'Vijay', NULL, N'Gaur', 0, N'vijayendra.gaur@gmail.com', N'23423423243', NULL, NULL, NULL, NULL, NULL, NULL, N'Vijay.Gaur', N'jz4nauBUiR7cpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (11, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'9637128866', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'euY35XbE3+jcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (12, N'Vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'434343', NULL, NULL, NULL, NULL, NULL, NULL, N'Vijay.gaur', N'4w7y212eKU/cpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (13, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'5345', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'5KobCZB3FuPcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (14, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'34234', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'QrW3M0DL3EPcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (15, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'9388383', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'w+405lcGYFncpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (16, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'53453', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'hBSVD/RJ/RHcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (17, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'423423', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'b2apDmFi9hvcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (18, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'5665', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'Ipr85zaPbgrcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (19, N'vj', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'42423', NULL, NULL, NULL, NULL, NULL, NULL, N'vj.gaur', N'/j9XYJ5N2NfcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (20, N'vij', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'4543', NULL, NULL, NULL, NULL, NULL, NULL, N'vij.gaur', N'L9tYdv7jtoXcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (21, N'vij', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'4534', NULL, NULL, NULL, NULL, NULL, NULL, N'vij.gaur2', N'/TX2O3ffE2PcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (22, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'542342', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'wElWKxmmxXzcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (23, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'534345', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'p5gZRwsv0AfcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (24, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'534', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'2gdTD/MA4fPcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (25, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'42343', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'0lhPxp4AWQ7cpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (26, N'vij', NULL, N'garu', 0, N'vijayendra.gaur@gmail.com', N'34532423423', NULL, NULL, NULL, NULL, NULL, NULL, N'vij.garu', N'FPnBL/4hb93cpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (27, N'vij', NULL, N'gaur', 1, N'vijayendra.gaur@gmail.com', N'2432423', NULL, NULL, NULL, NULL, NULL, NULL, N'vij.gaur2', N'iuDVIe2RJf/cpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (28, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'4543532', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'whT2IGBFyKncpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (29, N'vij', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'53453', NULL, NULL, NULL, NULL, NULL, NULL, N'vij.gaur2', N'IL2IGfMnkDzcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (30, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'45345', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'BR0KEUoFzXzcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (31, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'98353', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'eCA2uVYJjIDcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (32, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'985445', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'foECKntuv9HcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (33, N'sonu', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'7989', NULL, NULL, NULL, NULL, NULL, NULL, N'sonu.gaur', N'oQrTzKN3+djcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (34, N'vij', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'353453', NULL, NULL, NULL, NULL, NULL, NULL, N'vij.gaur2', N'2ql0xJW6lzXcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (35, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'453453', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'CWyMkMKxOojcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (36, N'vj', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'34234', NULL, NULL, NULL, NULL, NULL, NULL, N'vj.gaur2', N'tQ4JCyuWM43cpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (37, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'252453', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'mgG44e5ZXZTcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (38, N'Sujata', NULL, N'Kumarswamy', 2, N'sujata@inspinary.com', N'5234234', NULL, NULL, NULL, NULL, NULL, NULL, N'Sujata.Kum', N'hVePzT7WXBvcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (39, N'vijay', NULL, N'gaur', 0, N'vijayendra.gaur@gmail.com', N'3423423', NULL, NULL, NULL, NULL, NULL, NULL, N'vijay.gaur', N'sq2uo+nfMY/cpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (40, N'r', NULL, N't', 0, N'rajvhadlure@gmail.com', N'2323', NULL, NULL, NULL, NULL, NULL, NULL, N'r.t', N'abEJe9k48LHcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (41, N'raj', NULL, N'vha', 0, N'raj@gma.com', N'34234234', NULL, NULL, NULL, NULL, NULL, NULL, N'raj.vha', N'Cz3CRT1WMnbcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (42, N'dflg', N'dg', N'dfg', 1, N'rajvhadlure@gmail.com', N'234234', NULL, NULL, NULL, NULL, NULL, NULL, N'dflg.dfg', N'bNDLF8i7N7XcpNLjA2lfvQ==', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (43, N'raj', NULL, N'vha', 1, N'ar.co@gma.ocm', N'343434', NULL, NULL, NULL, NULL, NULL, NULL, N'rajesh', N'rajesh', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (44, N'sdf', NULL, N'sdf', 0, N'sdf@sg.uu', N'34434', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (45, N'raj', NULL, N'rr', 0, N'rr@gmil.com', N'324234234', NULL, NULL, NULL, NULL, NULL, NULL, N'raj', N'rajesh', NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (46, N'aakash', N'S', N'Shinde', 1, N'aakash.shinde@gmail.com', N'7787788778', N'Pune', N'Pune', N'Maharashtra', N'India', N'4113224', N'Clinic B', N'shinde', N'789789', 1, CAST(0x0000A80500D69DB1 AS DateTime), NULL, NULL, 0)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (47, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'+', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (48, N'Admin', NULL, N'User', 1, N'admin@inspinary.com', N'7878787878', NULL, NULL, NULL, NULL, NULL, NULL, N'admin', N'Inspinary#123', 1, CAST(0x0000A806013E744F AS DateTime), NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UserID], [FirstName], [MiddleName], [LastName], [Gender], [EmailID], [MobileNumber], [Address], [City], [State], [Country], [Pincode], [ClinicName], [Username], [Password], [CreatedBy], [CreatedOn], [UpdatedBy], [UpdatedOn], [IsActive]) VALUES (49, N'Admin', NULL, N'User', 1, N'rajvhadlure@gmail.com', N'7878778787', NULL, NULL, NULL, NULL, NULL, N'Clinic C, Clinic D, ', N'admin', N'A2Tg2kvg5SRqV0UX/FHbvA==', 1, CAST(0x0000A806013F6432 AS DateTime), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[UserMaster] OFF
SET IDENTITY_INSERT [dbo].[VitalMaster] ON 

INSERT [dbo].[VitalMaster] ([VitalID], [PatientID], [BloodPressure], [Height], [Pain], [Respiration], [Temperature], [Weight], [ChectCircumference/Girth], [PulseOximetry], [Pulse], [BloodSuger], [AbnormalCircumference]) VALUES (1, 1, 100, 10, 10, 10, CAST(10.00 AS Decimal(18, 2)), 10, 0, 0, 10, 100, 20)
INSERT [dbo].[VitalMaster] ([VitalID], [PatientID], [BloodPressure], [Height], [Pain], [Respiration], [Temperature], [Weight], [ChectCircumference/Girth], [PulseOximetry], [Pulse], [BloodSuger], [AbnormalCircumference]) VALUES (2, 1, 21, 26, 25, 22, CAST(23.00 AS Decimal(18, 2)), 27, NULL, NULL, 24, 20, NULL)
INSERT [dbo].[VitalMaster] ([VitalID], [PatientID], [BloodPressure], [Height], [Pain], [Respiration], [Temperature], [Weight], [ChectCircumference/Girth], [PulseOximetry], [Pulse], [BloodSuger], [AbnormalCircumference]) VALUES (3, 1, 10, 10, 10, 10, CAST(10.00 AS Decimal(18, 2)), 10, NULL, NULL, 10, 10, NULL)
INSERT [dbo].[VitalMaster] ([VitalID], [PatientID], [BloodPressure], [Height], [Pain], [Respiration], [Temperature], [Weight], [ChectCircumference/Girth], [PulseOximetry], [Pulse], [BloodSuger], [AbnormalCircumference]) VALUES (4, 1, 3, 3, 3, 3, CAST(3.00 AS Decimal(18, 2)), 3, NULL, NULL, 3, 3, NULL)
INSERT [dbo].[VitalMaster] ([VitalID], [PatientID], [BloodPressure], [Height], [Pain], [Respiration], [Temperature], [Weight], [ChectCircumference/Girth], [PulseOximetry], [Pulse], [BloodSuger], [AbnormalCircumference]) VALUES (5, 1, 23, 23, 23, 23, CAST(23.00 AS Decimal(18, 2)), 23, NULL, NULL, 23, 23, NULL)
INSERT [dbo].[VitalMaster] ([VitalID], [PatientID], [BloodPressure], [Height], [Pain], [Respiration], [Temperature], [Weight], [ChectCircumference/Girth], [PulseOximetry], [Pulse], [BloodSuger], [AbnormalCircumference]) VALUES (6, 1, 20, 20, 20, 20, CAST(20.00 AS Decimal(18, 2)), 20, NULL, NULL, 20, 20, NULL)
INSERT [dbo].[VitalMaster] ([VitalID], [PatientID], [BloodPressure], [Height], [Pain], [Respiration], [Temperature], [Weight], [ChectCircumference/Girth], [PulseOximetry], [Pulse], [BloodSuger], [AbnormalCircumference]) VALUES (7, 1, 20, 20, 20, 20, CAST(20.00 AS Decimal(18, 2)), 20, NULL, NULL, 20, 20, NULL)
INSERT [dbo].[VitalMaster] ([VitalID], [PatientID], [BloodPressure], [Height], [Pain], [Respiration], [Temperature], [Weight], [ChectCircumference/Girth], [PulseOximetry], [Pulse], [BloodSuger], [AbnormalCircumference]) VALUES (8, 1, 20, 20, 20, 20, CAST(20.00 AS Decimal(18, 2)), 20, NULL, NULL, 20, 20, NULL)
INSERT [dbo].[VitalMaster] ([VitalID], [PatientID], [BloodPressure], [Height], [Pain], [Respiration], [Temperature], [Weight], [ChectCircumference/Girth], [PulseOximetry], [Pulse], [BloodSuger], [AbnormalCircumference]) VALUES (9, 1, 20, 20, 20, 20, CAST(20.00 AS Decimal(18, 2)), 20, NULL, NULL, 20, 20, NULL)
INSERT [dbo].[VitalMaster] ([VitalID], [PatientID], [BloodPressure], [Height], [Pain], [Respiration], [Temperature], [Weight], [ChectCircumference/Girth], [PulseOximetry], [Pulse], [BloodSuger], [AbnormalCircumference]) VALUES (10, 1, 20, 20, 20, 20, CAST(20.00 AS Decimal(18, 2)), 20, NULL, NULL, 20, 20, NULL)
INSERT [dbo].[VitalMaster] ([VitalID], [PatientID], [BloodPressure], [Height], [Pain], [Respiration], [Temperature], [Weight], [ChectCircumference/Girth], [PulseOximetry], [Pulse], [BloodSuger], [AbnormalCircumference]) VALUES (11, 6, 65, 54, 10, 0, CAST(0.00 AS Decimal(18, 2)), 34, NULL, NULL, 8, 46, NULL)
INSERT [dbo].[VitalMaster] ([VitalID], [PatientID], [BloodPressure], [Height], [Pain], [Respiration], [Temperature], [Weight], [ChectCircumference/Girth], [PulseOximetry], [Pulse], [BloodSuger], [AbnormalCircumference]) VALUES (12, 34, 7, 7, 6, 8, CAST(9.00 AS Decimal(18, 2)), 8, NULL, NULL, 6, 10, NULL)
SET IDENTITY_INSERT [dbo].[VitalMaster] OFF
USE [master]
GO
ALTER DATABASE [dbClinic] SET  READ_WRITE 
GO
