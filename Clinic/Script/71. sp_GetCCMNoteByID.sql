USE [Clinic]
GO

/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteByID]    Script Date: 7/3/2021 1:22:59 PM ******/
DROP PROCEDURE [dbo].[SP_GetCCMNoteByID]
GO

/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteByID]    Script Date: 7/3/2021 1:22:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[sp_GetCCMNoteByID]
@CCMNoteID bigint,
@PatientID bigint
AS
BEGIN
	SELECT * FROM [dbo].[CCMNoteMaster] WHERE [PatientID] = @PatientID AND [CCMNoteID] = @CCMNoteID
END
GO


