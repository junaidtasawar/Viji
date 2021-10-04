using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicBO
{
    public class APIResponse
    {
        public bool IsError { get; set; }

        public string ErrorMessage { get; set; }

        public object Data { get; set; }
    }
}
