//$(document).ready(function () {
//    applyTriggerNotify();

//    setTimeout(function () {
//        $(".ClinicMM").addClass("active");
//    }, 1000);

//    var theTable = $('#clinicListGrid');
//    theTable.find("tbody > tr").find("td:eq(1)").mousedown(function () {
//        $(this).prev().find(":checkbox").click()
//    });

//    $("#filter").keyup(function () {
//        $.uiTableFilter(theTable, this.value);
//    })

//    $('#filter-form').submit(function () {
//        theTable.find("tbody > tr:visible > td:eq(1)").mousedown();
//        return false;
//    }).focus(); //Give focus to input field
//});

function RegisterNewClinic() {
    showLoader();
    window.location.href = "/Clinic/ClinicMaster";
}

var clinicListGrid = $("#clinicListGrid").grid({
    uiLibrary: "bootstrap",
    responsive: true,
    dataSource: {
        url: "/Clinic/GetAllClinicDetails_ForList",
    },
    autoLoad: true,
    columns: [
        { field: "ClinicID", hidden: true },
        { field: "Name", title: "Name" },
        { field: "Address", title: "Address" },
        { field: "ClinicID", title: "", type: "icon", icon: "btn-icon icofont-ui-edit btn btn-info btn-sm btn-square rounded-pill btn btn-error btn-sm btn-square rounded-pill", tooltip: "Edit Clinic", events: { "click": UpdateClinicDetails } },
        { field: "Name", title: "", type: "icon", icon: "glyphicon-user", tooltip: "Patient List", events: { "click": ClinicPatient } },
    ],
    pager: { enable: true, limit: 10, sizes: [10, 20, 50, 100] }
});

function ClinicPatient(e) {
    window.location.href = "/Patient/Index?ClinicName=" + e.data.record.Name;
}

function UpdateClinicDetails(e) {
    window.location.href = "/Clinic/ClinicMaster?ClinicID=" + e.data.record.ClinicID;
}

//function DeleteClinicDetails(e) {
//    var ClinicID = e.data.record.ClinicID;
//    $.ajax({
//        type: "POST",
//        url: "/Clinic/DeleteClinicDetails",
//        data: '{ ClinicID: ' + ClinicID + '}',
//        contentType: "application/json; charset=utf-8",
//        dataType: "json",
//        success: function (response) {
//            hideLoader();
//            $.notify("clinic deleted successfully", "success");
//            clinicListGrid.reload();
//        },
//        failure: function (response) {
//            $.notify(response.responseText, "error");
//        },
//        error: function (response) {
//            $.notify(response.responseText, "error");
//            clinicListGrid.reload();
//        }
//    });
//}



