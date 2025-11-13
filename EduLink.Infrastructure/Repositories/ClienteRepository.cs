using EduLink.Application.Interfaces;
using EduLink.Domain.Entities;
using EduLink.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace EduLink.Infrastructure.Repositories;

public class ClienteRepository : IClienteRepository
{
    private readonly AppDbContext _context;

    public ClienteRepository(AppDbContext context)
    {
        _context = context;
    }

    public async Task<Cliente?> ObtenerPorIdAsync(Guid id)
    {
        return await _context.Usuarios
            .OfType<Cliente>()
            .Include(c => c.Historial)
                .ThenInclude(r => r.Servicio)
            .Include(c => c.Historial)
                .ThenInclude(r => r.Slot)
            .FirstOrDefaultAsync(c => c.Id == id);
    }

    public async Task GuardarAsync(Cliente cliente)
    {
        _context.Usuarios.Update(cliente);
        await _context.SaveChangesAsync();
    }
}