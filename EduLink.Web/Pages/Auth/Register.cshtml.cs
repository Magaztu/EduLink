using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace EduLink.Web.Pages.Auth
{
    public class RegisterModel : PageModel
    {
        [BindProperty]
        public string Nombre { get; set; } = string.Empty;

        [BindProperty]
        public string Correo { get; set; } = string.Empty;

        [BindProperty]
        public string Password { get; set; } = string.Empty;

        [BindProperty]
        public bool AceptaTerminos { get; set; }

        public string? ErrorMessage { get; set; }

        public void OnGet()
        {
        }

        public IActionResult OnPost()
        {
            if (!ModelState.IsValid || !AceptaTerminos)
            {
                ErrorMessage = "Revisa los datos e indica que aceptas los términos.";
                return Page();
            }

            // TODO: aquí más adelante vas a crear el usuario de verdad (BD / Identity)
            // Por ahora solo simulamos que todo fue bien y redirigimos al login.
            return RedirectToPage("/Auth/Login");
        }
    }
}
