function AddNewMedication() {
    $(':input').not(':button, :submit, :reset').val('');
    $("#AddMedicationModel").modal("show");
}

var medicationListGrid = $("#medicationListGrid").grid({
    uiLibrary: "bootstrap",
    responsive: true,
    dataSource: {
        url: "/Patient/GetAllMedicationDetails_ForList", data: { patientID: patientID }
    },
    autoLoad: true,
    columns: [
        { field: "MedicationID", title: "ID", hidden: true },
        { field: "Medication", title: "Medication" },
        { field: "Quantity", title: "Quantity" },
        { field: "MeidcationStartDateStr", title: "Start Date" },
        { field: "MeidcationEndDateStr", title: "Start Date" },
        { field: "Provider", title: "Provider" },
        { field: "Status", title: "Status" },
        { field: "Comments", title: "Comments" },
        { field: "Frequency", title: "Frequency" },
        { field: "MedicationID", title: "", width: 30, type: "icon", icon: "glyphicon-pencil", tooltip: "Edit Medication", events: { "click": UpdateMedicationDetails } },
    ],
    pager: { enable: true, limit: 10, sizes: [10, 20, 50, 100] }
});

function fillMedicationListRecords() {
    medicationListGrid.reload();
}

function UpdateMedicationDetails(e) {
    showLoader();
    $("#AddMedicationFormDiv").load("/Patient/AddMedicationForm?MedicationID=" + e.data.record.MedicationID);
    hideLoader();
    setTimeout(function () {
        $("#AddMedicationModel").modal("show");
        FillMedicationDropDownListValues();
    }, 1000);
}

function FillMedicationDropDownListValues() {
    if ($("#medicationModel_Source").val() != null && $("#medicationModel_Source").val() != "") {
        $("#MedicationSourceDDL").val($("#medicationModel_Source").val());
    }

    if ($("#medicationModel_Status").val() != null && $("#medicationModel_Status").val() != "") {
        $("#MedicationStatusDDL").val($("#medicationModel_Status").val());
    }

    $("#medicationModel_StartDate").val($("#medicationModel_MeidcationStartDateStr").val());
    $("#medicationModel_EndDate").val($("#medicationModel_MeidcationEndDateStr").val());
}