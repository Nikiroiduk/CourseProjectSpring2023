using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
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

        //[Required]
        //[ForeignKey(nameof(Person))]
        //public int PersonId { get; set; }
        //public Person Person { get; set; }
    }
}