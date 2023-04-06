using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace course_project_spring_2023_api.Models
{
    public class Person
    {
        [JsonIgnore]
        public long Id { get; set; }

        [Required]
        public string FirstName { get; set; } = "Default";

        [Required]
        public string LastName { get; set; } = "Default";

        [Required]
        public string Username { get; set; } = "Default";

        [Required]
        [DataType(DataType.EmailAddress)]
        [EmailAddress]
        public string Email { get; set; } = "example@mail.com";

        [Required]
        [JsonIgnore]
        public string Password { get; set; } = "Default";

        [Required]
        [JsonIgnore]
        public string Role { get; set; } = "User";

        [JsonIgnore]
        public string Token { get; set; } = "Default token value";

        //[JsonIgnore]
        public bool IsNewPerson { get; set; } = true;

        public Person(){}

        public static Person Empty => new Person();

        //TODO: Override == & != or make class IEquattable and change all comparassions to Equals()

    }
}
