using course_project_spring_2023_api.Models;

namespace course_project_spring_2023_api.Services
{
    public interface IPersonService
    {
        Person Authenticate(string username, string password);
        IEnumerable<Person> GetAll();
        Person GetById(int id);
        public Person Registrate(Person user);
    }
}
