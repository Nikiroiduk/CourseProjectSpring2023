using System.ComponentModel.DataAnnotations;

namespace course_project_spring_2023_api.Models
{
    public class Repetition
    {
        [Required]
        public long Id { get; set; }

        [Required]
        public int Value { get; set; }
    }
}
