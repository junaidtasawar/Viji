USE [Clinic]
GO
/****** Object:  Table [dbo].[RPMReportMaster]    Script Date: 3/31/2021 7:52:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RPMReportMaster](
	[RPMReportID] [bigint] IDENTITY(1,1) NOT NULL,
	[DeviceID] [nvarchar](15) NULL,
	[PatientID] [bigint] NULL,
	[PatientName] [nvarchar](50) NULL,
	[BP] [int] NULL,
	[Glucose] [int] NULL,
	[MobileNumber] [nvarchar](15) NULL,
	[Status] [nchar](10) NULL,
	[Notes] [nvarchar](250) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_RPMReportMaster] PRIMARY KEY CLUSTERED 
(
	[RPMReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[RPMReportMaster] ON 

INSERT [dbo].[RPMReportMaster] ([RPMReportID], [DeviceID], [PatientID], [PatientName], [BP], [Glucose], [MobileNumber], [Status], [Notes], [CreatedDate]) VALUES (2, N'DWYUYT1', 1, N'Sagar Mane', 45, 112, N'7897897897', N'Critical  ', N'Test1', CAST(N'2021-03-30T00:00:00.000' AS DateTime))
INSERT [dbo].[RPMReportMaster] ([RPMReportID], [DeviceID], [PatientID], [PatientName], [BP], [Glucose], [MobileNumber], [Status], [Notes], [CreatedDate]) VALUES (3, N'FGRDAY7', 2, N'Anil Patil', 67, 109, N'4567891311', N'Normal    ', N'Test 2', CAST(N'2021-03-30T00:00:00.000' AS DateTime))
INSERT [dbo].[RPMReportMaster] ([RPMReportID], [DeviceID], [PatientID], [PatientName], [BP], [Glucose], [MobileNumber], [Status], [Notes], [CreatedDate]) VALUES (4, N'YUYYRS4', 3, N'Aarti Kumbhar', 69, 98, N'7845454545', N'Normal    ', N'Test 3', CAST(N'2021-03-30T00:00:00.000' AS DateTime))
INSERT [dbo].[RPMReportMaster] ([RPMReportID], [DeviceID], [PatientID], [PatientName], [BP], [Glucose], [MobileNumber], [Status], [Notes], [CreatedDate]) VALUES (5, N'GDASL4D', 4, N'Snehal Nalawade', 78, 87, N'9986898978', N'Normal    ', N'Test 4', CAST(N'2021-03-30T00:00:00.000' AS DateTime))
INSERT [dbo].[RPMReportMaster] ([RPMReportID], [DeviceID], [PatientID], [PatientName], [BP], [Glucose], [MobileNumber], [Status], [Notes], [CreatedDate]) VALUES (6, N'VBGHJS4', 5, N'Achal Sawariya', 89, 99, N'8797898787', N'Normal    ', N'Test 5', CAST(N'2021-03-30T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[RPMReportMaster] OFF
/****** Object:  StoredProcedure [dbo].[SP_GetRPMReportData_Forlist]    Script Date: 3/31/2021 7:53:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetRPMReportData_Forlist]
@Status nvarchar(50) = null,
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@TotalCount int = 0 OUT 
AS
BEGIN
		SELECT @TotalCount = COUNT(RPMReportID)
		FROM [dbo].[RPMReportMaster] A 

		SELECT * 
		FROM ( 
		SELECT ROW_NUMBER() OVER(ORDER BY RPMReportID) AS NUMBER,
			[RPMReportID], 
			[DeviceID], 
			[PatientID], 
			[PatientName], 
			[BP], 
			[Glucose], 
			[MobileNumber], 
			[Status], 
			[Notes], 
			[CreatedDate],
			@TotalCount as TotalCount	
		FROM  [dbo].[RPMReportMaster] 
		
	    ) AS TBL
		WHERE NUMBER BETWEEN ((@CurrentPage - 1) * @NumberOfRecords + 1) AND (@CurrentPage * @NumberOfRecords)
END

GO
