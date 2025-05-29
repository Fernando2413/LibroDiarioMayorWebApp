using LibroDiarioMayorWebApp.Models;
using Microsoft.EntityFrameworkCore;
using System.Data;
using MoreLinq;

namespace LibroDiarioMayorWebApp.Data
{
    public class BLLMiscFunctions
    {
        public DataTable NuevaTablaMovimientos()
        {
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("IdMovimiento").AutoIncrement = true;
            dataTable.Columns.Add("IdPartida");
            dataTable.Columns.Add("IdCuenta");
            dataTable.Columns.Add("NombreCuenta");
            dataTable.Columns.Add("Debe").DefaultValue = 0;
            dataTable.Columns.Add("Haber").DefaultValue = 0;

            return dataTable;
        }
        public DataTable NuevaTablaPartida()
        {
            DataTable dPartida = new DataTable();
            dPartida.Columns.Add("NumeroPartida");
            dPartida.Columns.Add("Fecha");
            dPartida.Columns.Add("Descripcion");
            dPartida.Columns.Add("Debe").DefaultValue = 0;
            dPartida.Columns.Add("Haber").DefaultValue = 0;

            DataRow DefaultRow = dPartida.NewRow();
            DefaultRow["NumeroPartida"] = 0;
            DefaultRow["Fecha"] = DateOnly.FromDateTime(DateTime.Now);
            DefaultRow["Descripcion"] = 0;
            DefaultRow["Debe"] = 0;
            DefaultRow["Haber"] = 0;
            dPartida.Rows.Add(DefaultRow);

            return dPartida;

        }
        public DataTable NuevaTablaCatalogo()
        {
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("NumeroCuenta");
            dataTable.Columns.Add("NombreCuenta");

            return dataTable;
        }

        public decimal DebeActual(DataTable dataTable)
        {
            decimal debe = 0;
            for (int i = 0; i < dataTable.Rows.Count; i++)
            {
                debe += Convert.ToDecimal(dataTable.Rows[i][4]);
            }
            return debe;
        }

        public decimal HaberActual(DataTable dataTable)
        {
            decimal haber = 0;
            for (int i = 0; i < dataTable.Rows.Count; i++)
            {
                haber += Convert.ToDecimal(dataTable.Rows[i][5]);
            }
            return haber;
        }
        public DataTable LlenarTablaMovimientos(int IdPartida, int[] tIdCuenta, string[] tNombreCuenta, decimal[] tDebe, decimal[] tHaber)
        {
            DataTable dataTable = NuevaTablaMovimientos();
            for (int i = 0; i < tIdCuenta.Length; i++)
            {
                DataRow Row = dataTable.NewRow();
                Row["IdPartida"] = IdPartida;
                Row["IdCuenta"] = tIdCuenta.GetValue(i);
                Row["NombreCuenta"] = tNombreCuenta.GetValue(i);
                Row["Debe"] = tDebe.GetValue(i);
                Row["Haber"] = tHaber.GetValue(i);
                dataTable.Rows.Add(Row);
            }
            return dataTable;
        }
        public DataTable LlenarTablaPartida(int NumeroPartida, DateOnly Fecha, string Descripcion, DataTable dataTable)
        {
            DataTable dPartida = NuevaTablaPartida();

            DataRow rPartida = dPartida.Rows[0];
            rPartida["NumeroPartida"] = NumeroPartida;
            rPartida["Fecha"] = Fecha;
            rPartida["Descripcion"] = Descripcion;
            rPartida["Debe"] = DebeActual(dataTable);
            rPartida["Haber"] = HaberActual(dataTable);
            dPartida.AcceptChanges();

            return dPartida;
        }
        public DataTable LlenarTablaCatalogo(int[] NumeroCuenta, string[] NombreCuenta)
        {
            DataTable dataTable = NuevaTablaCatalogo();

            for (int i = 0; i < NumeroCuenta.Length; i++)
            {
                DataRow Row = dataTable.NewRow();
                Row["NumeroCuenta"] = NumeroCuenta.GetValue(i);
                Row["NombreCuenta"] = NombreCuenta.GetValue(i);
                dataTable.Rows.Add(Row);
            }
            return dataTable;
        }
        public DataTable ActualizarTablaMovimientosIndex(DataTable dataTable, int idMovimiento, int NumeroPartida, int[] tIdCuenta, string[] tNombreCuenta, decimal[] tDebe, decimal[] tHaber)
        {
            DataTable NewTable = NuevaTablaMovimientos();
            int[] tIdMovimiento = new int[dataTable.Rows.Count];
            for (int i = 0; i < dataTable.Rows.Count; i++)
            {
                tIdMovimiento[i] = Convert.ToInt32(dataTable.Rows[i]["IdMovimiento"]);
            }

            for (int i = 0; i < tIdCuenta.Length; i++)
            {
                if (idMovimiento == tIdMovimiento[i]){}
                else
                {
                    DataRow Row = NewTable.NewRow();
                    Row["IdPartida"] = NumeroPartida;
                    Row["IdCuenta"] = tIdCuenta.GetValue(i);
                    Row["NombreCuenta"] = tNombreCuenta.GetValue(i);
                    Row["Debe"] = tDebe.GetValue(i);
                    Row["Haber"] = tHaber.GetValue(i);
                    NewTable.Rows.Add(Row);
                }
            }
            return NewTable;
        }

