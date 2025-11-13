using EduLink.Domain.Interfaces;

namespace EduLink.Domain.Strategies;

public class ImpuestoIncluidoStrategy : IPrecioStrategy
{
    private readonly decimal _tasaImpuesto;

    public ImpuestoIncluidoStrategy(decimal tasaImpuesto = 0.12m)
    {
        _tasaImpuesto = tasaImpuesto; // 12% por defecto correa
    }

    public decimal Calcular(decimal precioBase, Cliente cliente)
    {
        return precioBase * (1 + _tasaImpuesto);
    }
}