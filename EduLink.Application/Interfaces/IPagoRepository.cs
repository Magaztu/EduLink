using EduLink.Domain.Entities;

namespace EduLink.Application.Interfaces;

public interface IPagoRepository
{
    Task<Pago?> ObtenerPorIdAsync(Guid id);
    Task GuardarAsync(Pago pago);
}