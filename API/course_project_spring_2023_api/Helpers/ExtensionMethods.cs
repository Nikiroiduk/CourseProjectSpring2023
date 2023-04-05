using course_project_spring_2023_api.Models;

namespace course_project_spring_2023_api.Helpers
{
    public static class ExtensionMethods
    {
        public static IEnumerable<Person>? WithoutPasswords(this IEnumerable<Person> persons)
        {
            if (persons == null) return null;

            return persons.Select(x => x.WithoutPassword());
        }

        public static Person? WithoutPassword(this Person? person)
        {
            if (person == null) return null;

            person.Password = string.Empty;
            return person;
        }
    }
}
