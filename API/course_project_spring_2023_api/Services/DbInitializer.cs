using course_project_spring_2023_api.Context;
using course_project_spring_2023_api.Models;

namespace course_project_spring_2023_api.Services
{
    public class DbInitializer
    {
        public static void Initialize(ApiContext context)
        {
            context.Database.EnsureCreated();

            if (!context.Persons.Any())
            {
                var persons = new Person[]
                {
                    new Person { FirstName = "Admin", LastName = "Admin", Username = "admin", Password = "admin", IsNewPerson = false, Role = Role.Admin },
                    new User { FirstName = "User", LastName = "User", Username = "user", Password = "user", BirthDay = DateTime.Now, Weight = 80, Height = 180, IsNewPerson = false, Role = Role.User },
                };

                foreach (var p in persons)
                {
                    context.Persons.Add(p);
                }
            }


            if (!context.Posts.Any())
            {
                var posts = new Post[]
                {
                    new Post
                    {
                        Description = "Post desc",
                        Difficulty = Difficulty.Normal,
                        DurationOfOneSession = 30,
                        IsNeedEquipment = false,
                        Name = "Pull-ups",
                        ShortDescription = "Short desc",
                        Thumbnail = "Path to file on server or base 64 string who knows",
                        TotalDuration = 13,
                        TrainingCourse = new TrainingCourse
                        {
                            Name = "Pull-ups",
                            Exercises = new List<Exercise>
                            {
                                new Exercise
                                {
                                    Repetitions = new List<Repetition>{
                                        new Repetition
                                        {
                                            Value = 5,
                                            Timeout = 30
                                        } 
                                    }
                                },
                                new Exercise
                                {
                                    Repetitions = new List<Repetition>{
                                        new Repetition
                                        {
                                            Value = 10,
                                            Timeout = 40
                                        }
                                    }
                                },
                                new Exercise
                                {
                                    Repetitions = new List<Repetition>{
                                        new Repetition
                                        {
                                            Value = 15,
                                            Timeout = 50
                                        }
                                    }
                                },
                            }
                        }
                    },
                };

                foreach (var p in posts)
                {
                    context.Posts.Add(p);
                }
            }

            context.SaveChanges();
        }
    }
}
