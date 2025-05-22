using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using LibroDiarioMayorWebApp.Models;
using Microsoft.EntityFrameworkCore;

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
            entity.HasKey(e => e.IdMovimiento).HasName("PK__Movimien__BE8A588C26732B9C");

            entity.Property(e => e.IdMovimiento)
                .ValueGeneratedNever()
                .HasColumnName("id_Movimiento");
            entity.Property(e => e.IdCuenta).HasColumnName("id_Cuenta");
            entity.Property(e => e.IdPartida).HasColumnName("id_Partida");
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
            entity.Property(e => e.IngresadoPor).HasColumnName("ingresado_Por");
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
}
