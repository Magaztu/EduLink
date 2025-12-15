using EduLink.Domain.Interfaces;

namespace EduLink.Domain.Entities;

public class Proveedor : Usuario, IPuedePublicar
{
    public string Bio { get; set; } = string.Empty;
    public List<Servicio> Servicios { get; private set; } = new();

    public void PublicarServicio(Servicio servicio)
    {
        servicio.ProveedorId = Id;
        Servicios.Add(servicio);
    }
}