USE [Clinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertPatientData]    Script Date: 3/25/2021 7:43:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE  [dbo].[SP_InsertPatientData]
	@PatientID bigint,
	@FirstName nvarchar(250)  = null,
	@MiddleName nvarchar(250) = null,
	@LastName nvarchar(250)= null,
	@Gender int = null,
	@DOB DATETIME = null,
	@MobileNumber nvarchar(15)= null,
	@AddressLine1 nvarchar(250)= null,
	@CityID	nvarchar(250)= null,
	@CountryID nvarchar(250)= null,
	@StateID nvarchar(250)= null,
	@Pincode varchar(10)= null,
	@BloodGroup nvarchar(50) = null,
	@ClinicName nvarchar(250) = null,
	@DoctorsName nvarchar(max) = null,
	@StatusName nvarchar(50) = null,
	@MRNNumber nvarchar(10) = null,
	@Email nvarchar(50) = null,		
	@PrimaryContactNumber nvarchar(15) = null,
	@AlternateContactNumber	nvarchar(15) = null,
	@PrimaryLanguage nvarchar(30) = null,	
	@SecondaryLanguage nvarchar(30) = null,
	@Ethnicity nvarchar(30) = null,
	@MaritalStatus nvarchar(20) = null,
	@EmergencyName1 Nvarchar(50) = null,
	@EmergencyRelationship1 NVARCHAR(50) = NULL,
	@EmergencyPhoneNo1 NVARCHAR(20) = NULL,
	@EmergencyName2 Nvarchar(50) = null,
	@EmergencyRelationship2 NVARCHAR(50) = NULL,
	@EmergencyPhoneNo2 NVARCHAR(20) = NULL,
	@InsuranceName NVARCHAR(50) = NULL,
	@InsurancePlanName NVARCHAR(50) = NULL,
	@InsuranceStartDate DATETIME = NULL,
	@InsuranceEndDate DateTime = NULL,
	@InsuranceMemberID nvarchar(30) = NULL,
	@InsuranceGroupID NVARCHAR(30) = NULL,
	@CreatedBy int = null,
	@IsActive bit,
	@Races NVARCHAR(200) = null,
	@HomePhone NVARCHAR(20) = NULL,
	@WorkPhone NvARCHAR(20) = NULL,
	@SSN NVARCHAR(200) = NULL,
	@GuardianName NVARCHAR(200) = NULL,
	@DriverLicenseID NVARCHAR(200) = nULL,
	@DriverLicenseState bit = 0,
	@Comments NVARCHAR(max) = null,
	@CustomPatientID NVARCHAR(100) = null,
	@DeviceID NVARCHAR(15) = null,
	@LowBPLimit INT = null,
	@HighBPLimit INT = null,
	@LowGlucoseLimit INT = null,
	@HighGlucoseLimit INT = null
	AS
