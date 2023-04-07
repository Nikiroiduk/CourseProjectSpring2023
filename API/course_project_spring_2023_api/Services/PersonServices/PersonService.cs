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
            var person = await db.Persons.FirstOrDefaultAsync(x => x.Username == model.Username && x.Password == model.Password);

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
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
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
    }
}
