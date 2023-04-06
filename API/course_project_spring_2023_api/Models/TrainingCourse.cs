using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace course_project_spring_2023_api.Models
{
    public class TrainingCourse
    {
        [Required]
        public long Id { get; set; }

        [Required]
        public string Name { get; set; } = "Default";
        
        [Required]
        public ICollection<Exercise> Exercises { get; set; } = new List<Exercise>();


        public TrainingCourse(){}

        public static TrainingCourse Empty => new TrainingCourse();
    }
}
