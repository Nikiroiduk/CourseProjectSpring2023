using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;
using course_project_spring_2023_api.Models.DTO;
using Microsoft.EntityFrameworkCore;
using System.Data.OleDb;

namespace course_project_spring_2023_api.Services.CourseServices
{
    public class CourseService : ICourseService
    {
        public async Task<Course?> AddNew(NewCourseModel model, ApiContext db)
        {
            var course = new Course(model);
            var res = await db.Courses.AddAsync(course);
            if (Equals(res, null)) return null;
            await db.SaveChangesAsync();
            return res.Entity;
        }

        public async Task<bool> DeleteCourse(int id, ApiContext db)
        {
            var c = await db.Courses.FirstOrDefaultAsync(x => x.Id == id);
            if (Equals(c, null)) return false;
            db.Courses.Remove(c);
            await db.SaveChangesAsync();
            return true;
        }

        public async Task<IList<Course>> GetAll(ApiContext db)
        {
            var res = await db.Courses.ToListAsync();
            return res;
        }

        public async Task<Course?> GetCourseById(int id, ApiContext db)
        {
            var res = await db.Courses.FirstOrDefaultAsync(x => x.Id == id);

            if (Equals(res, null)) return null;
            return res;
        }

        public async Task<object?> Upsert(int id, Course newCourse, ApiContext db)
        {
            var old = await db.Courses.FirstOrDefaultAsync(x => x.Id == id);
            if (Equals(old, null)) return null;

            //messing with data TODO: fix this crap
            if (newCourse.Exercises.Count < old.Exercises.Count)
            {
                var i = old.Exercises.Count - newCourse.Exercises.Count;
                for (var j = i; j < old.Exercises.Count; j++)
                {
                    old.Exercises.RemoveAt(j);
                }
            }
            for (int i = 0; i < newCourse.Exercises.Count; i++)
            {
                if (i >= old.Exercises.Count)
                {
                    old.Exercises.Add(new Exercise() { Data = newCourse.Exercises[i].Data });
                    continue;
                }
                old.Exercises[i].Data = newCourse.Exercises[i].Data;
            }

            old.Exercises = newCourse.Exercises;
            old.Name = newCourse.Name;
            await db.SaveChangesAsync();
            return true;
        }
    }
}
