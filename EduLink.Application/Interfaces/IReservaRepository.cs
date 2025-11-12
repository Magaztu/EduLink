using EduLink.Domain.Entities;

namespace EduLink.Application.Interfaces;

public interface IReservaRepository
{
    Task<Reserva> ObtenerPorIdAsync(Guid id);
    Task GuardarAsync(Reserva reserva);
}