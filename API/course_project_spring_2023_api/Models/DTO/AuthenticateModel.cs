using course_project_spring_2023_api.Services;
using Newtonsoft.Json.Linq;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace course_project_spring_2023_api.Models.DTO
{
    public class AuthenticateModel
    {
        [Required]
        public string Username { get; set; } = "default";

        [Required]
        public string Password { get; set; } = "default";

        [NotMapped]
        [JsonIgnore]
        public string PlainPassword
        {
            set { PasswordService.DecryptCipherTextToPlainText(value); }
            get { return PasswordService.EncryptPlainTextToCipherText(Password); }
        }
    }
}
