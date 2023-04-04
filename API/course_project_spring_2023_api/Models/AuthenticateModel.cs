using System.ComponentModel.DataAnnotations;

namespace course_project_spring_2023_api.Models
{
    public class AuthenticateModel
    {
        [Required]
        public string Username { get; set; } = "Default";

        [Required]
        public string Password { get; set; } = "Default";
    }
}
