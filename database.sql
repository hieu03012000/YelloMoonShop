USE [master]
GO
/****** Object:  Database [YellowMoonShop]    Script Date: 18/10/2020 1:18:40 AM ******/
CREATE DATABASE [YellowMoonShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'YellowMoonShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\YellowMoonShop.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'YellowMoonShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\YellowMoonShop_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [YellowMoonShop] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [YellowMoonShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [YellowMoonShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [YellowMoonShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [YellowMoonShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [YellowMoonShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [YellowMoonShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [YellowMoonShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [YellowMoonShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [YellowMoonShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [YellowMoonShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [YellowMoonShop] SET  MULTI_USER 
GO
ALTER DATABASE [YellowMoonShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [YellowMoonShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [YellowMoonShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [YellowMoonShop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [YellowMoonShop] SET DELAYED_DURABILITY = DISABLED 
GO
USE [YellowMoonShop]
GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 18/10/2020 1:18:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCategory](
	[categoryID] [varchar](10) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblCategory] PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblLog]    Script Date: 18/10/2020 1:18:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblLog](
	[logID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_tblLog_logID]  DEFAULT (newid()),
	[userID] [varchar](50) NULL,
	[productID] [uniqueidentifier] NULL,
	[date] [datetime] NULL,
	[type] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblLog] PRIMARY KEY CLUSTERED 
(
	[logID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblOrder]    Script Date: 18/10/2020 1:18:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblOrder](
	[orderID] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[total] [float] NOT NULL,
	[orderDate] [datetime] NOT NULL,
	[orderAddress] [nvarchar](50) NOT NULL,
	[paymentID] [varchar](50) NULL,
	[email] [varchar](50) NULL,
 CONSTRAINT [PK_tblOrder] PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblOrderDetail]    Script Date: 18/10/2020 1:18:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderDetail](
	[detailID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_tblOrderDetail_detailID]  DEFAULT (newid()),
	[orderID] [uniqueidentifier] NOT NULL,
	[productID] [uniqueidentifier] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [float] NOT NULL,
 CONSTRAINT [PK_tblOrderDetail] PRIMARY KEY CLUSTERED 
(
	[detailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblPayment]    Script Date: 18/10/2020 1:18:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPayment](
	[paymentID] [varchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblPayment] PRIMARY KEY CLUSTERED 
(
	[paymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblProduct]    Script Date: 18/10/2020 1:18:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblProduct](
	[productID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_tblProduct_productID]  DEFAULT (newid()),
	[name] [nvarchar](50) NOT NULL,
	[price] [float] NOT NULL,
	[quantity] [int] NOT NULL,
	[categoryID] [varchar](10) NOT NULL,
	[image] [varchar](50) NULL,
	[createDate] [datetime] NULL,
	[expirationDate] [datetime] NULL,
	[status] [bit] NULL,
	[description] [nvarchar](300) NULL,
 CONSTRAINT [PK_tblProduct] PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblRole]    Script Date: 18/10/2020 1:18:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblRole](
	[roleID] [varchar](10) NOT NULL,
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblRole] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 18/10/2020 1:18:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUser](
	[email] [varchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[password] [varchar](64) NOT NULL,
	[status] [bit] NOT NULL,
	[roleID] [varchar](10) NOT NULL,
	[address] [nvarchar](255) NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tblCategory] ([categoryID], [name]) VALUES (N'A', N'Ajinomoto')
INSERT [dbo].[tblCategory] ([categoryID], [name]) VALUES (N'KD', N'Kinh Do')
INSERT [dbo].[tblCategory] ([categoryID], [name]) VALUES (N'MC', N'Matcha')
INSERT [dbo].[tblCategory] ([categoryID], [name]) VALUES (N'TC', N'Thap Cam')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'07ab4e8d-3979-46ea-ae83-0ca1d01485a8', N'hieu', N'8ca6812d-ee16-4d36-97f9-75af3b33d35b', CAST(N'2020-10-18 00:39:02.643' AS DateTime), N'update')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'074b3369-39d8-4ea0-bbe2-21118d975352', N'hieu', N'5a7c6d03-14c2-4ccf-851b-b396427fd286', CAST(N'2020-10-13 21:46:25.363' AS DateTime), N'update')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'18f29011-9f56-44d9-bef2-2e3fc84570d0', N'hieu', N'0821e722-f9b9-4838-9f00-16eb38a38925', CAST(N'2020-10-12 22:48:57.113' AS DateTime), N'create')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'f85cc7b3-14e5-40cf-bed1-31d444331eab', N'hieu', N'247b499c-67c1-4909-8b54-29af51d8d1b5', CAST(N'2020-10-18 00:52:29.077' AS DateTime), N'update')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'0858dee7-83d7-4bff-80cc-570ae0ea74d9', N'hieu', N'e6dba735-c695-4394-b1ac-4448d82eb4af', CAST(N'2020-10-12 22:48:23.897' AS DateTime), N'update')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'c4108e0c-3e83-45b9-8019-712b5672e783', N'hieu', N'0821e722-f9b9-4838-9f00-16eb38a38925', CAST(N'2020-10-12 23:07:28.720' AS DateTime), N'create')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'43d0820b-dc5d-47f9-9dde-769c36a7d1e2', N'hieu', N'06f7c989-9fc5-4165-bcd8-35a2e70eb9af', CAST(N'2020-10-12 23:10:25.233' AS DateTime), N'create')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'70a833c8-0181-429a-acf7-77a07aa9b8ea', N'hieu', N'b7b5b00e-38ba-4cae-b4af-95acd4fc58c1', CAST(N'2020-10-12 23:13:49.770' AS DateTime), N'create')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'edcebe91-87f3-4e46-b533-834dba4fe2e0', N'hieu', N'5a7c6d03-14c2-4ccf-851b-b396427fd286', CAST(N'2020-10-18 00:33:45.237' AS DateTime), N'update')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'4f010adc-dd0d-4407-806c-857cde5d2cc3', N'hieu', N'3e6f3e48-b268-4339-8705-43bbfa7e4861', CAST(N'2020-10-12 23:10:44.523' AS DateTime), N'update')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'c172fed8-2c59-46c2-860d-a42fa0a70fc7', N'hieu', N'1e3c7241-3f22-4f8a-8552-e176338104a2', CAST(N'2020-10-12 23:10:56.913' AS DateTime), N'update')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'3b6012da-d815-4ec5-820d-a6145dd2b5fd', N'hieu', N'0821e722-f9b9-4838-9f00-16eb38a38925', CAST(N'2020-10-18 01:14:47.893' AS DateTime), N'create')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'2b65959f-e0c1-4fba-8225-b5c2ea83c739', N'hieu', N'979c203c-8cd8-49b8-88e1-a445806ea47d', CAST(N'2020-10-12 19:33:13.027' AS DateTime), N'update')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'631a2d54-cb1f-41d6-9a17-bd5d79c40118', N'hieu', N'e15db05f-9573-4e96-b4d5-3844107021ec', CAST(N'2020-10-12 22:38:09.133' AS DateTime), N'create')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'39edb369-6a64-444d-90d4-c7b8ec9b66cf', N'hieu', N'3e6f3e48-b268-4339-8705-43bbfa7e4861', CAST(N'2020-10-17 10:05:05.590' AS DateTime), N'update')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'c8bc2bb0-67be-4d18-a775-cc62fb017df8', N'hieu', N'a7d68e4a-cb40-4d99-a04b-b67ba15c8c17', CAST(N'2020-10-12 23:08:36.747' AS DateTime), N'create')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'e2f12df3-35fe-4c79-8d74-d9564481c409', N'hieu', N'5a7c6d03-14c2-4ccf-851b-b396427fd286', CAST(N'2020-10-12 23:30:35.560' AS DateTime), N'update')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'2c48a36d-c5dc-4d48-b7f4-e56f29878c3c', N'hieu', N'8ca6812d-ee16-4d36-97f9-75af3b33d35b', CAST(N'2020-10-17 10:04:28.290' AS DateTime), N'update')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'7f63d85d-3d05-4bad-b77b-f0be9863de13', N'hieu', N'979c203c-8cd8-49b8-88e1-a445806ea47d', CAST(N'2020-10-12 13:38:30.253' AS DateTime), N'create')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date], [type]) VALUES (N'b01312a8-1ca9-45c8-ae82-f1d488e15a3f', N'hieu', N'f3355da2-67fe-4c49-850d-140546f7a151', CAST(N'2020-10-12 12:05:42.383' AS DateTime), N'create')
INSERT [dbo].[tblOrder] ([orderID], [total], [orderDate], [orderAddress], [paymentID], [email]) VALUES (N'f9dca0b2-9d62-4e3e-8a2e-23ad671796c7', 369492, CAST(N'2020-10-13 00:54:30.507' AS DateTime), N'c1', N'C', N'phuong')
INSERT [dbo].[tblOrder] ([orderID], [total], [orderDate], [orderAddress], [paymentID], [email]) VALUES (N'6df5eef5-8cb1-4882-a2c0-47534feb2a14', 100000, CAST(N'2020-10-13 01:26:16.790' AS DateTime), N'c1', N'C', N'user')
INSERT [dbo].[tblOrder] ([orderID], [total], [orderDate], [orderAddress], [paymentID], [email]) VALUES (N'd62fd77c-c162-44ad-941e-5e56dd77a2a3', 1, CAST(N'2020-10-18 00:31:48.377' AS DateTime), N'c1', N'O', N'user5')
INSERT [dbo].[tblOrder] ([orderID], [total], [orderDate], [orderAddress], [paymentID], [email]) VALUES (N'ae23ee01-19c5-4b43-9adc-67f2ae7c667a', 12512312, CAST(N'2020-10-12 01:18:25.033' AS DateTime), N'c1', N'C', N'phuong')
INSERT [dbo].[tblOrder] ([orderID], [total], [orderDate], [orderAddress], [paymentID], [email]) VALUES (N'16e12c62-60f9-4030-8a9a-6c4f2c938a26', 123, CAST(N'2020-10-13 02:33:21.767' AS DateTime), N'c1123', N'C', N'phuong')
INSERT [dbo].[tblOrder] ([orderID], [total], [orderDate], [orderAddress], [paymentID], [email]) VALUES (N'eaa8e40b-3ad9-4289-bbf5-72892c2bb35c', 100000, CAST(N'2020-10-13 01:10:53.787' AS DateTime), N'c1', N'C', N'phuong')
INSERT [dbo].[tblOrder] ([orderID], [total], [orderDate], [orderAddress], [paymentID], [email]) VALUES (N'4d90c90b-d045-46dd-b3a0-83e8626b9b2a', 200123, CAST(N'2020-10-13 00:46:08.573' AS DateTime), N'c1', N'C', N'phuong')
INSERT [dbo].[tblOrder] ([orderID], [total], [orderDate], [orderAddress], [paymentID], [email]) VALUES (N'38c9d947-7650-4be9-9746-94249b9ae65f', 37, CAST(N'2020-10-18 00:08:06.873' AS DateTime), N'MT', N'C', N'phuong')
INSERT [dbo].[tblOrder] ([orderID], [total], [orderDate], [orderAddress], [paymentID], [email]) VALUES (N'8b4942d9-2d77-4b80-b0b8-b5d33baf8b35', 100000, CAST(N'2020-10-13 01:28:01.983' AS DateTime), N'123', N'C', N'user1')
INSERT [dbo].[tblOrder] ([orderID], [total], [orderDate], [orderAddress], [paymentID], [email]) VALUES (N'3db6af8f-fb27-4341-ae92-f110d19f0316', 184, CAST(N'2020-10-14 00:11:53.073' AS DateTime), N'123', N'B', N'hieu03012000@gmail.com')
INSERT [dbo].[tblOrder] ([orderID], [total], [orderDate], [orderAddress], [paymentID], [email]) VALUES (N'd4500f20-b30f-445c-ab44-feedd302af62', 100000, CAST(N'2020-10-13 01:30:48.547' AS DateTime), N'c1', N'C', N'user2')
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'03912320-cd94-4cd9-a277-05fa0a2d21da', N'3db6af8f-fb27-4341-ae92-f110d19f0316', N'978f14b6-ce1d-4b77-9868-f1e912000b42', 1, 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'3d4aca75-3702-487e-b36f-22b42b473a8e', N'f9dca0b2-9d62-4e3e-8a2e-23ad671796c7', N'1e3c7241-3f22-4f8a-8552-e176338104a2', 3, 369000)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'413a46a1-b23f-4a86-a853-24f7c85b7554', N'f9dca0b2-9d62-4e3e-8a2e-23ad671796c7', N'0821e722-f9b9-4838-9f00-16eb38a38925', 4, 492)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'ee8f0f2e-faaa-4a2a-a66e-272a47299f94', N'ae23ee01-19c5-4b43-9adc-67f2ae7c667a', N'944cad0b-5046-467f-97f3-6cbfe310c629', 2, 200000)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'0523f9d0-7341-4313-937a-3f35af41acad', N'6df5eef5-8cb1-4882-a2c0-47534feb2a14', N'e6dba735-c695-4394-b1ac-4448d82eb4af', 1, 100000)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'9006a399-2760-4944-a682-6647e0fcef8f', N'16e12c62-60f9-4030-8a9a-6c4f2c938a26', N'0821e722-f9b9-4838-9f00-16eb38a38925', 1, 123)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'146e4f4b-8ccb-4156-aca1-727879238518', N'3db6af8f-fb27-4341-ae92-f110d19f0316', N'e15db05f-9573-4e96-b4d5-3844107021ec', 5, 60)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'20684561-0ddf-4a7c-a74e-888dff703c47', N'8b4942d9-2d77-4b80-b0b8-b5d33baf8b35', N'e6dba735-c695-4394-b1ac-4448d82eb4af', 1, 100000)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'a18e9bc4-5e14-492b-b9d3-8977aec880ba', N'3db6af8f-fb27-4341-ae92-f110d19f0316', N'0821e722-f9b9-4838-9f00-16eb38a38925', 1, 123)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'd0b41154-e1c2-4d33-b4df-a260dd6ec04d', N'38c9d947-7650-4be9-9746-94249b9ae65f', N'e15db05f-9573-4e96-b4d5-3844107021ec', 3, 36)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'22795e59-3868-4d00-a32e-b30854d3310e', N'4d90c90b-d045-46dd-b3a0-83e8626b9b2a', N'e6dba735-c695-4394-b1ac-4448d82eb4af', 2, 200000)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'd3602bf5-83f5-42a5-855e-bb9195fa74e6', N'd62fd77c-c162-44ad-941e-5e56dd77a2a3', N'978f14b6-ce1d-4b77-9868-f1e912000b42', 1, 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'7caf45a8-fd4f-4c77-8a41-c3c10b4c07c3', N'4d90c90b-d045-46dd-b3a0-83e8626b9b2a', N'06f7c989-9fc5-4165-bcd8-35a2e70eb9af', 1, 123)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'f6a9aa06-bf7b-48d4-b4c2-e5d3dd6d2a60', N'd4500f20-b30f-445c-ab44-feedd302af62', N'e6dba735-c695-4394-b1ac-4448d82eb4af', 1, 100000)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'e6ce406b-8853-42e2-a0fe-e8396210505a', N'38c9d947-7650-4be9-9746-94249b9ae65f', N'978f14b6-ce1d-4b77-9868-f1e912000b42', 1, 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'a0cd8607-756f-442c-ac45-f9c4c1e875b6', N'ae23ee01-19c5-4b43-9adc-67f2ae7c667a', N'979c203c-8cd8-49b8-88e1-a445806ea47d', 1, 12312312)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [quantity], [price]) VALUES (N'cbbf6b2b-ec09-4949-a366-fd9508e24a19', N'eaa8e40b-3ad9-4289-bbf5-72892c2bb35c', N'e6dba735-c695-4394-b1ac-4448d82eb4af', 1, 100000)
INSERT [dbo].[tblPayment] ([paymentID], [name]) VALUES (N'B', N'Banking')
INSERT [dbo].[tblPayment] ([paymentID], [name]) VALUES (N'C', N'Cash')
INSERT [dbo].[tblPayment] ([paymentID], [name]) VALUES (N'O', N'Other')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'a9b03552-39ad-4481-814d-1030501828d8', N'123123123123', 12, 10, N'A', N'./img/download.jpg', CAST(N'2020-10-01 00:00:00.000' AS DateTime), CAST(N'2020-10-03 00:00:00.000' AS DateTime), 1, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'f3355da2-67fe-4c49-850d-140546f7a151', N'chu H', 123, 1212, N'A', N'./img/download.jpg', CAST(N'2020-10-01 00:00:00.000' AS DateTime), CAST(N'2020-10-31 00:00:00.000' AS DateTime), 1, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'0821e722-f9b9-4838-9f00-16eb38a38925', N'cake trung thu', 123, 123, N'A', N'', CAST(N'2020-10-16 00:00:00.000' AS DateTime), CAST(N'2020-10-31 00:00:00.000' AS DateTime), 1, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'247b499c-67c1-4909-8b54-29af51d8d1b5', N'test paging', 100, 123, N'A', N'', CAST(N'2020-10-01 00:00:00.000' AS DateTime), CAST(N'2020-10-31 00:00:00.000' AS DateTime), 1, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'78abe532-0be1-4e84-9a4c-2e9d1527ec59', N'123123', 12, 234, N'A', N'', CAST(N'1900-01-01 00:00:00.000' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime), 1, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'06f7c989-9fc5-4165-bcd8-35a2e70eb9af', N'cake trung thu ahihi', 123, 123, N'A', N'', CAST(N'2020-10-01 00:00:00.000' AS DateTime), CAST(N'2020-10-23 00:00:00.000' AS DateTime), 1, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'e15db05f-9573-4e96-b4d5-3844107021ec', N'cake trung thu number 1', 12, 123, N'A', N'', CAST(N'2020-10-10 00:00:00.000' AS DateTime), CAST(N'2020-10-24 00:00:00.000' AS DateTime), 1, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'3e6f3e48-b268-4339-8705-43bbfa7e4861', N'123', 100, 123123, N'TC', N'./img/download.png', CAST(N'2020-10-06 00:00:00.000' AS DateTime), CAST(N'2020-10-30 00:00:00.000' AS DateTime), 0, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'e6dba735-c695-4394-b1ac-4448d82eb4af', N'3 cai banh 100', 100000, 3, N'A', N'', CAST(N'2020-10-15 00:00:00.000' AS DateTime), CAST(N'2020-10-31 00:00:00.000' AS DateTime), 1, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'7077399a-f906-4645-bd97-4a68ccf82e90', N'matcha', 300000, 10, N'KD', N'.\img\java.jpg', CAST(N'2020-09-10 00:00:00.000' AS DateTime), CAST(N'2020-10-10 00:00:00.000' AS DateTime), 1, N'ngon cuc cuc')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'4527ff61-66f0-41ac-ac40-62eb19b8dc08', N'cake trung thu', 100000, 12, N'A', N'./img/java.jpg', CAST(N'2020-10-01 00:00:00.000' AS DateTime), CAST(N'2020-10-31 00:00:00.000' AS DateTime), 1, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'944cad0b-5046-467f-97f3-6cbfe310c629', N'thap cam kinh do', 100000, 100, N'TC', N'.\img\java.jpg', CAST(N'2020-08-11 00:00:00.000' AS DateTime), CAST(N'2020-10-12 00:00:00.000' AS DateTime), 1, N'hong thich thap cam')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'8ca6812d-ee16-4d36-97f9-75af3b33d35b', N'banh chu h', 1, 1, N'TC', N'./img/download.png', CAST(N'2020-10-21 00:00:00.000' AS DateTime), CAST(N'2020-11-19 00:00:00.000' AS DateTime), 1, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'9e58ba01-1ff9-4959-87d2-9582e398a4ea', N'cake trung thu 23', 150, 12, N'A', N'', CAST(N'2020-10-15 00:00:00.000' AS DateTime), CAST(N'2020-10-31 00:00:00.000' AS DateTime), 0, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'b7b5b00e-38ba-4cae-b4af-95acd4fc58c1', N'cake trung thu Kinh do', 123, 123, N'KD', N'', CAST(N'2020-10-01 00:00:00.000' AS DateTime), CAST(N'2020-10-31 00:00:00.000' AS DateTime), 1, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'979c203c-8cd8-49b8-88e1-a445806ea47d', N'123', 123, 123123, N'TC', N'./img/download.png', CAST(N'2020-10-01 00:00:00.000' AS DateTime), CAST(N'2020-10-30 00:00:00.000' AS DateTime), 1, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'5a7c6d03-14c2-4ccf-851b-b396427fd286', N'hihi', 19000, 111, N'TC', N'./img/hinhnenanime2-749x499.jpg', CAST(N'2020-10-31 00:00:00.000' AS DateTime), CAST(N'2020-12-26 00:00:00.000' AS DateTime), 1, N'huhuhuhu')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'a7d68e4a-cb40-4d99-a04b-b67ba15c8c17', N'cake trung thu213123', 123, 123, N'A', N'', CAST(N'2020-10-01 00:00:00.000' AS DateTime), CAST(N'2020-10-31 00:00:00.000' AS DateTime), 1, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'fcd014ac-49d5-4842-bd46-bc49cf8353f6', N'cake trung', 12, 123, N'A', N'', CAST(N'2020-10-01 00:00:00.000' AS DateTime), CAST(N'2020-10-10 00:00:00.000' AS DateTime), 1, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'f76ad678-d86e-4551-8378-e04b48f16d5a', N'cake trung thu', 1, 1, N'A', N'', CAST(N'2020-10-15 00:00:00.000' AS DateTime), CAST(N'2020-10-31 00:00:00.000' AS DateTime), 1, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'1e3c7241-3f22-4f8a-8552-e176338104a2', N'cake trung thu', 123000, 123, N'A', N'', CAST(N'2020-10-01 00:00:00.000' AS DateTime), CAST(N'2020-10-17 00:00:00.000' AS DateTime), 1, N'Thưởng thức bánh trung thu bên cạnh là một tách trà để bạn nhâm nhi là một lựa chọn không tồi')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'978f14b6-ce1d-4b77-9868-f1e912000b42', N'1 cai banh', 1, 0, N'MC', N'./img/java.jpg', CAST(N'2020-10-01 00:00:00.000' AS DateTime), CAST(N'2020-10-31 00:00:00.000' AS DateTime), 1, NULL)
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [categoryID], [image], [createDate], [expirationDate], [status], [description]) VALUES (N'7edd0ace-9297-44f9-a156-ff2d1f36c97e', N'cake trung thu', 200, 2, N'TC', N'', CAST(N'2020-10-01 00:00:00.000' AS DateTime), CAST(N'2020-11-30 00:00:00.000' AS DateTime), 1, NULL)
INSERT [dbo].[tblRole] ([roleID], [name]) VALUES (N'AD', N'Admin')
INSERT [dbo].[tblRole] ([roleID], [name]) VALUES (N'U', N'User')
INSERT [dbo].[tblUser] ([email], [name], [password], [status], [roleID], [address]) VALUES (N'hieu', N'Hieu Nguyen', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 1, N'AD', N'c1')
INSERT [dbo].[tblUser] ([email], [name], [password], [status], [roleID], [address]) VALUES (N'hieu03012000@gmail.com', N'hieu03012000@gmail.com', N'2ac0c661f01550e06436b596f42224d49062162bafaf100b9e0a3ec0bfaa5f3e', 1, N'U', N'')
INSERT [dbo].[tblUser] ([email], [name], [password], [status], [roleID], [address]) VALUES (N'hieu1', N'Hieu', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 1, N'AD', N'MT')
INSERT [dbo].[tblUser] ([email], [name], [password], [status], [roleID], [address]) VALUES (N'hihi', N'hihi', N'123', 1, N'U', N'')
INSERT [dbo].[tblUser] ([email], [name], [password], [status], [roleID], [address]) VALUES (N'phuong', N'Phuong Pham', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 1, N'U', N'c1')
INSERT [dbo].[tblUser] ([email], [name], [password], [status], [roleID], [address]) VALUES (N'phuong2', N'Phuong', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 1, N'U', N'MT')
INSERT [dbo].[tblUser] ([email], [name], [password], [status], [roleID], [address]) VALUES (N'u', N'u', N'u', 1, N'U', N'u')
INSERT [dbo].[tblUser] ([email], [name], [password], [status], [roleID], [address]) VALUES (N'user', N'user', N'1234567', 1, N'U', N'')
INSERT [dbo].[tblUser] ([email], [name], [password], [status], [roleID], [address]) VALUES (N'user1', N'user1', N'1234567', 1, N'U', N'')
INSERT [dbo].[tblUser] ([email], [name], [password], [status], [roleID], [address]) VALUES (N'user2', N'user2', N'1234567', 1, N'U', N'')
INSERT [dbo].[tblUser] ([email], [name], [password], [status], [roleID], [address]) VALUES (N'user3', N'user3', N'1234567', 1, N'U', N'')
INSERT [dbo].[tblUser] ([email], [name], [password], [status], [roleID], [address]) VALUES (N'user4', N'user4', N'1234567', 1, N'U', N'')
INSERT [dbo].[tblUser] ([email], [name], [password], [status], [roleID], [address]) VALUES (N'user5', N'user5', N'1234567', 1, N'U', N'')
INSERT [dbo].[tblUser] ([email], [name], [password], [status], [roleID], [address]) VALUES (N'user6', N'user6', N'1234567', 1, N'U', N'')
ALTER TABLE [dbo].[tblLog]  WITH CHECK ADD  CONSTRAINT [FK_tblLog_tblProduct] FOREIGN KEY([productID])
REFERENCES [dbo].[tblProduct] ([productID])
GO
ALTER TABLE [dbo].[tblLog] CHECK CONSTRAINT [FK_tblLog_tblProduct]
GO
ALTER TABLE [dbo].[tblLog]  WITH CHECK ADD  CONSTRAINT [FK_tblLog_tblUser1] FOREIGN KEY([userID])
REFERENCES [dbo].[tblUser] ([email])
GO
ALTER TABLE [dbo].[tblLog] CHECK CONSTRAINT [FK_tblLog_tblUser1]
GO
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD  CONSTRAINT [FK_tblOrder_tblPayment] FOREIGN KEY([paymentID])
REFERENCES [dbo].[tblPayment] ([paymentID])
GO
ALTER TABLE [dbo].[tblOrder] CHECK CONSTRAINT [FK_tblOrder_tblPayment]
GO
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD  CONSTRAINT [FK_tblOrder_tblUser] FOREIGN KEY([email])
REFERENCES [dbo].[tblUser] ([email])
GO
ALTER TABLE [dbo].[tblOrder] CHECK CONSTRAINT [FK_tblOrder_tblUser]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetail_tblOrder] FOREIGN KEY([orderID])
REFERENCES [dbo].[tblOrder] ([orderID])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK_tblOrderDetail_tblOrder]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetail_tblProduct] FOREIGN KEY([productID])
REFERENCES [dbo].[tblProduct] ([productID])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK_tblOrderDetail_tblProduct]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK_tblProduct_tblCategory] FOREIGN KEY([categoryID])
REFERENCES [dbo].[tblCategory] ([categoryID])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_tblProduct_tblCategory]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK_tblUser_tblRole] FOREIGN KEY([roleID])
REFERENCES [dbo].[tblRole] ([roleID])
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK_tblUser_tblRole]
GO
USE [master]
GO
ALTER DATABASE [YellowMoonShop] SET  READ_WRITE 
GO
