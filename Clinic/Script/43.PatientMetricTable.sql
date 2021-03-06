USE [dbClinic]
GO
/****** Object:  Table [dbo].[PatientMetric]    Script Date: 5/11/2021 2:33:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientMetric](
	[metric] [nvarchar](50) NULL,
	[value_1] [nvarchar](50) NULL,
	[value_2] [nvarchar](50) NULL,
	[device_id] [nvarchar](15) NULL,
	[created] [datetime] NULL
) ON [PRIMARY]
GO
