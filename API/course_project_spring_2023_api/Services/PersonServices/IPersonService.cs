using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;
using course_project_spring_2023_api.Models.DTO;

namespace course_project_spring_2023_api.Services.PersonServices
{
    public interface IPersonService
    {
        Task<Person?> Authenticate(AuthenticateModel model, ApiContext db);
        Task<Person?> GetPersonById(int id, ApiContext db);
        Task<object?> Register(RegistrateModel model, ApiContext db);
        Task<IList<Person>> GetAll(ApiContext db);
        Task<bool> DeletePerson(int id, ApiContext db);
        Task<object?> Upsert(int id, Person newPerson, ApiContext db);
    }
}
