USE [Clinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertPatientMetric]    Script Date: 5/11/2021 2:21:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientMetricHistory](
	[PatientMatricId] [bigint] IDENTITY(1,1) NOT NULL,
	[metric] [nvarchar](50) NULL,
	[value_1] [nvarchar](50) NULL,
	[value_2] [nvarchar](50) NULL,
	[device_id] [nvarchar](50) NULL,
	[created] [datetime] NULL,
	[created_date] [datetime] NULL,
 CONSTRAINT [PK_PatientMetricHistory] PRIMARY KEY CLUSTERED 
(
	[PatientMatricId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PatientMetricHistory] ADD  CONSTRAINT [DF_PatientMetricHistory_created_date]  DEFAULT (getdate()) FOR [created_date]
GO
