using EduLink.Domain.Entities;

namespace EduLink.Application.Interfaces;

public interface IClienteRepository
{
    Task<Cliente> ObtenerPorIdAsync(Guid id);
    Task GuardarAsync(Cliente cliente);
}