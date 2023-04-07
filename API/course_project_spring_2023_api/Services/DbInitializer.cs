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
                    new Person
                    {
                        Username = "admin",
                        Password = "admin",
                        Role = Role.Admin
                    },
                    new Person
                    {
                        Username = "user",
                        Password = "user",
                        Role = Role.User,
                        Height = 180,
                        Weight = 80
                    },
                    new Person
                    {
                        Username = "user1",
                        Password = "user1",
                        Role = Role.User,
                        Height = 200,
                        Weight = 80,
                        Courses = new List<Course>()
                        {
                            new Course 
                            { 
                                Name = "Pull-ups", 
                                Exercises = new List<Exercise>
                                {
                                    new Exercise { Data = "1, 20, 1"},
                                    new Exercise { Data = "2, 20, 1"},
                                    new Exercise { Data = "2, 20, 2"},
                                    new Exercise { Data = "2, 20, 3"},
                                    new Exercise { Data = "4, 20, 3"},
                                } 
                            },
                            new Course 
                            { 
                                Name = "Push-ups",
                                Exercises = new List<Exercise>
                                {
                                    new Exercise { Data = "1, 20, 1"},
                                    new Exercise { Data = "2, 20, 1"},
                                    new Exercise { Data = "2, 20, 2"},
                                    new Exercise { Data = "2, 20, 3"},
                                    new Exercise { Data = "4, 20, 3"},
                                }
                            },
                        }
                    }
                };

                foreach (var person in persons)
                {
                    context.Persons.Add(person);
                }

            }
            context.SaveChanges();
        }
    }
}
