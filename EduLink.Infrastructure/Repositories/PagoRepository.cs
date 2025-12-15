using EduLink.Application.Interfaces;
using EduLink.Domain.Entities;
using EduLink.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace EduLink.Infrastructure.Repositories;

public class PagoRepository : IPagoRepository
{
    private readonly AppDbContext _context;
    public PagoRepository(AppDbContext context) => _context = context;

    public async Task<Pago?> ObtenerPorIdAsync(Guid id)
        => await _context.Pagos.FindAsync(id);

    public async Task GuardarAsync(Pago pago)
    {
        _context.Pagos.Update(pago);
        await _context.SaveChangesAsync();
    }
}