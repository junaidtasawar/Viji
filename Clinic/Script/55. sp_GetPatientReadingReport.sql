USE [Clinic]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPatientReadingReport]    Script Date: 6/10/2021 10:14:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetPatientReadingReport] 
@PatientId bigint 
AS
BEGIN

	SET NOCOUNT ON;

    SELECT PM.[PatientID], 
		   PM.FirstName + ' ' + PM.LastName + ' ' + PM.MobileNumber 'PatientName',
		   PMH.value_1 AS BP,
		   REPLACE(CONVERT(CHAR(11), PMH.created, 106),' ',' - ')  AS created_date
	  FROM [dbo].[PatientMetricHistory] PMH
	  JOIN [dbo].[PatientMaster] PM ON PMH.device_id = PM.DeviceId
	 WHERE  PM.[PatientID] = @PatientId
	   AND  PMH.[created_date] BETWEEN (select convert(varchar(10), DATEADD(DD,-(DAY(GETDATE() -1)), GETDATE()), 120)) AND (convert(varchar(10), DATEADD(DD,-(DAY(GETDATE())), DATEADD(MM, 1, GETDATE())), 120))
END