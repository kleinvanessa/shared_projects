using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Web.shared_projects.Data;
using Web.shared_projects.Models;
using Web.shared_projects.Repositories;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Web.shared_projects.Controllers {
    [Route("api/[controller]")]
    [ApiController]
    public class ProjectController : ControllerBase {
        private readonly IEFCoreRepository _repo;

        public ProjectController(IEFCoreRepository repo) {
            _repo = repo;
        }
        // GET: api/<ProjectController>
        [HttpGet]
        public async Task<IActionResult> Get() {
            try {
                var projects = await _repo.GetAllProjects();
                return Ok(projects);
            }
            catch (Exception ex) {
                return BadRequest($"Erro: {ex}");
            }
        }

        // GET: api/<ProjectController>/5
        [HttpGet("{id}", Name = "GetProject")]
        public async Task<IActionResult> Get(int id) {
            try {
                var project = await _repo.GetProjectById(id, true);
                return Ok(project);
            }
            catch (Exception ex) {
                return BadRequest($"Erro: {ex}");
            }
        }

        // POST api/<ProjectController>
        [HttpPost]
        public async Task<IActionResult> Post(Project model) { //insert
            try {
                _repo.Add(model); // model é o json 
                if(await _repo.SaveChangeAsync()) {
                    return Ok("Insert Project Success");
                }
            }
            catch (Exception ex) {
                return BadRequest($"Insert Project Error: {ex}");
            }

            return BadRequest("Not save Insert Project");
        }

        // PUT api/<ProjectController>/5
        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, Project model) { //update
            try {
                var projects = await _repo.GetProjectById(id);
                if (projects != null) {
                    _repo.Update(model);
                    if (await _repo.SaveChangeAsync()) {
                        return Ok("Update Project Success");
                    }
                }
            }
            catch (Exception ex) {
                return BadRequest($"Update Project Error: {ex}");
            }
            return BadRequest("Not Update Project");
        }

        // DELETE api/<ProjectController>/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id) {
            try {
                var projects = await _repo.GetProjectById(id);
                if (projects != null) {
                    _repo.Delete(projects);
                    if (await _repo.SaveChangeAsync()) {
                        return Ok("Delete Project Success");
                    }
                }
            }
            catch (Exception ex) {
                return BadRequest($"Delete Project Error: {ex}");
            }
            return BadRequest("Not Deleted Project");
        }
    }
}
