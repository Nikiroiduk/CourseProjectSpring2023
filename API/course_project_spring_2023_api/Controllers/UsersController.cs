using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;
using course_project_spring_2023_api.Services.PersonServices;
using course_project_spring_2023_api.Services.UserServices;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

namespace course_project_spring_2023_api.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class UsersController : ControllerBase
    {
        private IUserService _userService;
        private ApiContext _context;

        public UsersController(IUserService userService, ApiContext context)
        {
            _userService = userService;
            _context = context;
        }

        [Authorize(Roles = Role.User)]
        [HttpPost("addcourse")]
        public async Task<IActionResult> AddCourse([FromBody] Post post)
        {
            var id = long.Parse(User.Identity.Name);
            var res = await _userService.AddCourse(id, post.TrainingCourse, _context);
            return res ? Ok(res) : BadRequest(res);
        }

        [AllowAnonymous]
        [HttpPost("adduser")]
        public async Task<IActionResult> AddNewUser([FromBody] RegistrationModel user)
        {
            var res = await _userService.AddNewUser(user, _context);
            if (Equals(res, null)) return BadRequest(res);
            else return Ok(res);
        }

        [Authorize(Roles = Role.User)]
        [HttpGet("getbyid")]
        public async Task<IActionResult> GetById()
        {
            var id = long.Parse(User.Identity.Name);
            var res = await _userService.GetUserById(id, _context);
            if (Equals(res, null)) return BadRequest(res);
            else return Ok(res);
        }

        [Authorize(Roles = Role.Admin)]
        [HttpGet("getall")]
        public async Task<IActionResult> GetAll()
        {
            var r = await _userService.GetAll(_context);
            if (r.IsNullOrEmpty()) return BadRequest(r);
            else return Ok(r);
        }

        [Authorize(Roles = Role.User)]
        [HttpPut("upsert")]
        public async Task<IActionResult> UpsertUser([FromBody] User user)
        {
            var id = int.Parse(User.Identity.Name);
            var curUser = await _context.Users.FirstOrDefaultAsync(x => x.Id == id);
            var r = await _userService.UpsertUser(curUser, user, _context);
            if (Equals(r, null)) return BadRequest(r);
            else return Ok(r);
        }
    }
}
