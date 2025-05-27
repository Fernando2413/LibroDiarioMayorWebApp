using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using LibroDiarioMayorWebApp.Models;
using Microsoft.AspNetCore.Authorization;
using LibroDiarioMayorWebApp.Data;
using System.Data;
using System.Linq;
using MoreLinq;
using System.Security.Claims;
using NuGet.Protocol;
using Microsoft.CodeAnalysis;
using System.ComponentModel.DataAnnotations;
using System.Net;

namespace LibroDiarioMayorWebApp.Controllers
{
    public class MovimientosController : Controller
    {
        private readonly DiarioMayorContext _context;
        public BLLMiscFunctions functions = new BLLMiscFunctions();

        public MovimientosController(DiarioMayorContext context)
        {
            _context = context;
        }

        [Authorize(Roles = "Administrador, Usuario")]
        [HttpPost]
        public IActionResult NuevoMovimiento(int NumeroPartida, DateOnly Fecha, string Descripcion, string Action, int OGId, int[] tIdCuenta, string[] tNombreCuenta, decimal[] tDebe, decimal[] tHaber, int[] tCatalogoNumero, string[] tCatalogoNombre)
        {
            DataTable dataTable = functions.LlenarTablaMovimientos(NumeroPartida, tIdCuenta, tNombreCuenta, tDebe, tHaber);
            DataTable dPartida = functions.LlenarTablaPartida(NumeroPartida, Fecha, Descripcion, dataTable);

            ViewData["Cuentas"] = functions.LlenarTablaCatalogo(tCatalogoNumero, tCatalogoNombre);
            ViewData["Table"] = dataTable;
            ViewData["pDatos"] = dPartida;
            ViewData["Action"] = Action;
            ViewData["OGId"] = OGId;

            return View("Movimientos/Create");
        }
        [Authorize(Roles = "Administrador, Usuario")]
        [HttpPost]
        public IActionResult EditarMovimiento(int NumeroPartida, DateOnly Fecha, string Descripcion, int idMovimiento, string Action, int OGId, int[] tIdCuenta, string[] tNombreCuenta, decimal[] tDebe, decimal[] tHaber, int[] tCatalogoNumero, string[] tCatalogoNombre)
        {
            DataTable dataTable = functions.LlenarTablaMovimientos(NumeroPartida, tIdCuenta, tNombreCuenta, tDebe, tHaber);
            DataTable dPartida = functions.LlenarTablaPartida(NumeroPartida, Fecha, Descripcion, dataTable);

            ViewData["Cuentas"] = functions.LlenarTablaCatalogo(tCatalogoNumero, tCatalogoNombre);
            ViewData["Table"] = dataTable;
            ViewData["pDatos"] = dPartida;
            ViewData["Action"] = Action;
            ViewData["OGId"] = OGId;
            ViewData["IdMovimiento"] = idMovimiento;

            return View("Movimientos/Edit");
        }
        [Authorize(Roles = "Administrador, Usuario")]
        [HttpPost]
        public IActionResult EliminarMovimiento(int NumeroPartida, DateOnly Fecha, string Descripcion, int idMovimiento, string Action, int OGId, int[] tIdCuenta, string[] tNombreCuenta, decimal[] tDebe, decimal[] tHaber, int[] tCatalogoNumero, string[] tCatalogoNombre)
        {
            DataTable dataTable = functions.LlenarTablaMovimientos(NumeroPartida, tIdCuenta, tNombreCuenta, tDebe, tHaber);
            DataTable dPartida = functions.LlenarTablaPartida(NumeroPartida, Fecha, Descripcion, dataTable);

            ViewData["Cuentas"] = functions.LlenarTablaCatalogo(tCatalogoNumero, tCatalogoNombre);
            ViewData["Table"] = dataTable;
            ViewData["pDatos"] = dPartida;
            ViewData["Action"] = Action;
            ViewData["OGId"] = OGId;
            ViewData["IdMovimiento"] = idMovimiento;

            return View("Movimientos/Delete");
        }
        [Authorize(Roles = "Administrador, Usuario")]
        [HttpPost]
        public IActionResult VolverIndexMovimientos(int NumeroPartida, DateOnly Fecha, string Descripcion, string Action, int OGId, int[] tIdCuenta, string[] tNombreCuenta, decimal[] tDebe, decimal[] tHaber, int[] tCatalogoNumero, string[] tCatalogoNombre)
        {
            DataTable dataTable = functions.LlenarTablaMovimientos(NumeroPartida, tIdCuenta, tNombreCuenta, tDebe, tHaber);
            DataTable dPartida = functions.LlenarTablaPartida(NumeroPartida, Fecha, Descripcion, dataTable);

            ViewData["Cuentas"] = functions.LlenarTablaCatalogo(tCatalogoNumero, tCatalogoNombre);
            ViewData["Table"] = dataTable;
            ViewData["pDatos"] = dPartida;
            ViewData["Action"] = Action;
            ViewData["OGId"] = OGId;

            return View("Movimientos/Index");
        }
        [Authorize(Roles = "Administrador, Usuario")]
        [HttpPost]
        public async Task<IActionResult> GuardarTempMovimiento(int IdCuenta, decimal SaldoMovimiento, string TipoMovimiento, int NumeroPartida, DateOnly Fecha, string Descripcion, string Action, int OGId, string[] tIdPartida, int[] tIdCuenta, string[] tNombreCuenta, decimal[] tDebe, decimal[] tHaber, int[] tCatalogoNumero, string[] tCatalogoNombre)
        {
            string CuentaMovida = functions.ObtenerCuentaMovida(tCatalogoNumero, tCatalogoNombre, IdCuenta);

            DataTable dataTable = functions.LlenarTablaMovimientos(NumeroPartida, tIdCuenta, tNombreCuenta, tDebe, tHaber);

            DataRow NewRow = dataTable.NewRow();
            NewRow["IdPartida"] = NumeroPartida;
            NewRow["IdCuenta"] = IdCuenta;
            NewRow["NombreCuenta"] = CuentaMovida;
            if(TipoMovimiento == "Debe")
            {
                NewRow["Debe"] = SaldoMovimiento;
                NewRow["Haber"] = 0;
            }
            else
            {
                NewRow["Debe"] = 0;
                NewRow["Haber"] = SaldoMovimiento;
            }
            dataTable.Rows.Add(NewRow);

            DataTable dPartida = functions. LlenarTablaPartida(NumeroPartida, Fecha, Descripcion, dataTable);

            DataRow rPartida = dPartida.Rows[0];
            rPartida["NumeroPartida"] = NumeroPartida;
            rPartida["Fecha"] = Fecha;
            rPartida["Descripcion"] = Descripcion;
            rPartida["Debe"] = functions.DebeActual(dataTable);
            rPartida["Haber"] = functions.HaberActual(dataTable);
            dPartida.AcceptChanges();

            ViewData["Cuentas"] = functions.LlenarTablaCatalogo(tCatalogoNumero, tCatalogoNombre);
            ViewData["Table"] = dataTable;
            ViewData["pDatos"] = dPartida;
            ViewData["Action"] = Action;
            ViewData["OGId"] = OGId;

            return View("Movimientos/Index");
        }
        [Authorize(Roles = "Administrador, Usuario")]
        [HttpPost]
        public async Task<IActionResult> GuardarEditTempMovimiento(int IdCuenta, decimal SaldoMovimiento, string TipoMovimiento, int NumeroPartida, DateOnly Fecha, string Descripcion, int idMovimiento, string Action, int OGId, string[] tIdPartida, int[] tIdCuenta, string[] tNombreCuenta, decimal[] tDebe, decimal[] tHaber, int[] tCatalogoNumero, string[] tCatalogoNombre)
        {
            string CuentaMovida = functions.ObtenerCuentaMovida(tCatalogoNumero, tCatalogoNombre, IdCuenta);

            DataTable dataTable = functions.LlenarTablaMovimientos(NumeroPartida, tIdCuenta, tNombreCuenta, tDebe, tHaber);

            DataRow EditRow = dataTable.Rows[idMovimiento];
            EditRow["IdPartida"] = NumeroPartida;
            EditRow["IdCuenta"] = IdCuenta;
            EditRow["NombreCuenta"] = CuentaMovida;
            if (TipoMovimiento == "Debe")
            {
                EditRow["Debe"] = SaldoMovimiento;
                EditRow["Haber"] = 0;
            }
            else
            {
                EditRow["Debe"] = 0;
                EditRow["Haber"] = SaldoMovimiento;
            }
            dataTable.AcceptChanges();

            DataTable dPartida = functions.LlenarTablaPartida(NumeroPartida, Fecha, Descripcion, dataTable);

            DataRow rPartida = dPartida.Rows[0];
            rPartida["NumeroPartida"] = NumeroPartida;
            rPartida["Fecha"] = Fecha;
            rPartida["Descripcion"] = Descripcion;
            rPartida["Debe"] = functions.DebeActual(dataTable);
            rPartida["Haber"] = functions.HaberActual(dataTable);
            dPartida.AcceptChanges();

            ViewData["Cuentas"] = functions.LlenarTablaCatalogo(tCatalogoNumero, tCatalogoNombre);
            ViewData["Table"] = dataTable;
            ViewData["pDatos"] = dPartida;
            ViewData["Action"] = Action;
            ViewData["OGId"] = OGId;

            return View("Movimientos/Index");
        }
        [Authorize(Roles = "Administrador, Usuario")]
        [HttpPost]
        public IActionResult GuardarDeleteTempMovimiento(int NumeroPartida, DateOnly Fecha, string Descripcion, int idMovimiento, string Action, int OGId, int[] tIdCuenta, string[] tNombreCuenta, decimal[] tDebe, decimal[] tHaber, int[] tCatalogoNumero, string[] tCatalogoNombre)
        {
            DataTable dataTable = functions.LlenarTablaMovimientos(NumeroPartida, tIdCuenta, tNombreCuenta, tDebe, tHaber);
            dataTable = functions.ActualizarTablaMovimientosIndex(dataTable, idMovimiento, NumeroPartida, tIdCuenta, tNombreCuenta, tDebe, tHaber);

            DataTable dPartida = functions.LlenarTablaPartida(NumeroPartida, Fecha, Descripcion, dataTable);

            DataRow rPartida = dPartida.Rows[0];
            rPartida["NumeroPartida"] = NumeroPartida;
            rPartida["Fecha"] = Fecha;
            rPartida["Descripcion"] = Descripcion;
            rPartida["Debe"] = functions.DebeActual(dataTable);
            rPartida["Haber"] = functions.HaberActual(dataTable);
            dPartida.AcceptChanges();

            ViewData["Cuentas"] = functions.LlenarTablaCatalogo(tCatalogoNumero, tCatalogoNombre);
            ViewData["Table"] = dataTable;
            ViewData["pDatos"] = dPartida;
            ViewData["Action"] = Action;
            ViewData["OGId"] = OGId;

            return View("Movimientos/Index");
        }
    }
}
