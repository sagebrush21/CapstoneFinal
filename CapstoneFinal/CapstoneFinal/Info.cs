using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CapstoneFinal
{
    public class Info
    {
        private int id;
        private string email;
        private string password;

        public Info(int id, string email, string password)
        {
            this.id = id;
            this.email = email;
            this.password = password;
        }

        public int Id { get => id; set => id = value; }
        public string Email { get => email; set => email = value; }
        public string Password { get => password; set => password = value; }
    }
}