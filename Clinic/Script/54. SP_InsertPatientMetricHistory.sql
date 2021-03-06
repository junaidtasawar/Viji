USE [Clinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertPatientMetric]    Script Date: 5/11/2021 2:21:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SP_InsertPatientMetric]
(
@metric nvarchar(50),
@value_1 nvarchar(50),
@value_2 nvarchar(50),
@device_id nvarchar(50),
@created nvarchar(50)
)
AS
BEGIN
 DELETE FROM PatientMetric

 INSERT INTO PatientMetric
 (
	metric,
	value_1,
	value_2,
	device_id,
	created
 ) 
 values 
 (
    @metric,
	@value_1,
	@value_2,
	@device_id,
	@created
 )

 INSERT INTO [dbo].[PatientMetricHistory]
 (
	metric,
	value_1,
	value_2,
	device_id,
	created
 ) 
 values 
 (
    @metric,
	@value_1,
	@value_2,
	@device_id,
	@created
 )
END