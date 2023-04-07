using System.ComponentModel.DataAnnotations;

namespace course_project_spring_2023_api.Models.DTO
{
    public class AuthenticateModel
    {
        [Required]
        public string Username { get; set; } = "default";

        [Required]
        public string Password { get; set; } = "default";
    }
}
