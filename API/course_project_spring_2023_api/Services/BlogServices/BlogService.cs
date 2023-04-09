using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;
using course_project_spring_2023_api.Models.DTO;
using Microsoft.Build.Logging;
using Microsoft.EntityFrameworkCore;
using System.Reflection.Metadata;

namespace course_project_spring_2023_api.Services.BlogServices
{
    public class BlogService : IBlogService
    {
        public async Task<Blog?> AddNew(NewBlogModel model, ApiContext db)
        {
            var blog = new Blog(model);
            foreach (var item in model.Tags)
            {
                var tag = db.Tags.FirstOrDefault(x => x.Name == item.Name);
                if (!Equals(tag, null))
                    blog.Tags.Add(tag);
            }
            var res = await db.Blogs.AddAsync(blog);

            if (Equals(res, null)) return null;
            await db.SaveChangesAsync();
            return res.Entity;
        }

        public async Task<bool> DeleteBlog(int id, ApiContext db)
        {
            var b = await db.Blogs.FirstOrDefaultAsync(x => x.Id == id);
            if (Equals(b, null)) return false;
            db.Blogs.Remove(b);
            await db.SaveChangesAsync();
            return true;
        }

        public async Task<IList<Blog>> GetAll(ApiContext db)
        {
            var res = await db.Blogs.ToListAsync();
            return res;
        }

        public async Task<Blog?> GetBlogById(int id, ApiContext db)
        {
            var res = await db.Blogs.FirstOrDefaultAsync(x => x.Id == id);

            if (Equals(res, null)) return null;
            return res;
        }

        public async Task<bool> Upsert(int id, Blog newBlog, ApiContext db)
        {
            var old = await db.Blogs.FirstOrDefaultAsync(x => x.Id == id);
            if (Equals(old, null)) return false;

            var res = new List<Tag>();
            foreach (var item in newBlog.Tags)
            {
                var tag = db.Tags.FirstOrDefault(x => x.Name == item.Name);
                if (!Equals(tag, null))
                    res.Add(tag);
                else
                    res.Add(new Tag() { Name = item.Name });
            }

            old.Tags.Clear();
            old.Tags = res;
            old.Name = newBlog.Name;
            await db.SaveChangesAsync();
            return true;
        }
    }
}
