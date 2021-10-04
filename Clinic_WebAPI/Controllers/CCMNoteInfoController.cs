using ClinicBO;
using ClinicBO.Filters;
using System;
using System.Collections.Generic;
using System.Web.Http;

namespace Clinic_WebAPI.Controllers
{

    public class CCMNoteInfoController : ApiController
    {
        [HttpGet]
        [Route("api/CCMNoteInfo/GetCCMNoteInfoDetails")]
        [JwtAuthentication]

        public APIResponse GetCCMNoteInfoDetails()
        {
            CCMNoteInfoModel model = new CCMNoteInfoModel();
            APIResponse response = new APIResponse();
            try
            {
                List<CCMNoteInfoModel> listobj = new List<CCMNoteInfoModel>();
                listobj = model.GetCCMNoteInfoDetails();
                if (listobj.Count > 0)
                {
                    response.IsError = false;
                    response.Data = listobj;
                    response.ErrorMessage = string.Empty;
                }
                else
                {
                    response.IsError = true;
                    response.Data = null;
                    response.ErrorMessage = "No data found.";
                }
            }
            catch (Exception ex)
            {
                response.IsError = true;
                response.Data = null;
                response.ErrorMessage = ex.Message.ToString();
            }
            return response;
        }

        [HttpGet]
        [Route("api/CCMNoteInfo/GetCCMNoteInfoDescById")]
        [JwtAuthentication]

        public APIResponse GetCCMNoteInfoDescById(Int64 CCMNoteInfoId)
        {
            string description = string.Empty;
            CCMNoteInfoModel model = new CCMNoteInfoModel();
            APIResponse response = new APIResponse();
            try
            {
                description = model.GetCCMNoteInfoDescById(CCMNoteInfoId);
                if (!String.IsNullOrEmpty(description))
                {
                    response.IsError = false;
                    response.Data = description;
                    response.ErrorMessage = string.Empty;
                }
                else
                {
                    response.IsError = true;
                    response.Data = null;
                    response.ErrorMessage = "No data found.";
                }
            }
            catch (Exception ex)
            {
                response.IsError = true;
                response.Data = null;
                response.ErrorMessage = ex.Message.ToString();
            }
            return response;
        }

        [HttpPost]
        [Route("api/CCMNoteInfo/InsertCCMNoteInfo")]
        [JwtAuthentication]

        public APIResponse InsertCCMNoteInfo(CCMNoteInfoModel obj)
        {
            APIResponse response = new APIResponse();
            try
            {
                Int64 recordId = -1;
                recordId = obj.InsertCCMNoteInfo(obj);
                if (recordId > 0)
                {
                    response.IsError = false;
                    response.Data = recordId;
                    response.ErrorMessage = string.Empty;
                }
                else
                {
                    response.IsError = true;
                    response.Data = null;
                    response.ErrorMessage = "No data found.";
                }
            }
            catch (Exception ex)
            {
                response.IsError = true;
                response.Data = null;
                response.ErrorMessage = ex.Message.ToString();
            }
            return response;
        }
    }
}