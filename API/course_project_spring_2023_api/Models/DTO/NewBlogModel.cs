using System.ComponentModel.DataAnnotations;

namespace course_project_spring_2023_api.Models.DTO
{
    public class NewBlogModel
    {
        [Required]
        public string Name { get; set; } = "default";

        [Required]
        public IList<Tag> Tags { get; set; } = new List<Tag>();
    }
}
