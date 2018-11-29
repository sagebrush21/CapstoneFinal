using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CapstoneFinal
{
    public class UserCode
    {
        private string code;

        public UserCode(string code)
        {
            this.code = code;
        }

        public string Code { get => code; set => code = value; }
    }
}