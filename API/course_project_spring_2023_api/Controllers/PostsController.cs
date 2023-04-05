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

        public PostsController(IPostService postService)
        {
            _postService = postService;
        }

        [Authorize(Roles = Role.Admin)]
        [HttpPost("addpost")]
        public IActionResult AdminRegister([FromBody] Post post)
        {
            var _post = _postService.CreatePost(post);
            if (_post == null)
                return BadRequest(new { message = "Entered data is wrong" });
            return Ok(_post);
        }

        [Authorize(Roles = $"{Role.Admin}, {Role.User}")]
        [HttpGet("getall")]
        public IActionResult GetAll()
        {
            var posts = _postService.GetAll();
            return Ok(posts);
        }

        [Authorize(Roles = $"{Role.Admin}, {Role.User}")]
        [HttpGet("{id?}")]
        public IActionResult GetById(int id) 
        {
            var post = _postService.GetById(id);
            if (Equals(post, null))
                return NotFound();

            return Ok(post);
        }
    }
}
