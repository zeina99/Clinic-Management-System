USE [master]
GO
/****** Object:  Database [Clinic]    Script Date: 3/21/2021 6:01:42 PM ******/
CREATE DATABASE [Clinic]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Clinic', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Clinic.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Clinic_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Clinic_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Clinic] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Clinic].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Clinic] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Clinic] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Clinic] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Clinic] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Clinic] SET ARITHABORT OFF 
GO
ALTER DATABASE [Clinic] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Clinic] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Clinic] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Clinic] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Clinic] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Clinic] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Clinic] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Clinic] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Clinic] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Clinic] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Clinic] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Clinic] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Clinic] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Clinic] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Clinic] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Clinic] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Clinic] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Clinic] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Clinic] SET  MULTI_USER 
GO
ALTER DATABASE [Clinic] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Clinic] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Clinic] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Clinic] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Clinic] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Clinic] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Clinic] SET QUERY_STORE = OFF
GO
USE [Clinic]
GO
/****** Object:  Table [dbo].[Doctors]    Script Date: 3/21/2021 6:01:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nchar](10) NULL,
	[last_name] [nchar](10) NULL,
	[user_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patients]    Script Date: 3/21/2021 6:01:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patients](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nvarchar](50) NULL,
	[last_name] [nvarchar](50) NULL,
	[Date of birth] [date] NULL,
	[Address] [nvarchar](max) NULL,
	[user_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bookings]    Script Date: 3/21/2021 6:01:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bookings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[patient_id] [int] NULL,
	[doctor_id] [int] NULL,
	[reason] [nvarchar](50) NULL,
	[slot_start] [time](7) NULL,
	[slot_end] [time](7) NULL,
	[status] [nchar](10) NULL,
	[booking_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Bookings_DoctorsPatients]    Script Date: 3/21/2021 6:01:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Bookings_DoctorsPatients]
AS
SELECT dbo.Doctors.first_name AS doctor_first_name, dbo.Doctors.last_name AS doctor_last_name, dbo.Doctors.Id AS doctor_id, dbo.Bookings.reason, dbo.Bookings.patient_id, dbo.Patients.last_name AS patient_last_name, dbo.Patients.first_name AS patient_first_name, dbo.Patients.Address, dbo.Patients.[Date of birth], dbo.Bookings.slot_start, dbo.Bookings.slot_end, 
         dbo.Bookings.status, dbo.Bookings.booking_date
FROM  dbo.Bookings INNER JOIN
         dbo.Doctors ON dbo.Bookings.doctor_id = dbo.Doctors.Id INNER JOIN
         dbo.Patients ON dbo.Bookings.patient_id = dbo.Patients.Id
GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/21/2021 6:01:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[user_type] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DoctorsUsers]    Script Date: 3/21/2021 6:01:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DoctorsUsers]
	AS SELECT Doctors.Id as doctor_id, Users.username, Users.password, Doctors.[user_id], Doctors.first_name, Doctors.last_name FROM Doctors 
	JOIN Users On Users.Id  = Doctors.[user_id]
GO
/****** Object:  View [dbo].[DoctorsNBookings]    Script Date: 3/21/2021 6:01:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DoctorsNBookings]
	AS SELECT Bookings.Id AS booking_id, Doctors.Id AS doctor_id,  Bookings.booking_date, Bookings.patient_id, Bookings.reason, Bookings.slot_start, Bookings.slot_end, Doctors.first_name AS doctor_first_name, Doctors.last_name AS doctor_last_name, Bookings.status
	FROM Bookings JOIN Doctors ON Bookings.doctor_id = Doctors.Id
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 3/21/2021 6:01:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[First_Name] [nchar](10) NULL,
	[Last_Name] [nchar](10) NULL,
	[user_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Admin] ON 

INSERT [dbo].[Admin] ([Id], [First_Name], [Last_Name], [user_id]) VALUES (1, N'Reem      ', N'Abdullah  ', 11)
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO
SET IDENTITY_INSERT [dbo].[Bookings] ON 

INSERT [dbo].[Bookings] ([Id], [patient_id], [doctor_id], [reason], [slot_start], [slot_end], [status], [booking_date]) VALUES (15, 20, 6, N'Stomach pain', CAST(N'11:00:00' AS Time), CAST(N'11:30:00' AS Time), N'approved  ', CAST(N'2021-03-21' AS Date))
INSERT [dbo].[Bookings] ([Id], [patient_id], [doctor_id], [reason], [slot_start], [slot_end], [status], [booking_date]) VALUES (16, 21, 6, N'Stomach pain', CAST(N'10:00:00' AS Time), CAST(N'10:30:00' AS Time), N'approved  ', CAST(N'2021-03-21' AS Date))
INSERT [dbo].[Bookings] ([Id], [patient_id], [doctor_id], [reason], [slot_start], [slot_end], [status], [booking_date]) VALUES (17, 21, 6, N'heachaches', CAST(N'12:30:00' AS Time), CAST(N'13:00:00' AS Time), N'rejected  ', CAST(N'2021-03-21' AS Date))
SET IDENTITY_INSERT [dbo].[Bookings] OFF
GO
SET IDENTITY_INSERT [dbo].[Doctors] ON 

INSERT [dbo].[Doctors] ([Id], [first_name], [last_name], [user_id]) VALUES (6, N'Alya      ', N'Naser     ', 31)
INSERT [dbo].[Doctors] ([Id], [first_name], [last_name], [user_id]) VALUES (7, N'Omar      ', N'Mahmoud   ', 32)
INSERT [dbo].[Doctors] ([Id], [first_name], [last_name], [user_id]) VALUES (8, N'Amal      ', N'Abdullah  ', 29)
INSERT [dbo].[Doctors] ([Id], [first_name], [last_name], [user_id]) VALUES (9, N'doctr     ', N'dd        ', 35)
SET IDENTITY_INSERT [dbo].[Doctors] OFF
GO
SET IDENTITY_INSERT [dbo].[Patients] ON 

INSERT [dbo].[Patients] ([Id], [first_name], [last_name], [Date of birth], [Address], [user_id]) VALUES (17, N'Aisha', N'Mohammed', CAST(N'2002-01-01' AS Date), N'UAE', 28)
INSERT [dbo].[Patients] ([Id], [first_name], [last_name], [Date of birth], [Address], [user_id]) VALUES (19, N'Ahmed', N'Abdullah', CAST(N'1997-06-18' AS Date), N'sharjah', 30)
INSERT [dbo].[Patients] ([Id], [first_name], [last_name], [Date of birth], [Address], [user_id]) VALUES (20, N'Zeina', N'Thabet', CAST(N'2001-05-01' AS Date), N'Ajman', 33)
INSERT [dbo].[Patients] ([Id], [first_name], [last_name], [Date of birth], [Address], [user_id]) VALUES (21, N'zeina', N'thabettt', CAST(N'2018-06-21' AS Date), N'ajman', 34)
SET IDENTITY_INSERT [dbo].[Patients] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [username], [password], [user_type]) VALUES (11, N'admin', N'admin', N'Admin')
INSERT [dbo].[Users] ([Id], [username], [password], [user_type]) VALUES (28, N'aisha', N'123', N'Patient')
INSERT [dbo].[Users] ([Id], [username], [password], [user_type]) VALUES (29, N'amal', N'321', N'Doctor')
INSERT [dbo].[Users] ([Id], [username], [password], [user_type]) VALUES (30, N'myuser', N'123', N'Patient')
INSERT [dbo].[Users] ([Id], [username], [password], [user_type]) VALUES (31, N'alya0', N'123', N'Doctor')
INSERT [dbo].[Users] ([Id], [username], [password], [user_type]) VALUES (32, N'omar1', N'123', N'Doctor')
INSERT [dbo].[Users] ([Id], [username], [password], [user_type]) VALUES (33, N'zeina0', N'123', N'Patient')
INSERT [dbo].[Users] ([Id], [username], [password], [user_type]) VALUES (34, N'zeina01', N'123', N'Patient')
INSERT [dbo].[Users] ([Id], [username], [password], [user_type]) VALUES (35, N'123', N'123', N'Doctor')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Admin]  WITH CHECK ADD  CONSTRAINT [FK_Admin_user_id_To_Users_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Admin] CHECK CONSTRAINT [FK_Admin_user_id_To_Users_id]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [FK_doctor_id] FOREIGN KEY([doctor_id])
REFERENCES [dbo].[Doctors] ([Id])
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [FK_doctor_id]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [FK_Patient_ID] FOREIGN KEY([patient_id])
REFERENCES [dbo].[Patients] ([Id])
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [FK_Patient_ID]
GO
ALTER TABLE [dbo].[Doctors]  WITH CHECK ADD  CONSTRAINT [FK_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Doctors] CHECK CONSTRAINT [FK_user_id]
GO
ALTER TABLE [dbo].[Patients]  WITH CHECK ADD  CONSTRAINT [FK_Patients_user_Id_To_Users_Id] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Patients] CHECK CONSTRAINT [FK_Patients_user_Id_To_Users_Id]
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
         Begin Table = "Bookings"
            Begin Extent = 
               Top = 104
               Left = 1096
               Bottom = 561
               Right = 1371
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Doctors"
            Begin Extent = 
               Top = 124
               Left = 553
               Bottom = 371
               Right = 828
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Patients"
            Begin Extent = 
               Top = 106
               Left = 1544
               Bottom = 593
               Right = 1819
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Bookings_DoctorsPatients'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Bookings_DoctorsPatients'
GO
USE [master]
GO
ALTER DATABASE [Clinic] SET  READ_WRITE 
GO
