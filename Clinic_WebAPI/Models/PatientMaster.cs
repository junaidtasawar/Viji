using ClinicBO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Clinic_WebAPI.Models
{
    public class PatientMaster
    {
        public int PatientID { get; set; }
        public string FirstName { get; set; }
        public int HighGlucoseLimit { get; set; }
        public int MobileNumber { get; set; }



      
    }
}