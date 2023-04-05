using course_project_spring_2023_api.Models;

namespace course_project_spring_2023_api.Services.PostServices
{
    public class PostService : IPostService
    {
        private List<Post> _posts = new List<Post>
        {
            new Post
            {
                Id = 1,
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
                    Id = 1,
                    Name = "Pull-ups",
                    Exercises = new List<Exercise>
                    { 
                        new Exercise
                        {
                            Id = 1,
                            Repetitions = new List<uint>{ 1, 2, 1, 1, 3 },
                            Timeout = new List<uint>{ 120, 180, 120, 180 }
                        },
                        new Exercise
                        {
                            Id = 2,
                            Repetitions = new List<uint>{ 2, 2, 1, 1, 3 },
                            Timeout = new List<uint>{ 120, 180, 120, 180 }
                        },
                        new Exercise
                        {
                            Id = 3,
                            Repetitions = new List<uint>{ 2, 2, 1, 2, 3 },
                            Timeout = new List<uint>{ 120, 180, 120, 180 }
                        }
                    }
                }
            },
        };

        public Post? CreatePost(Post post)
        {
            _posts.Add(post);
            return post;
        }

        public IEnumerable<Post> GetAll()
        {
            return _posts;
        }

        public Post? GetById(int id)
        {
            return _posts.FirstOrDefault(x => x.Id == id);
        }
    }
}
