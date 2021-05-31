using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Web.shared_projects.Repositories {
    public interface IEFCoreRepository {
        void Add<T>(T entity) where T : class; // assinatura generica que aceita qualquer tipo como parametro / T = tipo
        void Update<T>(T entity) where T : class;
        void Delete<T>(T entity) where T : class;

        Task<bool> SaveChangeAsync();
    }
}
