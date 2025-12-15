using EduLink.Domain.Interfaces;
using System;
using System.Threading.Tasks;

namespace EduLink.Domain.Strategies;

public class TarjetaPagoStrategy : IPagoStrategy
{
    public string Nombre => "Tarjeta";
    public Task<bool> ProcesarAsync(decimal monto, Guid clienteId)
    {
        Console.WriteLine($"Procesando pago con tarjeta virtual de PeiGO por un monto de ${monto:F2}...");
        return Task.FromResult(true); // Hecho
    }
}