        public string ObtenerCuentaMovida(int[] tCatalogoNumero, string[] tCatalogoNombre, int IdCuenta)
        {
            string CuentaMovida = "";
            for (int i = 0; i < tCatalogoNumero.Length; i++)
            {
                if (tCatalogoNumero[i] == IdCuenta)
                {
                    CuentaMovida = tCatalogoNombre[i].ToString();
                    break;
                }
            }
            return CuentaMovida;
        }



		public DataTable NuevaTablaDBPartida()
		{
			DataTable DBPartida = new DataTable();
			DBPartida.Columns.Add("NumeroPartida");
			DBPartida.Columns.Add("Fecha");
			DBPartida.Columns.Add("Descripcion");
			DBPartida.Columns.Add("Debe").DefaultValue = 0; ;
			DBPartida.Columns.Add("Haber").DefaultValue = 0;
            DBPartida.Columns.Add("IngresadoPor");

			return DBPartida;
		}

		public DataTable NuevaTablaDBMovimientos()
		{
			DataTable DBMovimiento = new DataTable();
			DBMovimiento.Columns.Add("IdMovimiento");
			DBMovimiento.Columns.Add("IdPartida");
			DBMovimiento.Columns.Add("IdCuenta");
			DBMovimiento.Columns.Add("NombreCuenta");
			DBMovimiento.Columns.Add("Debe").DefaultValue = 0;
			DBMovimiento.Columns.Add("Haber").DefaultValue = 0;

			return DBMovimiento;
		}

        public DataTable[] ObtenerArrayTablasMovimientos(int FechaMayor, DataTable AllCuentas, DataTable AllPartidas, DataTable AllMovimientos)
        {
            DataTable Partidas = NuevaTablaDBPartida();
            DataTable Movimientos = NuevaTablaDBMovimientos();

            string[] NombresCuentas = new string[AllCuentas.Rows.Count];

            DataTable[] MovimientosCuentasAMostrar = new DataTable[AllCuentas.Rows.Count];

            for (int i = 0; i < AllCuentas.Rows.Count; i++)
            {
                NombresCuentas[i] = AllCuentas.Rows[i][1].ToString();
            }

            for (int i = 0; i < AllPartidas.Rows.Count; i++)
            {
                if (Convert.ToUInt32(DateOnly.Parse(AllPartidas.Rows[i][1].ToString()).Year) == FechaMayor)
                {
                    DataRow row = Partidas.NewRow();
                    row["NumeroPartida"] = AllPartidas.Rows[i][0];
                    row["Fecha"] = AllPartidas.Rows[i][1];
                    row["Descripcion"] = AllPartidas.Rows[i][2];
                    row["Debe"] = AllPartidas.Rows[i][3];
                    row["Haber"] = AllPartidas.Rows[i][4];
                    row["IngresadoPor"] = AllPartidas.Rows[i][5];
                    Partidas.Rows.Add(row);
                    Partidas.AcceptChanges();
                }
            }

            for (int i = 0; i < Partidas.Rows.Count; i++)
            {
                for (int j = 0; j < AllMovimientos.Rows.Count; j++)
                {
                    if (Convert.ToInt32(Partidas.Rows[i][0]) == Convert.ToInt32(AllMovimientos.Rows[j][1]))
                    {
                        DataRow row = Movimientos.NewRow();
                        row["IdMovimiento"] = AllMovimientos.Rows[j][0];
                        row["IdPartida"] = AllMovimientos.Rows[j][1];
                        row["IdCuenta"] = AllMovimientos.Rows[j][2];
                        row["NombreCuenta"] = AllMovimientos.Rows[j][3];

                        if (AllMovimientos.Rows[j][5].ToString() == "DEBE")
                        {
                            row["Debe"] = AllMovimientos.Rows[j][4];
                        }
                        else
                        {
                            row["Haber"] = AllMovimientos.Rows[j][4];
                        }

                        Movimientos.Rows.Add(row);
                        Movimientos.AcceptChanges();
                    }
                }
            }
            for (int i = 0; i < NombresCuentas.Length; i++)
            {
                DataTable MovimientosCuentaIndividual = NuevaTablaDBMovimientos();

                for (int j = 0; j < Movimientos.Rows.Count; j++)
                {
                    if (NombresCuentas[i] == Movimientos.Rows[j][3].ToString())
                    {
                        DataRow row = MovimientosCuentaIndividual.NewRow();
                        row["IdMovimiento"] = Movimientos.Rows[j][0];
                        row["IdPartida"] = Movimientos.Rows[j][1];
                        row["IdCuenta"] = Movimientos.Rows[j][2];
                        row["NombreCuenta"] = Movimientos.Rows[j][3];
                        row["Debe"] = Movimientos.Rows[j][4];
                        row["Haber"] = Movimientos.Rows[j][5];

                        MovimientosCuentaIndividual.Rows.Add(row);
                        MovimientosCuentaIndividual.AcceptChanges();
                    }
                }
                MovimientosCuentasAMostrar[i] = MovimientosCuentaIndividual;

            }
            return MovimientosCuentasAMostrar;
        }
	}
}
