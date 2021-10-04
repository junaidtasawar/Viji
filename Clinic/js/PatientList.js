$(document).ready(function () {
    applyTriggerNotify();
    setTimeout(function () {
        $(".PatientMM").addClass("active");
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

function preventBack() {window.history.forward(); }
setTimeout("preventBack()", 0);
window.onunload = function () {null};


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

//var patientListGrid = $("#patientListGrid").grid({
//    uiLibrary: "bootstrap",
//    responsive: true,
//    dataSource: {
//        url: "/Patient/GetAllPatientDetails_ForList", data: { clinicName: clinicname }
//    },
//    autoLoad: true,
//    columns: [
//        //{ field: "SerialNo", title: "Serial No"},
//        { field: "PatientID", hidden: true, title: "ID" },
//        { field: "DeviceID", hidden: true, title: "DeviceID" },
//        { field: "DeviceName", hidden: true, title: "DeviveName" },
//        { field: "FullName", title: "Name" },
//        { field: "GenderStr", title: "Gender" },
//        { field: "TimeSpentstr", title: "(Current Month) Billable Time" },
//        { field: "DoctorsName", title: "Primary Physician" },
//        { field: "age", title: "Age" },
//        { field: "StatusName", title: "Status", width: 250, renderer: function (value, record) { return createSelect(value, record); } },
//        { field: "PatientID", title: "Preview", width: 70, type: "icon", icon: "glyphicon-eye-open", tooltip: "Preview", events: { "click": PreviewPatientProfile } },
//        { field: "PatientID", title: "Edit", width: 50, type: "icon", icon: "glyphicon-pencil", tooltip: "Edit Patient", events: { "click": UpdatePatientDetails } },
//        { field: 'IsDeviceActive', renderer: function (value, record) { return createButton(value, record); }, events: { "click": DeviceActivated } },

//        //{ field: "PatientID", title: "Report", type: "icon", icon: "glyphicon-pencil", tooltip: "Edit Patient", events: { "click": UpdatePatientReport } },
//        //{ field: "PatientID", title: "Survey", width: 80, type: "icon", icon: "glyphicon-list-alt", tooltip: "Survey", events: { "click": AddNewSurvey } },
//        //{ field: "PatientID", title: "Last CCM Note", width: 40, type: "icon", icon: "glyphicon-pencil", tooltip: "Edit", events: { "click": UpdateCCMDetails } },
//        //{ field: "PatientID", title: "Care Plan Updated", width: 40, type: "icon", icon: "glyphicon-pencil", tooltip: "Edit" }
//    ],
//    pager: { enable: true, limit: 10, sizes: [10, 20, 50, 100] }
//});

function createButton(value, record) {
    debugger;
    var btnText;
    if (value) {
        btnText = "<input type='button' value='Deactive'  class='form-control' />";
    } else {
        btnText = "<input type='button' value='Active' class='form-control' />";
    }

    return btnText;
}

function DeviceActivated(e) {
    debugger;
    var DeviceActiveStatus = e.data.record.IsDeviceActive;
    var deviceId = e.data.record.DeviceID;
    var deviceName = e.data.record.DeviceName;
    if (DeviceActiveStatus) {
        $.ajax({
            type: "POST",
            url: "/Home/DeviceDeactive",
            data: {
                "deviceId": deviceId,
                "deviceName": deviceName
            },
            success: function (response) {
                debugger;
                if (parseInt(response) > 0)
                    location.reload();
                else
                    alert("Error while deactivated");
            },
            error: function (response) {
                alert("Error while inserting data");
            }
        });
    } else {

        $.ajax({
            type: "POST",
            url: "/Home/DeviceActive",
            data: {
                "deviceId": deviceId,
                "deviceName": deviceName
            },
            success: function (response) {
                debugger;
                if (parseInt(response) > 0)
                    location.reload();
                else
                    alert("Error while activated");
            },
            error: function () {
                alert("Error while inserting data");
            }
        });
    }
}

function RemoveCCMNoteDetails() {
    $("#ConfirmNoteModel").modal("hide");
}

function AddNewCCMNoteDetails() {
    var timespan = $('#hdnTimeSpan').val();
    if (timespan != '') {
        window.location.href = "/Patient/PatientIndividualProfile?PatientID=" + $('#hdnpatientId').val() + "&TimeSpent=" + $("#hdnTimeSpan").val();
    } else {
        window.location.href = "/Patient/PatientIndividualProfile?PatientID=" + $('#hdnpatientId').val();
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
    // window.location.href = "/Patient/PatientIndividualProfile?PatientID=" + e.data.record.PatientID;
    $('#hdnpatientId').val(patientId);
    $("#ConfirmNoteModel").modal("show");
}