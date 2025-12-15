using System;
using System.Threading.Tasks;

namespace EduLink.Domain.Interfaces;

public interface IPagoStrategy
{
    string Nombre { get; }
    Task<bool> ProcesarAsync(decimal monto, Guid clienteId);
}