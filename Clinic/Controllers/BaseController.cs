using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Clinic.Controllers
{
    public class BaseController : Controller
    {
        protected string _apiUrl;
        protected string _WebUrl;

        public BaseController()
        {
            _apiUrl = ConfigurationManager.AppSettings["WebApiUrl"];
            _WebUrl = ConfigurationManager.AppSettings["WebUrl"];
        }
    }
}