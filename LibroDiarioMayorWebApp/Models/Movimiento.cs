using System;
using System.Collections.Generic;

namespace LibroDiarioMayorWebApp.Models;

public partial class Movimiento
{
    public int IdMovimiento { get; set; }

    public int IdPartida { get; set; }

    public int IdCuenta { get; set; }

    public decimal SaldoMovimiento { get; set; }

    public string TipoMovimiento { get; set; } = null!;
}
