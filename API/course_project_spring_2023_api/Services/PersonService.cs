using course_project_spring_2023_api.Helpers;
using course_project_spring_2023_api.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace course_project_spring_2023_api.Services
{
    public class PersonService : IPersonService
    {
        // users hardcoded for simplicity, store in a db with hashed passwords in production applications
        private List<Person> _persons = new List<Person>
        {
            new Person { Id = 1, FirstName = "Admin", LastName = "Admin", Username = "admin", Password = "admin", IsNewPerson = false, Role = Role.Admin },
            new User { Id = 2, FirstName = "User", LastName = "User", Username = "user", Password = "user", BirthDay = DateTime.Now, Weight = 80, Height = 180, IsNewPerson = false, Role = Role.User }
        };

        private readonly AppSettings _appSettings;

        public PersonService(IOptions<AppSettings> appSettings)
        {
            _appSettings = appSettings.Value;
        }

        public Person Authenticate(string username, string password)
        {
            var person = _persons.SingleOrDefault(x => x.Username == username && x.Password == password);

            // TODO: Override == & !=
            if (person == null) return Person.Empty;

            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, person.Id.ToString()),
                    new Claim(ClaimTypes.Role, person.Role)
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            person.Token = tokenHandler.WriteToken(token);

            return person.WithoutPassword();
        }

        public IEnumerable<Person> GetAll() => _persons.WithoutPasswords();

        public Person GetById(int id)
        {
            var person = _persons.FirstOrDefault(x => x.Id == id);
            return person.WithoutPassword();
        }

        public Person Registrate(Person person)
        {
            _persons.Add(person);
            return person;
        }
    }
}
