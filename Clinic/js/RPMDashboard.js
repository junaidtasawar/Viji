$(document).ready(function () {
    $(function () {
  
            getAllMessages();
        
    });

    applyTriggerNotify();
    setTimeout(function () {
        $(".rpmDashboardMM").addClass("active");
    }, 1000);
    localStorage.timerValue = null;
    var theTable = $('#patientListGrid');
    theTable.find("tbody > tr").find("td:eq(1)").mousedown(function () {
        $(this).prev().find(":checkbox").click()
    });

    $("#filter").keyup(function () {
        $.uiTableFilter(theTable, this.value);
    })

    $('#filter-form').submit(function () {
        theTable.find("tbody > tr:visible > td:eq(1)").mousedown();
        return false;
    }).focus();

});

function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

var clinicname = getParameterByName('ClinicName');
if (clinicname != null) {
    $("#PartialClinicDDL").val(clinicname);
} else {
    clinicname = $("#PartialClinicDDL").val();
}


var nameRenderer = function (value, record, $cell, $displayEl) {
    if (value == 'No Reading') {
        $displayEl.css('color', 'red');
    }
    $displayEl.text(value);
};

function getAllMessages() {
    $.ajax({
        url: '/Home/GetRPMReportDetails_ForList',
        type: 'GET',
        data: { status: null, page: 1, limit: 10 },
        cache: false,
        datatype: 'json',
        success: function (data) {
            console.log(data);
            var rpmDashboardListGrid = $("#rpmDashboardListGrid").grid({
                uiLibrary: "bootstrap",
                responsive: true,

                columns: [
                    { field: "PatientID", hidden: true, title: "ID" },
                    { field: "PatientName", title: "Name" },
                    { field: "BPStr", title: "BP", renderer: nameRenderer },
                    { field: "GlucoseStr", title: "Glucose", renderer: nameRenderer },
                    { field: "MobileNumber", title: "Mobile Number" },
                    { field: "RPMInteractionTime", title: "RPM Interaction Time", renderer: nameRenderer },
                    { field: "RemainingBlockTime", title: "Remaining Block Time", renderer: nameRenderer },
                    { field: "MissedReadingDays", title: "Missed Reading Days", renderer: nameRenderer },
                    { field: "CreatedDateStr", title: "Created Date" },
                    { field: "Status", title: "Status", width: 250, hidden: true },
                    { field: "PatientID", title: "Note", width: 70, type: "icon", icon: "glyphicon-list-alt", tooltip: "Preview", events: { "click": PreviewPatientProfile } },
                    { field: 'WellNessCall', renderer: function (value, record) { return record.WellNessCall == 'Pending' ? '<u>' + value + '<u>' : value; }, events: { "click": setWellnessCallStatus } },
                    { field: "PatientID", title: "Reading Report", width: 70, type: "icon", icon: "glyphicon-download-alt", tooltip: "Reading Report", events: { "click": GetSingleReadingReport } }
                ],
                pager: { enable: true, limit: 10, sizes: [10, 20, 50, 100] }
            });
            rpmDashboardListGrid.on('rowDataBound', function (e, $row, id, record) {
                if (record.Status === 'Critical') {
                    $row.css('color', 'red');
                }
            });
            rpmDashboardListGrid.render(data);
        }
    });
}

function RemoveCCMNoteDetails() {
    $("#ConfirmNoteModel").modal("hide");
}

function RemoveWellnessModel() {
    $("#WellConfirmNoteModel").modal("hide");
}

function AddWellnessDetails() {
    window.location.href = "/CCM/Index?PatientId=" + $('#hdnpatientId').val() + "&Name=" + $("#hdnPatientName").val() + "&MobileNumber=" + $("#CellNumber").val() + "&Status=" + $("#hdnStatus").val() + "&WellnessStatus=" + $("#hdnWellnessStatus").val();
}

function AddNewCCMNoteDetails() {
    var timespan = $('#hdnTimeSpan').val();
    if (timespan != '') {
        window.location.href = "/Patient/PatientIndividualProfile?PatientID=" + $('#hdnpatientId').val() + "&TimeSpent=" + $("#hdnTimeSpan").val();
    } else {
        window.location.href = "/CCM/Index?PatientId=" + $('#hdnpatientId').val() + "&Name=" + $("#hdnPatientName").val() + "&MobileNumber=" + $("#CellNumber").val() + "&Status=" + $("#hdnStatus").val();
    }
}

