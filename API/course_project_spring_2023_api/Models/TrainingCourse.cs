using System;
using System.ComponentModel.DataAnnotations;

namespace course_project_spring_2023_api.Models
{
    public class TrainingCourse
    {
        [Required]
        public long Id { get; set; }
        
        [Required]
        public string Name { get; set; } = "Default";
        
        [Required]
        public IEnumerable<Exercise> Exercises { get; set; } = new List<Exercise>();

        public TrainingCourse(){}

        public static TrainingCourse Empty => new TrainingCourse();
    }
}
