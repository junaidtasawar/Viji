$("#ClinicMasterFormID").submit(function (e) {
    showLoader();
    var postData = $(this).serializeArray();
    var formURL = $(this).attr("action");
    $.ajax(
    {
        url: formURL,
        type: "POST",
        data: postData,
        success: function (message, textStatus, jqXHR) {
            if (textStatus == "success") {
                hideLoader();
                $(':input').not(':button, :submit, :reset').val('');
                $.notify("Clinic details saved successfully", "success");
                window.location.href = "/Clinic/Index";
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
        }
    });
    e.preventDefault(); //STOP default action
});

function SaveClientDetails() {
    if ($("#Name").val() == "") {
        $.notify("Please enter clinic name", "error");
    } else {
        if ($("#Address").val() == "") {
            $.notify("Please enter clinic address", "error");
        } else {
            $("#ClinicMasterFormID").submit();
        }
    }
}

function ResetClientDetails() {
    $(':input').not(':button, :submit, :reset').val('');
}