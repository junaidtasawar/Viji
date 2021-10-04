/**
 * Twilio Client configuration for the browser-calls-csharp
 * example application.
 */

// Store some selectors for elements we'll reuse



//const monthNames = ["January", "February", "March", "April", "May", "June",
//    "July", "August", "September", "October", "November", "December"];
//const dateObj = new Date();
//const month = monthNames[dateObj.getMonth()];
//const day = String(dateObj.getDate()).padStart(2, '0');
//const year = dateObj.getFullYear();
//const output = day + '\n' + month + ',' + year;

var callStatus = $("#call-status");
var PatientId = $("#PatientID").val();
var answerButton = $(".answer-button");
var callSupportButton = $(".call-support-button");
var hangUpButton = $(".hangup-button");
var callCustomerButtons = $(".call-customer-button");
/*var today = new Date();*/

var device = null;
var st = null;
var startime = null;

/* Helper function to update the call status bar */
function updateCallStatus(status) {
    callStatus.text(status);
}

/* Get a Twilio Client token with an AJAX request */
$(document).ready(function () {
    debugger;

    $.post("/Token/Generate", {
        page: window.location.pathname
    }).done(function (data) {
        // Set up the Twilio Client Device with the token
        device = new Twilio.Device(data.token);
        setupHandlers(device);
    }).fail(function () {
        updateCallStatus("Could not get a token from server!");
    });
});

function setupHandlers(device) {
    device.on('ready', function (_device) {
        updateCallStatus("Ready");
    });

    /* Report any errors to the call status display */
    device.on('error', function (error) {
        updateCallStatus("ERROR: " + error.message);
    });

    /* Callback for when Twilio Client initiates a new connection */
    device.on('connect', function (connection) {
        debugger;
        // Enable the hang up button and disable the call buttons
        //console.log("call connected" + status)
        hangUpButton.prop("disabled", false);
        callCustomerButtons.prop("disabled", true);
        callSupportButton.prop("disabled", true);
        answerButton.prop("disabled", true);

        // If phoneNumber is part of the connection, this is a call from a
        // support agent to a customer's phone
        if ("phoneNumber" in connection.message) {
            updateCallStatus("In call with " + connection.message.phoneNumber);
            //var startTime = new Date();
            //formatAMPM(startTime);
            //st = formatAMPM(startTime);
            startime = new Date();
            console.log(moment(startime, 'ddd DD-MMM-YYYY, hh:mm A').format('hh:mm A'));
            st = moment(startime, 'ddd DD-MMM-YYYY, hh:mm A').format('hh:mm A');
            //    console.log(output);
        } else {
            // This is a call from a website user to a support agent
            updateCallStatus("In call with support");
        }
    });

    /* Callback for when a call ends */
    device.on('disconnect', function (connection) {
        // Disable the hangup button and enable the call buttons
        hangUpButton.prop("disabled", true);
        callCustomerButtons.prop("disabled", false);
        callSupportButton.prop("disabled", false);
        updateCallStatus("Ready"); updateCallStatus("Ready");
        var endtime = new Date();
        console.log(moment(endtime, 'ddd DD-MMM-YYYY, hh:mm A').format('hh:mm A'));
        var etime = (moment(endtime, 'ddd DD-MMM-YYYY, hh:mm A').format('hh:mm A'));

        var time = new TimeSpan(Date.parse(endtime) - Date.parse(st)).toString("H:mm");

        console.log("duration" + time);

        CallLogs(PatientId, st, etime, time);
    });

    /* Callback for when Twilio Client receives a new incoming call */
    device.on('incoming', function (connection) {
        debugger;
        updateCallStatus("Incoming support call");

        // Set a callback to be executed when the connection is accepted
        connection.accept(function () {
            //alert("accepts call");
            st = new Date();
            //console.log(st);

            console.log(moment(st, 'ddd DD-MMM-YYYY, hh:mm A').format('hh:mm A'));
            updateCallStatus("In call with customer");
        });

        // Set a callback on the answer button and enable it
        answerButton.click(function () {
            //alert("accepts call");
            connection.accept();
            st = new Date();
            //console.log(st);

            console.log(moment(st, 'ddd DD-MMM-YYYY, hh:mm A').format('hh:mm A'));
            updateCallStatus("In call with customer");
        });
        answerButton.prop("disabled", false);
    });
};

