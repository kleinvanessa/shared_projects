using Microsoft.AspNetCore.Mvc;
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
    public class AreaKnowController : ControllerBase {

        private readonly IEFCoreRepository _repo;

        public AreaKnowController(IEFCoreRepository repo) {
            _repo = repo;
        }
        // GET: api/<AreaKnowController>
        [HttpGet]
        public async Task<IActionResult> Get() {
            try {
                return Ok(new AreaKnowledge());
                //var areas = await _repo.GetAllAreas();
               // return Ok(areas);
            }
            catch (Exception ex) {
                return BadRequest($"Erro: {ex}");
            }
        }

        // GET api/<AreaKnowController>/5
        [HttpGet("{id}")]
        public string Get(int id) {
            return "value";
        }

        // POST api/<AreaKnowController>
        [HttpPost]
        public async Task<IActionResult> Post(AreaKnowledge model) { //insert
            try {
                _repo.Add(model); // model é o json 
                if (await _repo.SaveChangeAsync()) {
                    var json = JsonSerializer.Serialize(new { response = "Insert Area Success" });
                    return Ok(json);
                }
            }
            catch (Exception ex) {
                return BadRequest($"Insert Area Error: {ex}");
            }

            return BadRequest("Not save Insert Area");
        }

        // PUT api/<AreaKnowController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value) {
        }

        // DELETE api/<AreaKnowController>/5
        [HttpDelete("{id}")]
        public void Delete(int id) {
        }
    }
}
