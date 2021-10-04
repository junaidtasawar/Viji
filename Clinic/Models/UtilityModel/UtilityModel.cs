using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Clinic.Models.UtilityModel
{
    public abstract class UtilityModel
    {
        public int DeleteFlag { get; set; }
        public Int64 CreatedBy { get; set; }
        public DateTime? CreatedOn { get; set; }
        public Int64 UpdatedBy { get; set; }
        public DateTime? UpdatedOn { get; set; }

        public int CurrentPage { get; set; }
        public int NumberOfRecords { get; set; }
        public string OrderBy { get; set; }
        public int TotalCount { get; set; }
        public string UniqueID { get; set; }
    }
}