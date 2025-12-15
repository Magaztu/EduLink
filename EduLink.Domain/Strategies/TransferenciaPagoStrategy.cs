using EduLink.Domain.Interfaces;
using System;
using System.Threading.Tasks;

namespace EduLink.Domain.Strategies;

public class TransferenciaPagoStrategy : IPagoStrategy
{
    public string Nombre => "Transferencia";
    public Task<bool> ProcesarAsync(decimal monto, Guid clienteId)
    {
        Console.WriteLine($"Procesando transferencia por ${monto:F2} a través de Movistar...");
        return Task.FromResult(true);
    }
}