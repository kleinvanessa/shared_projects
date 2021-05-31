﻿using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Web.shared_projects.Models;

namespace Web.shared_projects.Data {
    public class SharedProjContext : DbContext
    {
        public SharedProjContext(DbContextOptions<SharedProjContext> options) : base(options) {

        }
        public DbSet<User> User { get; set; }
        public DbSet<Project> Project { get; set; }
        public DbSet<UserProject> UserProject { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder) {
            modelBuilder.Entity<UserProject>(entity => {
                entity.HasKey(e => new { e.UserId, e.ProjectId }); // definindo a chave composta
            });
        }

    }
}
