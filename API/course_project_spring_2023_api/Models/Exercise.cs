using System.ComponentModel.DataAnnotations;

namespace course_project_spring_2023_api.Models
{
    public class Exercise
    {
        [Required]
        public long Id { get; set; }
        
        [Required]
        public IEnumerable<uint> Repetitions { get; set; } = new List<uint>(); //number of repetitions
        
        [Required]
        public IEnumerable<uint> Timeout { get; set; } = new List<uint>(); //seconds of rest
    }
}
