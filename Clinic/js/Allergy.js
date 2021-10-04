function AddNewAllergy() {
    $(':input').not(':button, :submit, :reset').val('');
    $("#AddAllergyModel").modal("show");
}

var allergiesListGrid = $("#allergiesListGrid").grid({
    uiLibrary: "bootstrap",
    responsive: true,
    dataSource: {
        url: "/Patient/GetAllAllergiesDetails_ForList", data: { patientID: patientID }
    },
    autoLoad: true,
    columns: [
   { field: "AllergyID", title: "ID", hidden: true },
   { field: "Type", title: "Type" },
   { field: "Agent", title: "Agent" },
   { field: "SNOMED", title: "SNOMED" },
   { field: "Reaction1", title: "Reaction" },
   { field: "Serverity", title: "Severity" },
   { field: "Source", title: "Source" },
   { field: "Status", title: "Status" },
   { field: "AllergyID", title: "", width: 30, type: "icon", icon: "glyphicon-pencil", tooltip: "Edit Allergy", events: { "click": UpdateAllergyDetails } },
    ],
    pager: { enable: true, limit: 10, sizes: [10, 20, 50, 100] }
});


function UpdateAllergyDetails(e) {
    showLoader();
    $("#AddAllergyFormDiv").load("/Patient/AddAllergyForm?AllergyID=" + e.data.record.AllergyID);
    hideLoader();
    setTimeout(function () {
        $("#AddAllergyModel").modal("show");
        FillAllergyDropDownListValues();
    }, 1000);
}

function FillAllergyDropDownListValues() {
    if ($("#allergyModel_Type").val() != null && $("#allergyModel_Type").val() != "") {
        $("#AllergyTypeDDL").val($("#allergyModel_Type").val());
    }

    if ($("#allergyModel_SNOMED").val() != null && $("#allergyModel_SNOMED").val() != "") {
        $("#SNOMEDDDL").val($("#allergyModel_SNOMED").val());
    }

    if ($("#allergyModel_Serverity").val() != null && $("#allergyModel_Serverity").val() != "") {
        $("#SeverityDDL").val($("#allergyModel_Serverity").val());
    }

    if ($("#allergyModel_Source").val() != null && $("#allergyModel_Source").val() != "") {
        $("#SourceDDL").val($("#allergyModel_Source").val());
    }

    if ($("#allergyModel_Status").val() != null && $("#allergyModel_Status").val() != "") {
        $("#AllergyStatusDDL").val($("#allergyModel_Status").val());
    }
}
function SaveAllergyDetails() {
    if ($("#allergyModel_Type").val() == "") {
        $.notify("Please select type", "error");
    } else if ($("#allergyModel_Agent").val() == "") {
        $.notify("Please enter agent", "error");
    } else if ($("#allergyModel_Source").val() == "") {
        $.notify("Please select source", "error");
    } else {
        var dataObject = {};
        dataObject.PatientID = patientID;
        dataObject.AllergyID = $("#allergyModel_AllergyID").val();
        dataObject.Agent = $('#allergyModel_Agent').val();
        dataObject.Type = $('#allergyModel_Type').val();
        dataObject.SNOMED = $('#allergyModel_SNOMED').val();
        dataObject.Reaction1 = $("#allergyModel_Reaction1").val();
        dataObject.Serverity = $("#allergyModel_Serverity").val();
        dataObject.Source = $("#allergyModel_Source").val();
        dataObject.Status = $("#allergyModel_Status").val();
        showLoader();
        $.ajax({
            type: "POST",
            url: '/Patient/SaveAllergyDetails',
            data: '{ model: ' + JSON.stringify(dataObject) + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                hideLoader();
                $(':input').not(':button, :submit, :reset').val('');
                $.notify("Allergy saved successfully", "success");
                $("#AddAllergyModel").modal("hide");
                allergiesListGrid.reload();
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

function AddNewDiagnosis() {
    $(':input').not(':button, :submit, :reset').val('');
    $("#AddDiagnosisModel").modal("show");
}

function OnAllergyTypeChange() {
    $("#allergyModel_Type").val($("#AllergyTypeDDL").val());
}

function OnSNOMEDChange() {
    $("#allergyModel_SNOMED").val($("#SNOMEDDDL").val());
}

function OnSeverityChange() {
    $("#allergyModel_Serverity").val($("#SeverityDDL").val());
}

function OnSourceChange() {
    $("#allergyModel_Source").val($("#SourceDDL").val());
}

function OnAllergyStatusChange() {
    $("#allergyModel_Status").val($("#AllergyStatusDDL").val());
}

function ResetAllergyDetails(){
    $(':input').not(':button, :submit, :reset').val('');
}