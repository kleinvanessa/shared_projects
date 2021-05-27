using System;
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
       // [Required]
      //  public DateTime BirthDate { get; set; }
       // [Required]
        public String Email { get; set; }
        public ICollection<UserProject> UsersProjects { get; set; }
        // [Required]
        //public String Password { get; set; }
    }
}
