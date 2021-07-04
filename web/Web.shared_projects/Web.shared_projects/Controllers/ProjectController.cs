using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
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
                var projects = await _repo.GetAllProjects(true);
                return Ok(projects);
                //return Ok(new Project()); //ver formato do json
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

        // GET: api/<ProjectController>/5
        [HttpGet("Category/{categoryId}")]
        public async Task<IActionResult> GetByCat(int categoryid) {
            try {
                var project = await _repo.GetProjectByCategory(categoryid, true);
                return Ok(project);
            }
            catch (Exception ex) {
                return BadRequest($"Erro: {ex}");
            }
        }

        [HttpGet("User/{userid}")]
        public async Task<IActionResult> GetByUser(int userid) {
            try {
                var project = await _repo.GetUserProj(userid);
                           
                return Ok(project);
            }
            catch (Exception ex) {
                return BadRequest($"Erro: {ex}");
            }
        }

        [HttpGet("getEnrollUsers/{id}")]
        public async Task<IActionResult> GetByUserEnroll(int id) {
            try {
                var users = await _repo.GetUsersEnrollsinProjects(id);

                return Ok(users);
            }
            catch (Exception ex) {
                return BadRequest($"Erro: {ex}");
            }
        }

        [HttpGet("getEnroll/{userid}")]
        public async Task<IActionResult> GetProjectsByUserEnroll(int userid) {
            try {
                var project = await _repo.GetEnrollUserProj(userid);

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
                    var json = JsonSerializer.Serialize(new { response = "Insert Projet Success" });
                    return Ok(json);
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
                        var json = JsonSerializer.Serialize(new { response = "Update Projet Success" });
                        return Ok(json);
                    }
                }
            }
            catch (Exception ex) {
                return BadRequest($"Update Project Error: {ex}");
            }
            return BadRequest("Not Update Project");
        }

        [HttpPut("enroll/{id}")]
        public async Task<IActionResult> PutEnroll(int id, Project model) { //update
            try {
                var projects = await _repo.GetProjectById(id);
                if (projects != null) {
                          //_repo(p => p.DataCadastro).IsModified = false;
                    //projects = 
                    _repo.Update(model);
                    if (await _repo.SaveChangeAsync()) {
                        var json = JsonSerializer.Serialize(new { response = "Update Enroll Projet Success" });
                        return Ok(json);
                    }
                }
            }
            catch (Exception ex) {
                var jsonBadREx = JsonSerializer.Serialize(new { response = "Você já está inscrito neste projeto!" });
                return BadRequest(jsonBadREx);
            }
            var jsonBadR = JsonSerializer.Serialize(new { response = "Not Update Project" });
            return BadRequest(jsonBadR);
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

        [HttpPost("deleteEnroll")]
        public async Task<IActionResult> DeleteEnrool(EnrolledProjects model) {
            try {
                var enroll = await _repo.DeleteEnrollUserProj(model.ProjectId, model.UserId);
                Console.WriteLine("projId: " + model.ProjectId + " " + "userId: " + model.UserId);
                if (enroll != null) {
                    //return Ok(enroll);
                    _repo.Delete(enroll);
                    if (await _repo.SaveChangeAsync()) {
                        return Ok("Delete enroll Success");
                    }
                }
            }
            catch (Exception ex) {
                return BadRequest($"Delete enroll Error: {ex}");
            }
            return BadRequest("Not Deleted enroll");
        }

    [HttpPost("getUsersProjects")]
        public async Task<IActionResult> GetUsersProjects(UserProject model) {
        try {
               var usersProject = await _repo.GetProjeByUserIdProj(model.ProjectId, model.UserId);
               Console.WriteLine("projId: " + model.ProjectId + " " + "userId: " + model.UserId);
                if (usersProject != null) {
                    return Ok(usersProject);
                }
                
                    var json = JsonSerializer.Serialize(new { response = "dont exist" });
                    return BadRequest(json);
               
        }
        catch (Exception ex) {
             return BadRequest($"Delete enroll Error: {ex}");
        }
        return BadRequest("Not Deleted enroll");
    }
        [HttpPost("getEnrollProj")]
        public async Task<IActionResult> GetEnrollProjects(EnrolledProjects model) {
            try {
                var enrollProject = await _repo.DeleteEnrollUserProj(model.ProjectId, model.UserId);
                Console.WriteLine("projId: " + model.ProjectId + " " + "userId: " + model.UserId);
                if (enrollProject != null) {
                    return Ok(enrollProject);
                }

                var json = JsonSerializer.Serialize(new { response = "dont exist" });
                return BadRequest(json);

            }
            catch (Exception ex) {
                return BadRequest($"Delete enroll Error: {ex}");
            }
            return BadRequest("Not Deleted enroll");
        }
    }
}
