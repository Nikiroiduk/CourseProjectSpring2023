﻿using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace course_project_spring_2023_api.Models
{
    public class Exercise
    {
        [Required]
        public long Id { get; set; }

        [Required]
        [JsonIgnore]
        public long TrainingCourseId { get; set; }

        [Required]
        public ICollection<Repetition> Repetitions { get; set; }
    }
}
