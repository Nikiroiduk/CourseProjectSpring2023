using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Helpers;
using course_project_spring_2023_api.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace course_project_spring_2023_api.Services.PersonServices
{
    public class PersonService : IPersonService
    {
        private readonly AppSettings _appSettings;

        public PersonService(IOptions<AppSettings> appSettings)
        {
            _appSettings = appSettings.Value;
        }

        public async Task<Person?> Authenticate(string username, string password, ApiContext db)
        {
            var person = await db.Persons.FirstOrDefaultAsync(x => x.Username == username && x.Password == password);

            if (Equals(person, null)) return null;

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

        public async Task<IEnumerable<Person>?> GetAll(ApiContext db) =>
            await db.Persons.ToListAsync();

        public async Task<Person?> GetById(int id, ApiContext db)
        {
            var person = await db.Persons.FindAsync((long)id);
            return person;
        }

        public async Task<User?> GetByIdUser(int id, ApiContext db)
        {
            var user = await db.Users.FindAsync((long)id);
            //var trainingCourses = db.TrainingCourses.Where(x => x.UserId == user.Id).ToList();
            //foreach (var course in trainingCourses)
            //{
            //    course.Exercises = db.Exercises.Where(x => x.TrainingCourseId == course.Id).ToList();
            //}
            //user.Courses = trainingCourses;
            return user;
        }

        public async Task<Person?> Registrate(RegistrationModel person, ApiContext db)
        {
            var p = new Person(person);
            var res = await db.Persons.AddAsync(p);
            await db.SaveChangesAsync();
            return res?.Entity;
        }

        public async Task<bool> UpsertUser(User old, User newUser, ApiContext db)
        {
            old.Courses = newUser.Courses;
            old.Height = newUser.Height;
            old.Weight = newUser.Weight;
            old.BirthDay = newUser.BirthDay;
            old.Username = newUser.Username;
            old.FirstName = newUser.FirstName;
            old.LastName = newUser.LastName;
            old.Email = newUser.Email;
            await db.SaveChangesAsync();
            return true;
        }
    }
}
