USE [Clinic]
GO

/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteDescription]    Script Date: 6/30/2021 11:01:34 AM ******/
DROP PROCEDURE [dbo].[SP_GetCCMNoteDescription]
GO

/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteDescription]    Script Date: 6/30/2021 11:01:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetCCMNoteInfoDescription]
@CCMNoteInfoId bigint
AS
BEGIN
	SELECT	CCMNoteDescription 
	  From	CCMNotesInfoMaster 
	 WHERE	CCMNoteInfoId = @CCMNoteInfoId 
END

GO


