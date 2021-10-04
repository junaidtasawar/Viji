using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Clinic.Models
{
    public class CommonUtility
    {
        public static string GenerateRandomNumericCode(int length)
        {
            string characterSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
            Random random = new Random();

            //The below code will select the random characters from the set
            //and then the array of these characters are passed to string 
            //constructor to make an alphanumeric string
            string randomCode = new string(
                Enumerable.Repeat(characterSet, length)
                    .Select(set => set[random.Next(set.Length)])
                    .ToArray());
            return randomCode;
        }
    }
}