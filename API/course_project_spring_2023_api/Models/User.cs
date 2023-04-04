using System.ComponentModel.DataAnnotations;

namespace course_project_spring_2023_api.Models
{
    public class User : Person
    {
        [Required]
        public DateTime BirthDay { get; set; }
        
        [Required]
        public double Weight { get; set; }
        
        [Required]
        public double Height { get; set; }

        public IEnumerable<TrainingCourse>? CompletedCourses { get; set; }
        public IEnumerable<TrainingCourse>? ActiveCourses { get; set; }
    }
}
