using EduLink.Application.Interfaces;
using EduLink.Domain.Entities;
using EduLink.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace EduLink.Infrastructure.Repositories;
public class ProveedorRepository : IProveedorRepository
{
    private readonly AppDbContext _context;
    public ProveedorRepository(AppDbContext context) => _context = context;

    public async Task<Proveedor?> ObtenerPorIdAsync(Guid id)
    {
        return await _context.Usuarios
            .OfType<Proveedor>()
            .Include(p => p.Servicios)
                .ThenInclude(s => s.Slots)
            .FirstOrDefaultAsync(p => p.Id == id);
    }

    public async Task GuardarAsync(Proveedor proveedor)
    {
        _context.Usuarios.Update(proveedor);
        await _context.SaveChangesAsync();
    }
}