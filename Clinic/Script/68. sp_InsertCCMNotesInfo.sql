USE [Clinic]
GO

/****** Object:  StoredProcedure [dbo].[InsertCCMNotesInfoData]    Script Date: 7/2/2021 12:39:41 AM ******/
DROP PROCEDURE [dbo].[InsertCCMNotesInfoData]
GO

/****** Object:  StoredProcedure [dbo].[InsertCCMNotesInfoData]    Script Date: 7/2/2021 12:39:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertCCMNotesInfo]
 @CCMNoteText nvarchar(250), 
 @CCMNoteDescription nvarchar(max)
 AS
BEGIN
	INSERT INTO CCMNotesInfoMaster 
	(
		CCMNoteText,
		CCMNoteDescription
	)
	Values 
	(
		@CCMNoteText,
		@CCMNoteDescription
	)
	SELECT @@IDENTITY
END

GO


