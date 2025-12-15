using EduLink.Domain.Entities;

namespace EduLink.Application.Interfaces;

public interface IProveedorRepository
{
    Task<Proveedor?> ObtenerPorIdAsync(Guid id);
    Task GuardarAsync(Proveedor proveedor);
}