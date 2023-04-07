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
        public DbSet<Repetition> Repetitions { get; set; }
        public DbSet<Post> Posts { get; set; }
        public DbSet<TrainingCourse> TrainingCourses { get; set; }
        public DbSet<UserCourse> UserCourses { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>()
                .HasMany(e => e.Courses)
                .WithOne(e => e.User)
                .HasForeignKey(e => e.UserId)
                .IsRequired();

            modelBuilder.Entity<UserCourse>()
                .HasOne(e => e.User)
                .WithMany(e => e.Courses)
                .HasForeignKey(e => e.UserId)
                .IsRequired();

            //modelBuilder.Entity<TrainingCourse>()
            //    .HasMany(e => e.Exercises);

            modelBuilder.Entity<Exercise>()
                .HasMany(e => e.Repetitions)
                .WithOne(e => e.Exercise)
                .HasForeignKey(e => e.ExerciseId)
                .IsRequired();

            modelBuilder.Entity<Repetition>()
                .HasOne(e => e.Exercise)
                .WithMany(e => e.Repetitions)
                .HasForeignKey(e => e.ExerciseId)
                .IsRequired();

            //modelBuilder.Entity<Post>()
            //    .HasOne(e => e.TrainingCourse);
        }
    }
}
