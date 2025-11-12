using EduLink.Domain.Entities;

namespace EduLink.Application.Interfaces;

public interface IServicioRepository
{
    Task<Servicio> ObtenerPorIdAsync(Guid id);
    Task<Servicio> ObtenerConSlotsAsync(Guid id);
    Task GuardarAsync(Servicio servicio);
}