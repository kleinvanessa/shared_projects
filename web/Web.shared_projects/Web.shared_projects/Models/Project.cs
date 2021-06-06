using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Web.shared_projects.Models {
    public class Project {
        public int Id { get; set; }
        public String ProjectName { get; set; }
        public String Description { get; set; }

        public int userAdminId { get; set; }

        public int CategoryId { get; set; }

        public AreaKnowledge Category { get; set; }

        public ICollection<UserProject> UsersProjects {get; set;}

    }
}
