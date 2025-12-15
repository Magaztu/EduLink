namespace EduLink.Domain.Entities;
//Hola soy las políticas de cancelación ejjesjje
public class PoliticaCancelacion
{
    public int PlazoMaximoCancelacionHoras { get; set; } // ej. 24h
    public decimal PorcentajeCargo { get; set; } // ej. 0.10 = 10%

    public bool PuedeCancelar(DateTime inicioSlot, DateTime ahora)
    {
        var horasRestantes = (inicioSlot - ahora).TotalHours;
        return horasRestantes >= PlazoMaximoCancelacionHoras;
    }

    public decimal CalcularCargo(decimal montoTotal)
    {
        return montoTotal * PorcentajeCargo;
    }
}