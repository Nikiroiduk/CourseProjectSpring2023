using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;
using course_project_spring_2023_api.Models.DTO;
using course_project_spring_2023_api.Services.CourseServices;
using course_project_spring_2023_api.Services.PersonServices;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.Reflection.Metadata.Ecma335;

namespace course_project_spring_2023_api.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class CoursesController : ControllerBase
    {
        private ICourseService _courseService;
        private ApiContext _context;

        public CoursesController(ICourseService courseService, ApiContext context)
        {
            _courseService = courseService;
            _context = context;
        }

        [Authorize(Roles = $"{Role.Admin}, {Role.User}")]
        [HttpGet("getall")]
        public async Task<IActionResult> GetAll()
        {
            var ans = await _courseService.GetAll(_context);

            var res = "{[";
            for (int i = 0; i < ans.Count; i++)
            {
                res += ans[i].json + (i < ans.Count - 1 ? ',' : ' ');
            }
            res += "]}";

            return Ok(res);
        }

        [Authorize(Roles = $"{Role.Admin}, {Role.User}")]
        [HttpGet("{id?}")]
        public async Task<IActionResult> GetById(int id)
        {
            var res = await _courseService.GetCourseById(id, _context);
            if (Equals(res, null)) return BadRequest(res);
            return Ok(res.json);
        }

        [Authorize(Roles = Role.Admin)]
        [HttpPost("new")]
        public async Task<IActionResult> AddNew([FromBody] NewCourseModel course)
        {
            var res = await _courseService.AddNew(course, _context);

            if (Equals(res, null)) return BadRequest(res);
            return Ok(res.json);
        }

        [Authorize(Roles = Role.Admin)]
        [HttpDelete("{id?}")]
        public async Task<IActionResult> Delete(int id)
        {
            var res = await _courseService.DeleteCourse(id, _context);
            return res ? Ok(res) : BadRequest(res);
        }

        [Authorize(Roles = Role.Admin)]
        [HttpPut("{id?}")]
        public async Task<IActionResult> Upsert(int id, [FromBody] Course course)
        {
            var res = await _courseService.Upsert(id, course, _context);

            if (Equals(res, null)) return BadRequest();

            if (res is bool b)
            {
                return b ? Ok(b) : BadRequest(b);
            }

            return BadRequest();
        }
    }
}
