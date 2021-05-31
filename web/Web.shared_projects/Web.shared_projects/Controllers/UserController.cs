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

        public readonly SharedProjContext _context;
        public UserController(SharedProjContext context) {
            _context = context;
        }

        // GET: api/<UserController>
        [HttpGet]
        public ActionResult Get() { //select em todas os dados da tabela User
            //var listUser =  _context.User.ToList();
            var listUser = (from user in _context.User select user).ToList();
            return Ok(listUser);
        }

        // GET api/<UserController>/5
        [HttpGet("insert/{nameUser}")]
        public ActionResult GetInsert(string nameUser) { //insert na tabela User
            var user = new User { FirstName = nameUser};
           
            _context.User.Add(user);
            _context.SaveChanges();
           
            return Ok();
        }
        [HttpGet("update/{id}")]
        public ActionResult GetUpdate(string nameUser, int id) { //update na tabela User
            var user = _context.User.Where(u => u.Id ==id).FirstOrDefault();
            user.FirstName = "teste update";
            
            _context.SaveChanges();

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
            var user = _context.User.Where(x => x.Id == id).Single();
            _context.User.Remove(user);
            _context.SaveChanges();
        }
    }
}
