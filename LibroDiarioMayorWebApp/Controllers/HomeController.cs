using LibroDiarioMayorWebApp.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using System.Runtime.CompilerServices;
using Microsoft.EntityFrameworkCore.Update;
using LibroDiarioMayorWebApp.Data;

namespace LibroDiarioMayorWebApp.Controllers
{
    public class HomeController : Controller
    {
        private readonly DiarioMayorContext _context = new DiarioMayorContext();

        public HomeController(DiarioMayorContext context)
        {
            _context = context; 
        }
        public IActionResult Login()
        {
            return View();
        }
        [HttpGet]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return View("Login");
        }

        [HttpPost]
        public async Task<IActionResult> Iniciar(Usuario modelo)
        {
            Usuario? usuario_Existe = await _context.Usuarios.Where(u =>
                u.NombreUsuario == modelo.NombreUsuario &&
                u.Clave == modelo.Clave
                ).FirstOrDefaultAsync();
            if (usuario_Existe == null)
            {
                TempData["Mensaje01"] = "Usuario no valido";
                return RedirectToAction("Login");
            }

            if (usuario_Existe.UltInicio == null)
            {
                ViewData["ChPassword"] = true;
                ViewData["Id"] = usuario_Existe.IdUsuario;
                return View("NewPassword");
            }
            List<Claim> claims = new List<Claim>()
            {
                new Claim(ClaimTypes.Name, usuario_Existe.NombreUsuario),
                new Claim(ClaimTypes.NameIdentifier, Convert.ToString(usuario_Existe.IdUsuario), ClaimValueTypes.Integer32),
                new Claim(ClaimTypes.Role, usuario_Existe.TipoUsuario)
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
            _context.UpdateUltInicio(usuario_Existe.IdUsuario);
            return RedirectToAction("Index");
            
        }
        [HttpGet]
        public IActionResult NewPassword(int id)
        {
            if (ViewData["ChPassword"] == null)
            {
                return View("Login");
            }
            ViewData["Id"] = id;
            return View();
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
        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
