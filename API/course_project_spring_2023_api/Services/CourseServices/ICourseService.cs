using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models.DTO;
using course_project_spring_2023_api.Models;

namespace course_project_spring_2023_api.Services.CourseServices
{
    public interface ICourseService
    {
        Task<Course?> GetCourseById(int id, ApiContext db);
        Task<Course?> AddNew(NewCourseModel model, ApiContext db);
        Task<IList<Course>> GetAll(ApiContext db);
        Task<bool> DeleteCourse(int id, ApiContext db);
        Task<object?> Upsert(int id, Course newCourse, ApiContext db);
    }
}
