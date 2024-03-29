/****** Object:  Database [filmBD]    Script Date: 30.01.2024 22:38:07 ******/
CREATE DATABASE [filmBD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'filmBD', FILENAME = N'C:\Users\Ангелина\filmBD.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'filmBD_log', FILENAME = N'C:\Users\Ангелина\filmBD_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [filmBD] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [filmBD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [filmBD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [filmBD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [filmBD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [filmBD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [filmBD] SET ARITHABORT OFF 
GO
ALTER DATABASE [filmBD] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [filmBD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [filmBD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [filmBD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [filmBD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [filmBD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [filmBD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [filmBD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [filmBD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [filmBD] SET  DISABLE_BROKER 
GO
ALTER DATABASE [filmBD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [filmBD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [filmBD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [filmBD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [filmBD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [filmBD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [filmBD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [filmBD] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [filmBD] SET  MULTI_USER 
GO
ALTER DATABASE [filmBD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [filmBD] SET DB_CHAINING OFF 
GO
ALTER DATABASE [filmBD] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [filmBD] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [filmBD] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [filmBD] SET QUERY_STORE = OFF
GO
/****** Object:  Table [dbo].[hall_row]    Script Date: 30.01.2024 22:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hall_row](
	[id_hall] [int] NOT NULL,
	[number] [smallint] NOT NULL,
	[capacity] [smallint] NOT NULL,
 CONSTRAINT [PK_hall_row] PRIMARY KEY CLUSTERED 
(
	[id_hall] ASC,
	[number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hall]    Script Date: 30.01.2024 22:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hall](
	[id] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_hall] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CapacityHall]    Script Date: 30.01.2024 22:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CapacityHall]
AS
SELECT TOP (100) PERCENT dbo.hall_row.capacity, dbo.hall.name
FROM   dbo.hall INNER JOIN
             dbo.hall_row ON dbo.hall.id = dbo.hall_row.id_hall
WHERE (dbo.hall_row.id_hall = 3) AND (dbo.hall_row.number = 2)
ORDER BY dbo.hall_row.capacity
GO
/****** Object:  Table [dbo].[screening]    Script Date: 30.01.2024 22:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[screening](
	[id] [int] NOT NULL,
	[hall_id] [int] NOT NULL,
	[film_id] [int] NOT NULL,
	[time] [datetime] NOT NULL,
 CONSTRAINT [PK_screening] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[film]    Script Date: 30.01.2024 22:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film](
	[id] [int] NOT NULL,
	[name_f] [nvarchar](255) NOT NULL,
	[decription] [nvarchar](2000) NOT NULL,
 CONSTRAINT [PK_film] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ScreeningTime]    Script Date: 30.01.2024 22:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ScreeningTime]
AS
SELECT dbo.film.name_f, dbo.screening.time
FROM   dbo.film INNER JOIN
             dbo.screening ON dbo.film.id = dbo.screening.film_id
WHERE (dbo.screening.time > CONVERT(DATETIME, '2021-01-01 11:00:00', 102))
GO
/****** Object:  View [dbo].[HallTime]    Script Date: 30.01.2024 22:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[HallTime]
AS
SELECT dbo.hall_row.number, dbo.hall.name, dbo.screening.time
FROM   dbo.hall_row INNER JOIN
             dbo.hall ON dbo.hall_row.id_hall = dbo.hall.id INNER JOIN
             dbo.screening ON dbo.hall.id = dbo.screening.hall_id
WHERE (dbo.hall_row.number = 1)
GO
/****** Object:  View [dbo].[FilmScreening]    Script Date: 30.01.2024 22:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FilmScreening]
AS
SELECT dbo.screening.film_id, dbo.film.name_f, dbo.screening.time
FROM   dbo.screening INNER JOIN
             dbo.film ON dbo.screening.film_id = dbo.film.id
WHERE (dbo.screening.film_id = 2)
GO
/****** Object:  Table [dbo].[tickets]    Script Date: 30.01.2024 22:38:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tickets](
	[id_screening] [int] NOT NULL,
	[row] [smallint] NOT NULL,
	[seat] [smallint] NOT NULL,
	[cost] [int] NOT NULL,
 CONSTRAINT [PK_tickets] PRIMARY KEY CLUSTERED 
(
	[id_screening] ASC,
	[row] ASC,
	[seat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[film] ([id], [name_f], [decription]) VALUES (1, N'Багратион', N'"Багратион" - советский двухсерийный историко-биографический фильм 1985 года о жизни прославленного российского полководца Петра Ивановича Багратиона - героя Отечественной войны 1812 года. Совместное производство "Грузия-фильм". Режиссеры Гиули Чохолидзе и Караман Мгеладзе. Премьера - декабрь 1985 года.')
INSERT [dbo].[film] ([id], [name_f], [decription]) VALUES (2, N'Форсаж', N'Его зовут Брайан, и он — фанат турбин и нитроускорителей. Он пытается попасть в автобанду легендарного Доминика Торетто, чемпиона опасных и незаконных уличных гонок. Брайан также полицейский, и его задание — втереться в доверие к Торетто, подозреваемому в причастности к дерзким грабежам грузовиков, совершаемым прямо на ходу.')
INSERT [dbo].[film] ([id], [name_f], [decription]) VALUES (3, N'Такси', N'Таксист Даниэль помешан на быстрой езде. Как ураган проносится он по извилистым улицам Марселя на мощном ревущем «Пежо», пугая прохожих и приводя в ужас пассажиров. Начинающий следователь Эмильен вынуждает его помогать в поимке банды грабителей банков, каждый раз ускользающих от полиции на неуловимых «Мерседесах».')
GO
INSERT [dbo].[hall] ([id], [name]) VALUES (1, N'Красный зал')
INSERT [dbo].[hall] ([id], [name]) VALUES (2, N'Желтый зал')
INSERT [dbo].[hall] ([id], [name]) VALUES (3, N'Синий зал')
INSERT [dbo].[hall] ([id], [name]) VALUES (4, N'Фиолетовый зал')
INSERT [dbo].[hall] ([id], [name]) VALUES (5, N'Розовый зал')
GO
INSERT [dbo].[hall_row] ([id_hall], [number], [capacity]) VALUES (1, 1, 10)
INSERT [dbo].[hall_row] ([id_hall], [number], [capacity]) VALUES (1, 2, 15)
INSERT [dbo].[hall_row] ([id_hall], [number], [capacity]) VALUES (1, 3, 20)
INSERT [dbo].[hall_row] ([id_hall], [number], [capacity]) VALUES (3, 2, 20)
INSERT [dbo].[hall_row] ([id_hall], [number], [capacity]) VALUES (4, 4, 15)
GO
INSERT [dbo].[screening] ([id], [hall_id], [film_id], [time]) VALUES (1, 1, 1, CAST(N'2021-01-01T10:35:00.000' AS DateTime))
INSERT [dbo].[screening] ([id], [hall_id], [film_id], [time]) VALUES (2, 1, 2, CAST(N'2021-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[screening] ([id], [hall_id], [film_id], [time]) VALUES (3, 1, 2, CAST(N'2021-01-01T13:35:00.000' AS DateTime))
INSERT [dbo].[screening] ([id], [hall_id], [film_id], [time]) VALUES (4, 3, 2, CAST(N'2021-01-01T13:00:00.000' AS DateTime))
INSERT [dbo].[screening] ([id], [hall_id], [film_id], [time]) VALUES (5, 2, 3, CAST(N'2021-01-01T15:50:00.000' AS DateTime))
GO
INSERT [dbo].[tickets] ([id_screening], [row], [seat], [cost]) VALUES (1, 2, 3, 150)
INSERT [dbo].[tickets] ([id_screening], [row], [seat], [cost]) VALUES (1, 2, 4, 250)
INSERT [dbo].[tickets] ([id_screening], [row], [seat], [cost]) VALUES (1, 3, 3, 200)
INSERT [dbo].[tickets] ([id_screening], [row], [seat], [cost]) VALUES (1, 3, 5, 150)
INSERT [dbo].[tickets] ([id_screening], [row], [seat], [cost]) VALUES (5, 5, 3, 200)
GO
ALTER TABLE [dbo].[hall_row]  WITH CHECK ADD  CONSTRAINT [FK_hall_row_hall] FOREIGN KEY([id_hall])
REFERENCES [dbo].[hall] ([id])
GO
ALTER TABLE [dbo].[hall_row] CHECK CONSTRAINT [FK_hall_row_hall]
GO
ALTER TABLE [dbo].[screening]  WITH CHECK ADD  CONSTRAINT [FK_screening_film] FOREIGN KEY([film_id])
REFERENCES [dbo].[film] ([id])
GO
ALTER TABLE [dbo].[screening] CHECK CONSTRAINT [FK_screening_film]
GO
ALTER TABLE [dbo].[screening]  WITH CHECK ADD  CONSTRAINT [FK_screening_hall] FOREIGN KEY([hall_id])
REFERENCES [dbo].[hall] ([id])
GO
ALTER TABLE [dbo].[screening] CHECK CONSTRAINT [FK_screening_hall]
GO
ALTER TABLE [dbo].[tickets]  WITH CHECK ADD  CONSTRAINT [FK_tickets_screening] FOREIGN KEY([id_screening])
REFERENCES [dbo].[screening] ([id])
GO
ALTER TABLE [dbo].[tickets] CHECK CONSTRAINT [FK_tickets_screening]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "hall"
            Begin Extent = 
               Top = 151
               Left = 53
               Bottom = 294
               Right = 275
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "hall_row"
            Begin Extent = 
               Top = 71
               Left = 393
               Bottom = 310
               Right = 629
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CapacityHall'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CapacityHall'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "screening"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "film"
            Begin Extent = 
               Top = 9
               Left = 336
               Bottom = 179
               Right = 558
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'FilmScreening'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'FilmScreening'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "hall_row"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 179
               Right = 279
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "screening"
            Begin Extent = 
               Top = 9
               Left = 336
               Bottom = 271
               Right = 534
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "hall"
            Begin Extent = 
               Top = 9
               Left = 615
               Bottom = 152
               Right = 837
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'HallTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'HallTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "film"
            Begin Extent = 
               Top = 175
               Left = 94
               Bottom = 345
               Right = 316
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "screening"
            Begin Extent = 
               Top = 64
               Left = 518
               Bottom = 261
               Right = 740
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ScreeningTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ScreeningTime'
GO
ALTER DATABASE [filmBD] SET  READ_WRITE 
GO
