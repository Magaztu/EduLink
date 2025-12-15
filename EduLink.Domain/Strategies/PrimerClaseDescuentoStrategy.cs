using EduLink.Domain.Entities;
using EduLink.Domain.Interfaces;

namespace EduLink.Domain.Strategies;

public class PrimerClaseDescuentoStrategy : IPrecioStrategy
{
    public decimal Calcular(decimal precioBase, Cliente cliente)
    {
        return cliente.Historial.Count == 0
            ? precioBase * 0.90m  // 10% de descuento
            : precioBase;
    }
}