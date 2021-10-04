SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetAllergyDataForList]
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
/****** Object:  StoredProcedure [dbo].[SP_GetAllPatientReportDetailForList]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetAllPatientReportDetailForList]
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
/****** Object:  StoredProcedure [dbo].[SP_GetAllSurveyReportForList]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[SP_GetAllSurveyReportForList]
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
/****** Object:  StoredProcedure [dbo].[SP_GetAllSurveyReportHRACallForList]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetAllSurveyReportHRACallForList]
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
/****** Object:  StoredProcedure [dbo].[SP_GetAllSurveyReportHRAForList]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetAllSurveyReportHRAForList]
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
/****** Object:  StoredProcedure [dbo].[SP_GetAllSurveyReportInitialCallForList]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetAllSurveyReportInitialCallForList]
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
/****** Object:  StoredProcedure [dbo].[SP_GetBillingReportDetailForList]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetBillingReportDetailForList]
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
/****** Object:  StoredProcedure [dbo].[SP_GetCCMIndividualReportDetailForList]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetCCMIndividualReportDetailForList]
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
/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteByID]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetCCMNoteByID]
@CCMNoteID bigint,
@PatientID bigint
AS
BEGIN
	SELECT * FROM [dbo].[CCMNoteMaster] WHERE [PatientID] = @PatientID AND [CCMNoteID] = @CCMNoteID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteByPatientID]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetCCMNoteByPatientID]
@PatientID bigint
AS
BEGIN
	SELECT * FROM [dbo].[CCMNoteMaster] WHERE [PatientID] = @PatientID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteData]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetCCMNoteData]
	
AS
BEGIN
	
	SELECT [CCMNoteInfoId],[CCMNoteText],[CCMNoteDescription]
	FROM [dbo].[CCMNotesInfoMaster]
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteDataForList]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_GetCCMNoteDataForList]
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
/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteDescription]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetCCMNoteDescription]
@CCMNoteID bigint
AS
BEGIN
	SELECT CCMNoteDescription From CCMNotesInfoMaster 
	WHERE CCMNoteInfoId = @CCMNoteID 
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteMasterData]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetCCMNoteMasterData]
@PatientID	bigint
AS
BEGIN
	SELECT CCMNoteID, [Description], CCMDate, CCMTime, TimeSpent, IsBillable, IsInitialVisti
	FROM CCMNoteMaster
	WHERE [PatientID] = @PatientID
END 

GO
/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteReportByPatientID]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetCCMNoteReportByPatientID]
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
/****** Object:  StoredProcedure [dbo].[SP_GetCityData]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetCityData]
	 @StateID bigint
AS
BEGIN
	SELECT 
	*
	from MST_City
	WHERE @StateID IS NULL OR RegionID = @StateID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetCityDataAutocomplete]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_GetCityDataAutocomplete]
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
/****** Object:  StoredProcedure [dbo].[SP_GetClinicData]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetClinicData] 

AS
BEGIN
	SELECT [Name] FROM [dbo].[ClinicMaster]
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetClinicData_Forlist]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetClinicData_Forlist]
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@TotalCount int = 0 OUT 
AS
BEGIN
		SELECT @TotalCount = COUNT(ClinicID)
		FROM ClinicMaster A 
		

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

GO
/****** Object:  StoredProcedure [dbo].[SP_GetClinicDataAutocomplete]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetClinicDataAutocomplete]
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
/****** Object:  StoredProcedure [dbo].[SP_GetClinicDetailsByClinicID]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_GetClinicDetailsByClinicID]
@ClinicID bigint 
AS
BEGIN

	SET NOCOUNT ON;

    
	SELECT ClinicID, Name, Address 
	FROM [dbo].[ClinicMaster]
	Where ClinicID = @ClinicID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetCountryDataAutocomplete]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetCountryDataAutocomplete]
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
/****** Object:  StoredProcedure [dbo].[SP_GetDashboardData]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetDashboardData]
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
/****** Object:  StoredProcedure [dbo].[SP_GetDiagnosisDataForList]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetDiagnosisDataForList]
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
/****** Object:  StoredProcedure [dbo].[SP_GetDoctorData_Forlist]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetDoctorData_Forlist]
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
/****** Object:  StoredProcedure [dbo].[SP_GetDoctorDataAutoComplete]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_GetDoctorDataAutoComplete]
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
/****** Object:  StoredProcedure [dbo].[SP_GetDoctorDetailsByDoctorID]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_GetDoctorDetailsByDoctorID]
@DoctorID bigint
AS
BEGIN
	SELECT DoctorID, Name, Address, Specility, PhoneNo, Email, WebAddress
	FROM [dbo].[DoctorMaster]
	WHERE DoctorID = @DoctorID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetDoctorsNameIDsByPatientID]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetDoctorsNameIDsByPatientID]
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
/****** Object:  StoredProcedure [dbo].[SP_GetMedicationDataByPatientID]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetMedicationDataByPatientID]
@PatientID bigint  = 0 
AS
BEGIN
	
	SET NOCOUNT ON;
	SELECT MedicationID, PatientID, Medication, RxNorms, Diagnosis, Quantity, RefillAllowed, StartDate, EndDate, [Source], OrderGeneratedBy, Provider, [Status], Comments
		FROM [dbo].[MedicationMaster]
		Where PatientID = @PatientID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetMedicationDataForList]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetMedicationDataForList]
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
/****** Object:  StoredProcedure [dbo].[SP_GetMedicationDetailsByMedicationID]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetMedicationDetailsByMedicationID]
@MedicationID bigint
AS
BEGIN
	SELECT MedicationID, PatientID, Medication, RxNorms, Diagnosis, Quantity, RefillAllowed, StartDate, EndDate, Source, OrderGeneratedBy, Provider, Status, Comments
	FROM MedicationMaster
	WHERE MedicationID = @MedicationID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetPatientData_Forlist]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_GetPatientData_Forlist]
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
		FROM [dbo].[PatientMaster]  
		
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
/****** Object:  StoredProcedure [dbo].[SP_GetPatientData_Forlist1]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetPatientData_Forlist1]
@ClinicName NVARCHAR(50),
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
		FROM [dbo].[PatientMaster]  
		
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
		--Where PM.ClinicName = @ClinicName
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
/****** Object:  StoredProcedure [dbo].[SP_GetPatientDataByPatientID]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetPatientDataByPatientID]
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
		CCMNote.CCMNoteID
		FROM PatientMaster PM
		LEFT JOIN [CCMNoteMaster] CCMNote
		ON CCMNote.PatientID = PM.PatientID
		Where PM.PatientID = @PatientID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetPatientDetailsByPatientID]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetPatientDetailsByPatientID]
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
			PM.[CustomPatientID]
	FROM	PatientMaster PM LEFT JOIN InsuranceMaster IM 
	ON		IM.PatientID = PM.PatientID
	WHERE	PM.[PatientID] = @PatientID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetPatientProfileData]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetPatientProfileData] 
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
/****** Object:  StoredProcedure [dbo].[SP_GetPatientReportDetailForList]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetPatientReportDetailForList]
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
/****** Object:  StoredProcedure [dbo].[SP_GetPatientShortDataByPatientID]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetPatientShortDataByPatientID]
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
/****** Object:  StoredProcedure [dbo].[SP_GetStateData]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetStateData]
	 @CountryID bigint
AS
BEGIN
	SELECT 
	*
	from MST_Regions_State
	WHERE @CountryID IS NULL OR CountryID = @CountryID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetStateDataAutocomplete]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetStateDataAutocomplete]
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
/****** Object:  StoredProcedure [dbo].[SP_GetUserData_Forlist]    Script Date: 1/19/2021 5:02:44 PM ******/
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
		@TotalCount as TotalCount	
		FROM UserMaster A
		WHERE [IsActive] = 1
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUserDetailsByUserID]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SP_GetUserDetailsByUserID]
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
/****** Object:  StoredProcedure [dbo].[SP_GetVitalDataForList]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_GetVitalDataForList]
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
/****** Object:  StoredProcedure [dbo].[SP_InsertAllergyDetails]    Script Date: 1/19/2021 5:02:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE  [dbo].[SP_InsertAllergyDetails]
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
