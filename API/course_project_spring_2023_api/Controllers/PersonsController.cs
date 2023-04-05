using course_project_spring_2023_api.Models;
using course_project_spring_2023_api.Services.PersonServices;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;

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

            if (Equals(person, null))
                return BadRequest(new { message = "Username or password is incorrect" });

            var response = new
            {
                id = person.Id,
                token = person.Token
            };

            return Ok(response);
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

        [Authorize(Roles = $"{Role.Admin}, {Role.User}")]
        [HttpGet("{id?}")]
        public IActionResult GetById(int id)
        {
            var currentUserId = int.Parse(User.Identity.Name);
            if (currentUserId != id && User.IsInRole(Role.User))
                return Unauthorized();

            var user = _personService.GetById(id);

            if (Equals(user, null))
                return NotFound();

            return Ok(user);
        }
    }
}
