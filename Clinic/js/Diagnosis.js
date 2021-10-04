$(document).ready(function () {
    applyTriggerNotify();
    setTimeout(function () {
        $(".DiagnosisMM").addClass("active");
    }, 1000);
});

$('#DiagnosisDate').datepicker({
    Format: 'dd/mm/yy',
    autoclose: true
});

var diagnosisListGrid = $("#diagnosisListGrid").grid({
    uiLibrary: "bootstrap",
    responsive: true,
    dataSource: {
        url: "/Patient/GetAllDiagnosisDetails_ForList", data: { patientID: patientID }
    },
    autoLoad: true,
    columns: [
   { field: "DiagnosisID", title: "ID", hidden: true, width: 60 },
   { field: "DiagnosisName", title: "Diagnosis/ Problem" },
   { field: "SNOMEDCT", title: "Physician Name" },
   { field: "DiagnosisStartDateStr", title: "Start Date" },
   { field: "DiagnosisEndDateStr", title: "End Date" },
   { field: "Source", title: "Source" },
   { field: "Status", title: "Status" },
   { field: "DiagnosisID", title: "", width: 30, type: "icon", icon: "glyphicon-pencil", tooltip: "Edit Diagnosis", events: { "click": UpdateDiagnosisDetails } },
    ],
    pager: { enable: true, limit: 10, sizes: [10, 20, 50, 100] }
});

function fillDiagnoisListRecords() {
    diagnosisListGrid.reload();
}

function UpdateDiagnosisDetails(e) {
    showLoader();
    $("#AddDiagnosisFormDiv").load("/Patient/AddDiagnosisForm?DiagnosisID=" + e.data.record.DiagnosisID);
    hideLoader();
    setTimeout(function () {
        $("#AddDiagnosisModel").modal("show");
    }, 1000);
}