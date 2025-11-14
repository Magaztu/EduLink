using Microsoft.AspNetCore.Mvc.RazorPages;
using EduLink.Application.UseCases;
using EduLink.Domain.Strategies;

namespace EduLink.Web.Pages;

public class TestFlujoCompletoModel : PageModel
{
    private readonly ReservarServicioUseCase _reservarUseCase;
    private readonly PagarReservaUseCase _pagarUseCase;

    public string Mensaje { get; private set; } = "Haz clic en el botón para probar el flujo completo.";

    public TestFlujoCompletoModel(
        ReservarServicioUseCase reservarUseCase,
        PagarReservaUseCase pagarUseCase)
    {
        _reservarUseCase = reservarUseCase;
        _pagarUseCase = pagarUseCase;
    }

    public async Task OnGetProbar()
{
    try
    {
        var clienteId = Guid.Parse("11111111-1111-1111-1111-111111111111");
        var servicioId = Guid.Parse("33333333-3333-3333-3333-333333333333");
        var slotId = Guid.Parse("44444444-4444-4444-4444-444444444444");

        // Reservar
        var reservaId = await _reservarUseCase.EjecutarAsync(new(clienteId, servicioId, slotId));

        // Pagar
        await _pagarUseCase.EjecutarAsync(reservaId, new TarjetaPagoStrategy());

        Mensaje = "Notificación enviada a consola con éxito.";
    }
    catch (Exception ex)
    {
        Mensaje = $"Error: {ex.Message}";
    }
}
}