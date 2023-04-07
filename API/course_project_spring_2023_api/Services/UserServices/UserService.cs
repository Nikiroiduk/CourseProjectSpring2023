using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;
using Microsoft.EntityFrameworkCore;

namespace course_project_spring_2023_api.Services.UserServices
{
    public class UserService : IUserService
    {
        public async Task<bool> AddCourse(long id, TrainingCourse course, ApiContext db)
        {
            //TODO: Exceptions
            //var user = await db.Users.FindAsync(id);
            //if (Equals(user, null)) return false;
            //var _course = await db.TrainingCourses.AddAsync(new TrainingCourse(course));
            //user.Courses.Add(new TrainingCourse(course));
            //await db.SaveChangesAsync();
            //return true;
            return false;
        }

        public async Task<User?> AddNewUser(RegistrationModel user, ApiContext db)
        {
            var _user = new User(user);
            var res = await db.Users.AddAsync(_user);
            if (Equals(res, null)) return null;
            await db.SaveChangesAsync();
            return _user;
        }

        public async Task<IEnumerable<User>> GetAll(ApiContext db)
        {
            return await db.Users.ToListAsync();
        }

        public async Task<User?> GetUserById(long id, ApiContext db)
        {
            var user = await db.Users.FirstOrDefaultAsync(x => x.Id == id);
            if (Equals(user, null)) return null;

            user.Courses = await db.UserCourses.Where(x => x.UserId == user.Id).ToListAsync();
            foreach (var course in user.Courses)
            {
                course.Exercises = await db.Exercises.Where(x => x.TrainingCourseId == course.Id).ToListAsync();
                foreach (var exercise in course.Exercises)
                {
                    exercise.Repetitions = await db.Repetitions.Where(x => x.ExerciseId == exercise.Id).ToListAsync();
                }
            }

            await db.SaveChangesAsync();
            return user;
        }

        public async Task<User?> UpsertUser(User old, User newUser, ApiContext db)
        {
            old.Courses = newUser.Courses;
            old.Height = newUser.Height;
            old.Weight = newUser.Weight;
            old.BirthDay = newUser.BirthDay;
            old.Username = newUser.Username;
            old.FirstName = newUser.FirstName;
            old.LastName = newUser.LastName;
            old.Email = newUser.Email;
            await db.SaveChangesAsync();
            return newUser;
        }
    }
}
