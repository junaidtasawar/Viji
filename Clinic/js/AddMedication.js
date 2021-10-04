$('#medicationModel_StartDate').datepicker({
    autoclose: true
/*    endDate: new Date(),*/
});

$('#medicationModel_EndDate').datepicker({
    autoclose: true
/*    endDate: new Date(),*/
});

$("#medicationModel_StartDate").val($("#MeidcationStartDateStr").val());
$("#medicationModel_EndDate").val($("#MeidcationEndDateStr").val());

function OnMedicationSourceChange() {
    $("#medicationModel_Source").val($("#MedicationSourceDDL").val());
}

function OnMedicationStatusChange() {
    $("#medicationModel_Status").val($("#MedicationStatusDDL").val());
}

function SaveAddNewMedicationDetails() {
    if ($("#medicationModel_Medication").val() == "") {
        $.notify("Please enter medication name", "error");
    } else if ($("#medicationModel_Quantity").val() == "") {
        $.notify("Please enter Dosage", "error");
    } else if ($("#medicationModel_Status").val() == "") {
        $.notify("Please select status", "error");
    } else {
        showLoader();
        var dataObject = {};
        dataObject.PatientID = patientID;
        dataObject.MedicationID = $("#medicationModel_MedicationID").val();
        dataObject.Medication = $('#medicationModel_Medication').val();
        dataObject.Diagnosis = $('#medicationModel_Diagnosis').val();
        dataObject.RefillAllowed = $('#medicationModel_RefillAllowed').val();
        dataObject.RxNorms = $("#medicationModel_RxNorms").val();
        dataObject.Source = $("#medicationModel_Source").val();
        dataObject.Quantity = $("#medicationModel_Quantity").val();
        dataObject.StartDate = $("#medicationModel_StartDate").val();
        dataObject.EndDate = $("#medicationModel_EndDate").val();
        dataObject.Comments = $("#medicationModel_Comments").val();
        dataObject.OrderGeneratedBy = $("#medicationModel_OrderGeneratedBy").val();
        dataObject.Provider = $("#medicationModel_Provider").val();
        dataObject.Status = $("#medicationModel_Status").val();
        dataObject.DosaseCount = $("#DosaseCount option:selected").text();
        dataObject.Measure = $("#Measure option:selected").text();
        dataObject.Route = $("#Route option:selected").text();
        dataObject.Frequency = $("#Frequency option:selected").text();
        dataObject.Instruction = $("#Instruction option:selected").text();

        $.ajax({
            type: "POST",
            url: "/Patient/SaveMedicationDetails",
            data: '{ model: ' + JSON.stringify(dataObject) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                hideLoader();
                $.notify("Medication saved successfully", "success");
                $("#AddMedicationModel").modal("hide");
                fillMedicationListRecords();
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

function ResetMedicationDetails() {
    $(':input').not(':button, :submit, :reset').val('');
}