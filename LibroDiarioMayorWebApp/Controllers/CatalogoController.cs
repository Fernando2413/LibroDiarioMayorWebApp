﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using LibroDiarioMayorWebApp.Models;
using Microsoft.AspNetCore.Authorization;
using System.Data;
using System.Collections.Immutable;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using MoreLinq;
using LibroDiarioMayorWebApp.Data;

namespace LibroDiarioMayorWebApp.Controllers
{
    [Authorize(Roles = "Administrador")]
    [Authorize]
    public class CatalogoController : Controller
    {
        private readonly DiarioMayorContext _context;

        public CatalogoController(DiarioMayorContext context)
        {
            _context = context;
        }
        public DataTable GetCatalogo()
        {
            DataTable catalogo = _context.Catalogos.ToDataTable();
            return catalogo;


        }
        // GET: Catalogo
        public async Task<IActionResult> Index()
        {
            return View(await _context.Catalogos.ToListAsync());
        }

        // GET: Catalogo/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var catalogo = await _context.Catalogos
                .FirstOrDefaultAsync(m => m.NumeroCuenta == id);
            if (catalogo == null)
            {
                return NotFound();
            }

            return View(catalogo);
        }

        // GET: Catalogo/Create
        public IActionResult Create()
        {
            ViewData["TablaCatalogo"] = GetCatalogo();
            return View();
        }

        // POST: Catalogo/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("NumeroCuenta,NombreCuenta,GrupoCuenta,TipoCuenta,ClasificacionCuenta,IncluidaEn,CR")] Catalogo catalogo)
        {
            if (ModelState.IsValid)
            {
                Catalogo? catalogo_Existe = await _context.Catalogos.Where(c => c.NumeroCuenta == catalogo.NumeroCuenta).FirstOrDefaultAsync();
                if (catalogo_Existe != null)
                {
                    ViewData["Mensaje01"] = "Este Número de Cuenta ya esta en uso";
                    return View(catalogo);
                }
                else
                {
                    _context.Add(catalogo);
                    await _context.SaveChangesAsync();
                    return RedirectToAction(nameof(Index));
                }
            }
            return View(catalogo);
        }

        // GET: Catalogo/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }
            var catalogo = await _context.Catalogos.FindAsync(id);
            if (catalogo == null)
            {
                return NotFound();
            }
            return View(catalogo);
        }

        // POST: Catalogo/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("NumeroCuenta,NombreCuenta,GrupoCuenta,TipoCuenta,ClasificacionCuenta,IncluidaEn,CR")] Catalogo catalogo)
        {
            if (id != catalogo.NumeroCuenta)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(catalogo);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!CatalogoExists(catalogo.NumeroCuenta))
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
            return View(catalogo);
        }

        // GET: Catalogo/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var catalogo = await _context.Catalogos
                .FirstOrDefaultAsync(m => m.NumeroCuenta == id);
            if (catalogo == null)
            {
                return NotFound();
            }

            return View(catalogo);
        }

        // POST: Catalogo/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var catalogo = await _context.Catalogos.FindAsync(id);
            if (catalogo != null)
            {
                _context.Catalogos.Remove(catalogo);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool CatalogoExists(int id)
        {
            return _context.Catalogos.Any(e => e.NumeroCuenta == id);
        }
    }
}
