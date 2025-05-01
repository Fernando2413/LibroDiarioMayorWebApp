using System;
using System.Collections.Generic;

namespace LibroDiarioMayorWebApp.Models;

public partial class Catalogo
{
    public int NumeroCuenta { get; set; }

    public string NombreCuenta { get; set; } = null!;

    public string TipoCuenta { get; set; } = null!;

    public string IncluidaEn { get; set; } = null!;
}
