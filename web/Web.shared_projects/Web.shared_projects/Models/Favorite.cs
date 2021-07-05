using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Web.shared_projects.Models {
    public class Favorite {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int ProjectId { get; set; }
    }
}
