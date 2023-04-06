using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace course_project_spring_2023_api.Models
{
    public class Exercise
    {
        [Required]
        public long Id { get; set; }

        [Required]
        public ICollection<Repetition> Repetitions { get; set; } 

        //[Required]
        //public ICollection<int> Timeout { get; set; } //seconds of rest

        //public TrainingCourse TrainingCourse { get; set; }
    }
}
