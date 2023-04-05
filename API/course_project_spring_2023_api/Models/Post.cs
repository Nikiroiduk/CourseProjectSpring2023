using System.ComponentModel.DataAnnotations;

namespace course_project_spring_2023_api.Models
{
    public class Post
    {
        [Required]
        public long Id { get; set; }
                
        [Required]
        public string Name { get; set; } = "Default";
        
        [Required]
        public string Difficulty { get; set; } = "Easy";
        
        [Required]
        public bool IsNeedEquipment { get; set; } = false;
        
        [Required]
        public uint DurationOfOneSession { get; set; } = 0;
        
        [Required]
        public uint TotalDuration { get; set; } = 0;
        
        [Required]
        public string ShortDescription { get; set; } = "Undefined";

        [Required]
        public TrainingCourse TrainingCourse { get; set; } = TrainingCourse.Empty;
        
        public string Description { get; set; } = "Undefined";
        public string Thumbnail { get; set; } = "Path";
    }
}
