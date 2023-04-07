using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using NuGet.Packaging;

namespace course_project_spring_2023_api.Services.PostServices
{
    public class PostService : IPostService
    {
        public async Task<Post?> CreatePost(Post post, ApiContext db)
        {
            var p = await db.Posts.AddAsync(post);
            await db.SaveChangesAsync();
            return p?.Entity;
        }

        public async Task<IEnumerable<Post>> GetAll(ApiContext db)
        {
            var posts = await db.Posts.ToListAsync();
            //foreach (var post in posts)
            //{
            //    post.TrainingCourse = await db.TrainingCourses.FindAsync(post.TrainingCourseId);
            //    var exercises = await db.Exercises.Where(x => x.TrainingCourseId == post.TrainingCourse.Id).ToListAsync();
            //    foreach (var exercise in exercises)
            //    {
            //        exercise.Repetitions = await db.Repetitions.Where(x => x.ExerciseId == exercise.Id).ToListAsync();
            //    }
            //    post.TrainingCourse.Exercises = exercises;
            //}
            return posts;
        }

        public async Task<Post?> GetById(int id, ApiContext db)
        {
            var p = await db.Posts.FirstOrDefaultAsync(x => x.Id == id);
            var course = await db.TrainingCourses.FirstOrDefaultAsync(x => x.Id == p.TrainingCourseId);
            p.TrainingCourse = course;
            var exercises = await db.Exercises.Where(x => x.TrainingCourseId == p.TrainingCourse.Id).ToListAsync();
            foreach (var exercise in exercises)
            {
                exercise.Repetitions = await db.Repetitions.Where(x => x.ExerciseId == exercise.Id).ToListAsync();
            }
            p.TrainingCourse.Exercises = exercises;
            return p;
        }
    }
}
