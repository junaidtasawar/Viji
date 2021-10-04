$('#InitialCallDate').datepicker({
    autoclose: true
});
$('#SecondCallDate').datepicker({
    autoclose: true
});
$('#ThirdCallDate').datepicker({
    autoclose: true
});
$('#HRACompletedDate').datepicker({
    autoclose: true
});
$('#NurseVisitScheduleDate').datepicker({
    autoclose: true
});
$('#NurseVisitCompletionDate').datepicker({
    autoclose: true
});

function SaveSurveyDetails() {
    var dataObject = {};
    dataObject.ID = $("#ID").val();
    dataObject.FirstName = $("#FirstName").val();
    dataObject.LastName = $("#LastName").val();
    dataObject.MRN = $("#MRN").val();
    dataObject.InitialCallDate = $("#InitialCallDate").val();
    if (document.getElementById('InitialCallrb1').checked) {
        dataObject.InitialCallAnswer = document.getElementById('InitialCallrb1').value;
    } else if (document.getElementById('InitialCallrb2').checked) {
        dataObject.InitialCallAnswer = document.getElementById('InitialCallrb2').value;
    } else if (document.getElementById('InitialCallrb3').checked) {
        dataObject.InitialCallAnswer = document.getElementById('InitialCallrb3').value;
    } else if (document.getElementById('InitialCallrb4').checked) {
        dataObject.InitialCallAnswer = document.getElementById('InitialCallrb4').value;
    } else if (document.getElementById('InitialCallrb5').checked) {
        dataObject.InitialCallAnswer = document.getElementById('InitialCallrb5').value;
    } else if (document.getElementById('InitialCallrb6').checked) {
        dataObject.InitialCallAnswer = 'Inactive Phone Number';
    }

    dataObject.SecondCallDate = $("#SecondCallDate").val();
    if (document.getElementById('SecondCallrb1').checked) {
        dataObject.SecondCallAnswer = document.getElementById('SecondCallrb1').value;
    } else if (document.getElementById('SecondCallrb2').checked) {
        dataObject.SecondCallAnswer = document.getElementById('SecondCallrb2').value;
    } else if (document.getElementById('SecondCallrb3').checked) {
        dataObject.SecondCallAnswer = document.getElementById('SecondCallrb3').value;
    } else if (document.getElementById('SecondCallrb4').checked) {
        dataObject.SecondCallAnswer = document.getElementById('SecondCallrb4').value;
    } else if (document.getElementById('SecondCallrb5').checked) {
        dataObject.SecondCallAnswer = document.getElementById('SecondCallrb5').value;
    } else if (document.getElementById('SecondCallrb6').checked) {
        dataObject.SecondCallAnswer = 'Inactive Phone Number';
    }

    dataObject.ThirdCallDate = $("#ThirdCallDate").val();
    if (document.getElementById('ThirdCallrb1').checked) {
        dataObject.ThirdCallAnswer = document.getElementById('ThirdCallrb1').value;
    } else if (document.getElementById('ThirdCallrb2').checked) {
        dataObject.ThirdCallAnswer = document.getElementById('ThirdCallrb2').value;
    } else if (document.getElementById('ThirdCallrb3').checked) {
        dataObject.ThirdCallAnswer = document.getElementById('ThirdCallrb3').value;
    } else if (document.getElementById('ThirdCallrb4').checked) {
        dataObject.ThirdCallAnswer = document.getElementById('ThirdCallrb4').value;
    }

    if (document.getElementById('HRACallrb1').checked) {
        dataObject.HRAStatus = document.getElementById('HRACallrb1').value;
    } else if (document.getElementById('HRACallrb2').checked) {
        dataObject.HRAStatus = document.getElementById('HRACallrb2').value;
    } else if (document.getElementById('HRACallrb3').checked) {
        dataObject.HRAStatus = document.getElementById('HRACallrb3').value;
    }

    if (document.getElementById('IsMemberEligiblerb1').checked) {
        dataObject.IsMemberEligible = document.getElementById('IsMemberEligiblerb1').value;
    } else if (document.getElementById('IsMemberEligiblerb2').checked) {
        dataObject.IsMemberEligible = document.getElementById('IsMemberEligiblerb2').value;
    }

    dataObject.HRACompletedDate = $("#HRACompletedDate").val();

    if (document.getElementById('LivioNurserb1').checked) {
        dataObject.LivioNurseVisit = document.getElementById('LivioNurserb1').value;
    } else if (document.getElementById('LivioNurserb2').checked) {
        dataObject.LivioNurseVisit = document.getElementById('LivioNurserb2').value;
        dataObject.LivioNurseVisit = document.getElementById('LivioNurserb2').value;
    }

    dataObject.NurseVisitScheduleDate = $("#NurseVisitScheduleDate").val();

    dataObject.NurseVisitCompletionDate = $("#NurseVisitCompletionDate").val();

    showLoader();
    $.ajax({
        type: "POST",
        url: "/SurveyReport/SavePatientSurveyDetails",
        data: '{ model: ' + JSON.stringify(dataObject) + '}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            hideLoader();
            $.notify("Survey saved successfully", "success");
            $(':input').not(':button, :submit, :reset').val('');
            window.location.href = "/Patient/Index";
        },
        failure: function (response) {
            $.notify(response.responseText, "error");
        },
        error: function (response) {
            $.notify(response.responseText, "error");
        }
    });
}


