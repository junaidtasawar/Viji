var vitalListGrid = $("#vitalListGrid").grid({
    uiLibrary: "bootstrap",
    responsive: true,
    dataSource: {
        url: "/Patient/GetAllVitalDetails_ForList", data: { patientID: patientID }
    },
    autoLoad: true,
    columns: [
   { field: "VitalID", title: "ID", hidden: true },
   { field: "BloodSuger", title: "Blood Suger" },
   { field: "BloodPressure", title: "Blood Pressure" },
   { field: "Pain", title: "Pain"},
   { field: "Temperature", title: "Temperature" },
   { field: "Height", title: "Height" },
   { field: "Weight", title: "Weight" },
   { field: "Respiration", title: "Respiration" },
   { field: "Pulse", title: "Pulse" },
   { field: "VitalID", title: "", width: 30, type: "icon", icon: "glyphicon-pencil", tooltip: "Edit Vital", events: { "click": UpdateVitalDetails } },
    ],
    pager: { enable: true, limit: 10, sizes: [10, 20, 50, 100] }
});

function SaveVitalDetails() {
    if ($("#vitalModel_BloodSuger").val() == "") {
        $.notify("Please enter blood suger", "error");
    } else if ($("#vitalModel_BloodPressure").val() == "") {
        $.notify("Please enter blood pressure", "error");
    } else if ($("#vitalModel_Height").val() == "") {
        $.notify("Please enter height", "error");
    } else if ($("#vitalModel_Weight").val() == "") {
        $.notify("Please enter weight", "error");
    } else {
        var dataObject = {};
        dataObject.PatientID = patientID;
        dataObject.VitalID = $("#vitalModel_VitalID").val();
        dataObject.BloodSuger = $("#vitalModel_BloodSuger").val();
        dataObject.BloodPressure = $("#vitalModel_BloodPressure").val();
        dataObject.Height = $("#vitalModel_Height").val();
        dataObject.Weight = $("#vitalModel_Weight").val();
        dataObject.Pain = $("#vitalModel_Pain").val();
        dataObject.Respiration = $("#vitalModel_Respiration").val();
        dataObject.Pulse = $("#vitalModel_Pulse").val();
        dataObject.Temperature = $("#vitalModel_Temperature").val();

        $.ajax({
            type: "POST",
            url: '/Patient/SaveVitalDetails',
            data: '{ model: ' + JSON.stringify(dataObject) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                hideLoader();
                $.notify("Vitals info saved successfully", "success");
                $(':input').not(':button, :submit, :reset, select').val('');
                $("#AddVitalModel").modal("hide");
                vitalListGrid.reload();
            },
            failure: function (response) {
                $.notify(response.responseText, "error");
            },
            error: function (response) {
                $.notify(response.responseText, "error");
                $.notify("Vitals info saved successfully", "success");
                $(':input').not(':button, :submit, :reset, select').val('');
                $("#AddVitalModel").modal("hide");
                vitalListGrid.reload();
            }
        });
    }
}

function UpdateVitalDetails(e) {
    showLoader();
    $("#AddVitalFormDiv").load("/Patient/AddVitalForm?VitalID=" + e.data.record.VitalID);
    hideLoader();
    setTimeout(function () {
        $("#AddVitalModel").modal("show");
    }, 1000);
}

function AddNewVital() {
    $(':input').not(':button, :submit, :reset').val('');
    $("#AddVitalModel").modal("show");
}

function ResetVitalDetails() {
    $(':input').not(':button, :submit, :reset').val('');
}