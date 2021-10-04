$(document).ready(function () {
    applyTriggerNotify();
    setTimeout(function () {
        $(".DoctorMM").addClass("active");
    }, 1000);
});

$("#DoctorRegistrationFormID").submit(function (e) {
    showLoader();
    var postData = $(this).serializeArray();
    var formURL = $(this).attr("action");
    $.ajax(
    {
        url: formURL,
        type: "POST",
        data: postData,
        success: function (message, textStatus, jqXHR) {
            hideLoader();
            $.notify("Doctor details saved successfully", "success");
            $(':input').not(':button, :submit, :reset, select').val('');
            window.location.href = "/Provider/Index";
        },
        error: function (jqXHR, textStatus, errorThrown) {
        }
    });
    e.preventDefault(); //STOP default action
});

function SaveDoctorDetails() {
    if ($("#Name").val() == "") {
        $.notify("Please enter name", "error");
    } else if ($("#Specility").val() == "") {
        $.notify("Please enter specility", "error");
    } else if ($("#Email").val() == "") {
        $.notify("Please enter email", "error");
    } else if ($("#PhoneNo").val() == "") {
        $.notify("Please enter phone number", "error");
    } else if ($("#WebAddress").val() == "") {
        $.notify("Please enter web address", "error");
    } else if (!isValidEmailAddress($("#Email").val())) {
        $.notify("Please enter valid email", "error");
    } else if (!validateURL($("#WebAddress").val())) {
        $.notify("Please enter valid url", "error");
    } else {
        $("#DoctorRegistrationFormID").submit();
    }
}

function ResetDoctorDetails() {
    $(':input').not(':button, :submit, :reset').val('');
}

function OnGenderChange() {
    $("#GenderID").val($("#GenderDDL").val());
}