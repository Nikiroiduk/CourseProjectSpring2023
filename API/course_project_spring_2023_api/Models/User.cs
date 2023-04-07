using System.ComponentModel.DataAnnotations;

namespace course_project_spring_2023_api.Models
{
    public class User : Person
    {
        [Required]
        public DateTime BirthDay { get; set; }
        
        [Required]
        public double Weight { get; set; }
        
        [Required]
        public double Height { get; set; }

        [Required]
        public IList<UserCourse> Courses { get; set; } = new List<UserCourse>();
        
        public User(){}
        
        public User(RegistrationModel model)
        {
            FirstName = model.FirstName;
            LastName = model.LastName;
            Username = model.Username;
            Password = model.Password;
            Email = model.Email;
        }
    }
}
