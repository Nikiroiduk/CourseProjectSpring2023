using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;
using course_project_spring_2023_api.Services.PersonServices;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;

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

        [AllowAnonymous]
        [HttpPost("authenticate")]
        public async Task<IActionResult> Authenticate([FromBody] AuthenticateModel model)
        {
            var person = await _personService.Authenticate(model.Username, model.Password, _context);

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
        public async Task<IActionResult> Register([FromBody] RegistrationModel person)
        {
            var _person = await _personService.Registrate(person, _context);
            if (_person == null)
                return BadRequest(new { message = "Entered data is wrong" });
            return Ok(_person);
        }

        //[Authorize(Roles = Role.Admin)]
        //[HttpPost("admin_register")]
        //public IActionResult AdminRegister([FromBody] PowerUser powerUser)
        //{
        //    var _powerUser = _personService.Registrate(powerUser, _context);
        //    if (_powerUser == null)
        //        return BadRequest(new { message = "Entered data is wrong" });
        //    return Ok(_powerUser);
        //}

        [Authorize(Roles = Role.Admin)]
        [HttpGet("getall")]
        public async Task<IActionResult> GetAll()
        {
            var persons = await _personService.GetAll(_context);
            return Ok(persons);
        }

        [Authorize(Roles = Role.Admin)]
        [HttpGet("{id?}")]
        public async Task<IActionResult> GetById(int id)
        {
            var currentUserId = int.Parse(User.Identity.Name);
            if (currentUserId != id && User.IsInRole(Role.User))
                return Unauthorized();

            var user = await _personService.GetById(id, _context);

            if (Equals(user, null))
                return NotFound();

            return Ok(user);
        }

        [Authorize(Roles = Role.User)]
        [HttpGet("getuser")]
        public async Task<IActionResult> GetByIdUser()
        {
            var currentUserId = int.Parse(User.Identity.Name);
            var user = await _personService.GetByIdUser(currentUserId, _context);

            if (Equals(user, null))
                return NotFound();

            return Ok(user);
        }

        [Authorize(Roles = $"{Role.Admin}, {Role.User}")]
        [HttpPut("upsert")]
        public async Task<IActionResult> UpsertUser([FromBody] User user)
        {
            var id = int.Parse(User.Identity.Name);
            var curUser = await _context.Users.FirstOrDefaultAsync(x => x.Id == id);
            var r = await _personService.UpsertUser(curUser, user, _context);
            return r ? Ok(r) : BadRequest(curUser);
        }
    }
}
