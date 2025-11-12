using EduLink.Application.DTOs;
using EduLink.Application.Interfaces;
using EduLink.Domain.Entities;
using EduLink.Domain.Enums;

namespace EduLink.Application.UseCases;

public class PublicarServicioUseCase
{
    private readonly IProveedorRepository _proveedorRepo;
    private readonly IServicioRepository _servicioRepo;

    public PublicarServicioUseCase(
        IProveedorRepository proveedorRepo,
        IServicioRepository servicioRepo)
    {
        _proveedorRepo = proveedorRepo;
        _servicioRepo = servicioRepo;
    }

    public async Task EjecutarAsync(PublicarServicioRequest request)
    {
        var proveedor = await _proveedorRepo.ObtenerPorIdAsync(request.ProveedorId);
        if (proveedor == null)
            throw new ArgumentException("Proveedor no encontrado.");

        var nuevoServicio = new Servicio
        {
            Titulo = request.Titulo,
            Descripcion = request.Descripcion,
            PrecioBase = request.PrecioBase,
            DuracionMinutos = request.DuracionMinutos,
            Modalidad = request.Modalidad,
            Ubicacion = request.Ubicacion
        };

        proveedor.PublicarServicio(nuevoServicio);

        await _servicioRepo.GuardarAsync(nuevoServicio);
    }
}