using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Web.shared_projects.Models {
    public class Curriculum {
        public int Id { get; set; }
        public int userId { get; set; }
        public String Institution { get; set; }
        public String Course { get; set; }
        public String Activites { get; set; }

    }
}
