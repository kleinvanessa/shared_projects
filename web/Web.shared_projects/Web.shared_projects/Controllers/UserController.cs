using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Web.shared_projects.Data;
using Web.shared_projects.Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Web.shared_projects.Controllers {
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase {
        // GET: api/<UserController>
        [HttpGet]
        public ActionResult<IEnumerable<string>> Get() {
            return new string[] { "value1", "value2" };
        }

        // GET api/<UserController>/5
        [HttpGet("{id}")]
        public ActionResult Get(int id) {
            var user = new User { FirstName = "Vanessa", LastName = "Klein", Email = "vanessa@gmail.com" };
            using (var context = new SharedProjContext()) {
                context.User.Add(user);
                context.SaveChanges();
            }
            return Ok();
        }

        // POST api/<UserController>
        [HttpPost]
        public void Post([FromBody] string value) {
        }

        // PUT api/<UserController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value) {
        }

        // DELETE api/<UserController>/5
        [HttpDelete("{id}")]
        public void Delete(int id) {
        }
    }
}
