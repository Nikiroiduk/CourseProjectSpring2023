using course_project_spring_2023_api.Models;

namespace course_project_spring_2023_api.Services.PostServices
{
    public interface IPostService
    {
        Post? CreatePost(Post post);
        IEnumerable<Post> GetAll();
        Post? GetById(int id);
    }
}