function CallLogs(PatientId, st, endtime, time) {
    debugger;

    //$.post("/CCM/CallLogs", {
    //    page: window.location.pathname,
    //    data: { PatientId: PatientId, Startime: st, Endtime: endtime, Duration: time }

    //}).done(function (data) {
    //    // Set up the Twilio Client Device with the token
    //    //alert("save call logs");
    //    location.reload();

    //}).fail(function () {
    //    updateCallStatus("Could not get a token from server!");
    //});
    $.ajax(
        {
            type: 'POST',
            url: '/CCM/CallLogs',
            data: { PatientId: PatientId, Startime: st, Endtime: endtime, Duration: time },
            success:
                function (response) {
                    // Generate HTML table.  
                    //alert("save call logs");
                    $("#CallLogId").val(response);
                    //location.reload();
                },
            error:
                function (response) {
                    alert("Error: " + response);
                }
        });  
}
/* Call a customer from a support ticket */
function callCustomer(phoneNumber) {
    debugger;
    updateCallStatus("Calling " + "+" + phoneNumber + "...");

    var params = { "phoneNumber": "+" + phoneNumber };
    device.connect(params);
}

/* Call the support_agent from the home page */
function callSupport() {
    updateCallStatus("Calling support...");

    // Our backend will assume that no params means a call to support_agent
    device.connect();
}

/* End a call */
function hangUp() {
    device.disconnectAll();

}










/**
 * @version: 1.0
 * @author: @geoffreymcgill
 * @date: 2015-11-25
 * @copyright: Copyright (c) 2008-2019, Object.NET, Inc. (https://object.net). All rights reserved.
 * @license: See LICENSE and https://github.com/datejs/Datejs/blob/master/LICENSE
 * @website: https://datejs.com
 */

/* 
 * TimeSpan(milliseconds);
 * TimeSpan(days, hours, minutes, seconds);
 * TimeSpan(days, hours, minutes, seconds, milliseconds);
 */
var TimeSpan = function (days, hours, minutes, seconds, milliseconds) {
    var attrs = "days hours minutes seconds milliseconds".split(/\s+/);

    var gFn = function (attr) {
        return function () {
            return this[attr];
        };
    };

    var sFn = function (attr) {
        return function (val) {
            this[attr] = val;
            return this;
        };
    };

    for (var i = 0; i < attrs.length; i++) {
        var $a = attrs[i], $b = $a.slice(0, 1).toUpperCase() + $a.slice(1);
        TimeSpan.prototype[$a] = 0;
        TimeSpan.prototype["get" + $b] = gFn($a);
        TimeSpan.prototype["set" + $b] = sFn($a);
    }

    if (arguments.length == 4) {
        this.setDays(days);
        this.setHours(hours);
        this.setMinutes(minutes);
        this.setSeconds(seconds);
    } else if (arguments.length == 5) {
        this.setDays(days);
        this.setHours(hours);
        this.setMinutes(minutes);
        this.setSeconds(seconds);
        this.setMilliseconds(milliseconds);
    } else if (arguments.length == 1 && typeof days == "number") {
        var orient = (days < 0) ? -1 : +1;
        this.setMilliseconds(Math.abs(days));

        this.setDays(Math.floor(this.getMilliseconds() / 86400000) * orient);
        this.setMilliseconds(this.getMilliseconds() % 86400000);

        this.setHours(Math.floor(this.getMilliseconds() / 3600000) * orient);
        this.setMilliseconds(this.getMilliseconds() % 3600000);

        this.setMinutes(Math.floor(this.getMilliseconds() / 60000) * orient);
        this.setMilliseconds(this.getMilliseconds() % 60000);

        this.setSeconds(Math.floor(this.getMilliseconds() / 1000) * orient);
        this.setMilliseconds(this.getMilliseconds() % 1000);

        this.setMilliseconds(this.getMilliseconds() * orient);
    }

    this.getTotalMilliseconds = function () {
        return (this.getDays() * 86400000) + (this.getHours() * 3600000) + (this.getMinutes() * 60000) + (this.getSeconds() * 1000);
    };

    this.compareTo = function (time) {
        var t1 = new Date(1970, 1, 1, this.getHours(), this.getMinutes(), this.getSeconds()), t2;
        if (time === null) {
            t2 = new Date(1970, 1, 1, 0, 0, 0);
        }
        else {
            t2 = new Date(1970, 1, 1, time.getHours(), time.getMinutes(), time.getSeconds());
        }
        return (t1 < t2) ? -1 : (t1 > t2) ? 1 : 0;
    };

    this.equals = function (time) {
        return (this.compareTo(time) === 0);
    };

    this.add = function (time) {
        return (time === null) ? this : this.addSeconds(time.getTotalMilliseconds() / 1000);
    };

    this.subtract = function (time) {
        return (time === null) ? this : this.addSeconds(-time.getTotalMilliseconds() / 1000);
    };

    this.addDays = function (n) {
        return new TimeSpan(this.getTotalMilliseconds() + (n * 86400000));
    };

    this.addHours = function (n) {
        return new TimeSpan(this.getTotalMilliseconds() + (n * 3600000));
    };

    this.addMinutes = function (n) {
        return new TimeSpan(this.getTotalMilliseconds() + (n * 60000));
    };

    this.addSeconds = function (n) {
        return new TimeSpan(this.getTotalMilliseconds() + (n * 1000));
    };

    this.addMilliseconds = function (n) {
        return new TimeSpan(this.getTotalMilliseconds() + n);
    };

    this.get12HourHour = function () {
        return (this.getHours() > 12) ? this.getHours() - 12 : (this.getHours() === 0) ? 12 : this.getHours();
    };

    this.getDesignator = function () {
        return (this.getHours() < 12) ? Date.CultureInfo.amDesignator : Date.CultureInfo.pmDesignator;
    };

    this.toString = function (format) {
        this._toString = function () {
            if (this.getDays() !== null && this.getDays() > 0) {
                return this.getDays() + "." + this.getHours() + ":" + this.p(this.getMinutes()) + ":" + this.p(this.getSeconds());
            }
            else {
                return this.getHours() + ":" + this.p(this.getMinutes()) + ":" + this.p(this.getSeconds());
            }
        };

        this.p = function (s) {
            return (s.toString().length < 2) ? "0" + s : s;
        };

        var me = this;

        return format ? format.replace(/dd?|HH?|hh?|mm?|ss?|tt?/g,
            function (format) {
                switch (format) {
                    case "d":
                        return me.getDays();
                    case "dd":
                        return me.p(me.getDays());
                    case "H":
                        return me.getHours();
                    case "HH":
                        return me.p(me.getHours());
                    case "h":
                        return me.get12HourHour();
                    case "hh":
                        return me.p(me.get12HourHour());
                    case "m":
                        return me.getMinutes();
                    case "mm":
                        return me.p(me.getMinutes());
                    case "s":
                        return me.getSeconds();
                    case "ss":
                        return me.p(me.getSeconds());
                    case "t":
                        return ((me.getHours() < 12) ? Date.CultureInfo.amDesignator : Date.CultureInfo.pmDesignator).substring(0, 1);
                    case "tt":
                        return (me.getHours() < 12) ? Date.CultureInfo.amDesignator : Date.CultureInfo.pmDesignator;
                }
            }
        ) : this._toString();
    };
    return this;
};