function AddNewSurvey(e) {
    window.location.href = "/SurveyReport/SurveyForm?PatientID=" + e.data.record.PatientID;
}

function AddNewPatient() {
    showLoader();
    window.location.href = "/Patient/PatientMaster?ClinicName=" + $("#PartialClinicDDL").val();
}

function OnChangePartialClinicDDL() {
    $("#SearchFirstName").val('');
    $("#SearchLastName").val('');
    $("#ClinicName").val($("#PartialClinicDDL").val());
    patientListGrid.reload({ clinicName: $("#PartialClinicDDL").val() });
}

function SearchPatient() {
    patientListGrid.reload({ clinicName: $("#PartialClinicDDL").val(), FirstName: $("#SearchFirstName").val(), LastName: $("#SearchLastName").val() });
}

function UpdatePatientDetails(e) {
    window.location.href = "/Patient/PatientMaster?PatientID=" + e.data.record.PatientID;
}

function UpdatePatientReport(e) {
    window.location.href = "/Patient/PatientReport?PatientID=" + e.data.record.PatientID;
}

function UpdateCCMDetails(e) {
    var patientId = e.data.record.PatientID;
    var timespan = e.data.record.TimeSpentstr;
    var cellnumber = e.data.record.MobileNumber;
    var patientStatus = e.data.record.Status
    $('#CellNumber').val(cellnumber);
    $('#hdnpatientId').val(patientId);
    $('#hdnTimeSpan').val(timespan);
    $("#ConfirmNoteModel").modal("show");
}

var offices = ["Enrolled", "On Hold-Hospitalized", "On Hold-Home Health", "On TCM", "Declined", "Discharged from CCM-other reason"];

function createSelect(selItem, record) {

    var id = record.PatientID;
    var sel = "<select id='ddlStatus' onchange='GetSelectedTextValue(this," + id + ")' class='form-control'><option>Select</option>";
    for (var i = 0; i < offices.length; ++i) {
        if (offices[i] == selItem) {
            sel += "<option selected value = '" + offices[i] + "' >" + offices[i] + "</option>";
        }
        else {
            sel += "<option  value = '" + offices[i] + "' >" + offices[i] + "</option>";
        }
    }
    sel += "</select>";
    return sel;
}

function GetSelectedTextValue(ddlStatus, id) {
    var selectedValue = ddlStatus.value;

    $.ajax({
        url: '/Patient/UpdatePatientStatus',
        type: 'POST',
        data: { 'PatientId': id, 'StatusName': selectedValue },
        cache: false,
        async: false,
        success: function (data) {
            hideLoader();
            $.notify("Status updated successfully", "success");
        }
    });
}


function PreviewPatientProfile(e) {
    var patientId = e.data.record.PatientID;
    var patientName = e.data.record.PatientName;
    var cellnumber = e.data.record.MobileNumber;
    var status = e.data.record.Status;
    $('#CellNumber').val(cellnumber);
    // window.location.href = "/Patient/PatientIndividualProfile?PatientID=" + e.data.record.PatientID;
    $('#hdnpatientId').val(patientId);
    $("#hdnPatientName").val(patientName);
    $("#hdnStatus").val(status);
    $("#ConfirmNoteModel").modal("show");
}

function setWellnessCallStatus(e) {
    var patientId = e.data.record.PatientID;
    var patientName = e.data.record.PatientName;
    var cellnumber = e.data.record.MobileNumber;
    var status = e.data.record.Status;
    var wellnessstatus = e.data.record.WellNessCall;
    if (wellnessstatus === 'Pending') {
        $('#CellNumber').val(cellnumber);
        $('#hdnpatientId').val(patientId);
        $("#hdnPatientName").val(patientName);
        $("#hdnStatus").val(status);
        $("#WellConfirmNoteModel").modal("show");
        $("#hdnWellnessStatus").val(wellnessstatus);
    }

    function GetSingleReadingReport(e) {
       window.open('/Home/DownloadSingleReadingReport?PatientID=" + e.data.record.PatientID;', '_blank');
    }
}

