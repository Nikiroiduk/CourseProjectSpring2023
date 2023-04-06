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

        public async Task<Person?> Registrate(Person person, ApiContext db)
        {
            var p = await db.Persons.AddAsync(person);
            if (!Equals(p, null)) await db.SaveChangesAsync();
            return p?.Entity;
        }

        //public async Task<bool> UpsertUser(User user, ApiContext db)
        //{
        //    //TODO: if user will change email then it doesn't work (id don't work in this case either)
        //    var cur = await db.Persons.FirstOrDefaultAsync(x => x.Id == user.Id);
        //    if (Equals(cur, null))
        //        return false;
        //    if (cur.Role == Role.User)
        //        return true;
        //    if (cur is not User u)
        //        return false;
        //    else
        //    {
        //        u.Courses = user.Courses;
        //        u.Height = user.Height;
        //        u.Weight = user.Weight;
        //        u.BirthDay = user.BirthDay;
        //        u.Username = user.Username;
        //        u.FirstName = user.FirstName;
        //        u.LastName = user.LastName;
        //        u.Email = user.Email;
        //        db.Persons.Update(cur);
        //        await db.SaveChangesAsync();
        //        return true;
        //    }
        //}
    }
}
