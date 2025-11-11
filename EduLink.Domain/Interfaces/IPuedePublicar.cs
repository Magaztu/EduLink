using EduLink.Domain.Entities;

namespace EduLink.Domain.Interfaces;

public interface IPuedePublicar
{
    void PublicarServicio(Servicio servicio);
}