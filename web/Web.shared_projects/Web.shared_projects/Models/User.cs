﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace Web.shared_projects.Models {
    public class User {
        // [Required]
        public int Id { get; set; }
       // [Required]
        public String FirstName { get; set; }
        //[Required]
        public String LastName { get; set; }
        public String Email { get; set; }
        public long Contact { get; set; }
        public ICollection<UserProject> UsersProjects { get; set; }
        public String Password { get; set; }
    }
}
