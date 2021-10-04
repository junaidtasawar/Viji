$(document).ready(function () {
	applyTriggerNotify();

	if ($("#CCMTimeSpan").val() != null && $("#CCMTimeSpan").val() != "") {
		$("#CCMTimeSpanDDL").val($("#CCMTimeSpan").val());
	} else {
		$("#CCMTimeSpan").val("00");
	}
});

var ccmReportGrid = $("#ccmReportGrid").grid({
	uiLibrary: "bootstrap",
	responsive: true,
	dataSource: {
		url: "/Report/GetPatientList",
		data: { searchString: "", FromDate: $("#FromDate").val(), ToDate: $("#ToDate").val(), CCMTimeSpan: $("#CCMTimeSpan").val(), IsBillable: IsBillable }
	},
	autoLoad: true,
	columns: [
		{ field: "PatientID", title: "ID", hidden: true },
		{ field: "PatientName", title: "Name" },
		{ field: "MRNNumber", title: "MRN Number" },
		{ field: "CCMNote", title: "Note" },
		{ field: "TotalMinute", title: "Total Minute" },
		{ field: "PatientID", title: "", width: 80, type: "icon", icon: "glyphicon-download-alt", tooltip: "Download CCM Report", events: { "click": DownloadCCMReport } },
	],
	pager: { enable: true, limit: 10, sizes: [10, 20, 50, 100] }
});

$('#btnSearch').on('click', function () {
	var IsBillable
	if ($('input.checkbox_check').is(':checked')) {
		IsBillable = true;
	} else {
		IsBillable = false;
	}
	ccmReportGrid.reload({ FromDate: $("#FromDate").val(), ToDate: $("#ToDate").val(), CCMTimeSpan: $("#CCMTimeSpan").val(), IsBillable: IsBillable });

	//$("#downloadBillingReport").css("display", "block");
});

function OnCCMTimeSpanChange() {
	$("#CCMTimeSpan").val($("#CCMTimeSpanDDL").val());
}

$('#FromDate').datepicker({
	autoclose: true
});

$('#ToDate').datepicker({
	autoclose: true
});

var date = new Date();
var formattedDate = ('0' + date.getDate()).slice(-2);
var formattedMonth = ('0' + (date.getMonth() + 1)).slice(-2);
var formattedYear = date.getFullYear().toString().substr(2, 2);

// Combine and format date string
var dateString = formattedMonth + '/' + formattedDate + '/' + formattedYear;
// Get a date object for the current time
$('#ToDate').val(dateString);

var d = new Date();
// Set it to one month ago
d.setMonth(d.getMonth() - 1);
var previousDate = ('0' + d.getDate()).slice(-2);
var previousMonth = ('0' + (d.getMonth() + 1)).slice(-2);
var previousYear = d.getFullYear().toString().substr(2, 2);
var previousString = previousMonth + '/' + previousDate + '/' + previousYear;

$('#FromDate').val(previousString);

function downloadBillableReport() {
	var IsBillable, FromDate, ToDate;
	if ($('input.checkbox_check').is(':checked')) {
		IsBillable = true;
	} else {
		IsBillable = false;
	}

	FromDate = $('#FromDate').val();
	ToDate = $('#ToDate').val();
	var dataObject = {};
	dataObject.IsBillable = IsBillable;
	dataObject.FromDate = $("#FromDate").val();
	dataObject.ToDate = $('#ToDate').val();

	var ajax = new XMLHttpRequest();
	ajax.open("Post", "/Report/DownloadBillableReport?FromDate=" + $("#FromDate").val() + "&ToDate=" + $("#ToDate").val() + "&IsBillable=" + IsBillable, true);
	ajax.responseType = "blob";
	ajax.onreadystatechange = function () {
		if (this.readyState == 4) {
			var blob = new Blob([this.response], { type: "application/octet-stream" });
			var fileName = "BillingReport.zip";
			saveAs(blob, fileName);
			hideLoader();
		}
	};
	ajax.send(null);
}

function generateCCMReport() {
	reload();
	var IsBillable;
	if ($('input.checkbox_check').is(':checked')) {
		IsBillable = true;
	} else {
		IsBillable = false;
	}

	ccmReportGrid.reload({ searchString: "", FromDate: $("#FromDate").val(), ToDate: $("#ToDate").val(), CCMTimeSpan: $("#CCMTimeSpan").val(), IsBillable: IsBillable });

	$("#downloadBillingReport").css("display", "block");
}

var IsBillable;
if ($('input.checkbox_check').is(':checked')) {
	IsBillable = true;
} else {
	IsBillable = false;
}

function DownloadCCMReport(e) {
	var patientID = e.data.record.PatientID;
	showLoader();
	var IsBillable;
	if ($('input.checkbox_check').is(':checked')) {
		IsBillable = true;
	} else {
		IsBillable = false;
	}
	var ajax = new XMLHttpRequest();
	ajax.open("Post", "/Report/GenerateIndividualCCMReport?PatientID=" + patientID + "&FromDate=" + $("#FromDate").val() + "&ToDate=" + $("#ToDate").val() + "&CCMTimeSpan=" + $("#CCMTimeSpan").val() + "&IsBillable=" + IsBillable, true);
	ajax.responseType = "blob";
	ajax.onreadystatechange = function () {
		if (this.readyState == 4) {
			var blob = new Blob([this.response], { type: "application/octet-stream" });
			var fileName = "CCMIndividualReport.zip";
			saveAs(blob, fileName);
			hideLoader();
		}
	};
	ajax.send(null);
}

