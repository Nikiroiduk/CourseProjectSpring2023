using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace course_project_spring_2023_api.Models
{
    public class RegistrationModel
    {
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
        public string Password { get; set; } = "Default";
    }
}
