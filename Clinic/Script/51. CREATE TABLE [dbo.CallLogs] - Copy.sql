USE [dbClinic]
GO

/****** Object:  Table [dbo].[CallLogs]    Script Date: 5/26/2021 1:51:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CallLogs](
	[PatientID] [bigint] NOT NULL,
	[startTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[Duration] [datetime] NOT NULL
) ON [PRIMARY]

GO


