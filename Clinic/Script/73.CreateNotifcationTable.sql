USE [dbClinic]
GO

/****** Object:  Table [dbo].[Notifications]    Script Date: 7/15/2021 7:57:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Notifications](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [bigint] NULL,
	[PatientName] [nvarchar](50) NULL,
	[BP] [nvarchar](50) NULL,
	[Notification_Action] [varchar](50) NULL,
	[Notification_Time] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


