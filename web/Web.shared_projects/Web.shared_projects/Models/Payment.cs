using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Web.shared_projects.Models {
    public class Payment {
        public int Id { get; set; }
        public int userId { get; set; }
        public String Bank { get; set; }
        public int Agency { get; set; }
        public long Account { get; set; }
    }
}
