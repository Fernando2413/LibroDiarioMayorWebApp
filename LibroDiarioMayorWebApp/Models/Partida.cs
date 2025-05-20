using System;
using System.Collections.Generic;

namespace LibroDiarioMayorWebApp.Models;

public partial class Partida
{
    public int NumeroPartida { get; set; }

    public DateOnly Fecha { get; set; }

    public string Descripcion { get; set; } = null!;

    public decimal? Debe { get; set; }

    public decimal? Haber { get; set; }

    public int? IngresadoPor { get; set; }
}
