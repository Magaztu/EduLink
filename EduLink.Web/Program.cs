// Línea para poder modificar en VS Code, los using de .Net se comportan raros

using Microsoft.AspNetCore.Identity;
// using Microsoft.EntityFrameworkCore; // Aún no se configura el ORM

var builder = WebApplication.CreateBuilder(args);

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
app.Run();