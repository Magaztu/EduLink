using EduLink.Domain.Enums;
using EduLink.Domain.Interfaces;
using EduLink.Domain.Strategies;
using System;
using System.Collections.Generic;

namespace EduLink.Domain.Entities;

public class Servicio
{
    public Guid Id { get; init; } = Guid.NewGuid();
    public Guid ProveedorId { get; set; }
    public string Titulo { get; set; } = string.Empty;
    public string Descripcion { get; set; } = string.Empty;
    public decimal PrecioBase { get; set; }
    public int DuracionMinutos { get; set; }
    public Modalidad Modalidad { get; set; }
    public string? Ubicacion { get; set; }
    public List<SlotHorario> Slots { get; private set; } = new();

    public IPrecioStrategy EstrategiaPrecio { get; set; } = new PrecioBaseStrategy(); //elegir

    public decimal CalcularPrecioFinal(Cliente cliente) => EstrategiaPrecio.Calcular(PrecioBase, cliente); // strategi
}