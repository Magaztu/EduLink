using EduLink.Application.Interfaces;
using EduLink.Domain.Entities;
using EduLink.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace EduLink.Infrastructure.Repositories;

public class ReservaRepository : IReservaRepository
{
    private readonly AppDbContext _context;
    public ReservaRepository(AppDbContext context) => _context = context;

    public async Task<Reserva?> ObtenerPorIdAsync(Guid id)
    {
        return await _context.Reservas
            .Include(r => r.Cliente)
            .Include(r => r.Servicio)
            .Include(r => r.Slot)
            .FirstOrDefaultAsync(r => r.Id == id);
    }

    public async Task GuardarAsync(Reserva reserva)
    {
        _context.Reservas.Update(reserva);
        await _context.SaveChangesAsync();
    }
}