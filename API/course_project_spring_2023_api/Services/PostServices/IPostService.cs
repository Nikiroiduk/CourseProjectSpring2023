using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;

namespace course_project_spring_2023_api.Services.PostServices
{
    public interface IPostService
    {
        Task<Post?> CreatePost(Post post, ApiContext db);
        Task<IEnumerable<Post>> GetAll(ApiContext db);
        Task<Post?> GetById(int id, ApiContext db);
    }
}
