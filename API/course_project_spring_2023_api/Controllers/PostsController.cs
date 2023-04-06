using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;
using course_project_spring_2023_api.Services.PostServices;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace course_project_spring_2023_api.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class PostsController : ControllerBase
    {
        private IPostService _postService;
        private ApiContext _context;

        public PostsController(IPostService postService, ApiContext context)
        {
            _postService = postService;
            _context = context;
        }

        [Authorize(Roles = Role.Admin)]
        [HttpPost("addpost")]
        public async Task<IActionResult> AdminRegister([FromBody] Post post)
        {
            var _post = await _postService.CreatePost(post, _context);
            if (_post == null)
                return BadRequest(new { message = "Entered data is wrong" });
            return Ok(_post);
        }

        [Authorize(Roles = $"{Role.Admin}, {Role.User}")]
        [HttpGet("getall")]
        public async Task<IActionResult> GetAll()
        {
            var posts = await _postService.GetAll(_context);
            return Ok(posts);
        }

        [Authorize(Roles = $"{Role.Admin}, {Role.User}")]
        [HttpGet("{id?}")]
        public async Task<IActionResult> GetById(int id) 
        {
            var post = await _postService.GetById(id, _context);
            if (Equals(post, null))
                return NotFound();

            return Ok(post);
        }
    }
}
