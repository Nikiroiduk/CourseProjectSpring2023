using course_project_spring_2023_api.Models;
using Microsoft.EntityFrameworkCore;

namespace course_project_spring_2023_api.Context
{
    public class ApiContext : DbContext
    {
        public ApiContext(DbContextOptions<ApiContext> options) : base(options)
        {
        }

        //public DbSet<Person> Persons { get; set; }
        //public DbSet<User> Users { get; set; }
        //public DbSet<Exercise> Exercises { get; set; }
        //public DbSet<Repetition> Repetitions { get; set; }
        //public DbSet<Post> Posts { get; set; }
        //public DbSet<TrainingCourse> TrainingCourses { get; set; }
        //public DbSet<UserCourse> UserCourses { get; set; }

        public DbSet<Person> Persons { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Person>()
                .HasMany(e => e.Courses)
                .WithMany(e => e.Persons)
                .UsingEntity<PersonCourse>();

            modelBuilder.Entity<Course>()
                .HasMany(e => e.Exercises)
                .WithOne(e => e.Course)
                .HasForeignKey(e => e.CourseId)
                .IsRequired();
        }
    }
}
