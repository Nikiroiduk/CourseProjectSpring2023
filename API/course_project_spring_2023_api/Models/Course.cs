using course_project_spring_2023_api.Models.DTO;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace course_project_spring_2023_api.Models
{
    public class Course
    {
        [Required]
        public int Id { get; set; }

        [Required]
        public string Name { get; set; } = "default";

        [Required]
        [JsonIgnore]
        public virtual IList<Person> Persons { get; set; } = new List<Person>();

        [Required]
        public virtual IList<Exercise> Exercises { get; set; } = new List<Exercise>();

        [NotMapped]
        [JsonIgnore]
        public string json => JsonSerializer.Serialize(this);

        public Course(){}

        public Course(NewCourseModel model)
        {
            Name = model.Name;
            foreach (var item in model.Exercises)
            {
                Exercises.Add(new Exercise() { Data = item.Data });
            }
        }
    }
}