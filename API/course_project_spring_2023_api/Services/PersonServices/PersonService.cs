using Castle.Core.Internal;
using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Helpers;
using course_project_spring_2023_api.Models;
using course_project_spring_2023_api.Models.DTO;
using Microsoft.EntityFrameworkCore;
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

        public async Task<Person?> Authenticate(AuthenticateModel model, ApiContext db)
        {
            var person = await db.Persons.FirstOrDefaultAsync(
                x => x.Username == model.Username && x.Password == model.PlainPassword);

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
                Expires = DateTime.UtcNow.AddDays(15),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), 
                    SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            person.Token = tokenHandler.WriteToken(token);

            return person;
        }

        public async Task<Person?> GetPersonById(int id, ApiContext db)
        {
            var p = await db.Persons.FindAsync(id);

            if (Equals(p, null)) return null;

            return p;
        }

        public async Task<object?> Register(RegistrateModel model, ApiContext db)
        {
            var t = await db.Persons.FirstOrDefaultAsync(x => x.Username == model.Username);
            if (!Equals(t, null)) return new string("Username is reserved");

            var p = new Person(model);

            var res = await db.Persons.AddAsync(p);

            if (Equals(res.Entity, null)) return null;

            await db.SaveChangesAsync();

            return res.Entity;
        }

        public async Task<IList<Person>> GetAll(ApiContext db)
        {
            var res = await db.Persons.ToListAsync();

            if (Equals(res, null)) return new List<Person>();

            return res;
        }

        public async Task<bool> DeletePerson(int id, ApiContext db)
        {
            var p = await db.Persons.FirstOrDefaultAsync(x => x.Id == id);
            if (Equals(p, null)) return false;
            db.Persons.Remove(p);
            await db.SaveChangesAsync();
            return true;
        }

        public async Task<object?> Upsert(int id, Person newPerson, ApiContext db)
        {
            var t = await db.Persons.FirstOrDefaultAsync(x => x.Username == newPerson.Username);
            if (!Equals(t, null) && id != t.Id) return new string("Username is reserved");

            var old = await db.Persons.FirstOrDefaultAsync(x => x.Id == id);
            if (Equals(old, null)) return $"User with id: {id} doesn't exists";
            
            old.Courses.Clear();
            old.Courses = newPerson.Courses;
            old.Weight = newPerson.Weight;
            old.Height = newPerson.Height;
            old.Username = newPerson.Username;
            old.IsNewUser = newPerson.IsNewUser;
            old.FirstName = newPerson.FirstName;
            old.LastName = newPerson.LastName;
            old.BirthDay = newPerson.BirthDay;

            await db.SaveChangesAsync();

            return true;
        }
    }
}
