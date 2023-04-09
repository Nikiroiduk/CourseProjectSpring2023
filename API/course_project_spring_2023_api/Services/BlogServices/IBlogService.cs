using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models.DTO;
using course_project_spring_2023_api.Models;

namespace course_project_spring_2023_api.Services.BlogServices
{
    public interface IBlogService
    {
        Task<Blog?> GetBlogById(int id, ApiContext db);
        Task<Blog?> AddNew(NewBlogModel model, ApiContext db);
        Task<IList<Blog>> GetAll(ApiContext db);
        Task<bool> DeleteBlog(int id, ApiContext db);
        Task<bool> Upsert(int id, Blog newBlog, ApiContext db);
    }
}
