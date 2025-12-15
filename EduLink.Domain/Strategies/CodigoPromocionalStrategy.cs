using EduLink.Domain.Entities;
using EduLink.Domain.Interfaces;
using System;

namespace EduLink.Domain.Strategies;

public class CodigoPromocionalStrategy : IPrecioStrategy
{
    private readonly string _codigoEsperado;
    private readonly decimal _descuentoPorcentual;
    private readonly decimal _descuentoFijo;

    public CodigoPromocionalStrategy(
        string codigoEsperado = "EDULINK10",
        decimal descuentoPorcentual = 0.10m,
        decimal descuentoFijo = 0m)
    {
        _codigoEsperado = codigoEsperado;
        _descuentoPorcentual = descuentoPorcentual;
        _descuentoFijo = descuentoFijo;
    }

    public decimal Calcular(decimal precioBase, Cliente cliente)
    {
        
        var codigoActivo = "EDULINK10"; // nombre

        if (codigoActivo == _codigoEsperado)
        {
            var descuento = precioBase * _descuentoPorcentual;
            if (_descuentoFijo > 0) descuento = Math.Min(descuento, _descuentoFijo);
            return Math.Max(0, precioBase - descuento);
        }

        return precioBase;
    }
}