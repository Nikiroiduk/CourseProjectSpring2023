using System.ComponentModel.DataAnnotations;

namespace course_project_spring_2023_api.Models
{
    public class PowerUser : Person
    {
        [Required]
        public new string Role { get; set; } = "PowerUser";
    }
}
