using course_project_spring_2023_api.Models;
using course_project_spring_2023_api.Services;
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

        public PersonsController(IPersonService personService)
        {
            _personService = personService;
        }

        [AllowAnonymous]
        [HttpPost("authenticate")]
        public IActionResult Authenticate([FromBody] AuthenticateModel model)
        {
            var person = _personService.Authenticate(model.Username, model.Password);

            if (person == Person.Empty)
                return BadRequest(new { message = "Username or password is incorrect" });

            return Ok(person.Token);
            //return Ok(person);
        }

        [AllowAnonymous]
        [HttpPost("register")]
        public IActionResult Register([FromBody] Person person)
        {
            var _person = _personService.Registrate(person);
            if (_person == null)
                return BadRequest(new { message = "Entered data is wrong" });
            return Ok(_person);
        }

        [Authorize(Roles = Role.Admin)]
        [HttpPost("admin_register")]
        public IActionResult AdminRegister([FromBody] PowerUser powerUser)
        {
            var _powerUser = _personService.Registrate(powerUser);
            if (_powerUser == null)
                return BadRequest(new { message = "Entered data is wrong" });
            return Ok(_powerUser);
        }

        [Authorize(Roles = Role.Admin)]
        [HttpGet("getall")]
        public IActionResult GetAll()
        {
            var persons = _personService.GetAll();
            return Ok(persons);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            // only allow admins to access other user records
            var currentUserId = int.Parse(User.Identity.Name);
            if (id != currentUserId && !User.IsInRole(Role.Admin))
                return Forbid();

            var user = _personService.GetById(id);

            if (user == null)
                return NotFound();

            return Ok(user);
        }
    }
}
