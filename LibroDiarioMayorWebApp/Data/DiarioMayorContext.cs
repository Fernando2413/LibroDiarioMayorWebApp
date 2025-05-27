using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.CompilerServices;
using LibroDiarioMayorWebApp.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Migrations.Operations;

namespace LibroDiarioMayorWebApp.Data;

public partial class DiarioMayorContext : DbContext
{
    public DiarioMayorContext()
    {
    }

    public DiarioMayorContext(DbContextOptions<DiarioMayorContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Catalogo> Catalogos { get; set; }

    public virtual DbSet<Movimiento> Movimientos { get; set; }

    public virtual DbSet<Partida> Partidas { get; set; }

    public virtual DbSet<Usuario> Usuarios { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Catalogo>(entity =>
        {
            entity.HasKey(e => e.NumeroCuenta).HasName("PK__tmp_ms_x__5B44F5F2EE466332");

            entity.ToTable("Catalogo");

            entity.Property(e => e.NumeroCuenta)
                .ValueGeneratedNever()
                .HasColumnName("numero_Cuenta");
            entity.Property(e => e.IncluidaEn)
                .HasMaxLength(50)
                .HasColumnName("incluida_En");
            entity.Property(e => e.NombreCuenta)
                .HasMaxLength(250)
                .HasColumnName("nombre_Cuenta");
            entity.Property(e => e.TipoCuenta)
                .HasMaxLength(70)
                .HasColumnName("tipo_Cuenta");
        });

        modelBuilder.Entity<Movimiento>(entity =>
        {
            entity.HasKey(e => e.IdMovimiento).HasName("PK__tmp_ms_x__BE8A588C8586C87A");

            entity.Property(e => e.IdMovimiento).HasColumnName("id_Movimiento");
            entity.Property(e => e.IdCuenta).HasColumnName("id_Cuenta");
            entity.Property(e => e.IdPartida).HasColumnName("id_Partida");
            entity.Property(e => e.NombreCuenta)
                .HasMaxLength(250)
                .HasColumnName("nombre_Cuenta");
            entity.Property(e => e.SaldoMovimiento)
                .HasColumnType("money")
                .HasColumnName("saldo_Movimiento");
            entity.Property(e => e.TipoMovimiento)
                .HasMaxLength(5)
                .HasColumnName("tipo_Movimiento");
        });

        modelBuilder.Entity<Partida>(entity =>
        {
            entity.HasKey(e => e.NumeroPartida).HasName("PK__Partidas__1C4E7F7C99FE733A");

            entity.Property(e => e.NumeroPartida)
                .ValueGeneratedNever()
                .HasColumnName("numero_Partida");
            entity.Property(e => e.Debe)
                .HasColumnType("money")
                .HasColumnName("debe");
            entity.Property(e => e.Descripcion)
                .HasMaxLength(600)
                .HasColumnName("descripcion");
            entity.Property(e => e.Fecha).HasColumnName("fecha");
            entity.Property(e => e.Haber)
                .HasColumnType("money")
                .HasColumnName("haber");
            entity.Property(e => e.IngresadoPor).HasColumnName("ingresado_Por")
            .HasMaxLength(200);
        });

        modelBuilder.Entity<Usuario>(entity =>
        {
            entity.HasKey(e => e.IdUsuario).HasName("PK__tmp_ms_x__8E901EAAB53C102F");

            entity.HasIndex(e => e.NombreUsuario, "UQ__Usuarios__81B20F412903E74E").IsUnique();

            entity.Property(e => e.IdUsuario).HasColumnName("id_Usuario");
            entity.Property(e => e.Clave)
                .HasMaxLength(50)
                .HasColumnName("clave");
            entity.Property(e => e.Correo)
                .HasMaxLength(150)
                .HasColumnName("correo");
            entity.Property(e => e.Direccion)
                .HasMaxLength(200)
                .HasColumnName("direccion");
            entity.Property(e => e.NombreUsuario)
                .HasMaxLength(200)
                .HasColumnName("nombre_Usuario");
            entity.Property(e => e.Telefono)
                .HasMaxLength(20)
                .HasColumnName("telefono");
            entity.Property(e => e.TipoUsuario)
                .HasMaxLength(20)
                .HasColumnName("tipo_Usuario");
            entity.Property(e => e.UltInicio)
                .HasColumnType("datetime")
                .HasColumnName("ult_Inicio");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    public void UpdateUltInicio(int IdUsuario)
    {
        var sql = FormattableStringFactory.Create("UPDATE Usuarios SET [ult_Inicio] = GETUTCDATE() WHERE [id_Usuario] = {0}", IdUsuario.ToString());
        Database.ExecuteSql(sql);
    }
    public void ClearUltInicio(int IdUsuario)
    {
        var sql = FormattableStringFactory.Create("UPDATE Usuarios SET [ult_Inicio] = NULL WHERE [id_Usuario] = {0}", IdUsuario.ToString());
        Database.ExecuteSql(sql);
    }
    public void UpdateClave(int id, string clave)
    {
        var sql = FormattableStringFactory.Create("UPDATE Usuarios SET [clave] = {0} WHERE [id_Usuario] = {1}", clave, id.ToString());
        Database.ExecuteSql(sql);
    }
    public void CreatePartidaMovimientos(int IdPartida, DataTable datatable, DataTable pDatos, string user)
    {
        var sql01 = FormattableStringFactory.Create("INSERT INTO Partidas ([numero_Partida], [fecha], [descripcion], [debe], [haber], [ingresado_Por]) VALUES ({0},{1},{2},{3},{4},{5})"
            , pDatos.Rows[0]["NumeroPartida"], DateOnly.FromDateTime(Convert.ToDateTime(pDatos.Rows[0]["Fecha"].ToString())), pDatos.Rows[0]["Descripcion"], pDatos.Rows[0]["Debe"], pDatos.Rows[0]["Haber"], user);
        Database.ExecuteSql(sql01);

        for (int i = 0; i < datatable.Rows.Count; i++)
        {
            decimal saldo;
            string tipo;
            if (Convert.ToDecimal(datatable.Rows[i]["Debe"]) != 0)
            {
                saldo = Convert.ToDecimal(datatable.Rows[i]["Debe"]);
                tipo = "DEBE";
            }
            else
            {
                saldo = Convert.ToDecimal(datatable.Rows[i]["Haber"]);
                tipo = "HABER";
            }
            var sql02 = FormattableStringFactory.Create("INSERT INTO Movimientos ([id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES ({0},{1},{2},{3},{4})"
                , IdPartida, datatable.Rows[i]["IdCuenta"], datatable.Rows[i]["NombreCuenta"], saldo, tipo);
            Database.ExecuteSql(sql02);
        }
    }
    public void EditPartidaMovimientos(int IdPartida, DataTable datatable, DataTable pDatos, string user, int OGId)
    {
        var sql01 = FormattableStringFactory.Create("DELETE FROM Movimientos WHERE [id_Partida] = {0}", OGId);
        Database.ExecuteSql(sql01);

        var sql02 = FormattableStringFactory.Create("UPDATE Partidas SET [numero_Partida] = {0}, [fecha] = {1}, [descripcion] = {2}, [debe] = {3}, [haber] ={4}, [ingresado_Por] = {5} WHERE [numero_Partida] = {6}"
                    , pDatos.Rows[0]["NumeroPartida"], DateOnly.FromDateTime(Convert.ToDateTime(pDatos.Rows[0]["Fecha"].ToString())), pDatos.Rows[0]["Descripcion"], pDatos.Rows[0]["Debe"], pDatos.Rows[0]["Haber"], user, OGId);
        Database.ExecuteSql(sql02);
        for (int i = 0; i < datatable.Rows.Count; i++)
        {
            decimal saldo;
            string tipo;
            if (Convert.ToDecimal(datatable.Rows[i]["Debe"]) != 0)
            {
                saldo = Convert.ToDecimal(datatable.Rows[i]["Debe"]);
                tipo = "DEBE";
            }
            else
            {
                saldo = Convert.ToDecimal(datatable.Rows[i]["Haber"]);
                tipo = "HABER";
            }
            var sql03 = FormattableStringFactory.Create("INSERT INTO Movimientos ([id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES ({0},{1},{2},{3},{4})"
                , IdPartida, datatable.Rows[i]["IdCuenta"], datatable.Rows[i]["NombreCuenta"], saldo, tipo);
            Database.ExecuteSql(sql03);
        }

    }
    public void DeletePartidaMovimientos(int Id)
    {
        var sql01 = FormattableStringFactory.Create("DELETE FROM Partidas WHERE [numero_Partida] = {0}", Id);
        Database.ExecuteSql(sql01);

        var sql02 = FormattableStringFactory.Create("DELETE FROM Movimientos WHERE [id_Partida] = {0}", Id);
        Database.ExecuteSql(sql02);

    }
}
