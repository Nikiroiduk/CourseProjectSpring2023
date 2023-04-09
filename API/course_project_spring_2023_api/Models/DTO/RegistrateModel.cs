using course_project_spring_2023_api.Services;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace course_project_spring_2023_api.Models.DTO
{
    public class RegistrateModel
    {
        [Required]
        public string Username { get; set; } = "default";

        [Required]
        public string Password { get; set; } = "default";
    }
}
