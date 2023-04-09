using System.ComponentModel.DataAnnotations;

namespace course_project_spring_2023_api.Models.DTO
{
    public class NewExerciseModel
    {
        [Required]
        public string Data { get; set; } = "10, 30, 10, 30, 10, 30, 10, 30, 10";
    }
}
