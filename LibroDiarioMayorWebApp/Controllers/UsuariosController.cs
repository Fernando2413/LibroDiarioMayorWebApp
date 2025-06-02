using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using LibroDiarioMayorWebApp.Models;
using Microsoft.AspNetCore.Authorization;
using MoreLinq.Extensions;
using System.Data;
using System.Runtime.CompilerServices;
using LibroDiarioMayorWebApp.Data;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Security.Claims;

namespace LibroDiarioMayorWebApp.Controllers
{
    public class UsuariosController : Controller
    {
        private readonly DiarioMayorContext _context;
        
        public UsuariosController(DiarioMayorContext context)
        {
            _context = context;
        }

        // GET: Usuarios
        [Authorize(Roles = "Administrador")]
        public async Task<IActionResult> Index()
        {
            return View(await _context.Usuarios.ToListAsync());
        }

        // GET: Usuarios/Details/5
        [Authorize(Roles = "Administrador, Usuario")]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var usuario = await _context.Usuarios
                .FirstOrDefaultAsync(m => m.IdUsuario == id);
            if (usuario == null)
            {
                return NotFound();
            }

            return View(usuario);
        }

        // GET: Usuarios/Create
        [Authorize(Roles = "Administrador")]
        public IActionResult Create()
        {
            return View();
        }

        // POST: Usuarios/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("IdUsuario,NombreUsuario,TipoUsuario,Telefono,Direccion,Correo,UltInicio,Clave")] Usuario usuario)
        {
            if (ModelState.IsValid)
            {
                if(await _context.Usuarios.Where(u => u.NombreUsuario == usuario.NombreUsuario).FirstOrDefaultAsync() == null)
                {
					_context.Add(usuario);
					await _context.SaveChangesAsync();
					return RedirectToAction(nameof(Index));
				}
                else
                {
                    ViewData["Mensaje01"] = "Este nombre de usuario ya existe";
					return View(usuario);
				}
            }
            return View(usuario);
        }

        // GET: Usuarios/Edit/5
        [Authorize(Roles = "Administrador, Usuario")]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var usuario = await _context.Usuarios.FindAsync(id);
            if (usuario == null)
            {
                return NotFound();
            }
            return View(usuario);
        }

        // POST: Usuarios/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("IdUsuario,NombreUsuario,TipoUsuario,Telefono,Direccion,Correo,UltInicio,Clave")] Usuario usuario)
        {
            if (id != usuario.IdUsuario)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    if(id != _context.Usuarios.Where(u => u.NombreUsuario == usuario.NombreUsuario).Select(i => i.IdUsuario).FirstOrDefault())
                    {
                        ViewData["Mensaje01"] = "Este nombre de usuario ya existe";
                        return View(usuario);
                    }
                    _context.Update(usuario);
                    await _context.SaveChangesAsync();
                    if (usuario.IdUsuario != Convert.ToInt32(User.Claims.Where(c => c.Type == ClaimTypes.NameIdentifier).Select(c => c.Value).SingleOrDefault()))
                    {
                        _context.ClearUltInicio(usuario.IdUsuario);
                    }

                    if (id == Convert.ToInt32(User.Claims.Where(c => c.Type == ClaimTypes.NameIdentifier).Select(c => c.Value).SingleOrDefault()))
                    {
                        await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
                    }
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!UsuarioExists(usuario.IdUsuario))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(usuario);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> NewPassword(int Id, string Clave, string ConfirmarClave)
        {
            if(Clave != ConfirmarClave || Clave == null || ConfirmarClave == null)
            {
                ViewData["ChPassword"] = true;
                ViewData["Id"] = Id;
                if (Clave == null || ConfirmarClave == null) { ViewData["Mensaje01"] = "Ambos campos son requeridos"; }
                else { ViewData["Mensaje01"] = "Las contraseñas no coinciden"; };
                return View("Home/NewPassword");
            }

            _context.UpdateClave(Id,Clave);
            _context.UpdateUltInicio(Id);
            await _context.SaveChangesAsync();
            TempData["Mensaje02"] = "Contraseña Cambiada Correctamente, Por favor inicie sesión nuevamente.";
            return RedirectToAction("Login", "Home");
        }

        // GET: Usuarios/Delete/5
        [Authorize(Roles = "Administrador")]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var usuario = await _context.Usuarios
                .FirstOrDefaultAsync(m => m.IdUsuario == id);
            if (usuario == null)
            {
                return NotFound();
            }

            return View(usuario);
        }

        // POST: Usuarios/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var usuario = await _context.Usuarios.FindAsync(id);
            if (usuario != null)
            {
                _context.Usuarios.Remove(usuario);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool UsuarioExists(int id)
        {
            return _context.Usuarios.Any(e => e.IdUsuario == id);
        }
    }
}
