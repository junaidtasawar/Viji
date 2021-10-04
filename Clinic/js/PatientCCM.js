var patientID = GetParameterValues('PatientID');

function GetParameterValues(param) {
	var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
	for (var i = 0; i < url.length; i++) {
		var urlparam = url[i].split('=');
		if (urlparam[0] == param) {
			return urlparam[1];
		}
	}
}

function DisplayCCMNotePopup(status) {
	var status = status.replace('+', '');
	status = status.replace('+', '');
	status = status.trim();
	window.location.href = "/CCM/Index?PatientId=" + patientID + "&Name=" + $("#FullName").val() + "&Status=" + status;
}

var seconds = 0, minutes = 0, hours = 0, t;

//Code added for Timer (StopWatch) display in Textbox
function add() {
	if (localStorage.timerValue != "null") {
		var times = localStorage.timerValue.split(":");
		seconds = times[2].replace(/^0+/, ''), minutes = times[1].replace(/^0+/, ''), hours = times[0].replace(/^0+/, ''), t;
	}
	seconds++;
	if (seconds >= 60) {
		seconds = 0;
		minutes++;
		if (minutes >= 60) {
			minutes = 0;
			hours++;
		}
	}
	$("#inputTimeSpent").text((hours ? (hours > 9 ? hours : "0" + hours) : "00") + ":" + (minutes ? (minutes > 9 ? minutes : "0" + minutes) : "00") + ":" + (seconds > 9 ? seconds : "0" + seconds));
	localStorage.timerValue = $("#inputTimeSpent").text();
	timer();
}

function timer() {
	t = setTimeout(add, 1000);
}
$(document).ready(function () {
	timer();
});


