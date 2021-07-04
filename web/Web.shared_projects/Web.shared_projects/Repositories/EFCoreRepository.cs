using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Web.shared_projects.Data;
using Web.shared_projects.Models;

namespace Web.shared_projects.Repositories {
    public class EFCoreRepository : IEFCoreRepository {
        private readonly SharedProjContext _context;
        public EFCoreRepository(SharedProjContext context) {
            _context = context;
        }
        public void Add<T>(T entity) where T : class {
            _context.Add(entity);
        }

        public void Update<T>(T entity) where T : class {
            _context.Update(entity);
        }

        public void UpdateOnlyEnroll<T>(T entity) where T : class {
            _context.Entry(entity).State = EntityState.Modified;
            _context.Update(entity);
        }

        public void Delete<T>(T entity) where T : class {
            _context.Remove(entity);
        }

        public async Task<bool> SaveChangeAsync() {
            return (await _context.SaveChangesAsync()) > 0;
        }

        public async Task<User[]> GetAllUsers(bool includeProject = false) {
            IQueryable<User> query = _context.User;

            if (includeProject) {
                query = query.Include(u => u.UsersProjects).ThenInclude(up => up.Project);
            }

            query = query.AsNoTracking().OrderBy(u => u.Id);
            return await query.ToArrayAsync();
        }

        public async Task<User> GetUserById(int id, bool includeProject = false) {
            IQueryable<User> query = _context.User;

            if (includeProject) {
                query = query.Include(u => u.UsersProjects).ThenInclude(up => up.Project);
            }

            query = query.AsNoTracking().OrderBy(u => u.Id);
            return await query.FirstOrDefaultAsync(u => u.Id == id);
        }

        public async Task<User> GetUserByEmail(string email, bool includeProject = false) {
            IQueryable<User> query = _context.User;

            if (includeProject) {
                query = query.Include(u => u.UsersProjects).ThenInclude(up => up.Project);
            }

            query = query.AsNoTracking().OrderBy(u => u.Id);
            return await query.FirstOrDefaultAsync(u => u.Email == email);
        }

        public async Task<User[]> GetUsersByName(string name, bool includeProject = false) {
            IQueryable<User> query = _context.User;

            if (includeProject) {
                query = query.Include(u => u.UsersProjects).ThenInclude(up => up.Project);
            }

            query = query.AsNoTracking().Where((u => u.FirstName.Contains(name))).OrderBy(u => u.Id);
            return await query.ToArrayAsync();
        }

        public async Task<Project[]> GetAllProjects(bool includeUser = false) {
            IQueryable<Project> query = _context.Project;

            if (includeUser) {
                query = query.Include(p => p.UsersProjects).ThenInclude(up => up.User);
                query = query.Include(p => p.EnrolledProjects).ThenInclude(ep => ep.User);
            }

            query = query.AsNoTracking().OrderBy(p => p.Id);
            return await query.ToArrayAsync();
        }

        public async Task<Project> GetProjectById(int id, bool includeUser = false) {
            IQueryable<Project> query = _context.Project;

            if (includeUser) {
                query = query.Include(p => p.UsersProjects).ThenInclude(up => up.User);
                query = query.Include(p => p.EnrolledProjects).ThenInclude(ep => ep.User);
            }

            query = query.AsNoTracking().OrderBy(p => p.Id);
            return await query.FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task<Project[]> GetProjectByCategory(int categoryId, bool includeUser = false) {
            IQueryable<Project> query = _context.Project;

            if (includeUser) {
                query = query.Include(p => p.UsersProjects).ThenInclude(up => up.User);
            }

            query = query.AsNoTracking().Where((p => p.CategoryId == categoryId)).OrderBy(p => p.Id);
            return await query.ToArrayAsync();
        }      

        public async Task<Project[]> GetUserProj(int userid) {

            IQueryable<Project> query = from U in _context.UserProject
                    join P in _context.Project on U.UserId equals userid
                    where P.Id == U.ProjectId
                    select P;

            query = query.AsNoTracking();

            return await query.ToArrayAsync();
        }

        public async Task<Project[]> GetEnrollUserProj(int userid) {

            IQueryable<Project> query = from E in _context.EnrolledProjects
                                         join P in _context.Project on E.UserId equals userid
                                         where P.Id == E.ProjectId
                                         select P;

            query = query.AsNoTracking();

            return await query.ToArrayAsync();
        }

        public async Task<User[]> GetUsersEnrollsinProjects(int projectId) {
            IQueryable<User> query = from E in _context.EnrolledProjects
                                        join U in _context.User on E.ProjectId equals projectId
                                     where U.Id == E.UserId
                                        select U;

            query = query.AsNoTracking();

            return await query.ToArrayAsync();
        }

        public async Task<AreaKnowledge[]> GetAllAreas() {
            IQueryable<AreaKnowledge> query = _context.AreaKnowledge;

            query = query.AsNoTracking().OrderBy(p => p.Id);
            return await query.ToArrayAsync();
        }

        public async Task<EnrolledProjects> DeleteEnrollUserProj(int id, int userid) {
            IQueryable<EnrolledProjects> query = _context.EnrolledProjects;
            
            return await query.FirstOrDefaultAsync(p => p.ProjectId == id && p.UserId == userid);
        }
        public async Task<UserProject> GetProjeByUserIdProj(int id, int userid) {
            IQueryable<UserProject> query = _context.UserProject;

            return await query.FirstOrDefaultAsync(p => p.ProjectId == id && p.UserId == userid);
        }

        public async Task<Curriculum> GetCurriculumByUserId(int userid) {
            IQueryable<Curriculum> query = _context.Curriculum;

            query = query.AsNoTracking().OrderBy(u => u.userId);
            return await query.FirstOrDefaultAsync(u => u.userId == userid);
        }
        public async Task<Payment> GetPaymentByUserId(int userid) {
            IQueryable<Payment> query = _context.Payment;

            query = query.AsNoTracking().OrderBy(u => u.userId);
            return await query.FirstOrDefaultAsync(u => u.userId == userid);
        }
    }
}
