USE [dbClinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_AuthorizeUser]    Script Date: 4/19/2021 6:08:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_AuthorizeUser]
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

