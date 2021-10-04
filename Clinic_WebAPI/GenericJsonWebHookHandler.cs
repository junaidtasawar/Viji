using System;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using Clinic.Models;
using Clinic_WebAPI.Models;
using Microsoft.AspNet.WebHooks;
using Newtonsoft.Json.Linq;

namespace Clinic_WebAPI
{
    public class GenericJsonWebHookHandler:WebHookHandler
    {
        public GenericJsonWebHookHandler()
        {
            this.Receiver = "genericjson";
        }

        public override Task ExecuteAsync(string receiver, WebHookHandlerContext context)
        {
            Clinic.Models.PatientMetric data = context.GetDataOrDefault<Clinic.Models.PatientMetric>();


            if (context.Id == "z")
            {
                //DBManager.InsertingPatientMertic(data);

                PatientMetric obj = new PatientMetric();
                Int64 PatientID = -1;
                PatientID = obj.SavePatientBPDetails(data);
                if(PatientID==0)
                {
                    obj.UpdatePatientData(data.device_id);
                }
            }
            return Task.FromResult(true);
        }
    }

       
    }

