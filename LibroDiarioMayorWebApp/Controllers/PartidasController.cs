using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using LibroDiarioMayorWebApp.Models;
using Microsoft.AspNetCore.Authorization;
using LibroDiarioMayorWebApp.Data;
using System.Data;
using MoreLinq;
using System.Security.Claims;
using System.Xml;
using Microsoft.CodeAnalysis.Elfie.Extensions;
using static System.Runtime.InteropServices.JavaScript.JSType;
using System.Security.Cryptography;

namespace LibroDiarioMayorWebApp.Controllers
{
    public class PartidasController : Controller
    {
        private readonly DiarioMayorContext _context;
        public BLLMiscFunctions functions = new BLLMiscFunctions();

        public PartidasController(DiarioMayorContext context)
        {
            _context = context;
        }

        // GET: Partidas
        [Authorize(Roles = "Administrador, Usuario")]
        [HttpGet]
        public async Task<IActionResult> Index()
        {
            
            return View("Partidas/Index", await _context.Partidas.ToListAsync());
        }

        // GET: Partidas/Details/5
        [Authorize(Roles = "Administrador, Usuario")]
        [HttpGet]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var partida = await _context.Partidas
                .FirstOrDefaultAsync(m => m.NumeroPartida == id);
            if (partida == null)
            {
                return NotFound();
            }
            DataTable allMov = _context.Movimientos.ToDataTable();
            DataTable dataTable = functions.NuevaTablaMovimientos();
            for (int i = 0; i < allMov.Rows.Count; i++)
            {
                if (Convert.ToInt32(allMov.Rows[i]["IdPartida"]) == id)
                {
                    DataRow row = dataTable.NewRow();
                    row["IdPartida"] = allMov.Rows[i][1];
                    row["IdCuenta"] = allMov.Rows[i][2];
                    row["NombreCuenta"] = allMov.Rows[i][3];
                    if (allMov.Rows[i][5].ToString() == "DEBE")
                    {
                        row["Debe"] = allMov.Rows[i][4];
                    }
                    else
                    {
                        row["Haber"] = allMov.Rows[i][4];
                    }

                    dataTable.Rows.Add(row);
                }
            }
            dataTable.AcceptChanges();

            DataTable pDatos = functions.LlenarTablaPartida(partida.NumeroPartida, partida.Fecha, partida.Descripcion, dataTable);

            ViewData["Table"] = dataTable;
            ViewData["pDatos"] = pDatos;
            ViewData["IngresadoPor"] = partida.IngresadoPor;
            return View("Partidas/Details");
        }

        // GET: Partidas/Create
        [Authorize(Roles = "Administrador, Usuario")]
        [HttpGet]
        public IActionResult Create()
        {
            ViewData["Cuentas"] = _context.Catalogos.ToDataTable();
            return View("Partidas/Create");
        }
        // POST: Partidas/Create
        [HttpPost]
        public IActionResult AccionNuevaPartida(int NumeroPartida, DateOnly Fecha, string Descripcion, int[] tCatalogoNumero, string[] tCatalogoNombre, string Action)
        {
            ViewData["Cuentas"] = functions.LlenarTablaCatalogo(tCatalogoNumero, tCatalogoNombre);
            ViewData["Table"] = functions.NuevaTablaMovimientos();
            ViewData["pDatos"] = functions.LlenarTablaPartida(NumeroPartida, Fecha, Descripcion, functions.NuevaTablaMovimientos());
            ViewData["Action"] = Action;
            return View("Movimientos/Index");
        }
        // POST: ir aPartidas/Edit
        [HttpPost]
        public IActionResult AccionEditarPartida(int NumeroPartida, DateOnly Fecha, string Descripcion, string Action, int OGId, int[] tIdCuenta, string[] tNombreCuenta, decimal[] tDebe, decimal[] tHaber, int[] tCatalogoNumero, string[] tCatalogoNombre)
        {
            ViewData["Cuentas"] = functions.LlenarTablaCatalogo(tCatalogoNumero, tCatalogoNombre);
            ViewData["Table"] = functions.LlenarTablaMovimientos(NumeroPartida, tIdCuenta, tNombreCuenta, tDebe, tHaber);
            ViewData["pDatos"] = functions.LlenarTablaPartida(NumeroPartida, Fecha, Descripcion, functions.LlenarTablaMovimientos(NumeroPartida, tIdCuenta, tNombreCuenta, tDebe, tHaber));
            ViewData["Action"] = Action;
            ViewData["OGId"] = OGId;
            return View("Partidas/Edit");
        }
        // POST: volviendo de Partidas/Edit
        [HttpPost]
        public IActionResult PartidaVolverIndexMovimientos(int NumeroPartida, DateOnly Fecha, string Descripcion, string Action, int OGId, int[] tIdCuenta, string[] tNombreCuenta, decimal[] tDebe, decimal[] tHaber, int[] tCatalogoNumero, string[] tCatalogoNombre)
        {
            ViewData["Cuentas"] = functions.LlenarTablaCatalogo(tCatalogoNumero, tCatalogoNombre);
            ViewData["Table"] = functions.LlenarTablaMovimientos(NumeroPartida, tIdCuenta, tNombreCuenta, tDebe, tHaber);
            ViewData["pDatos"] = functions.LlenarTablaPartida(NumeroPartida, Fecha, Descripcion, functions.LlenarTablaMovimientos(NumeroPartida, tIdCuenta, tNombreCuenta, tDebe, tHaber));
            ViewData["Action"] = Action;
            ViewData["OGId"] = OGId;
            return View("Movimientos/Index");
        }

