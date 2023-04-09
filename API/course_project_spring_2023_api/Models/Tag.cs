using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace course_project_spring_2023_api.Models
{
    public class Tag
    {
        [Required]
        public int Id { get; set; }
        
        [Required]
        public string Name { get; set; } = "default";

        [Required]
        [JsonIgnore]
        public virtual IList<Blog> Blogs { get; set; } = new List<Blog>();
    }
}
