$('#diagnosisModel_DiagnosisStartDate').datepicker({
    autoclose: true
});
$('#diagnosisModel_DiagnosisEndDate').datepicker({
    autoclose: true
});

$("#diagnosisModel_DiagnosisStartDate").val($("#diagnosisModel_DiagnosisStartDateStr").val());
$("#diagnosisModel_DiagnosisEndDate").val($("#diagnosisModel_DiagnosisEndDateStr").val());


function SaveDiagnosisDetails() {
    if ($("#diagnosisModel_DiagnosisName").val() == "") {
        $.notify("Please enter diagnosis", "error");
    } else {
        var dataObject = {};
        dataObject.PatientID = patientID;
        dataObject.DiagnosisID = $("#diagnosisModel_DiagnosisID").val();
        dataObject.DiagnosisName = $("#diagnosisModel_DiagnosisName").val();
        dataObject.SNOMEDCT = $("#diagnosisModel_SNOMEDCT").val();
        dataObject.DiagnosisStartDate = $("#diagnosisModel_DiagnosisStartDate").val();
        dataObject.DiagnosisEndDate = $("#diagnosisModel_DiagnosisEndDate").val();
        dataObject.Status = $("#diagnosisModel_Status").val();
        dataObject.Occurrence = $("#diagnosisModel_Occurrence").val();
        dataObject.Source = $("#diagnosisModel_Source").val();
        showLoader();
        $.ajax({
            type: "POST",
            url: "/Patient/SaveDiagnosisDetails",
            data: '{ model: ' + JSON.stringify(dataObject) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                hideLoader();
                $.notify("Diagnosis saved successfully", "success");
                $("#AddDiagnosisModel").modal("hide");
                fillDiagnoisListRecords();
            },
            failure: function (response) {
                $.notify(response.responseText, "error");
            },
            error: function (response) {
                $.notify(response.responseText, "error");
            }
        });
    }
}

function OnDiagnosisStatusChange() {
    $("#diagnosisModel_Status").val($("#DiagnosisStatusDDL").val());
}

function OnDiagnosisSNOMEDCTChange() {
    $("#diagnosisModel_SNOMEDCT").val($("#DiagnosisSNOMEDCTDDL").val());
}

function OnOccurrenceChange() {
    $("#diagnosisModel_Occurrence").val($("#OccurrenceDDL").val());
}

function OnDiagnosisSourceChange() {
    $("#diagnosisModel_Source").val($("#DiagnosisSourceDDL").val());
}

function ResetDiagnosisDetails() {
    $(':input').not(':button, :submit, :reset').val('');
}