        // POST: guardando datos de Partidas/Edit
        [HttpPost]
        public IActionResult AccionGuardarEditPartida(int NumeroPartida, DateOnly Fecha, string Descripcion, string Action, int OGId, int[] tIdCuenta, string[] tNombreCuenta, decimal[] tDebe, decimal[] tHaber, int[] tCatalogoNumero, string[] tCatalogoNombre)
        {
            ViewData["Cuentas"] = functions.LlenarTablaCatalogo(tCatalogoNumero, tCatalogoNombre);
            ViewData["Table"] = functions.LlenarTablaMovimientos(NumeroPartida, tIdCuenta, tNombreCuenta, tDebe, tHaber);
            ViewData["pDatos"] = functions.LlenarTablaPartida(NumeroPartida, Fecha, Descripcion, functions.LlenarTablaMovimientos(NumeroPartida, tIdCuenta, tNombreCuenta, tDebe, tHaber));
            ViewData["Action"] = Action;
            ViewData["OGId"] = OGId;
            return View("Movimientos/Index");
        }
        // POST: Guardando Partida de Movimientos/Index
        [Authorize(Roles = "Administrador, Usuario")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> AccionGuardarPartida(int NumeroPartida, DateOnly Fecha, string Descripcion, string Action, int OGId, decimal Debe, decimal Haber, string[] tIdPartida, int[] tIdCuenta, string[] tNombreCuenta, decimal[] tDebe, decimal[] tHaber, int[] tCatalogoNumero, string[] tCatalogoNombre)
        {
            DataTable dataTable = functions.LlenarTablaMovimientos(NumeroPartida, tIdCuenta, tNombreCuenta, tDebe, tHaber);
            DataTable pDatos = functions.LlenarTablaPartida(NumeroPartida, Fecha, Descripcion, dataTable);
            if (_context.Partidas.Where(p => p.NumeroPartida == NumeroPartida).FirstOrDefault() != null && Action != "Edit")
            {
                ViewData["Mensaje01"] = "Este numero de partida ya existe, defina uno nuevo";
                ViewData["Cuentas"] = functions.LlenarTablaCatalogo(tCatalogoNumero, tCatalogoNombre);
                ViewData["Table"] = dataTable;
                ViewData["pDatos"] = pDatos;
                ViewData["Action"] = Action;
                ViewData["OGId"] = OGId;

                return View("Movimientos/Index");
            }
            if (Debe != Haber || Debe <= 0 || Haber <= 0)
            {
                if (Debe <= 0 || Haber <= 0)
                {
                    ViewData["Mensaje01"] = "El DEBE y el HABER no pueden ser igual o menor que 0";
                }
                else
                {
                    ViewData["Mensaje01"] = "El DEBE total y el HABER total no coinciden";
                }
                ViewData["Cuentas"] = functions.LlenarTablaCatalogo(tCatalogoNumero, tCatalogoNombre);
                ViewData["Table"] = dataTable;
                ViewData["pDatos"] = pDatos;
                ViewData["Action"] = Action;
                ViewData["OGId"] = OGId;

                return View("Movimientos/Index");
            }
            else
            {
                if (Action == "Create")
                {
                    _context.CreatePartidaMovimientos(NumeroPartida, dataTable, pDatos, User.Claims.Where(u => u.Type == ClaimTypes.Name).Select(v => v.Value).SingleOrDefault());
                    _context.SaveChanges();
                    return View("Partidas/Index", await _context.Partidas.ToListAsync());
                }
                else
                {
                    if (User.IsInRole("Usuario") == true)
                    {
                        ViewData["Mensaje01"] = "No tienes permiso para acceder a esta funcionalidad";
                        return View("Partidas/Index");
                    }
                    _context.EditPartidaMovimientos(NumeroPartida, dataTable, pDatos, User.Claims.Where(u => u.Type == ClaimTypes.Name).Select(v => v.Value).SingleOrDefault(), OGId);
                    _context.SaveChanges();
                    return View("Partidas/Index", await _context.Partidas.ToListAsync());
                }
            }
        }

        // GET: Partidas/Edit/5
        [Authorize(Roles = "Administrador")]
        [HttpGet]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var partida = await _context.Partidas.FindAsync(id);
            if (partida == null)
            {
                return NotFound();
            }
            DataTable allMov = _context.Movimientos.ToDataTable();
            DataTable dataTable = functions.NuevaTablaMovimientos();
            for (int i = 0; i < allMov.Rows.Count; i++)
            {
                if (Convert.ToInt32(allMov.Rows[i]["IdPartida"]) == id)
                {
                    DataRow row = dataTable.NewRow();
                    row["IdPartida"] = allMov.Rows[i][1];
                    row["IdCuenta"] = allMov.Rows[i][2];
                    row["NombreCuenta"] = allMov.Rows[i][3];
                    if (allMov.Rows[i][5].ToString() == "DEBE")
                    {
                        row["Debe"] = allMov.Rows[i][4];
                    }
                    else
                    {
                        row["Haber"] = allMov.Rows[i][4];
                    }

                    dataTable.Rows.Add(row);
                }
            }
            dataTable.AcceptChanges();

            DataTable pDatos = functions.LlenarTablaPartida(partida.NumeroPartida, partida.Fecha, partida.Descripcion, dataTable);
            ViewData["Cuentas"] = _context.Catalogos.ToDataTable();
            ViewData["Table"] = dataTable;
            ViewData["pDatos"] = pDatos;
            ViewData["Action"] = "Edit";
            ViewData["OGId"] = id;
            ViewData["Cuentas"] = _context.Catalogos.ToDataTable();
            return View("Movimientos/Index");
        }

