function AddNewUser() {
    showLoader();
    var i = 10;
    window.location.href = "/User/AddUser";
}

$(document).ready(function () {
    applyTriggerNotify();
    setTimeout(function () {
        $(".UserMM").addClass("active");
    }, 1000);

    var theTable = $('#userListGrid');
    theTable.find("tbody > tr").find("td:eq(1)").mousedown(function () {
        $(this).prev().find(":checkbox").click()
    });

    $("#filter").keyup(function () {
        $.uiTableFilter(theTable, this.value);
    })

    $('#filter-form').submit(function () {
        theTable.find("tbody > tr:visible > td:eq(1)").mousedown();
        return false;
    }).focus(); //Give focus to input field
});

var userListGrid = $("#userListGrid").grid({
    uiLibrary: "bootstrap",
    responsive: true,
    dataSource: {
        url: "/User/GetAllUserDetails_ForList",
    },
    autoLoad: true,
    columns: [
        { field: "UserID", title: "ID", hidden: true },
        { field: "FullName", title: "Name" },
        { field: "AddressLine", title: "Address" },
        { field: "MobileNumber", title: "Mobile Number" },
        { field: "GenderStr", title: "Gender" },
        { field: "ClinicName", title: "Clinic"},
        { field: "UserID", title: "", width: 50, type: "icon", icon: "glyphicon-pencil", tooltip: "Edit User", events: { "click": UpdateUserDetails } },
        { field: "UsreID", title: "Call Report", width: 70, type: "icon", icon: "glyphicon-download-alt", tooltip: "Call Report", events: { "click": GetCallReport } }
     ],
    pager: { enable: true, limit: 10, sizes: [10, 20, 50, 100] }
});

function UpdateUserDetails(e) {
    window.location.href = "/User/AddUser?UserID=" + e.data.record.UserID;
}

function GetCallReport(e) {
    window.open('/Home/DownloadCallLogReport?userID=' + e.data.record.UserID, '_blank');
}
