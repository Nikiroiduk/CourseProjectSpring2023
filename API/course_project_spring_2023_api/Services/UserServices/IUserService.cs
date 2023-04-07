using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;

namespace course_project_spring_2023_api.Services.UserServices
{
    public interface IUserService
    {
        Task<bool> AddCourse(long id, TrainingCourse course, ApiContext db);
        Task<User?> AddNewUser(RegistrationModel user, ApiContext db);
        Task<IEnumerable<User>> GetAll(ApiContext db);
        Task<User?> GetUserById(long id, ApiContext db);
        Task<User?> UpsertUser(User old, User newUser, ApiContext db);
    }
}
