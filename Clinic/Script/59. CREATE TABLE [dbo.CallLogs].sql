USE [Clinic]
GO

/****** Object:  Table [dbo].[CallLogs]    Script Date: 6/13/2021 9:07:37 PM ******/
DROP TABLE [dbo].[CallLogs]
GO

/****** Object:  Table [dbo].[CallLogs]    Script Date: 6/13/2021 9:07:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CallLogs](
	[CallLogId] [bigint] IDENTITY(1,1) NOT NULL,
	[PatientID] [bigint] NOT NULL,
	[startTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[Duration] [datetime] NOT NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_CallLogs] PRIMARY KEY CLUSTERED 
(
	[CallLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



