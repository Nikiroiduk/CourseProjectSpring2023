using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;
using course_project_spring_2023_api.Models.DTO;
using course_project_spring_2023_api.Services.PersonServices;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace course_project_spring_2023_api.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class PersonsController : ControllerBase
    {
        private IPersonService _personService;
        private ApiContext _context;

        public PersonsController(IPersonService personService, ApiContext context)
        {
            _personService = personService;
            _context = context;
        }

        [HttpGet("test")]
        public string test()
        {
            return "Hello";
        }

        [AllowAnonymous]
        [HttpPost("authenticate")]
        public async Task<IActionResult> Authenticate([FromBody] AuthenticateModel model)
        {
            var person = await _personService.Authenticate(model, _context);
            if (Equals(person, null)) return BadRequest(person);
            var response = new
            {
                id = person.Id,
                token = person.Token
            };

            return Ok(response);
        }

        [Authorize(Roles = $"{Role.User}, {Role.Admin}")]
        [HttpGet("{id?}")]
        public async Task<IActionResult> GetPersonById(int id)
        {
            var _id = int.Parse(User.Identity.Name);
            if (_id != id && User.IsInRole(Role.User)) return Unauthorized(id);

            var p = await _personService.GetPersonById(_id, _context);
            if (Equals(p, null)) return BadRequest(p);
            return Ok(p.json);
        }

        [AllowAnonymous]
        [HttpPost("register")]
        public async Task<IActionResult> RegisterPerson([FromBody] RegistrateModel model)
        {
            var p = await _personService.Register(model, _context);

            if (Equals(p, null)) return BadRequest(p);
            if (p is string) return BadRequest(p);
            if (p is Person person)
                return Ok(person.json);
            else
                return BadRequest("Something went wrong");
        }

        [Authorize(Roles = Role.Admin)]
        [HttpGet("getall")]
        public async Task<IActionResult> GetAll()
        {
            var ans = await _personService.GetAll(_context);

            var res = "{[";
            for (int i = 0; i < ans.Count; i++)
            {
                res += ans[i].json + (i < ans.Count - 1 ? ',' : ' ');
            }
            res += "]}";
            return Ok(res);
        }

        [Authorize(Roles = $"{Role.Admin}, {Role.User}")]
        [HttpDelete("{id?}")]
        public async Task<IActionResult> DeletePerson(int id)
        {
            var _id = int.Parse(User.Identity.Name);

            if (_id != id && User.IsInRole(Role.User)) return Unauthorized();
            if (User.IsInRole(Role.Admin) && _id == id) return Unauthorized();

            var res = await _personService.DeletePerson(id, _context);
            return res ? Ok() : BadRequest();
        }

        [Authorize(Roles = Role.User)]
        [HttpPut("upsert")]
        public async Task<IActionResult> UpsertUser([FromBody] Person person)
        {
            var id = int.Parse(User.Identity.Name);
            var res = await _personService.Upsert(id, person, _context);

            if (res is bool b)
                return b ? Ok(b) : BadRequest(b);

            return BadRequest(res);
        }
    }
}
