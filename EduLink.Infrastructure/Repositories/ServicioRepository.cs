using EduLink.Application.Interfaces;
using EduLink.Domain.Entities;
using EduLink.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace EduLink.Infrastructure.Repositories;
public class ServicioRepository : IServicioRepository
{
    private readonly AppDbContext _context;
    public ServicioRepository(AppDbContext context) => _context = context;

    public async Task<Servicio?> ObtenerPorIdAsync(Guid id)
        => await _context.Servicios.FindAsync(id);

    public async Task<Servicio?> ObtenerConSlotsAsync(Guid id)
        => await _context.Servicios
            .Include(s => s.Slots)
            .FirstOrDefaultAsync(s => s.Id == id);

    public async Task GuardarAsync(Servicio servicio)
    {
        if (servicio.Id == Guid.Empty)
            _context.Servicios.Add(servicio);
        else
            _context.Servicios.Update(servicio);
        await _context.SaveChangesAsync();
    }
}