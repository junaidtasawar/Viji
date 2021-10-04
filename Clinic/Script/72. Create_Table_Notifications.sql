USE [Clinic]
GO

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
    [Notification_Time] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Notifications] ADD PRIMARY KEY CLUSTERED 
(
    [id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


