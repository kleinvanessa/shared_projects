﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Web.shared_projects.Models;

namespace Web.shared_projects.Repositories {
    public interface IEFCoreRepository {
        void Add<T>(T entity) where T : class; // assinatura generica que aceita qualquer tipo como parametro / T = tipo
        void Update<T>(T entity) where T : class; 
        void UpdateOnlyEnroll<T>(T entity) where T : class;
        void Delete<T>(T entity) where T : class;

        Task<bool> SaveChangeAsync();

        Task<User[]> GetAllUsers(bool includeProject = false);
        Task<User> GetUserById(int id, bool includeProject = false);
        Task<User> GetUserByEmail(String email, bool includeProject = false);
        Task<User[]> GetUsersByName(string name, bool includeProject = false);

        Task<Project[]> GetAllProjects(bool includeUser = false);
        Task<Project> GetProjectById(int id, bool includeUser = false);

        Task<Project[]> GetProjectByCategory(int categoryId, bool includeUser = false);

        Task<Project[]> GetUserProj(int userid);
        Task<Project[]> GetEnrollUserProj(int userid);

        Task<EnrolledProjects> DeleteEnrollUserProj(int id, int userid);
        Task<UserProject> GetProjeByUserIdProj(int id, int userid);
        Task<UserProject[]> GetUsersByIdProj(int id);
        Task<Favorite> GetFavoritesProj(int id, int userid);
        Task<Favorite[]> GetAllFavoritesProjByuser(int id);
        Task<Curriculum> GetCurriculumByUserId(int userid);
        Task<Payment> GetPaymentByUserId(int userid);

        Task<User[]> GetUsersEnrollsinProjects(int projectId);
        Task<User[]> GetUsersinProjects(int projectId);

        Task<AreaKnowledge[]> GetAllAreas();
    }
}
