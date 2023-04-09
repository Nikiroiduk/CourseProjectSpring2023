using course_project_spring_2023_api.Models;
using Microsoft.EntityFrameworkCore;

namespace course_project_spring_2023_api.Context
{
    public class ApiContext : DbContext
    {
        public ApiContext(DbContextOptions<ApiContext> options) : base(options){}

        public DbSet<Person> Persons { get; set; }
        public DbSet<Course> Courses { get; set; }
        public DbSet<Blog> Blogs { get; set; }
        public DbSet<Tag> Tags { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Person>()
                .HasMany(e => e.Courses)
                .WithMany(e => e.Persons)
                .UsingEntity<PersonCourse>();

            modelBuilder.Entity<Person>()
                .HasMany(e => e.Blogs)
                .WithMany(e => e.Persons)
                .UsingEntity<PersonBlog>();

            modelBuilder.Entity<Course>()
                .HasMany(e => e.Exercises);

            modelBuilder.Entity<Blog>()
                .HasMany(e => e.Tags)
                .WithMany(e => e.Blogs)
                .UsingEntity<BlogTag>();
        }
    }
}
