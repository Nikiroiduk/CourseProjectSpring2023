using Castle.DynamicProxy.Generators.Emitters.SimpleAST;
using course_project_spring_2023_api.Models.DTO;
using course_project_spring_2023_api.Services;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace course_project_spring_2023_api.Models
{
    public class Person
    {
        [Required]
        public int Id { get; set; }

        [Required]
        [MaxLength(32)]
        public string Username { get; set; } = "default";

        [Required]
        [JsonIgnore]
        [MaxLength(32)]
        public string Password { get; set; } = "default";

        [NotMapped]
        [JsonIgnore]
        public string PlainPassword
        {
            get { return PasswordService.DecryptCipherTextToPlainText(Password); }
            set { Password = PasswordService.EncryptPlainTextToCipherText(value); }
        }

        [Required]
        [JsonIgnore]
        public string Role { get; set; } = "User";

        [JsonIgnore]
        [NotMapped]
        public string Token { get; set; } = "default";

        public double Weight { get; set; } = 0;
        public double Height { get; set; } = 0;
        public virtual IList<Course> Courses { get; set; } = new List<Course>();
        public bool IsNewUser { get; set; } = true;
        public string FirstName { get; set; } = "default";
        public string LastName { get; set; } = "default";
        public DateTime BirthDay { get; set; } = DateTime.Now;
        public string Gender { get; set; } = "default";


        [JsonIgnore]
        public virtual IList<Blog> Blogs { get; set; } = new List<Blog>();

        [JsonIgnore]
        public DateTime TimeOfRegistration { get; set; } = DateTime.Now;

        [JsonIgnore]
        [NotMapped]
        public string json => JsonSerializer.Serialize(this);

        public Person(){}

        public Person(RegistrateModel model)
        {
            Username = model.Username;
            PlainPassword = model.Password;
        }
    }
}
