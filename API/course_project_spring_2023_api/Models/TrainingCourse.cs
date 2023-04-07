﻿using Newtonsoft.Json;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace course_project_spring_2023_api.Models
{
    public class TrainingCourse
    {
        [Required]
        public long Id { get; set; }

        //[Required]
        //[JsonIgnore]
        //public long UserId { get; set; }

        //[Required]
        //public User User { get; set; }

        [Required]
        public string Name { get; set; } = "Default";
        
        [Required]
        public ICollection<Exercise> Exercises { get; set; }


        public TrainingCourse(){}
        public TrainingCourse(TrainingCourse course){
            Name = course.Name;
            Exercises = course.Exercises;
        }

        public static TrainingCourse Empty => new TrainingCourse();
    }
}