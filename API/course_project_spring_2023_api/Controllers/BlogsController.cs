using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;
using course_project_spring_2023_api.Models.DTO;
using course_project_spring_2023_api.Services.BlogServices;
using course_project_spring_2023_api.Services.CourseServices;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace course_project_spring_2023_api.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class BlogsController : ControllerBase
    {
        private IBlogService _blogService;
        private ApiContext _context;

        public BlogsController(IBlogService blogService, ApiContext context)
        {
            _blogService = blogService;
            _context = context;
        }

        [Authorize(Roles = $"{Role.User}, {Role.Admin}")]
        [HttpGet("getall")]
        public async Task<IActionResult> GetAll()
        {
            var ans = await _blogService.GetAll(_context);

            var res = "";
            for (int i = 0; i < ans.Count; i++)
            {
                res += ans[i].json;
            }

            return Ok(res);
        }

        [Authorize(Roles = $"{Role.User}, {Role.Admin}")]
        [HttpGet("{id?}")]
        public async Task<IActionResult> GetById(int id)
        {
            var res = await _blogService.GetBlogById(id, _context);

            if (Equals(res, null)) return BadRequest(res);
            return Ok(res.json);
        }

        [Authorize(Roles = Role.Admin)]
        [HttpPost("new")]
        public async Task<IActionResult> AddNew([FromBody] NewBlogModel model)
        {
            var res = await _blogService.AddNew(model, _context);

            if (Equals(res, null)) return BadRequest(res);
            return Ok(res.json);
        }

        [Authorize(Roles = Role.Admin)]
        [HttpDelete("{id?}")]
        public async Task<IActionResult> Delete(int id)
        {
            var res = await _blogService.DeleteBlog(id, _context);

            return res ? Ok(res) : BadRequest(res);
        }

        [Authorize(Roles = Role.Admin)]
        [HttpPut("{id?}")]
        public async Task<IActionResult> Upsert(int id, [FromBody] Blog blog)
        {
            var res = await _blogService.Upsert(id, blog, _context);

            return res ? Ok(res) : BadRequest(res);
        }

        // TODO: Add images support https://stackoverflow.com/questions/19005991/how-to-handle-images-using-webapi
    }
}
