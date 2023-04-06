using course_project_spring_2023_api.Models;
using Microsoft.EntityFrameworkCore;

namespace course_project_spring_2023_api.Context
{
    public class ApiContext : DbContext
    {
        public ApiContext(DbContextOptions<ApiContext> options) : base(options)
        {
        }

        public DbSet<Person> Persons { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Exercise> Exercises { get; set; }
        public DbSet<Post> Posts { get; set; }
        public DbSet<TrainingCourse> TrainingCourses { get; set; }
    }
}
