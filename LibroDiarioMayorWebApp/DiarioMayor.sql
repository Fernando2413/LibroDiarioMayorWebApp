USE [master]
GO
/****** Object:  Database [DiarioMayor]    Script Date: 21/05/2025 09:29:30 p. m. ******/
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
/****** Object:  Table [dbo].[Catalogo]    Script Date: 21/05/2025 09:29:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Catalogo](
	[numero_Cuenta] [int] NOT NULL,
	[nombre_Cuenta] [nvarchar](250) NOT NULL,
	[tipo_Cuenta] [nvarchar](70) NOT NULL,
	[incluida_En] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[numero_Cuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movimientos]    Script Date: 21/05/2025 09:29:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movimientos](
	[id_Movimiento] [int] NOT NULL,
	[id_Partida] [int] NOT NULL,
	[id_Cuenta] [int] NOT NULL,
	[saldo_Movimiento] [money] NOT NULL,
	[tipo_Movimiento] [nvarchar](5) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Movimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Partidas]    Script Date: 21/05/2025 09:29:30 p. m. ******/
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
	[ingresado_Por] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[numero_Partida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 21/05/2025 09:29:30 p. m. ******/
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
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11101, N'Caja General', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11102, N'Caja Chica', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11103, N'Bancos - Banco Agricola', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11104, N'Bancos - Banco Davivienda', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11105, N'Bancos - Banco Promérica', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11106, N'Bancos - Banco de América Central', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11110, N'Inversiones Temporales', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11201, N'Cuentas por Cobrar Comerciales', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11202, N'Clientes - Personas Naturales', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11203, N'Clientes - Sociedades o Empresas', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11204, N'CR - Estimación para Cuentas Incobrables', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11205, N'Anticipo a Proveedores', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11206, N'Prestamos al Personal', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11207, N'Cuenta Personal', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11208, N'Otras Cuentas por Cobrar', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11209, N'Documentos por Cobrar', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11210, N'IVA - Credito Fiscal', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11211, N'Cuentas a Cobrar por Arrendamiento Financiero', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11301, N'Inventario - Materiales', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11302, N'Inventario - Productos en Proceso', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11303, N'Inventario - Productos Terminados', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11304, N'Inventario - Mercaderia al Costo', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11305, N'Mercaderia en Consignación', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11306, N'Pedidos en Transito', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11310, N'CR - Estimación para Obsolencia de Inventario', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11401, N'Beneficios a Empleados por Anticipados', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11402, N'Seguros en Vigencia', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11403, N'Rentas Pagadas por Anticipado', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11404, N'Papelería y Útiles', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11405, N'Otros Gastos Pagados por Anticipados', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (11501, N'Inversiones en Inmuebles', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12101, N'Bienes Inmuebles - Terrenos', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12102, N'Bienes Inmuebles - Edificaciones', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12103, N'Bienes Inmuebles - Instalaciones', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12104, N'Bienes Inmuebles - Construcciones en Proceso', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12201, N'Bienes Muebles - Mobiliario y Equipo', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12202, N'Bienes Muebles - Equipo de Transporte', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12203, N'Bienes Muebles - Maquinaria y Equipo', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12204, N'Bienes Muebles - Otros', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12301, N'CR - Depreciación Acumulada - Edificaciones e Instalaciones', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12302, N'CR - Depreciación Acumulada - Mobiliario, Maquinaria, y Equipo', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12303, N'CR - Depreciación Acumulada - Otros', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12401, N'Revaluación de Terrenos', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12402, N'Revaluación de Edificaciones', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12501, N'CR - Estimación para Cuentas Incobrables por Arrendamiento Financiero', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12601, N'Impuesto Sobre la Renta - Remanente de años anteriores', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12602, N'Impuesto Sobre la Renta - Anticipo Pago a Cuenta', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12603, N'Impuesto Sobre la Renta - Impuesto por Aplicar', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12701, N'Inversiones Permanentes - Subsidiarias', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12702, N'Inversiones Permanentes - Inversiones en Títulos Valores', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12801, N'Activos Intangibles - Licencias y Concesiones', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12802, N'Activos intangibles - Programas y Sistemas', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12803, N'Activos Intangibles - Derechos y Patentes', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (12901, N'Activos Biologicos - Plantaciones', N'ACTIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21101, N'Prestamos Bancarios', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21102, N'Sobregiros Bancarios', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21103, N'Prestamos a Corto Plazo', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21104, N'Deudas Convertibles a Corto Plazo', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21105, N'Porción Circulante - Prestamos a Largo Plazo', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21201, N'Cuentas por Pagar - Proveedores Locales', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21202, N'Cuentas por Pagar - Proveedores del Exterior', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21203, N'Cuentas por Pagar - Acreedores Varios', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21204, N'Cuentas por Pagar - Documentos por Pagar', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21205, N'Obligaciones por Arrendamiento Financiero', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21206, N'Remuneración y Prestaciones por Pagar - Salarios', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21207, N'Remuneración y Prestaciones por Pagar - Comisiones', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21208, N'Remuneración y Prestaciones por Pagar - Bonificaciones', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21209, N'Remuneración y Prestaciones por Pagar - Vacaciones', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21210, N'Remuneración y Prestaciones por Pagar - Indemnizaciones', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21211, N'Retenciones y Descuentos - Seguro Social', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21212, N'Retenciones y Descuentos - AFPs', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21213, N'Retenciones y Descuentos - Otros Descuentos', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21214, N'Retenciones y Descuentos - Otras Retenciones', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21215, N'Provisiones - Cuota Patronal ISSS Salud', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21216, N'Provisiones - Cuota Patronal AFP', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21217, N'Provisiones - Servicios de Agua', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21218, N'Provisiones - Servicio de Energia Eléctrica', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21219, N'Provisiones - Otros', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21220, N'IVA - Debito Fiscal', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21231, N'Impuestos de Renta - Impuestos por Pagar Corriente', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21232, N'Impuestos de Renta - Provisión Pago a Cuenta', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (21233, N'Impuesto de Renta - Retenido a Terceros', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (22101, N'Prestamos Bancarios por pagar a Largo Plazo', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (22102, N'Deudas Convertibles a Largo Plazo', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (22103, N'Otros Prestamos a Largo Plazo', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (22201, N'Contrato Bajo Arrendamiento Financiero', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (22301, N'Documentos por Pagar a Largo plazo', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (22401, N'Anticipos de Cliente', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (22402, N'Garantias Recibidas', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (22501, N'Otros Pasivos no Corrientes - Obligaciones Laborales', N'PASIVO', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (31101, N'Capital Social Suscritoy Pagado', N'CAPITAL', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (31102, N'Capital Social Suscrito No Pagado', N'CAPITAL', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (32101, N'Utilidades Restringidas - Reserva legal', N'CAPITAL', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (32102, N'Utilidades Restringidas - Otras Reservas', N'CAPITAL', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (33101, N'Utilidades por Distribuir - Utilidades Retenidas', N'CAPITAL', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (33102, N'Utilidades por Distribuir - Utilidades del Ejercicio', N'CAPITAL', N'Balance General')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (41101, N'Costo de Venta de Mercadería', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (41102, N'Costo de Venta de Mercadería en Consignación', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (41201, N'Costos de Producción - Materiales', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (41202, N'Costos de Producción - Mano de Obra Directa', N'CUENTA DEUDORA', N'Estado de Resultado')
GO
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (41203, N'Costos de Producción - Costos Indirectos', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (41301, N'Compras - Compras de Mercadería', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (41302, N'Compras - Gastos Sobre Compra', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (41401, N'Devoluciones Sobre Ventas', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (41402, N'Rebajas Sobre Ventas', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (41403, N'Descuentos sobre Ventas', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (42101, N'Gastos de Venta', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (42102, N'Gastos de Administración', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (43101, N'Gastos Financieros - Intereses Bancarios', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (43102, N'Gastos Financieros - Comisiones Bancarias', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (43103, N'Gastos Financieros - Diferencias en Cambio', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (43104, N'Gastos Financieros - Intereses Diversos', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (43201, N'Gastos Extraordinarios - Perdidas en Ventas de Activos Fijos', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (43202, N'Gastos Extraordinarios - Perdidas en Retiros de Activos Fijos', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (43203, N'Gastos Extraordinarios - Gastos por Siniestros', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (43204, N'Otros Gastos y Diversos', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (43205, N'Gastos no reconocidos en ejercicios anteriores', N'CUENTA DEUDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (51101, N'Ventas de Mercaderia', N'CUENTA ACREEDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (51102, N'Venta de Servicios', N'CUENTA ACREEDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (51111, N'Venta de Mercaderia en Consignación', N'CUENTA ACREEDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (51121, N'Ingresos por servicios de operación', N'CUENTA ACREEDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (51201, N'Devoluciones Sobre Compras', N'CUENTA ACREEDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (51202, N'Rebajas Sobre Compras', N'CUENTA ACREEDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (51203, N'Descuentos Sobre Compras', N'CUENTA ACREEDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (52101, N'Dividendos Ganados', N'CUENTA ACREEDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (52201, N'Ganancias en ventas de Activos Fijos', N'CUENTA ACREEDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (52202, N'Indemnizacion por Siniestros', N'CUENTA ACREEDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (52203, N'Ingresos no reconocidos en Ejercicios Anteriores', N'CUENTA ACREEDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (52204, N'Productos Financieros', N'CUENTA ACREEDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (52205, N'Otros Ingresos', N'CUENTA ACREEDORA', N'Estado de Resultado')
INSERT [dbo].[Catalogo] ([numero_Cuenta], [nombre_Cuenta], [tipo_Cuenta], [incluida_En]) VALUES (52301, N'Ingresos por Activo dado en Arrendamiento Financiero', N'CUENTA ACREEDORA', N'Estado de Resultado')
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([id_Usuario], [nombre_Usuario], [tipo_Usuario], [telefono], [direccion], [correo], [ult_Inicio], [clave]) VALUES (1, N'admin01', N'Administrador', N'TelAd01', N'Direcciónadmin01', N'admin01@correo.com', CAST(N'2025-05-22T03:24:48.720' AS DateTime), N'12345admin')
INSERT [dbo].[Usuarios] ([id_Usuario], [nombre_Usuario], [tipo_Usuario], [telefono], [direccion], [correo], [ult_Inicio], [clave]) VALUES (10, N'usuario01', N'Usuario', N'TelUs01', N'Direcciónusuario01', N'usuario01@correo.com', CAST(N'2025-05-22T03:22:45.970' AS DateTime), N'12345usuario')
INSERT [dbo].[Usuarios] ([id_Usuario], [nombre_Usuario], [tipo_Usuario], [telefono], [direccion], [correo], [ult_Inicio], [clave]) VALUES (12, N'usuario02', N'Usuario', N'TelUs02', N'Direcciónusuario02', N'usuario02@correo.com', NULL, N'2468usuario')
INSERT [dbo].[Usuarios] ([id_Usuario], [nombre_Usuario], [tipo_Usuario], [telefono], [direccion], [correo], [ult_Inicio], [clave]) VALUES (13, N'usuario03', N'Usuario', N'TelUs03', N'Direcciónusuario03', N'usuario03@correo.com', NULL, N'36912usuario')
INSERT [dbo].[Usuarios] ([id_Usuario], [nombre_Usuario], [tipo_Usuario], [telefono], [direccion], [correo], [ult_Inicio], [clave]) VALUES (14, N'usuario04', N'Usuario', N'TelUs04', N'Direcciónusuario04', N'usuario04@correo.com', NULL, N'481216usuario')
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__81B20F4128C5BAC8]    Script Date: 21/05/2025 09:29:31 p. m. ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[nombre_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__81B20F412903E74E]    Script Date: 21/05/2025 09:29:31 p. m. ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[nombre_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [DiarioMayor] SET  READ_WRITE 
GO