/**
 * Gets the time of day for this date instances. 
 * @return {TimeSpan} TimeSpan
 */
Date.prototype.getTimeOfDay = function () {
    return new TimeSpan(0, this.getHours(), this.getMinutes(), this.getSeconds(), this.getMilliseconds());
};

/* 
 * TimePeriod(startDate, endDate);
 * TimePeriod(years, months, days, hours, minutes, seconds, milliseconds);
 */
var TimePeriod = function (years, months, days, hours, minutes, seconds, milliseconds) {
    var attrs = "years months days hours minutes seconds milliseconds".split(/\s+/);

    var gFn = function (attr) {
        return function () {
            return this[attr];
        };
    };

    var sFn = function (attr) {
        return function (val) {
            this[attr] = val;
            return this;
        };
    };

    for (var i = 0; i < attrs.length; i++) {
        var $a = attrs[i], $b = $a.slice(0, 1).toUpperCase() + $a.slice(1);
        TimePeriod.prototype[$a] = 0;
        TimePeriod.prototype["get" + $b] = gFn($a);
        TimePeriod.prototype["set" + $b] = sFn($a);
    }

    if (arguments.length == 7) {
        this.years = years;
        this.months = months;
        this.setDays(days);
        this.setHours(hours);
        this.setMinutes(minutes);
        this.setSeconds(seconds);
        this.setMilliseconds(milliseconds);
    } else if (arguments.length == 2 && arguments[0] instanceof Date && arguments[1] instanceof Date) {
        // startDate and endDate as arguments

        var d1 = years.clone();
        var d2 = months.clone();

        var temp = d1.clone();
        var orient = (d1 > d2) ? -1 : +1;

        this.years = d2.getFullYear() - d1.getFullYear();
        temp.addYears(this.years);

        if (orient == +1) {
            if (temp > d2) {
                if (this.years !== 0) {
                    this.years--;
                }
            }
        } else {
            if (temp < d2) {
                if (this.years !== 0) {
                    this.years++;
                }
            }
        }

        d1.addYears(this.years);

        if (orient == +1) {
            while (d1 < d2 && d1.clone().addDays(Date.getDaysInMonth(d1.getYear(), d1.getMonth())) < d2) {
                d1.addMonths(1);
                this.months++;
            }
        }
        else {
            while (d1 > d2 && d1.clone().addDays(-d1.getDaysInMonth()) > d2) {
                d1.addMonths(-1);
                this.months--;
            }
        }

        var diff = d2 - d1;

        if (diff !== 0) {
            var ts = new TimeSpan(diff);
            this.setDays(ts.getDays());
            this.setHours(ts.getHours());
            this.setMinutes(ts.getMinutes());
            this.setSeconds(ts.getSeconds());
            this.setMilliseconds(ts.getMilliseconds());
        }
    }
    return this;
};