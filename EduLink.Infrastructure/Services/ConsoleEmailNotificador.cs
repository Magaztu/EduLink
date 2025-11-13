using EduLink.Application.Events;
using EduLink.Application.Interfaces; // Queda de más pero hay ambigüedad con mi IDE

namespace EduLink.Infrastructure.Services;

public class ConsoleEmailNotificador : IDomainObserver<ReservaConfirmadaEvent>
{
    public void OnNext(ReservaConfirmadaEvent evento)
    {
        Console.WriteLine();
        Console.WriteLine("    [NOTIFICACIÓN POR CONSOLA]");
        Console.WriteLine($"   Hola {evento.ClienteNombre},");
        Console.WriteLine($"   Tu reserva para '{evento.ServicioTitulo}' el {evento.FechaSlot:dd/MM/yyyy HH:mm} ha sido confirmada.");
        Console.WriteLine($"   Un correo de confirmación fue enviado a: {evento.ClienteEmail}");
        Console.WriteLine("   ¡Gracias por usar EduLink!");
        Console.WriteLine();
    }
}

// No pude utilizar concatenación con este método pipipipi
// Console.WriteLine(""""""
//            [NOTIFICACIÓN SIMULADA POR CONSOLA]"
//            Hola {evento.ClienteNombre},");
//            Tu reserva para '{evento.ServicioTitulo}' el {evento.FechaSlot:dd/MM/yyyy HH:mm} ha sido confirmada.");
//            Un correo de confirmación fue enviado a: {evento.ClienteEmail}");
//            ¡Gracias por usar EduLink!");
        
//         """""");