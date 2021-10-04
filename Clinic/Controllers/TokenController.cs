using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Clinic.Models;
namespace Clinic.Controllers
{
    public class TokenController : Controller
    {
        // GET: Token
        private readonly ICredentials _credentials;

        public TokenController() : this(new Credentials()) { }

        public TokenController(ICredentials credentials)
        {
            _credentials = credentials;
        }

        // GET: Token/Generate
        public JsonResult Generate(string page)
        {
            var token = new Capability(_credentials).Generate(InferRole(page));
            return Json(new { token }, JsonRequestBehavior.AllowGet);
        }

        private static string InferRole(string page)
        {
            return page.Equals("/Dashboard", StringComparison.InvariantCultureIgnoreCase)
                ? "support_agent" : "customer";
        }
    }
}