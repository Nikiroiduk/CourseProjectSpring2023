using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;
using course_project_spring_2023_api.Models.DTO;
using course_project_spring_2023_api.Services.PersonServices;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using NuGet.Protocol;

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
            return Ok(p);
            // TODO: Remove lazy loader creap from json
            // https://stackoverflow.com/questions/25749509/how-can-i-tell-json-net-to-ignore-properties-in-a-3rd-party-object
        }
    }
}
