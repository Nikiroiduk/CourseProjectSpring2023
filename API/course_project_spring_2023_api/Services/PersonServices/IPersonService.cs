using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;

namespace course_project_spring_2023_api.Services.PersonServices
{
    public interface IPersonService
    {
        Task<Person?> Authenticate(string username, string password, ApiContext db);
        Task<IEnumerable<Person>?> GetAll(ApiContext db);
        Task<Person?> GetById(int id, ApiContext db);
        Task<User?> GetByIdUser(int id, ApiContext db);
        Task<Person?> Registrate(RegistrationModel user, ApiContext db);
        Task<bool> UpsertUser(User old, User newUser, ApiContext db);
    }
}
