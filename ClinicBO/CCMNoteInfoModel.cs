using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClinicBO
{
    public class CCMNoteInfoModel
    {
        public Int64 CCMNoteID { get; set; }
        public string CCMNoteText { get; set; }
        public string CCMNoteDescrption { get; set; }

        public static string queryGetCCMNoteInfoData = "sp_GetCCMNoteInfoData";
        public static string queryGetCCMNoteInfoDescription = "sp_GetCCMNoteInfoDescription";
        public static string queryInsertCCMNoteInfo = "sp_InsertCCMNotesInfo";

        public List<CCMNoteInfoModel> GetCCMNoteInfoDetails()
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            return TransformCCMNoteData(DBManager.GetData(queryGetCCMNoteInfoData, parameters));
        }

        private List<CCMNoteInfoModel> TransformCCMNoteData(DataTable dataTable)
        {
            List<CCMNoteInfoModel> ccmnotesList = new List<CCMNoteInfoModel>();
            if (dataTable.Rows.Count > 0)
            {
                foreach (var item in dataTable.AsEnumerable())
                {
                    CCMNoteInfoModel obj = new CCMNoteInfoModel();
                    obj.CCMNoteID = Convert.ToInt64(item["CCMNoteInfoId"]);
                    obj.CCMNoteText = Convert.ToString(item["CCMNoteText"]);
                    obj.CCMNoteDescrption = Convert.ToString(item["CCMNoteDescription"]);
                    ccmnotesList.Add(obj);
                }
            }
            return ccmnotesList;
        }

        public string GetCCMNoteInfoDescById(Int64 CCMNoteInfoId)
        {
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CCMNoteInfoId", CCMNoteInfoId);
            return TransformCCMNoteInfoDesscription(DBManager.GetData(queryGetCCMNoteInfoDescription, parameters));
        }

        private string TransformCCMNoteInfoDesscription(DataTable dataTable)
        {
            if (dataTable.Rows.Count > 0)
            {
                return Convert.ToString(dataTable.Rows[0]["CCMNoteDescription"]);
            }
            return string.Empty;
        }

        public long InsertCCMNoteInfo(CCMNoteInfoModel obj)
        {
            Int64 RecordID = -1;
            Dictionary<object, object> parameters = new Dictionary<object, object>();
            parameters.Add("@CCMNoteText", obj.CCMNoteText);
            parameters.Add("@CCMNoteDescription", obj.CCMNoteDescrption);
            DBManager.CreateUpdateData(queryInsertCCMNoteInfo, parameters, out RecordID);
            return RecordID;
        }
    }
}