BEGIN
	DECLARE @Age INT
	SELECT @Age = DATEDIFF(hour,@DOB,GETDATE())/8766
	

	IF(@PatientID = 0)
	BEGIN
		DECLARE @InsertedPatientID BIGINT
		INSERT INTO PatientMaster
		(
			FirstName, MiddleName, LastName, Gender,[DOB],[Age], MobileNumber, [Address], City, Country, [State],PostalCode,ClinicName,
			BloodGroup, DoctorsName, StatusName, MRNNumber,	[Email], [PrimaryContactNumber], [AlternateContactNumber],	[PrimaryLanguage], [SecondaryLanguage], [Ethnicity], [MaritalStatus],	[EmergencyName1], [EmergencyRelationship1],	[EmergencyPhoneNo1], [EmergencyName2], [EmergencyRelationship2], [EmergencyPhoneNo2],
			[Races],[HomePhone],[CellPhone],[Comments],[GuardianName],[DriverLicenseID],[DriverLicenseState],[CreatedBy],[CreatedOn],[SSN],[IsActive],[CustomPatientID],
			[DeviceId],[LowBPLimit],[HighBPLimit],[LowGlucoseLimit],[HighGlucoseLimit]
		) 
		VALUES
		(
			@FirstName,	@MiddleName, @LastName, @Gender,@DOB,@Age, @MobileNumber,	@AddressLine1,	@CityID, @CountryID, @StateID, @Pincode, @ClinicName,
			@BloodGroup, @DoctorsName, @StatusName, @MRNNumber, @Email, @PrimaryContactNumber,	@AlternateContactNumber, @PrimaryLanguage,
			@SecondaryLanguage, @Ethnicity, @MaritalStatus, @EmergencyName1, @EmergencyRelationship1, @EmergencyPhoneNo1, @EmergencyName2,
			@EmergencyRelationship2, @EmergencyPhoneNo2,@Races,@HomePhone,@WorkPhone,@Comments,@GuardianName,@DriverLicenseID,@DriverLicenseState,@CreatedBy,GETDATE(),@SSN,
			@IsActive,@CustomPatientID, @DeviceID, @LowBPLimit, @HighBPLimit, @LowGlucoseLimit, @HighGlucoseLimit
		)
		
			set @InsertedPatientID = @@Identity

			IF (@InsuranceName IS NOT NULL)
			BEGIN
				INSERT INTO [dbo].[InsuranceMaster] (Name,[PatientID], PlanName, StartDate, EndDate, MemberID, GroupID)
				VALUES (@InsuranceName,@InsertedPatientID,@InsurancePlanName,@InsuranceStartDate,@InsuranceEndDate,@InsuranceMemberID,@InsuranceGroupID)
			END 

			SELECT @InsertedPatientID
	END
	ELSE
	BEGIN
		UPDATE PatientMaster
		SET FirstName = @FirstName, MiddleName = @MiddleName , LastName = @LastName, Gender=@Gender,[DOB]=@DOB,[Age]=@Age, MobileNumber=@MobileNumber, [Address]=@AddressLine1, City=@CityID, Country=@CountryID, [State]=@StateID,PostalCode=@Pincode,ClinicName=@ClinicName,
			BloodGroup=@BloodGroup, DoctorsName=@DoctorsName, StatusName=@StatusName, MRNNumber=@MRNNumber,	[Email]=@Email, [PrimaryContactNumber]=@PrimaryContactNumber, [AlternateContactNumber]=@AlternateContactNumber,	[PrimaryLanguage]=@PrimaryLanguage, 
			[SecondaryLanguage]=@SecondaryLanguage, [Ethnicity]=@Ethnicity, [MaritalStatus]=@MaritalStatus,	[EmergencyName1]=@EmergencyName1, [EmergencyRelationship1]=@EmergencyRelationship1,	[EmergencyPhoneNo1]=@EmergencyPhoneNo1, [EmergencyName2]=@EmergencyName2, 
			[EmergencyRelationship2]=@EmergencyRelationship2, [EmergencyPhoneNo2]=@EmergencyPhoneNo2,
			[Races]=@Races,[HomePhone]=@HomePhone,[CellPhone]=@WorkPhone,[Comments]=@Comments,[GuardianName]=@GuardianName,[DriverLicenseID]=@DriverLicenseID,[DriverLicenseState]=@DriverLicenseState,[UpdatedBy]=@CreatedBy,[UpdatedOn]=GETDATE(),[SSN]=@SSN,[IsActive]=@IsActive,[CustomPatientID]=@CustomPatientID,[DeviceId]=@DeviceID,
			LowBPLimit = @LowBPLimit, HighBPLimit = @HighBPLimit,LowGlucoseLimit = @LowGlucoseLimit,HighGlucoseLimit= @HighGlucoseLimit
		WHERE PatientID = @PatientID

		UPDATE  [dbo].[InsuranceMaster] 
		SET		[Name]=@InsuranceName,PlanName=@InsurancePlanName, StartDate=@InsuranceStartDate, EndDate=@InsuranceEndDate, MemberID=@InsuranceMemberID, GroupID=@InsuranceGroupID
		WHERE	PatientID = @PatientID
	END
END