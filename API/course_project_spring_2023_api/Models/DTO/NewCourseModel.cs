using System.ComponentModel.DataAnnotations;

namespace course_project_spring_2023_api.Models.DTO
{
    public class NewCourseModel
    {
        [Required]
        public string Name { get; set; } = "default";

        [Required]
        public IEnumerable<NewExerciseModel> Exercises { get; set; } = new List<NewExerciseModel>();
    }
}
