using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Web.shared_projects.Data;
using Web.shared_projects.Models;
using Web.shared_projects.Repositories;
using System.Text.Json;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Web.shared_projects.Controllers {
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase {

        private readonly IEFCoreRepository _repo;

        public UserController(IEFCoreRepository repo) {
            _repo = repo;
        }

        // GET: api/<UserController>
        [HttpGet]
        public async Task<IActionResult> Get() { //select em todas os dados da tabela User
            try {
                var users = await _repo.GetAllUsers();
                return Ok(users);
            }
            catch (Exception ex) {
                return BadRequest($"Erro: {ex}");
            }

        }

        // GET: api/<UserController>/5
        [HttpGet("{id}", Name = "GetUser")]
        public async Task<IActionResult> Get(int id) {
            try {
                var user = await _repo.GetUserById(id, true);
                return Ok(user);
            }
            catch (Exception ex) {
                return BadRequest($"Erro: {ex}");
            }
        }

        // POST api/<UserController>
        [HttpPost]
        public async Task<IActionResult> Post(User model) { //insert
            try {
                var user = await _repo.GetUserByEmail(model.Email);
                if (user == null) {
                    _repo.Add(model); // model é o json
                    if (await _repo.SaveChangeAsync()) {
                        return Ok("Insert User Success");
                    }
                    return BadRequest("not save user");
                }
                return BadRequest("email dif de null, email ja existe");

                 
                
            }
            catch (Exception ex) {
                return BadRequest($"Insert User Error: {ex}");
            }

            //return BadRequest("Not save User Project");
        }

        [HttpPost("Login")]
        public async Task<IActionResult> PostLogin(User model) { //insert
            try {
                var user = await _repo.GetUserByEmail(model.Email);                
                
                if(user != null) {
                    var result = new {
                        id = user.Id,
                        firstname = user.FirstName,
                        lastname = user.LastName,
                        email = user.Email,
                        response = "User logado com sucesso"
                    };
                    var json = JsonSerializer.Serialize(result);
                    return Ok(json);
                }
                ///_repo.Add(model); // model é o json 
                
            }
            catch (Exception ex) {
                return BadRequest($"Login Error: {ex}");
            }

            return BadRequest("Not login User");
        }

        // PUT api/<UserController>/5
        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, User model) { //update
            try {
                var user = await _repo.GetProjectById(id);
                if (user != null) {
                    _repo.Update(model);
                    if (await _repo.SaveChangeAsync()) {
                        return Ok("Update User Success");
                    }
                }
            }
            catch (Exception ex) {
                return BadRequest($"Update User Error: {ex}");
            }
            return BadRequest("Not Update User");
        }

        // DELETE api/<UserController>/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id) {
            try {
                var user = await _repo.GetUserById(id);
                if (user != null) {
                    _repo.Delete(user);
                    if (await _repo.SaveChangeAsync()) {
                        return Ok("Delete User Success");
                    }
                }
            }
            catch (Exception ex) {
                return BadRequest($"Update User Error: {ex}");
            }
            return BadRequest("Not Deleted User");
        }
    }
}
