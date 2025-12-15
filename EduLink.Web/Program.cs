// Línea para poder modificar en VS Code, los using de .Net se comportan raros

using EduLink.Application.Events;
using EduLink.Application.Interfaces;
using EduLink.Application.UseCases;
using EduLink.Domain.Entities;
using EduLink.Domain.Enums;
using EduLink.Domain.Strategies;
using EduLink.Infrastructure.Data;
using EduLink.Infrastructure.Repositories;
using EduLink.Infrastructure.Services;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
// using Microsoft.EntityFrameworkCore; // Aún no se configura el ORM

var builder = WebApplication.CreateBuilder(args);

// DbContext
builder.Services.AddDbContext<AppDbContext>(options =>
    {
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));
    options.LogTo(Console.WriteLine, LogLevel.Information); // logsito para ver qué ando parseando mal
    });

// Repositorios
builder.Services.AddScoped<IClienteRepository, ClienteRepository>();
builder.Services.AddScoped<IProveedorRepository, ProveedorRepository>();
builder.Services.AddScoped<IServicioRepository, ServicioRepository>();
builder.Services.AddScoped<IReservaRepository, ReservaRepository>();
builder.Services.AddScoped<IPagoRepository, PagoRepository>();

// Casos de uso
builder.Services.AddScoped<ReservarServicioUseCase>();
builder.Services.AddScoped<PagarReservaUseCase>();

//Singleton no puede ser omgggggg
builder.Services.AddSingleton<IDomainObserver<ReservaConfirmadaEvent>, ConsoleEmailNotificador>();

// Add services to the container.
builder.Services.AddRazorPages();

// Autenticación que se usará
builder.Services.AddAuthentication().AddJwtBearer(); // Requiere Microsoft.AspNetCore.Authentication.JwtBearer, no olviden usar el dotnet restore
builder.Services.AddAuthorization();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();

app.UseAuthentication(); // NO REALIZA NI COMPRUEBA NADA POR AHORA
app.UseAuthorization();

app.MapRazorPages();

// Prueba unitaria para ver si funciona el backkkk
using (var scope = app.Services.CreateScope())
{
    var clienteRepo = scope.ServiceProvider.GetRequiredService<IClienteRepository>();
    var proveedorRepo = scope.ServiceProvider.GetRequiredService<IProveedorRepository>();
    var servicioRepo = scope.ServiceProvider.GetRequiredService<IServicioRepository>();

    // Solo si no existen datos
    if ((await clienteRepo.ObtenerPorIdAsync(Guid.Parse("11111111-1111-1111-1111-111111111111"))) == null)
    {
        var cliente = new Cliente
        {
            Id = Guid.Parse("11111111-1111-1111-1111-111111111111"),
            Nombre = "Ana López",
            Email = "ana@example.com"
        };
        await clienteRepo.GuardarAsync(cliente);

        var proveedor = new Proveedor
        {
            Id = Guid.Parse("22222222-2222-2222-2222-222222222222"),
            Nombre = "Carlos Méndez",
            Email = "carlos@edulink.com",
            Bio = "Ingeniero en Sistemas, 5 años enseñando C#"
        };
        await proveedorRepo.GuardarAsync(proveedor);

        var servicio = new Servicio
        {
            Id = Guid.Parse("33333333-3333-3333-3333-333333333333"),
            ProveedorId = proveedor.Id,
            Titulo = "Clase de Cálculo",
            Descripcion = "Repaso para examen final. Temas: integrales, derivadas.",
            PrecioBase = 25.00m,
            DuracionMinutos = 60,
            Modalidad = Modalidad.Online,
            EstrategiaPrecio = new PrimerClaseDescuentoStrategy()
        };
        servicio.Slots.Add(new SlotHorario
        {
            Id = Guid.Parse("44444444-4444-4444-4444-444444444444"),
            Inicio = DateTime.UtcNow.AddHours(24),
            Fin = DateTime.UtcNow.AddHours(25),
            CupoMax = 3
        });
        
        await servicioRepo.GuardarAsync(servicio);
    }
}

app.Run();