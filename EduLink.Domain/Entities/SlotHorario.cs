using EduLink.Domain.Entities.States;
using EduLink.Domain.Enums;
using System;

namespace EduLink.Domain.Entities;

public class SlotHorario
{
    public Guid Id { get; init; } = Guid.NewGuid();
    public DateTime Inicio { get; set; }
    public DateTime Fin { get; set; }
    public int CupoMax { get; set; }
    public int CupoActual { get; private set; } = 0;

    // Exposicion
    public EstadoSlot Estado => EstadoInterno.Nombre;

    // No exposicion pero llamado por expo
    internal SlotState EstadoInterno { get; set; } = new DisponibleState();

    public void Reservar() => EstadoInterno.Reservar(this);
    public void Cancelar() => EstadoInterno.Cancelar(this);
    public void Expirar() => EstadoInterno.Expirar(this);
}