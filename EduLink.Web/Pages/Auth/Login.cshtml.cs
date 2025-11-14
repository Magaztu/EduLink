using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace EduLink.Web.Pages.Auth
{
    public class LoginModel : PageModel
    {
        [BindProperty]
        public string Email { get; set; } = string.Empty;

        [BindProperty]
        public string Password { get; set; } = string.Empty;

        [BindProperty]
        public bool RememberMe { get; set; }

        public string? ErrorMessage { get; set; }

        public void OnGet()
        {
        }

        public IActionResult OnPost()
        {
            if (!ModelState.IsValid)
            {
                ErrorMessage = "Por favor revisa los datos ingresados.";
                return Page();
            }

            // Aquí luego conectas con tu servicio real de autenticación.
            // Por ahora lo dejamos como dummy:
            if (Email == "demo@edulink.com" && Password == "123456")
            {
                return RedirectToPage("/Cliente/Dashboard");
            }

            ErrorMessage = "Credenciales incorrectas.";
            return Page();
        }
    }
}
