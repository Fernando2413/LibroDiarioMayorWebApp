using LibroDiarioMayorWebApp.Data;
using Microsoft.AspNetCore.Http;
using MoreLinq;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using System;
using LibroDiarioMayorWebApp.Models;
using Microsoft.EntityFrameworkCore.Metadata.Conventions;

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

        public IActionResult Index()
        {
            return View();
        }

		public IActionResult Visualize(int FechaMayor)
		{
            DataTable AllPartidas = _context.Partidas.ToDataTable();
            DataTable AllMovimientos = _context.Movimientos.ToDataTable();
            DataTable AllCuentas = _context.Catalogos.ToDataTable();
            ViewData["Fecha"] = FechaMayor;
            ViewData["CuentasAMostrar"] = functions.ObtenerArrayTablasMovimientos(FechaMayor, AllCuentas, AllPartidas, AllMovimientos);
            return View("Index");
		}
        public IActionResult BalanceGeneral()
        {
            return View();
        }
        public IActionResult EstadoResultado()
        {
            return View();
        }
    }
}
