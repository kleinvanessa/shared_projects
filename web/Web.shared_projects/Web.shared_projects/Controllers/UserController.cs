using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
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
            try {
                return Ok(listUser);
            }
            catch(Exception ex) {
                return BadRequest($"Erro: {ex}");
            }
            
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
            var user = _context.User.Where(u => u.Id ==id).FirstOrDefault(); //
           // var user = _context.User.Where(u => EF.Functions.Like(u.FirstName, $"%{nameUser}%")).OrderByDescending(u => u.Id).FirstOrDefault();
            user.FirstName = "teste update";
            
            _context.SaveChanges();

            return Ok();
        }

        // POST api/<UserController>
        [HttpPost]
        public ActionResult Post() { // insert
            try {
                var user = new User {
                    FirstName = "hoje",
                    LastName = "maio",
                    Email = "tst@aqui.mail.com",
                    
                };
                _context.User.Add(user);
                _context.SaveChanges();
                return Ok("Insert Success");
            }
            catch (Exception ex) {
                return BadRequest($"Insert Error: {ex}");
            }
        }

        // PUT api/<UserController>/5
        [HttpPut("{id}")]
        public ActionResult Put(int id) { //update
            try {
                var user = new User {
                    Id = id,
                    FirstName = "update",
                    LastName = "31 de maio",
                    Email = "tst@mail.com",

                };
                _context.User.Update(user);
                _context.SaveChanges();
                return Ok("Update Success");
            }
            catch (Exception ex) {
                return BadRequest($"Update Error: {ex}");
            }
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
