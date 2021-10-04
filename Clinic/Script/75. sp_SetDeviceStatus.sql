USE [dbClinic]
GO


-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SetDeviceStatus]
@deviceId NVARCHAR(50),
@deviceName NVARCHAR(50) = null,
@isActive bit
AS
BEGIN

 UPDATE PatientMaster
 SET    IsDeviceActive = @isActive
 WHERE  [DeviceID] = @deviceId 

END

