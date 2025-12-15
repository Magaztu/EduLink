using EduLink.Domain.Entities;
using EduLink.Domain.Interfaces;

namespace EduLink.Domain.Strategies;

public class PrecioBaseStrategy : IPrecioStrategy
{
    public decimal Calcular(decimal precioBase, Cliente cliente) => precioBase;
}