using Microsoft.EntityFrameworkCore;
using EduLink.Domain.Entities;
using EduLink.Domain.Enums;
using EduLink.Domain.Strategies;
using EduLink.Domain.Interfaces;
using Microsoft.EntityFrameworkCore.Metadata;

namespace EduLink.Infrastructure.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options)
    {
    }

    // DbSet: solo para las raíces
    public DbSet<Usuario> Usuarios => Set<Usuario>();
    public DbSet<Servicio> Servicios => Set<Servicio>();
    public DbSet<Reserva> Reservas => Set<Reserva>();
    public DbSet<Pago> Pagos => Set<Pago>();
    public DbSet<SlotHorario> Slots => Set<SlotHorario>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Usuario>().ToTable("Usuarios");
        modelBuilder.Entity<Servicio>().ToTable("Servicios");
        modelBuilder.Entity<Reserva>().ToTable("Reservas");
        modelBuilder.Entity<Pago>().ToTable("Pagos");
        modelBuilder.Entity<SlotHorario>().ToTable("Slots");

        modelBuilder.Entity<Usuario>()
            .HasDiscriminator<string>("TipoUsuario")
            .HasValue<Cliente>("Cliente")
            .HasValue<Proveedor>("Proveedor");

        modelBuilder.Entity<Cliente>(cb =>
        {
            cb.Ignore(c => c.MetodosPagoTokenizados);
        });

        modelBuilder.Entity<Reserva>(rb =>
        {
            rb.OwnsOne(r => r.PoliticaCancelacion, pc =>
            {
                pc.Property(p => p.PlazoMaximoCancelacionHoras)
                .HasColumnName("PlazoMaximoCancelacionHoras");
                pc.Property(p => p.PorcentajeCargo)
                .HasColumnName("PorcentajeCargo")
                .HasPrecision(5, 4);
            });

            rb.Ignore(r => r.Estado);
            // rb.Property(r => r.Estado)
            //   .HasConversion(
            //       v => EstadoToString(v),
            //       v => StringToEstadoReserva(v))
            //   .Metadata.SetAfterSaveBehavior(PropertySaveBehavior.Ignore);

            rb.HasOne(r => r.Cliente)
              .WithMany(c => c.Historial)
              .HasForeignKey("ClienteId")
              .OnDelete(DeleteBehavior.Restrict);

            rb.HasOne(r => r.Slot)
              .WithMany()
              .HasForeignKey("SlotId")
              .OnDelete(DeleteBehavior.Restrict);

            rb.HasOne(r => r.PagoAsociado)
              .WithOne(p => p.Reserva)
              .HasForeignKey<Pago>(p => p.ReservaId)
              .OnDelete(DeleteBehavior.Cascade);
              
        });

        modelBuilder.Entity<SlotHorario>(sb =>
        {
            // sb.Property(s => s.Estado)
            //   .HasConversion(
            //       v => EstadoSlotToString(v),
            //       v => StringToEstadoSlot(v))
            //   .Metadata.SetAfterSaveBehavior(PropertySaveBehavior.Ignore);
            sb.Ignore(s => s.Estado);
        });

        modelBuilder.Entity<Servicio>(sb =>
        {
            sb.Ignore(s => s.EstrategiaPrecio);
            sb.Property(s => s.PrecioBase)
            .HasPrecision(18, 2); // 18 dígitos totales, 2 decimales

            // sb.Property(s => s.EstrategiaPrecio)
            // .HasConversion(
            //     v => PrecioStrategyToString(v),
            //     v => StringToPrecioStrategy(v));

        });

        modelBuilder.Entity<Pago>(pb =>
        {
            pb.Property(p => p.MetodoPago)
              .HasConversion(
                  v => PagoStrategyToString(v),
                  v => StringToPagoStrategy(v));
        });

        modelBuilder.Entity<Servicio>()
            .HasMany(s => s.Slots)
            .WithOne()
            .HasForeignKey("ServicioId")
            .OnDelete(DeleteBehavior.Cascade);

        base.OnModelCreating(modelBuilder);
    }

    // Conversión estática que pide EF porque es bodrio

    private static string EstadoToString(EstadoReserva estado) => estado.ToString();
    private static EstadoReserva StringToEstadoReserva(string valor) =>
        Enum.Parse<EstadoReserva>(valor);

    private static string EstadoSlotToString(EstadoSlot estado) => estado.ToString();
    private static EstadoSlot StringToEstadoSlot(string valor) =>
        Enum.Parse<EstadoSlot>(valor);

    private static string PrecioStrategyToString(IPrecioStrategy estrategia) =>
        estrategia.GetType().Name;

    private static IPrecioStrategy StringToPrecioStrategy(string nombre) =>
        nombre switch
        {
            nameof(PrecioBaseStrategy) => new PrecioBaseStrategy(),
            nameof(PrimerClaseDescuentoStrategy) => new PrimerClaseDescuentoStrategy(),
            nameof(ImpuestoIncluidoStrategy) => new ImpuestoIncluidoStrategy(),
            nameof(CodigoPromocionalStrategy) => new CodigoPromocionalStrategy(),
            _ => new PrecioBaseStrategy()
        };

    private static string PagoStrategyToString(IPagoStrategy estrategia) =>
        estrategia.Nombre;

    private static IPagoStrategy StringToPagoStrategy(string nombre) =>
        nombre switch
        {
            "Tarjeta" => new TarjetaPagoStrategy(),
            "TransferenciaSimulada" => new TransferenciaPagoStrategy(),
            "PagarEnSitio" => new PagarEnSitioStrategy(),
            _ => new TarjetaPagoStrategy()
        };
}