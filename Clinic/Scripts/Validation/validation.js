function clinicValidation(){
    var submitFlag = true;
    if ($("#name").val() == "") {
        errorNotify("ClinicName", error["ClinicName"]);
        submitFlag = false;
    }
    if ($("#address").val() == "") {
        errorNotify("ClinicAddress", error["ClinicAddress"]);
        submitFlag = false;
    }
    return submitFlag;
}

//function userRegistrationValidation() {
//    var submitFlag = true;

//    if ($("#FirstName").val() == "") {
//        errorNotify("FirstName", error["FirstName"]);
//        submitFlag = false;
//    }
//    if ($("#LastName").val() == "") {
//        errorNotify("LastName", error["LastName"]);
//        submitFlag = false;
//    }
//    if ($("#GenderDDL").val() == "0") {
//        errorNotify("GenderDDL", error["Gender"]);
//        submitFlag = false;
//    }
//    if ($("#EmailID").val() == "") {
//        errorNotify("EmailID", error["EmailID"]);
//        submitFlag = false;
//    }
//    if ($("#MobileNumber").val() == "") {
//        errorNotify("MobileNumber", error["MobileNumber"]);
//        submitFlag = false;
//    }
//    if ($("#AddressLine1").val() == "") {
//        errorNotify("AddressLine1", error["AddressLine1"]);
//        submitFlag = false;
//    }
//    if ($("#CityDDL").val() == "0") {
//        errorNotify("CityDDL", error["City"]);
//        submitFlag = false;
//    }
//    if ($("#CountryDDL").val() == "0") {
//        errorNotify("CountryDDL", error["Country"]);
//        submitFlag = false;
//    }
//    if ($("#StateDDL").val() == "0") {
//        errorNotify("StateDDL", error["State"]);
//        submitFlag = false;
//    }
//    if ($("#Pincode").val() == "") {
//        errorNotify("Pincode", error["Pincode"]);
//        submitFlag = false;
//    }
    
//    return submitFlag;
//}

function isDate(txtDate) {
    var currVal = txtDate;
    if (currVal == '')
        return false;

    var rxDatePattern = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/; //Declare Regex
    var dtArray = currVal.match(rxDatePattern); // is format OK?

    if (dtArray == null)
        return false;

    //Checks for mm/dd/yyyy format.
    dtMonth = dtArray[1];
    dtDay = dtArray[3];
    dtYear = dtArray[5];

    if (dtMonth < 1 || dtMonth > 12)
        return false;
    else if (dtDay < 1 || dtDay > 31)
        return false;
    else if ((dtMonth == 4 || dtMonth == 6 || dtMonth == 9 || dtMonth == 11) && dtDay == 31)
        return false;
    else if (dtMonth == 2) {
        var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));
        if (dtDay > 29 || (dtDay == 29 && !isleap))
            return false;
    }
    return true;
}

function ValidateLoginDetails() {
    if ($("#UserName").val() == "" || $("#Password").val() == "") {
        //$.notify(error["UsernameAndPassword"], "error");
        submitFlag = false;
        return error["UsernameAndPassword"];
    }
    return "";

    //var submitFlag = true;
    //
    //if ($("#Username").val() == "") {
    //    //$.notify(error["UsernameAndPassword"], "error");
    //    submitFlag = false;
    //    errorNotify("Username", error["Username"]);
    //}
    //if ($("#Password").val() == "") {
    //    submitFlag = false;
    //    errorNotify("Password", error["Password"]);
    //}
    //return submitFlag;
}

function ValidateForgotPasswordDetails() {
    var submitFlag = true;
    if ($("#UserName").val() == "") {
        errorNotify("UserName", error["UserName"]);
        //$.notify(error["UsernameAndPassword"], "error");
        submitFlag = false;
    }
    return submitFlag;
}


//user registeration
function userRegisterationValidation() {
    var submitFlag = true;
    if ($("#FirstName").val() == "") {
        errorNotify("FirstName", error["FirstName"]);
        submitFlag = false;
    }
    if ($("#LastName").val() == "") {
        errorNotify("LastName", error["LastName"]);
        submitFlag = false;
    }
    if ($("#EmailID").val() == "") {
        errorNotify("EmailID", error["EmailID"]);
        submitFlag = false;
    }
    if ($("#MobileNumber").val() == "") {
        errorNotify("MobileNumber", error["MobileNumber"]);
        submitFlag = false;
    }
    return submitFlag;
}

//Change Password
function changePasswordValidation() {
    var submitFlag = true;

    if ($("#CurrentPassword").val() == "") {
        errorNotify("CurrentPassword", error["CurrentPassword"]);
        submitFlag = false;
    }
    if ($("#NewPassword").val() == "") {
        errorNotify("NewPassword", error["NewPassword"]);
        submitFlag = false;
    }
    if ($("#ConfirmPassword").val() == "") {
        errorNotify("ConfirmPassword", error["ConfirmPassword"]);
        submitFlag = false;
    }
    if ($("#NewPassword").val() != $("#ConfirmPassword").val()) {
        errorNotify("ConfirmPassword", error["SamePassword"]);
        errorNotify("NewPassword", error["SamePassword"]);
        submitFlag = false;
    }

    return submitFlag;
}