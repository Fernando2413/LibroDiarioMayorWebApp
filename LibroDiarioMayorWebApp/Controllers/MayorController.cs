using LibroDiarioMayorWebApp.Data;
using Microsoft.AspNetCore.Http;
using MoreLinq;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using System;
using LibroDiarioMayorWebApp.Models;
using Microsoft.EntityFrameworkCore.Metadata.Conventions;
using iText.Kernel.Pdf;
using iText.Html2pdf;
using iText.Layout;
using iText.Layout.Element;

namespace LibroDiarioMayorWebApp.Controllers
{
    public class MayorController : Controller
    {
        private readonly DiarioMayorContext _context;
        public BLLMiscFunctions functions = new BLLMiscFunctions();

        public MayorController(DiarioMayorContext context)
        {
            _context = context;
        }

        public IActionResult LibroMayor()
        {
            return View("Mayor");
        }
		public IActionResult BalanceGeneral()
		{
			return View();
		}
		public IActionResult EstadoResultado()
		{
			return View();
		}

		public IActionResult GenerarLibroMayor(int FechaMayor)
		{
			DataTable AllPartidas = _context.Partidas.ToDataTable();
			DataTable AllMovimientos = _context.Movimientos.ToDataTable();
			DataTable AllCuentas = _context.Catalogos.ToDataTable();
			DataTable[] CuentasAMostrar = functions.ObtenerArrayTablasMovimientos(FechaMayor, AllCuentas, AllPartidas, AllMovimientos);
			ViewData["Fecha"] = FechaMayor;
			ViewData["CuentasAMostrar"] = CuentasAMostrar;
            return View("Mayor");
		}
        public IActionResult GenerarBalanceGeneral(int FechaMayor)
        {
			DataTable AllPartidas = _context.Partidas.ToDataTable();
			DataTable AllMovimientos = _context.Movimientos.ToDataTable();
			DataTable AllCuentas = _context.Catalogos.ToDataTable();
			DataTable[] CuentasAMostrar = functions.ObtenerArrayTablasMovimientos(FechaMayor, AllCuentas, AllPartidas, AllMovimientos);

			ViewData["Fecha"] = FechaMayor;
			ViewData["CuentasAMostrar"] = CuentasAMostrar;
			ViewData["Saldos"] = functions.Saldos(CuentasAMostrar);
			return View("BalanceGeneral");
        }
        public IActionResult GenerarEstadoResultado(int FechaMayor)
        {
			{
				DataTable AllPartidas = _context.Partidas.ToDataTable();
				DataTable AllMovimientos = _context.Movimientos.ToDataTable();
				DataTable AllCuentas = _context.Catalogos.ToDataTable();
				DataTable[] CuentasAMostrar = functions.ObtenerArrayTablasMovimientos(FechaMayor, AllCuentas, AllPartidas, AllMovimientos);
				DataTable[] InventarioAnterior = functions.InventarioMovimiento(functions.ObtenerArrayTablasMovimientos(FechaMayor - 1, AllCuentas, AllPartidas, AllMovimientos));

				ViewData["Fecha"] = FechaMayor;
				ViewData["CuentasAMostrar"] = CuentasAMostrar;
				ViewData["Saldos"] = functions.Saldos(CuentasAMostrar);
				ViewData["InventarioAnterior"] = InventarioAnterior;
				return View("EstadoResultado");
			}
        }
    }
}
