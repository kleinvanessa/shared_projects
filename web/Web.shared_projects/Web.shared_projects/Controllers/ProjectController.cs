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
    public class ProjectController : ControllerBase {

        public readonly SharedProjContext _context;
        public ProjectController(SharedProjContext context) {
            _context = context;
        }
        // GET: api/<ProjectController>
        [HttpGet]
        public ActionResult Get() {
            try {
                return Ok(new Project());
            }
            catch (Exception ex) {
                return BadRequest($"Erro: {ex}");
            }
        }

        // POST api/<ProjectController>
        [HttpPost]
        public ActionResult Post(Project model) { //insert
            try {
                _context.Project.Add(model); // model é o json 
                _context.SaveChanges();
                return Ok("Insert Project Success");
            }
            catch (Exception ex) {
                return BadRequest($"Insert Project Error: {ex}");
            }
        }

        // PUT api/<ProjectController>/5
        [HttpPut("{id}")]
        public ActionResult Put(int id, Project model) { //update
            try {
                if (_context.Project.AsNoTracking().FirstOrDefault(u => u.Id == id) != null) {
                    _context.Project.Update(model);
                    _context.SaveChanges();
                    return Ok("Update Project Success");
                }
                else {
                    return Ok("Id Project not found");
                }



            }
            catch (Exception ex) {
                return BadRequest($"Update Project Error: {ex}");
            }
        }

        // DELETE api/<ProjectController>/5
        [HttpDelete("{id}")]
        public ActionResult Delete(int id) {
            try {
                if (_context.Project.AsNoTracking().FirstOrDefault(p => p.Id == id) != null) {
                    var project = _context.Project.Where(x => x.Id == id).Single();
                    _context.Project.Remove(project);
                    _context.SaveChanges();
                    return Ok("Delete Project Success");
                }
                else {
                    return Ok("Id Project not found");
                }



            }
            catch (Exception ex) {
                return BadRequest($"Delete Project Error: {ex}");
            }
        }
    }
}
