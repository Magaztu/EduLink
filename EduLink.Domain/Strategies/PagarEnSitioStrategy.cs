using EduLink.Domain.Interfaces;
using System;
using System.Threading.Tasks;

namespace EduLink.Domain.Strategies;

public class PagarEnSitioStrategy : IPagoStrategy
{
	public string Nombre => "PagarEnSitio";
	public Task<bool> ProcesarAsync(decimal monto, Guid clienteId)
	{
		Console.WriteLine($"Pago en efectivo programado para ${monto:F2}. Por favor cumpla no sea ratón.");
		return Task.FromResult(true); // Siempre debería marcarse como exitosoid
	}
}