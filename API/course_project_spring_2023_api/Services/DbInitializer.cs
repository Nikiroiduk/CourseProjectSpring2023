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
                        PlainPassword = "admin",
                        Role = Role.Admin,
                        IsNewUser = false,
                        Blogs = new List<Blog>()
                        {
                            new Blog()
                            {
                                Name = "Blog 1",
                                Tags = new List<Tag>()
                                {
                                    new Tag() { Name = "News" },
                                    new Tag() { Name = "Sport" }
                                },
                                Content = "Laboris elit et magna pariatur et cupidatat esse. " +
                                "Irure ad elit ullamco ut anim consectetur ad incididunt amet. " +
                                "Excepteur laboris enim veniam sunt voluptate nostrud. Dolore " +
                                "dolor consectetur deserunt irure. Pariatur do officia sint " +
                                "exercitation aliqua veniam ipsum ipsum dolore consectetur. " +
                                "Nisi eiusmod occaecat aliquip labore.\r\nNostrud incididunt " +
                                "pariatur aute in eiusmod. Nostrud cupidatat qui veniam est " +
                                "veniam sit veniam elit magna Lorem cupidatat deserunt excepteur " +
                                "culpa. Aute eu eu adipisicing aliquip in ad. Reprehenderit " +
                                "proident mollit do velit fugiat ipsum non cupidatat commodo " +
                                "nisi.\r\nNulla adipisicing duis mollit occaecat duis mollit " +
                                "dolore. Irure tempor adipisicing enim culpa incididunt nisi " +
                                "proident ex et commodo. Excepteur minim velit occaecat culpa " +
                                "consectetur nisi excepteur deserunt duis sit nostrud mollit. " +
                                "Qui excepteur eu ad irure.\r\nDeserunt qui Lorem occaecat " +
                                "reprehenderit veniam fugiat laboris culpa adipisicing ad " +
                                "aute consectetur fugiat. Laboris deserunt veniam cillum est " +
                                "dolor esse consequat adipisicing non officia dolor culpa est. " +
                                "Tempor veniam aliquip ad incididunt ullamco ut in et do dolore " +
                                "esse nisi id pariatur."
                            }
                        }
                    },
                    new Person
                    {
                        Username = "user",
                        PlainPassword = "user",
                        Role = Role.User,
                        Height = 180,
                        Weight = 80
                    },
                    new Person
                    {
                        Username = "user1",
                        PlainPassword = "user1",
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
