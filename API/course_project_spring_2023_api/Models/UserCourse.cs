using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace course_project_spring_2023_api.Models
{
    public class UserCourse
    {
        [Required]
        public long Id { get; set; }

        [Required]
        [JsonIgnore]
        public long UserId { get; set; }

        [Required]
        public User User { get; set; }

        [Required]
        public string Name { get; set; } = "Default";

        [Required]
        public ICollection<Exercise> Exercises { get; set; }


    }
}
