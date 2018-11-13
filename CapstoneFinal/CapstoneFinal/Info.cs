using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CapstoneFinal
{
    public class Info
    {
        private string email;
        private string firstName;
        private string lastName;
        private string currentPosition;
        private string edu_or_cert;
        private string userCity;
        private string userState;
        private string userCountry;
        private string goals;
        private string skills;
        private string experience;
        private string userAvailability;

        public Info(string email, string firstName, string lastName, string currentPosition, string edu_or_cert, string userCity, string userState, string userCountry, string goals, string skills, string experience, string userAvailability)
        {
            this.email = email;
            this.firstName = firstName;
            this.lastName = lastName;
            this.currentPosition = currentPosition;
            this.edu_or_cert = edu_or_cert;
            this.userCity = userCity;
            this.userState = userState;
            this.userCountry = userCountry;
            this.goals = goals;
            this.skills = skills;
            this.experience = experience;
            this.userAvailability = userAvailability;
        }

        public string Email { get => email; set => email = value; }
        public string FirstName { get => firstName; set => firstName = value; }
        public string LastName { get => lastName; set => lastName = value; }
        public string CurrentPosition { get => currentPosition; set => currentPosition = value; }
        public string Edu_or_cert { get => edu_or_cert; set => edu_or_cert = value; }
        public string UserCity { get => userCity; set => userCity = value; }
        public string UserState { get => userState; set => userState = value; }
        public string UserCountry { get => userCountry; set => userCountry = value; }
        public string Goals { get => goals; set => goals = value; }
        public string Skills { get => skills; set => skills = value; }
        public string Experience { get => experience; set => experience = value; }
        public string UserAvailability { get => userAvailability; set => userAvailability = value; }
    }
}