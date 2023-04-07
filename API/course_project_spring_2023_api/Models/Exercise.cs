using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace course_project_spring_2023_api.Models
{
    public class Exercise
    {
        [Required]
        public int Id { get; set; }

        [Required]
        [JsonIgnore]
        public int CourseId { get; set; }

        [Required]
        [JsonIgnore]
        public virtual Course Course { get; set; }

        [Required]
        public string Data { get; set; } = "10, 30, 10, 30, 10, 30, 10, 30, 10"; // set, timeout ...
    }
}