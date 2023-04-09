using course_project_spring_2023_api.Models.DTO;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace course_project_spring_2023_api.Models
{
    public class Blog
    {
        [Required]
        public int Id { get; set; }

        [Required]
        public string Name { get; set; } = "default";

        [Required]
        public virtual IList<Tag> Tags { get; set; } = new List<Tag>();

        [Required]
        [JsonIgnore]
        public virtual IList<Person> Persons { get; set; } = new List<Person>();

        [NotMapped]
        [JsonIgnore]
        public string json => JsonSerializer.Serialize(this);

        public Blog(){}

        public Blog(NewBlogModel model)
        {
            Name = model.Name;
        }
    }
}
