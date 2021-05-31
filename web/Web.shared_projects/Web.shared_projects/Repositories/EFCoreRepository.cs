using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Web.shared_projects.Data;

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

        
    }
}
