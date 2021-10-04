USE [Clinic]
GO

/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteData]    Script Date: 6/30/2021 10:58:18 AM ******/
DROP PROCEDURE [dbo].[SP_GetCCMNoteData]
GO

/****** Object:  StoredProcedure [dbo].[SP_GetCCMNoteData]    Script Date: 6/30/2021 10:58:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetCCMNoteInfoData]
	
AS
BEGIN
	
	SELECT	[CCMNoteInfoId],
			[CCMNoteText],
			[CCMNoteDescription]
	  FROM	[dbo].[CCMNotesInfoMaster]
END
GO


