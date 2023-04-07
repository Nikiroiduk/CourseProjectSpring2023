using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace course_project_spring_2023_api.Models
{
    public class Person
    {
        [Required]
        public int Id { get; set; }

        [Required]
        public string Username { get; set; } = "default";

        [Required]
        [JsonIgnore]
        public string Password { get; set; } = "default";

        [Required]
        [JsonIgnore]
        public string Role { get; set; } = "User";

        [JsonIgnore]
        public string Token { get; set; } = "default";

        public double Weight { get; set; } = 0;
        public double Height { get; set; } = 0;
        public virtual IList<Course> Courses { get; set; } = new List<Course>();
    }
}
