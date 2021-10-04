$(document).ready(function () {
    applyTriggerNotify();
    setTimeout(function () {
        $(".DoctorMM").addClass("active");
    }, 1000);

    var theTable = $('#doctorListGrid');
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

function AddNewDoctor() {
    showLoader();
    window.location.href = "/Provider/ProviderMaster";
}

var doctorListGrid = $("#doctorListGrid").grid({
    uiLibrary: "bootstrap",
    responsive: true,
    dataSource: {
        url: "/Provider/GetAllDoctorDetails_ForList",
    },
    autoLoad: true,
    columns: [
        { field: "DoctorID", title: "ID", hidden: true },
        { field: "Name", title: "Name" },
        { field: "Address", title: "Address" },
        { field: "Specility", title: "Specility" },
        { field: "PhoneNo", title: "Phone No" },
        { field: "Email", title: "Email" },
        { field: "WebAddress", title: "Web Address" },
        { field: "DoctorID", title: "", width: 50, type: "icon", icon: "glyphicon-pencil", tooltip: "Edit Doctor", events: { "click": UpdateDoctorDetails } },
    ],
    pager: { enable: true, limit: 10, sizes: [10, 20, 50, 100] }
});

function UpdateDoctorDetails(e) {
    window.location.href = "/Provider/ProviderMaster?DoctorID=" + e.data.record.DoctorID;
}