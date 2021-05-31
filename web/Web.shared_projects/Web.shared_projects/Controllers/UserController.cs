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
            try {
                return Ok(new User());
            }
            catch(Exception ex) {
                return BadRequest($"Erro: {ex}");
            }
            
        }

        // POST api/<UserController>
        [HttpPost]
        public ActionResult Post(User model) { // insert
            try {
                _context.User.Add(model); // model é o json 
                _context.SaveChanges();
                return Ok("Insert User Success");
            }
            catch (Exception ex) {
                return BadRequest($"Insert User Error: {ex}");
            }
        }

        // PUT api/<UserController>/5
        [HttpPut("{id}")]
        public ActionResult Put(int id, User model) { //update
            try {
                if(_context.User.AsNoTracking().FirstOrDefault(u => u.Id == id) != null) {
                    _context.User.Update(model);
                    _context.SaveChanges();
                    return Ok("Update User Success");
                }
                else {
                    return Ok("Id User not found");
                }                
                
                
                
            }
            catch (Exception ex) {
                return BadRequest($"Update User Error: {ex}");
            }
        }

        // DELETE api/<UserController>/5
        [HttpDelete("{id}")]
        public ActionResult Delete(int id) {
            try {
                if (_context.User.AsNoTracking().FirstOrDefault(u => u.Id == id) != null) {
                    var user = _context.User.Where(x => x.Id == id).Single();
                    _context.User.Remove(user);
                    _context.SaveChanges();
                    return Ok("Delete User Success");
                }
                else {
                    return Ok("Id User not found");
                }



            }
            catch (Exception ex) {
                return BadRequest($"Delete User Error: {ex}");
            }
        }
    }
}
