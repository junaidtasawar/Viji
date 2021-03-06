USE [dbClinic]
GO
/****** Object:  Trigger [dbo].[tblRPMReportMasterUpdate]    Script Date: 7/15/2021 7:53:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER  TRIGGER [dbo].[tblRPMReportMasterUpdate] on [dbo].[RPMReportMaster]  
FOR UPDATE  
as  
declare @PatientID bigint, @PatientName nvarchar(50), @BP nvarchar(50);  
select @PatientID = Insrt.PatientID, @PatientName = Insrt.PatientName, @BP = Insrt.BP from inserted Insrt;  
insert into Notifications(PatientID, PatientName, BP, Notification_Action, Notification_Time)  
values(@PatientID, @PatientName,  @BP, 'Record update', GETDATE());  
print 'Triggered fired - After Update'