﻿using Microsoft.EntityFrameworkCore;
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
            }

            query = query.AsNoTracking().OrderBy(p => p.Id);
            return await query.ToArrayAsync();
        }

        public async Task<Project> GetProjectById(int id, bool includeUser = false) {
            IQueryable<Project> query = _context.Project;

            if (includeUser) {
                query = query.Include(p => p.UsersProjects).ThenInclude(up => up.User);
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

        public async Task<AreaKnowledge[]> GetAllAreas() {
            IQueryable<AreaKnowledge> query = _context.AreaKnowledge;

            query = query.AsNoTracking().OrderBy(p => p.Id);
            return await query.ToArrayAsync();
        }

        
    }
}
