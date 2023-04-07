using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;
using course_project_spring_2023_api.Models.DTO;

namespace course_project_spring_2023_api.Services.PersonServices
{
    public interface IPersonService
    {
        Task<Person?> Authenticate(AuthenticateModel model, ApiContext db);
        Task<Person?> GetPersonById(int id, ApiContext db);
    }
}