        // GET: Partidas/Delete/5
        [Authorize(Roles = "Administrador")]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var partida = await _context.Partidas
                .FirstOrDefaultAsync(m => m.NumeroPartida == id);
            if (partida == null)
            {
                return NotFound();
            }
            DataTable allMov = _context.Movimientos.ToDataTable();
            DataTable dataTable = functions.NuevaTablaMovimientos();
            for (int i = 0; i < allMov.Rows.Count; i++)
            {
                if (Convert.ToInt32(allMov.Rows[i]["IdPartida"]) == id)
                {
                    DataRow row = dataTable.NewRow();
                    row["IdPartida"] = allMov.Rows[i][1];
                    row["IdCuenta"] = allMov.Rows[i][2];
                    row["NombreCuenta"] = allMov.Rows[i][3];
                    if (allMov.Rows[i][5].ToString() == "DEBE")
                    {
                        row["Debe"] = allMov.Rows[i][4];
                    }
                    else
                    {
                        row["Haber"] = allMov.Rows[i][4];
                    }

                    dataTable.Rows.Add(row);
                }
            }
            dataTable.AcceptChanges();

            DataTable pDatos = functions.LlenarTablaPartida(partida.NumeroPartida, partida.Fecha, partida.Descripcion, dataTable);

            ViewData["Table"] = dataTable;
            ViewData["pDatos"] = pDatos;
            ViewData["OGId"] = id;

            return View("Partidas/Delete");
        }

        // POST: Partidas/Delete/5
        [Authorize(Roles = "Administrador")]
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var partida = await _context.Partidas.FindAsync(id);
            if (partida != null)
            {
                _context.Partidas.Remove(partida);
            }
            await _context.SaveChangesAsync();
            _context.DeletePartidaMovimientos(id);
            return RedirectToAction(nameof(Index));
        }

        private bool PartidaExists(int id)
        {
            return _context.Partidas.Any(e => e.NumeroPartida == id);
        }
    }
}
