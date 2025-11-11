using EduLink.Domain.Entities;

namespace EduLink.Domain.Interfaces;

public interface IPuedeReservar
{
    void Reservar(Servicio servicio, SlotHorario slot);
}