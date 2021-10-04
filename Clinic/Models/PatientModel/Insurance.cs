using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Clinic.Models.PatientModel
{
    public class Insurance
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string PlanName { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public string MemberID { get; set; }
        public string GroupID { get; set; }
    }

    public class Device
    {
        public string DeviceId { get; set; }
        public string DeviceName { get; set; }
    }
}