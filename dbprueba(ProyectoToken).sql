USE [master]
GO
/****** Object:  Database [dbprueba]    Script Date: 19/01/2023 13:41:01 ******/
CREATE DATABASE [dbprueba]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbprueba', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVERDEV\MSSQL\DATA\dbprueba.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dbprueba_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVERDEV\MSSQL\DATA\dbprueba_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [dbprueba] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbprueba].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbprueba] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbprueba] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbprueba] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbprueba] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbprueba] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbprueba] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbprueba] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbprueba] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbprueba] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbprueba] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbprueba] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbprueba] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbprueba] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbprueba] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbprueba] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dbprueba] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbprueba] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbprueba] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbprueba] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbprueba] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbprueba] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbprueba] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbprueba] SET RECOVERY FULL 
GO
ALTER DATABASE [dbprueba] SET  MULTI_USER 
GO
ALTER DATABASE [dbprueba] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbprueba] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbprueba] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbprueba] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dbprueba] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dbprueba] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'dbprueba', N'ON'
GO
ALTER DATABASE [dbprueba] SET QUERY_STORE = OFF
GO
USE [dbprueba]
GO
/****** Object:  Table [dbo].[HistorialRefreshToken]    Script Date: 19/01/2023 13:41:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistorialRefreshToken](
	[IdHistorialToken] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NULL,
	[Token] [varchar](500) NULL,
	[RefreshToken] [varchar](200) NULL,
	[FechaCreacion] [datetime] NULL,
	[FechaExpiracion] [datetime] NULL,
	[EsActivo]  AS (case when [FechaExpiracion]<getdate() then CONVERT([bit],(0)) else CONVERT([bit],(1)) end),
PRIMARY KEY CLUSTERED 
(
	[IdHistorialToken] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 19/01/2023 13:41:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[NombreUsuario] [varchar](20) NULL,
	[Clave] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[HistorialRefreshToken] ON 

INSERT [dbo].[HistorialRefreshToken] ([IdHistorialToken], [idUsuario], [Token], [RefreshToken], [FechaCreacion], [FechaExpiracion]) VALUES (1, 1, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIxIiwibmJmIjoxNjc0MTQ4Njg3LCJleHAiOjE2NzQxNDg3NDcsImlhdCI6MTY3NDE0ODY4N30.vXdOnOFihjhFekG0MF1F6Yy26wgpqvbJUnq8FgtdXgc', N'eMUSAHfY2E75+kElCz3fnlI2vqcgQnf0/SLyh0sXC/qud3u57+t6bUPPv17qjAlDT9LhTWfHpmjA4i5M70bkHQ==', CAST(N'2023-01-19T17:18:07.697' AS DateTime), CAST(N'2023-01-19T17:20:07.697' AS DateTime))
INSERT [dbo].[HistorialRefreshToken] ([IdHistorialToken], [idUsuario], [Token], [RefreshToken], [FechaCreacion], [FechaExpiracion]) VALUES (2, 1, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIxIiwibmJmIjoxNjc0MTQ5MDM5LCJleHAiOjE2NzQxNDkwOTksImlhdCI6MTY3NDE0OTAzOX0.eu-_ZE_3rreixV4_HN_3GlPvOH-zRapMpXOH4WkAh0U', N'kM6qmUXgsc5fZ8Wa4uJaVewkClrngDaoy7fT4StlQtE8jKWA+0ioEuB0KlXwh/FRXJ09jhSjVkAHoR55Q1g1Cg==', CAST(N'2023-01-19T17:23:59.883' AS DateTime), CAST(N'2023-01-19T17:25:59.883' AS DateTime))
INSERT [dbo].[HistorialRefreshToken] ([IdHistorialToken], [idUsuario], [Token], [RefreshToken], [FechaCreacion], [FechaExpiracion]) VALUES (3, 1, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIxIiwibmJmIjoxNjc0MTQ5NjYwLCJleHAiOjE2NzQxNDk3MjAsImlhdCI6MTY3NDE0OTY2MH0.R1JAk9hr4eGWG0oHmk-nTr1pkxf3PU58XjRNn_qYnMg', N'56zc4E/lbYJnIzWZaBmErdeXwvSFhL+LK/Oy/Ryuj8ZaEQNF1Kfr1eB2GV1ITaUi4hDlAQUDAdp9XzNmPhcNTg==', CAST(N'2023-01-19T17:34:21.003' AS DateTime), CAST(N'2023-01-19T17:36:21.010' AS DateTime))
INSERT [dbo].[HistorialRefreshToken] ([IdHistorialToken], [idUsuario], [Token], [RefreshToken], [FechaCreacion], [FechaExpiracion]) VALUES (4, 1, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIxIiwibmJmIjoxNjc0MTQ5NzQ4LCJleHAiOjE2NzQxNDk4MDgsImlhdCI6MTY3NDE0OTc0OH0.zayuKubMlCqwikxzzIBa39mtDp4VblGsDNLhLsawMG4', N'Ml9TkWprQbGxNOq1aaJ4UhmjTtbjSr56OYKFfNAlsF91Zi3xrOx/pirrfY+LBEPAee+90XQl6UgqTwf+eltEHg==', CAST(N'2023-01-19T17:35:48.603' AS DateTime), CAST(N'2023-01-19T17:37:48.603' AS DateTime))
INSERT [dbo].[HistorialRefreshToken] ([IdHistorialToken], [idUsuario], [Token], [RefreshToken], [FechaCreacion], [FechaExpiracion]) VALUES (5, 1, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIxIiwibmJmIjoxNjc0MTQ5Nzc2LCJleHAiOjE2NzQxNDk4MzYsImlhdCI6MTY3NDE0OTc3Nn0.N9l9Ez9XIoSBsVt_u9mtX1AwuEBcK2GKmJ2_eWe1A5A', N'VnZu5NPiTHACSh4GNB+YakzUb3L8hy7uauDPSbRJAOBci2eYTCLUIQV5H8ECB6x+SOZbvJEjfE1Fsvi/+YLzkw==', CAST(N'2023-01-19T17:36:16.180' AS DateTime), CAST(N'2023-01-19T17:38:16.180' AS DateTime))
INSERT [dbo].[HistorialRefreshToken] ([IdHistorialToken], [idUsuario], [Token], [RefreshToken], [FechaCreacion], [FechaExpiracion]) VALUES (6, 1, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIxIiwibmJmIjoxNjc0MTQ5Nzg3LCJleHAiOjE2NzQxNDk4NDcsImlhdCI6MTY3NDE0OTc4N30.EU3OSpPoEwsWQo3D87Ey4Xrcb9WYJiAtUBwzjXfE-Eg', N'8ToFEdoysD1XYC0oAIxFM6r+L8bHJ3ozMf7Nt+o2IjQqBK5AJRk7LBebSI1yuo4rrxDF0DKU/VyN1bAFkL/wmA==', CAST(N'2023-01-19T17:36:27.430' AS DateTime), CAST(N'2023-01-19T17:38:27.430' AS DateTime))
INSERT [dbo].[HistorialRefreshToken] ([IdHistorialToken], [idUsuario], [Token], [RefreshToken], [FechaCreacion], [FechaExpiracion]) VALUES (7, 1, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIxIiwibmJmIjoxNjc0MTQ5ODEzLCJleHAiOjE2NzQxNDk4NzMsImlhdCI6MTY3NDE0OTgxM30.RLn8EJhtaaVixjTH7-aPIihf6N1BHSXBmr4J--pBP80', N'TFhm2W3r+UeXIS/0TY+gbHTnjzr2ZphG1NDPt7RdkmX7tzQeD4JmEQLY6lhW2v6vKLxCOxUwAsFZ2PU90w+N6w==', CAST(N'2023-01-19T17:36:53.980' AS DateTime), CAST(N'2023-01-19T17:38:53.980' AS DateTime))
INSERT [dbo].[HistorialRefreshToken] ([IdHistorialToken], [idUsuario], [Token], [RefreshToken], [FechaCreacion], [FechaExpiracion]) VALUES (8, 1, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIxIiwibmJmIjoxNjc0MTQ5ODc5LCJleHAiOjE2NzQxNDk5MzksImlhdCI6MTY3NDE0OTg3OX0.mCdITMxcjvFLgrIQlr9jIxMqeB_3cfqTcjjBetWJaSo', N'HbkuB8PXe0fFie+bTDh9ILz0ovvjr/DQLZIfu3FNpDhwGZnCTXpTKcMirONZDJpQ04cOkdHIzr3+HjAWi6iQNw==', CAST(N'2023-01-19T17:37:59.723' AS DateTime), CAST(N'2023-01-19T17:39:59.723' AS DateTime))
SET IDENTITY_INSERT [dbo].[HistorialRefreshToken] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([IdUsuario], [NombreUsuario], [Clave]) VALUES (1, N'admin', N'admin')
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
ALTER TABLE [dbo].[HistorialRefreshToken]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([IdUsuario])
GO
USE [master]
GO
ALTER DATABASE [dbprueba] SET  READ_WRITE 
GO
