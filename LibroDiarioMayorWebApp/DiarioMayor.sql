USE [master]
GO
/****** Object:  Database [DiarioMayor]    Script Date: 01/06/2025 01:58:48 p. m. ******/
CREATE DATABASE [DiarioMayor]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DiarioMayor', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\DiarioMayor.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DiarioMayor_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\DiarioMayor_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DiarioMayor] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DiarioMayor].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DiarioMayor] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DiarioMayor] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DiarioMayor] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DiarioMayor] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DiarioMayor] SET ARITHABORT OFF 
GO
ALTER DATABASE [DiarioMayor] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DiarioMayor] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DiarioMayor] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DiarioMayor] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DiarioMayor] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DiarioMayor] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DiarioMayor] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DiarioMayor] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DiarioMayor] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DiarioMayor] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DiarioMayor] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DiarioMayor] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DiarioMayor] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DiarioMayor] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DiarioMayor] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DiarioMayor] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DiarioMayor] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DiarioMayor] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DiarioMayor] SET  MULTI_USER 
GO
ALTER DATABASE [DiarioMayor] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DiarioMayor] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DiarioMayor] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DiarioMayor] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DiarioMayor] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DiarioMayor] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DiarioMayor] SET QUERY_STORE = ON
GO
ALTER DATABASE [DiarioMayor] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DiarioMayor]
GO
/****** Object:  Table [dbo].[Catalogo]    Script Date: 01/06/2025 01:58:48 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Catalogo](
	[numero_Cuenta] [int] NOT NULL,
	[nombre_Cuenta] [nvarchar](250) NOT NULL,
	[grupo_Cuenta] [nvarchar](20) NOT NULL,
	[tipo_Cuenta] [nvarchar](45) NOT NULL,
	[clasificacion_Cuenta] [nvarchar](70) NOT NULL,
	[incluida_En] [nvarchar](50) NOT NULL,
	[cr] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[numero_Cuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movimientos]    Script Date: 01/06/2025 01:58:48 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movimientos](
	[id_Movimiento] [int] IDENTITY(1,1) NOT NULL,
	[id_Partida] [int] NOT NULL,
	[id_Cuenta] [int] NOT NULL,
	[nombre_Cuenta] [nvarchar](250) NOT NULL,
	[saldo_Movimiento] [money] NOT NULL,
	[tipo_Movimiento] [nvarchar](5) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Movimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Partidas]    Script Date: 01/06/2025 01:58:48 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partidas](
	[numero_Partida] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[descripcion] [nvarchar](600) NOT NULL,
	[debe] [money] NULL,
	[haber] [money] NULL,
	[ingresado_Por] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[numero_Partida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 01/06/2025 01:58:48 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[id_Usuario] [int] IDENTITY(1,1) NOT NULL,
	[nombre_Usuario] [nvarchar](200) NOT NULL,
	[tipo_Usuario] [nvarchar](20) NOT NULL,
	[telefono] [nvarchar](20) NULL,
	[direccion] [nvarchar](200) NULL,
	[correo] [nvarchar](150) NULL,
	[ult_Inicio] [datetime] NULL,
	[clave] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11101, N'Caja General', N'ACTIVO', N'ACTIVO CORRIENTE', N'EFECTIVO Y EQUIVALENTE', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11102, N'Caja Chica', N'ACTIVO', N'ACTIVO CORRIENTE', N'EFECTIVO Y EQUIVALENTE', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11103, N'Bancos', N'ACTIVO', N'ACTIVO CORRIENTE', N'EFECTIVO Y EQUIVALENTE', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11104, N'Inversiones Temporales', N'ACTIVO', N'ACTIVO CORRIENTE', N'EFECTIVO Y EQUIVALENTE', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11201, N'Cuentas por Cobrar Comerciales', N'ACTIVO', N'ACTIVO CORRIENTE', N'CUENTAS Y DOCUMENTOS POR COBRAR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11202, N'CR - Estimación Para Cuentas Incobrables', N'ACTIVO', N'ACTIVO CORRIENTE', N'CUENTAS Y DOCUMENTOS POR COBRAR', N'Balance General', 1)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11203, N'Anticipo a Proveedores', N'ACTIVO', N'ACTIVO CORRIENTE', N'CUENTAS Y DOCUMENTOS POR COBRAR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11204, N'Préstamos al Personal', N'ACTIVO', N'ACTIVO CORRIENTE', N'CUENTAS Y DOCUMENTOS POR COBRAR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11205, N'Cuenta Personal', N'ACTIVO', N'ACTIVO CORRIENTE', N'CUENTAS Y DOCUMENTOS POR COBRAR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11206, N'Otras Cuentas por Cobrar', N'ACTIVO', N'ACTIVO CORRIENTE', N'CUENTAS Y DOCUMENTOS POR COBRAR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11207, N'Documentos por Cobrar', N'ACTIVO', N'ACTIVO CORRIENTE', N'CUENTAS Y DOCUMENTOS POR COBRAR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11208, N'IVA - Credito Fiscal', N'ACTIVO', N'ACTIVO CORRIENTE', N'CUENTAS Y DOCUMENTOS POR COBRAR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11209, N'Cuentas a Cobrar por Arrendamiento Financiero', N'ACTIVO', N'ACTIVO CORRIENTE', N'CUENTAS Y DOCUMENTOS POR COBRAR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11301, N'Inventario - Materiales', N'ACTIVO', N'ACTIVO CORRIENTE', N'INVENTARIO', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11302, N'Inventario - Productos en Proceso', N'ACTIVO', N'ACTIVO CORRIENTE', N'INVENTARIO', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11303, N'Inventario - Productos Terminados', N'ACTIVO', N'ACTIVO CORRIENTE', N'INVENTARIO', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11304, N'Inventario - Mercaderia al Costo', N'ACTIVO', N'ACTIVO CORRIENTE', N'INVENTARIO', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11305, N'Mercaderia en Consignación', N'ACTIVO', N'ACTIVO CORRIENTE', N'INVENTARIO', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11306, N'Pedidos en Transiso', N'ACTIVO', N'ACTIVO CORRIENTE', N'INVENTARIO', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11310, N'CR - Estimación para Obsolencia de Inventario', N'ACTIVO', N'ACTIVO CORRIENTE', N'INVENTARIO', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11401, N'Beneficios a Empleados por Anticipados', N'ACTIVO', N'ACTIVO CORRIENTE', N'PAGOS ANTICIPADOS', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11402, N'Seguros en Vigencia', N'ACTIVO', N'ACTIVO CORRIENTE', N'PAGOS ANTICIPADOS', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11403, N'Rentas Pagadas por Anticipado', N'ACTIVO', N'ACTIVO CORRIENTE', N'PAGOS ANTICIPADOS', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11404, N'Papelería y Útiles', N'ACTIVO', N'ACTIVO CORRIENTE', N'PAGOS ANTICIPADOS', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11405, N'Otros Gastos Pagados por Anticipados', N'ACTIVO', N'ACTIVO CORRIENTE', N'PAGOS ANTICIPADOS', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (11501, N'Inmuebles', N'ACTIVO', N'ACTIVO CORRIENTE', N'INVERSIONES EN PROPIEDAD', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (12101, N'Bienes Inmuebles', N'ACTIVO', N'ACTIVO NO CORRIENTE', N'PROPIEDAD PLANTA Y EQUIPO', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (12102, N'Bienes Muebles', N'ACTIVO', N'ACTIVO NO CORRIENTE', N'PROPIEDAD PLANTA Y EQUIPO', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (12103, N'CR - Depreciación Acumulada - Propiedad Planta y Equipo', N'ACTIVO', N'ACTIVO NO CORRIENTE', N'PROPIEDAD PLANTA Y EQUIPO', N'Balance General', 1)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (12104, N'Revaluación de Activos - Terrenos y Edificios', N'ACTIVO', N'ACTIVO NO CORRIENTE', N'PROPIEDAD PLANTA Y EQUIPO', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (12201, N'Arrendamiento Financiero por Cobrar a LP', N'ACTIVO', N'ACTIVO NO CORRIENTE', N'CPC - ARRENDAMIENTO FINANCIERO A LP', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (12202, N'CR - Estimación para Cuentas Incobrables por Arrendamiento Financiero', N'ACTIVO', N'ACTIVO NO CORRIENTE', N'CPC - ARRENDAMIENTO FINANCIERO A LP', N'Balance General', 1)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (12301, N'I.S.R. Remanente de años anteriores', N'ACTIVO', N'ACTIVO NO CORRIENTE', N'IMPUESTO SOBRE LA RENTA', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (12302, N'I.S.R. Anticipo Pago a Cuenta', N'ACTIVO', N'ACTIVO NO CORRIENTE', N'IMPUESTO SOBRE LA RENTA', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (12303, N'I.S.R. Por Aplicar', N'ACTIVO', N'ACTIVO NO CORRIENTE', N'IMPUESTO SOBRE LA RENTA', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (12401, N'Inversiones Subsidiarias', N'ACTIVO', N'ACTIVO NO CORRIENTE', N'INVERSIONES PERMANENTES', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (12402, N'Inversiones en Titulos Valores', N'ACTIVO', N'ACTIVO NO CORRIENTE', N'INVERSIONES PERMANENTES', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (12501, N'Plantaciones', N'ACTIVO', N'ACTIVO NO CORRIENTE', N'ACTIVOS BIOLOGICOS', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (12601, N'Licencias y Concesiones', N'ACTIVO', N'ACTIVO NO CORRIENTE', N'ACTIVOS INTANGIBLES', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (12602, N'Programas y Sistemas', N'ACTIVO', N'ACTIVO NO CORRIENTE', N'ACTIVOS INTANGIBLES', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (12603, N'Derechos y Patentes', N'ACTIVO', N'ACTIVO NO CORRIENTE', N'ACTIVOS INTANGIBLES', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (21101, N'Prestamos Bancarios por pagar a Corto Plazo', N'PASIVO', N'PASIVO CORRIENTE', N'PRESTAMOS Y SOBREGIROS BAMCARIOS', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (21102, N'Sobregiros Bancarios', N'PASIVO', N'PASIVO CORRIENTE', N'PRESTAMOS Y SOBREGIROS BAMCARIOS', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (21103, N'Prestamos a Corto Plazo', N'PASIVO', N'PASIVO CORRIENTE', N'PRESTAMOS Y SOBREGIROS BAMCARIOS', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (21104, N'Deudas Convertibles a Corto Plazo', N'PASIVO', N'PASIVO CORRIENTE', N'PRESTAMOS Y SOBREGIROS BAMCARIOS', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (21105, N'Porción Circulante - Prestamos a Largo Plazo', N'PASIVO', N'PASIVO CORRIENTE', N'PRESTAMOS Y SOBREGIROS BAMCARIOS', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (21201, N'Cuentas por Pagar', N'PASIVO', N'PASIVO CORRIENTE', N'CUENTAS Y DOCUMENTOS POR PAGAR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (21202, N'Obligaciones por Arrendamiento Financiero', N'PASIVO', N'PASIVO CORRIENTE', N'CUENTAS Y DOCUMENTOS POR PAGAR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (21203, N'Remuneración y Prestaciones por Pagar', N'PASIVO', N'PASIVO CORRIENTE', N'CUENTAS Y DOCUMENTOS POR PAGAR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (21204, N'Retenciones y Descuentos', N'PASIVO', N'PASIVO CORRIENTE', N'CUENTAS Y DOCUMENTOS POR PAGAR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (21205, N'Provisiones', N'PASIVO', N'PASIVO CORRIENTE', N'CUENTAS Y DOCUMENTOS POR PAGAR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (21206, N'IVA - Debito Fiscal', N'PASIVO', N'PASIVO CORRIENTE', N'CUENTAS Y DOCUMENTOS POR PAGAR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (21207, N'Impuestos de Renta', N'PASIVO', N'PASIVO CORRIENTE', N'CUENTAS Y DOCUMENTOS POR PAGAR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (22101, N'Prestamos Bancarios por pagar a Largo Plazo', N'PASIVO', N'PASIVO NO CORRIENTE', N'PRESTAMOS POR PAGAR A LP', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (22102, N'Deudas Convertibles a Largo Plazo', N'PASIVO', N'PASIVO NO CORRIENTE', N'PRESTAMOS POR PAGAR A LP', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (22103, N'Otros Prestamos a Largo Plazo', N'PASIVO', N'PASIVO NO CORRIENTE', N'PRESTAMOS POR PAGAR A LP', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (22201, N'Contrato Bajo Arrendamiento Financiero a LP', N'PASIVO', N'PASIVO NO CORRIENTE', N'OBLIGACIONES POR ARRENDAMIENTO FINANCIERO', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (22301, N'Documentos por Pagar a LP', N'PASIVO', N'PASIVO NO CORRIENTE', N'DOCUMENTOS POR PAGAR A LP', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (22401, N'Anticipos de Cliente', N'PASIVO', N'PASIVO NO CORRIENTE', N'ANTICIPO Y GARANTIA DE CLIENTE', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (22402, N'Garantias Recibidas', N'PASIVO', N'PASIVO NO CORRIENTE', N'ANTICIPO Y GARANTIA DE CLIENTE', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (22501, N'Obligaciones Laborales', N'PASIVO', N'PASIVO NO CORRIENTE', N'OTROS PASIVOS NO CORRIENTES', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (31101, N'Capital Social Suscrito y Pagado', N'CAPITAL', N'CAPITAL SOCIAL', N'CAPITAL SOCIAL SUSCRITO', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (31102, N'Capital Social Suscrito No Pagado', N'CAPITAL', N'CAPITAL SOCIAL', N'CAPITAL SOCIAL SUSCRITO', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (32101, N'Reserva Legal', N'CAPITAL', N'RESERVAS', N'UTILIDADES RESTRINGIDAS', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (32102, N'Otras Reservas', N'CAPITAL', N'RESERVAS', N'UTILIDADES RESTRINGIDAS', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (33101, N'Utilidades Retenidas', N'CAPITAL', N'UTILIDADES', N'UTILIDADES POR DISTRIBUIR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (33102, N'Utilidad del Ejercicio', N'CAPITAL', N'UTILIDADES', N'UTILIDADES POR DISTRIBUIR', N'Balance General', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (41101, N'Costo de Venta de Mercaderia', N'CUENTA DEUDORA', N'COSTOS DE VENTA Y DE PRODUCCION', N'COSTO DE VENTA DE BIENES', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (41102, N'Costo de Venta de Mercadería en Consignación', N'CUENTA DEUDORA', N'COSTOS DE VENTA Y DE PRODUCCION', N'COSTO DE VENTA DE BIENES', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (41201, N'Materiales', N'CUENTA DEUDORA', N'COSTOS DE VENTA Y DE PRODUCCION', N'COSTOS DE PRODUCCION', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (41202, N'Mano de Obra Directa', N'CUENTA DEUDORA', N'COSTOS DE VENTA Y DE PRODUCCION', N'COSTOS DE PRODUCCION', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (41203, N'Costos Indirectos', N'CUENTA DEUDORA', N'COSTOS DE VENTA Y DE PRODUCCION', N'COSTOS DE PRODUCCION', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (41301, N'Compras de Mercadería', N'CUENTA DEUDORA', N'COSTOS DE VENTA Y DE PRODUCCION', N'COMPRAS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (41302, N'Gastos Sobre Compra', N'CUENTA DEUDORA', N'COSTOS DE VENTA Y DE PRODUCCION', N'COMPRAS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (41401, N'Devoluciones Sobre Ventas', N'CUENTA DEUDORA', N'COSTOS DE VENTA Y DE PRODUCCION', N'DEVOLUCIONES Y REBAJAS SOBRE VENTAS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (41402, N'Rebajas Sobre Ventas', N'CUENTA DEUDORA', N'COSTOS DE VENTA Y DE PRODUCCION', N'DEVOLUCIONES Y REBAJAS SOBRE VENTAS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (41403, N'Descuentos Sobre Ventas', N'CUENTA DEUDORA', N'COSTOS DE VENTA Y DE PRODUCCION', N'DEVOLUCIONES Y REBAJAS SOBRE VENTAS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (42101, N'Gastos de Venta', N'CUENTA DEUDORA', N'GASTOS DE OPERACION ORDINARIAS', N'GASTOS DE OPERACION', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (42102, N'Gastos de Administración', N'CUENTA DEUDORA', N'GASTOS DE OPERACION ORDINARIAS', N'GASTOS DE OPERACION', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (43101, N'Interes Bancarios', N'CUENTA DEUDORA', N'GASTOS DE NO OPERACION', N'GASTOS FINANCIEROS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (43102, N'Comisiones Bancarias', N'CUENTA DEUDORA', N'GASTOS DE NO OPERACION', N'GASTOS FINANCIEROS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (43103, N'Diferencias en Cambio', N'CUENTA DEUDORA', N'GASTOS DE NO OPERACION', N'GASTOS FINANCIEROS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (43104, N'Intereses Diversos', N'CUENTA DEUDORA', N'GASTOS DE NO OPERACION', N'GASTOS FINANCIEROS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (43201, N'Perdidas en Ventas de Activos Fijos', N'CUENTA DEUDORA', N'GASTOS DE NO OPERACION', N'GASTOS EXTRAORDINARIOS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (43202, N'Perdidas en Retiro de Activos Fijos', N'CUENTA DEUDORA', N'GASTOS DE NO OPERACION', N'GASTOS EXTRAORDINARIOS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (43203, N'Gastos por Siniestros', N'CUENTA DEUDORA', N'GASTOS DE NO OPERACION', N'GASTOS EXTRAORDINARIOS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (43204, N'Otros Gastos y Diversos', N'CUENTA DEUDORA', N'GASTOS DE NO OPERACION', N'GASTOS EXTRAORDINARIOS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (43205, N'Gastos no reconocidos en ejercicios anteriores', N'CUENTA DEUDORA', N'GASTOS DE NO OPERACION', N'GASTOS EXTRAORDINARIOS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (51101, N'Venta de Mercaderia', N'CUENTA ACREEDORA', N'INGRESOS DE OPERACIONES ORDINARIAS', N'VENTAS DE BIENES Y SERVICIOS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (51102, N'Venta de Servicios', N'CUENTA ACREEDORA', N'INGRESOS DE OPERACIONES ORDINARIAS', N'VENTAS DE BIENES Y SERVICIOS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (51103, N'Venta de Mercaderia en Consignación', N'CUENTA ACREEDORA', N'INGRESOS DE OPERACIONES ORDINARIAS', N'VENTAS DE BIENES Y SERVICIOS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (51104, N'Ingresos por Servicios de Operación', N'CUENTA ACREEDORA', N'INGRESOS DE OPERACIONES ORDINARIAS', N'VENTAS DE BIENES Y SERVICIOS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (51201, N'Devoluciones Sobre Compras', N'CUENTA ACREEDORA', N'INGRESOS DE OPERACIONES ORDINARIAS', N'DEVOLUCIONES Y REBAJAS SOBRE COMPRAS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (51202, N'Rebajas Sobre Compras', N'CUENTA ACREEDORA', N'INGRESOS DE OPERACIONES ORDINARIAS', N'DEVOLUCIONES Y REBAJAS SOBRE COMPRAS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (51203, N'Descuentos Sobre Compras', N'CUENTA ACREEDORA', N'INGRESOS DE OPERACIONES ORDINARIAS', N'DEVOLUCIONES Y REBAJAS SOBRE COMPRAS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (52101, N'Dividendos Ganados', N'CUENTA ACREEDORA', N'INGRESOS NO OPERACIONALES', N'INGRESOS DE NO OPERACION', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (52201, N'Ganancias en ventas de Activos Fijos', N'CUENTA ACREEDORA', N'INGRESOS NO OPERACIONALES', N'INGRESOS EXTRAORDINARIOS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (52202, N'Indemnizacion por Siniestros', N'CUENTA ACREEDORA', N'INGRESOS NO OPERACIONALES', N'INGRESOS EXTRAORDINARIOS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (52203, N'Ingresos no reconocidos en Ejercicios Anteriores', N'CUENTA ACREEDORA', N'INGRESOS NO OPERACIONALES', N'INGRESOS EXTRAORDINARIOS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (52204, N'Productos Financieros', N'CUENTA ACREEDORA', N'INGRESOS NO OPERACIONALES', N'INGRESOS EXTRAORDINARIOS', N'Estado de Resultado', 0)
GO
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (52205, N'Otros Ingresos', N'CUENTA ACREEDORA', N'INGRESOS NO OPERACIONALES', N'INGRESOS EXTRAORDINARIOS', N'Estado de Resultado', 0)
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [grupo_Cuenta], [tipo_Cuenta], [clasificacion_Cuenta], [incluida_En], [cr]) VALUES (52301, N'Ingresos por Activo dado en Arrendamiento Financiero', N'CUENTA ACREEDORA', N'INGRESOS NO OPERACIONALES', N'OTROS INGRESOS DE NO OPERACION', N'Estado de Resultado', 0)
GO
SET IDENTITY_INSERT [dbo].[Movimientos] ON 

INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (3, 1, 11304, N'Inventario - Mercaderia al Costo', 10000.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (4, 1, 31101, N'Capital Social Suscrito y Pagado', 10000.0000, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (5, 2, 41301, N'Compras de Mercadería', 5000.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (6, 2, 11208, N'IVA - Credito Fiscal', 650.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (7, 2, 21201, N'Cuentas por Pagar', 5650.0000, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (8, 3, 41302, N'Gastos Sobre Compra', 100.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (9, 3, 11208, N'IVA - Credito Fiscal', 13.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (10, 3, 11101, N'Caja General', 113.0000, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (11, 4, 21201, N'Cuentas por Pagar', 1130.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (12, 4, 51201, N'Devoluciones Sobre Compras', 1000.0000, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (13, 4, 11208, N'IVA - Credito Fiscal', 130.0000, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (14, 5, 41301, N'Compras de Mercadería', 3000.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (15, 5, 11208, N'IVA - Credito Fiscal', 390.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (16, 5, 11101, N'Caja General', 3390.0000, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (17, 6, 11101, N'Caja General', 56.5000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (18, 6, 51202, N'Rebajas Sobre Compras', 50.0000, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (19, 6, 11208, N'IVA - Credito Fiscal', 6.5000, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (20, 7, 11101, N'Caja General', 11.3000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (21, 7, 51203, N'Descuentos Sobre Compras', 10.0000, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (22, 7, 11208, N'IVA - Credito Fiscal', 1.3000, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (23, 8, 11201, N'Cuentas por Cobrar Comerciales', 10735.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (24, 8, 21206, N'IVA - Debito Fiscal', 1235.0000, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (25, 8, 51101, N'Venta de Mercaderia', 9500.0000, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (26, 9, 41401, N'Devoluciones Sobre Ventas', 500.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (27, 9, 21206, N'IVA - Debito Fiscal', 65.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (28, 9, 11201, N'Cuentas por Cobrar Comerciales', 565.0000, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (29, 10, 11101, N'Caja General', 11865.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (30, 10, 51101, N'Venta de Mercaderia', 10500.0000, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (31, 10, 21206, N'IVA - Debito Fiscal', 1365.0000, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (32, 11, 41402, N'Rebajas Sobre Ventas', 60.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (33, 11, 21206, N'IVA - Debito Fiscal', 7.8000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (34, 11, 11101, N'Caja General', 67.8000, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (35, 12, 41403, N'Descuentos Sobre Ventas', 12.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (36, 12, 21206, N'IVA - Debito Fiscal', 1.5600, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (37, 12, 11101, N'Caja General', 13.5600, N'HABER')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (38, 13, 42101, N'Gastos de Venta', 2300.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (39, 13, 42102, N'Gastos de Administración', 1500.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (40, 13, 43101, N'Interes Bancarios', 250.0000, N'DEBE')
INSERT [dbo].[Movimientos] ([id_Movimiento], [id_Partida], [id_Cuenta], [nombre_Cuenta], [saldo_Movimiento], [tipo_Movimiento]) VALUES (41, 13, 11101, N'Caja General', 4050.0000, N'HABER')
SET IDENTITY_INSERT [dbo].[Movimientos] OFF
GO
INSERT [dbo].[Partidas] ([numero_Partida], [fecha], [descripcion], [debe], [haber], [ingresado_Por]) VALUES (1, CAST(N'2023-05-01' AS Date), N'Para el Registro de apertura de la contabilidad', 10000.0000, 10000.0000, N'admin01')
INSERT [dbo].[Partidas] ([numero_Partida], [fecha], [descripcion], [debe], [haber], [ingresado_Por]) VALUES (2, CAST(N'2023-05-05' AS Date), N'Para registrar la compra de mercaderia al Credito, 200 Unidades', 5650.0000, 5650.0000, N'usuario01')
INSERT [dbo].[Partidas] ([numero_Partida], [fecha], [descripcion], [debe], [haber], [ingresado_Por]) VALUES (3, CAST(N'2023-05-05' AS Date), N'Para registrar gastos de compra en efectivo a TRANSPORTE VELOZ', 113.0000, 113.0000, N'usuario01')
INSERT [dbo].[Partidas] ([numero_Partida], [fecha], [descripcion], [debe], [haber], [ingresado_Por]) VALUES (4, CAST(N'2023-05-10' AS Date), N'Para registrar la devolución de 40 unidades', 1130.0000, 1130.0000, N'usuario01')
INSERT [dbo].[Partidas] ([numero_Partida], [fecha], [descripcion], [debe], [haber], [ingresado_Por]) VALUES (5, CAST(N'2023-05-15' AS Date), N'Para registrar compra de mercaderia al contado de 150 unidades"CC" a un precio unitario de $22.60', 3390.0000, 3390.0000, N'usuario02')
INSERT [dbo].[Partidas] ([numero_Partida], [fecha], [descripcion], [debe], [haber], [ingresado_Por]) VALUES (6, CAST(N'2023-05-15' AS Date), N'Para registrar la rebaja de la compra de 150 unidades "CC"', 56.5000, 56.5000, N'usuario02')
INSERT [dbo].[Partidas] ([numero_Partida], [fecha], [descripcion], [debe], [haber], [ingresado_Por]) VALUES (7, CAST(N'2023-05-15' AS Date), N'Para registrar el descuento de la compra de 150 unidades "CC"', 11.3000, 11.3000, N'usuario02')
INSERT [dbo].[Partidas] ([numero_Partida], [fecha], [descripcion], [debe], [haber], [ingresado_Por]) VALUES (8, CAST(N'2023-05-16' AS Date), N'Por la venta de mercaderia a "Comercial Verapaz"', 10735.0000, 10735.0000, N'usuario03')
INSERT [dbo].[Partidas] ([numero_Partida], [fecha], [descripcion], [debe], [haber], [ingresado_Por]) VALUES (9, CAST(N'2023-05-22' AS Date), N'Para registrar la devolución que nos hace "Comercial Verapaz"', 565.0000, 565.0000, N'usuario03')
INSERT [dbo].[Partidas] ([numero_Partida], [fecha], [descripcion], [debe], [haber], [ingresado_Por]) VALUES (10, CAST(N'2023-05-23' AS Date), N'Para registrar la venta de mercaderia al contado', 11865.0000, 11865.0000, N'usuario04')
INSERT [dbo].[Partidas] ([numero_Partida], [fecha], [descripcion], [debe], [haber], [ingresado_Por]) VALUES (11, CAST(N'2023-05-23' AS Date), N'Para registrar una rebaja sobre la venta de mercaderia al contado', 67.8000, 67.8000, N'usuario04')
INSERT [dbo].[Partidas] ([numero_Partida], [fecha], [descripcion], [debe], [haber], [ingresado_Por]) VALUES (12, CAST(N'2023-05-23' AS Date), N'Para registrar un descuento sobre la venta de mercaderia al contado', 13.5600, 13.5600, N'usuario04')
INSERT [dbo].[Partidas] ([numero_Partida], [fecha], [descripcion], [debe], [haber], [ingresado_Por]) VALUES (13, CAST(N'2023-05-31' AS Date), N'Para registrar los gastos de operación y los gastos de NO operación', 4050.0000, 4050.0000, N'usuario05')
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([id_Usuario], [nombre_Usuario], [tipo_Usuario], [telefono], [direccion], [correo], [ult_Inicio], [clave]) VALUES (1, N'admin01', N'Administrador', N'TelAd01', N'Direcciónadmin01', N'admin01@correo.com', CAST(N'2025-06-01T05:00:09.103' AS DateTime), N'12345admin')
INSERT [dbo].[Usuarios] ([id_Usuario], [nombre_Usuario], [tipo_Usuario], [telefono], [direccion], [correo], [ult_Inicio], [clave]) VALUES (10, N'usuario01', N'Usuario', N'TelUs01', N'Direcciónusuario01', N'usuario01@correo.com', CAST(N'2025-05-30T04:29:33.237' AS DateTime), N'12345usuario')
INSERT [dbo].[Usuarios] ([id_Usuario], [nombre_Usuario], [tipo_Usuario], [telefono], [direccion], [correo], [ult_Inicio], [clave]) VALUES (12, N'usuario02', N'Usuario', N'TelUs02', N'Direcciónusuario02', N'usuario02@correo.com', CAST(N'2025-05-30T04:37:18.340' AS DateTime), N'2468usuario')
INSERT [dbo].[Usuarios] ([id_Usuario], [nombre_Usuario], [tipo_Usuario], [telefono], [direccion], [correo], [ult_Inicio], [clave]) VALUES (13, N'usuario03', N'Usuario', N'TelUs03', N'Direcciónusuario03', N'usuario03@correo.com', CAST(N'2025-05-30T04:42:59.423' AS DateTime), N'36912usuario')
INSERT [dbo].[Usuarios] ([id_Usuario], [nombre_Usuario], [tipo_Usuario], [telefono], [direccion], [correo], [ult_Inicio], [clave]) VALUES (14, N'usuario04', N'Usuario', N'TelUs04', N'Direcciónusuario04', N'usuario04@correo.com', CAST(N'2025-05-30T04:47:19.753' AS DateTime), N'481216usuario')
INSERT [dbo].[Usuarios] ([id_Usuario], [nombre_Usuario], [tipo_Usuario], [telefono], [direccion], [correo], [ult_Inicio], [clave]) VALUES (16, N'usuario05', N'Usuario', N'TelUs05', N'Direcciónusuario05', N'usuario05@correo.com', CAST(N'2025-05-30T04:53:30.977' AS DateTime), N'51015usuario')
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__81B20F41E2B1EC05]    Script Date: 01/06/2025 01:58:48 p. m. ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[nombre_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__81B20F41EF51668D]    Script Date: 01/06/2025 01:58:48 p. m. ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[nombre_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Catalogo] ADD  DEFAULT ((0)) FOR [cr]
GO
USE [master]
GO
ALTER DATABASE [DiarioMayor] SET  READ_WRITE 
GO
