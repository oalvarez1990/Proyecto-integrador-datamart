USE [master]
GO
/****** Object:  Database [datamar_jardineria]    Script Date: 26/05/2024 23:10:08 ******/
CREATE DATABASE [datamar_jardineria]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'datamar_jardineria', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\datamar_jardineria.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'datamar_jardineria_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\datamar_jardineria_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [datamar_jardineria] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [datamar_jardineria].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [datamar_jardineria] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [datamar_jardineria] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [datamar_jardineria] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [datamar_jardineria] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [datamar_jardineria] SET ARITHABORT OFF 
GO
ALTER DATABASE [datamar_jardineria] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [datamar_jardineria] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [datamar_jardineria] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [datamar_jardineria] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [datamar_jardineria] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [datamar_jardineria] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [datamar_jardineria] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [datamar_jardineria] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [datamar_jardineria] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [datamar_jardineria] SET  DISABLE_BROKER 
GO
ALTER DATABASE [datamar_jardineria] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [datamar_jardineria] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [datamar_jardineria] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [datamar_jardineria] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [datamar_jardineria] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [datamar_jardineria] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [datamar_jardineria] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [datamar_jardineria] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [datamar_jardineria] SET  MULTI_USER 
GO
ALTER DATABASE [datamar_jardineria] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [datamar_jardineria] SET DB_CHAINING OFF 
GO
ALTER DATABASE [datamar_jardineria] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [datamar_jardineria] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [datamar_jardineria] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [datamar_jardineria] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [datamar_jardineria] SET QUERY_STORE = OFF
GO
USE [datamar_jardineria]
GO
/****** Object:  Table [dbo].[DIMcliente]    Script Date: 26/05/2024 23:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIMcliente](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[ciudad] [varchar](50) NOT NULL,
	[pais] [varchar](50) NOT NULL,
 CONSTRAINT [PK_DIMcliente] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DIMempleado]    Script Date: 26/05/2024 23:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIMempleado](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[apellido] [varchar](50) NOT NULL,
 CONSTRAINT [PK_DIMempleado] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DIMproducto]    Script Date: 26/05/2024 23:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIMproducto](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[categoria] [varchar](50) NOT NULL,
 CONSTRAINT [PK_DIMproducto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DIMtiempo]    Script Date: 26/05/2024 23:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIMtiempo](
	[id] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[anio] [int] NOT NULL,
	[trimestre] [int] NOT NULL,
	[mes] [varchar](20) NOT NULL,
	[dia] [int] NOT NULL,
 CONSTRAINT [PK_DIMtiempo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_hecho_ventas]    Script Date: 26/05/2024 23:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_hecho_ventas](
	[ID_cliente] [int] NOT NULL,
	[ID_tiempo] [int] NOT NULL,
	[ID_producto] [int] NOT NULL,
	[ID_empleado] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[precio] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_hecho_ventas]  WITH CHECK ADD  CONSTRAINT [FK_TBL_hecho_ventas_DIMcliente] FOREIGN KEY([ID_cliente])
REFERENCES [dbo].[DIMcliente] ([id])
GO
ALTER TABLE [dbo].[TBL_hecho_ventas] CHECK CONSTRAINT [FK_TBL_hecho_ventas_DIMcliente]
GO
ALTER TABLE [dbo].[TBL_hecho_ventas]  WITH CHECK ADD  CONSTRAINT [FK_TBL_hecho_ventas_DIMempleado] FOREIGN KEY([ID_empleado])
REFERENCES [dbo].[DIMempleado] ([id])
GO
ALTER TABLE [dbo].[TBL_hecho_ventas] CHECK CONSTRAINT [FK_TBL_hecho_ventas_DIMempleado]
GO
ALTER TABLE [dbo].[TBL_hecho_ventas]  WITH CHECK ADD  CONSTRAINT [FK_TBL_hecho_ventas_DIMproducto] FOREIGN KEY([ID_producto])
REFERENCES [dbo].[DIMproducto] ([id])
GO
ALTER TABLE [dbo].[TBL_hecho_ventas] CHECK CONSTRAINT [FK_TBL_hecho_ventas_DIMproducto]
GO
ALTER TABLE [dbo].[TBL_hecho_ventas]  WITH CHECK ADD  CONSTRAINT [FK_TBL_hecho_ventas_DIMtiempo] FOREIGN KEY([ID_tiempo])
REFERENCES [dbo].[DIMtiempo] ([id])
GO
ALTER TABLE [dbo].[TBL_hecho_ventas] CHECK CONSTRAINT [FK_TBL_hecho_ventas_DIMtiempo]
GO
USE [master]
GO
ALTER DATABASE [datamar_jardineria] SET  READ_WRITE 
GO
