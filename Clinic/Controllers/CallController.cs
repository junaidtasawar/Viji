using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Clinic.Models;
using Twilio.AspNet.Mvc;
using Twilio.TwiML;
using Twilio.TwiML.Voice;
namespace Clinic.Controllers
{
    public class CallController : TwilioController
    {
        //
        private readonly ICredentials _credentials;

        public CallController() : this(new Credentials()) { }

        public CallController(ICredentials credentials)
        {
            _credentials = credentials;
        }

        // POST Call/Connect
        [HttpPost]
        public ActionResult Connect(string phoneNumber)
        {
            var response = new VoiceResponse();

            var dial = new Dial(callerId: _credentials.PhoneNumber);
            if (phoneNumber != null)
            {
                dial.Number(phoneNumber);
            }
            else
            {
                dial.Client("support_agent");
            }
            response.Append(dial);

            return TwiML(response);
        }
    }
}
