using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;
using Microsoft.EntityFrameworkCore;

namespace course_project_spring_2023_api.Services.PostServices
{
    public class PostService : IPostService
    {
        public async Task<Post?> CreatePost(Post post, ApiContext db)
        {
            var p = await db.Posts.AddAsync(post);
            if (!Equals(p, null)) await db.SaveChangesAsync();
            return p?.Entity;
        }

        public async Task<IEnumerable<Post>> GetAll(ApiContext db)
        {
            var posts = await db.Posts.ToListAsync();
            return posts;
        }

        public async Task<Post?> GetById(int id, ApiContext db)
        {
            var p = await db.Posts.FindAsync((long)id);
            return p;
        }
    }
}
