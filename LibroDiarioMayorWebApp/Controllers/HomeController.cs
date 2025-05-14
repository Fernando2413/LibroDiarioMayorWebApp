using LibroDiarioMayorWebApp.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;

namespace LibroDiarioMayorWebApp.Controllers
{
    public class HomeController : Controller
    {
        private readonly DiarioMayorContext _Context = new DiarioMayorContext();

        public HomeController(DiarioMayorContext context)
        {
            _Context = context; 
        }
        public IActionResult Login()
        {
            return View();
        }
        [HttpGet]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync();
            return View("Login");
        }
        [Authorize]
        public IActionResult Index()
        {
            return View();
        }
        [Authorize]
        public IActionResult Privacy()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Iniciar(Usuario modelo)
        {
            Usuario? usuario_Existe =
                await _Context.Usuarios.Where(u =>
                u.NombreUsuario == modelo.NombreUsuario &&
                u.Clave == modelo.Clave
                ).FirstOrDefaultAsync();
            if (usuario_Existe == null)
            {
                TempData["Mensaje"] = "Usuario no valido";
                return RedirectToAction("Login");
            }

            else
            {
                List<Claim> claims = new List<Claim>()
                {
                    new Claim(ClaimTypes.Name, usuario_Existe.NombreUsuario)
                };
                ClaimsIdentity claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                AuthenticationProperties properties = new AuthenticationProperties()
                {
                    AllowRefresh = true,
                };
                await HttpContext.SignInAsync(
                    CookieAuthenticationDefaults.AuthenticationScheme,
                    new ClaimsPrincipal(claimsIdentity),
                    properties
                    );
                return RedirectToAction("Index");
            }
        }
        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
