-- Ejecutar en SQL Server antes de abrir el sitio.
-- Base TiendaOnline. La cadena de conexión está en Web.config
-- (localhost, autenticación de Windows).

USE master;
GO

IF DB_ID(N'TiendaOnline') IS NULL
    CREATE DATABASE TiendaOnline;
GO

USE TiendaOnline;
GO

IF OBJECT_ID(N'dbo.productos', N'U') IS NOT NULL
    DROP TABLE dbo.productos;
GO

IF OBJECT_ID(N'dbo.categorías', N'U') IS NOT NULL
    DROP TABLE dbo.[categorías];
GO

CREATE TABLE [categorías] (
    idCategoria INT IDENTITY(1, 1) NOT NULL,
    [descripción] VARCHAR(100) NOT NULL,
    CONSTRAINT PK_categorias PRIMARY KEY (idCategoria)
);
GO

CREATE TABLE productos (
    idProducto INT IDENTITY(1, 1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    [categoría] INT NOT NULL,
    CONSTRAINT PK_productos PRIMARY KEY (idProducto),
    CONSTRAINT FK_productos_categorias FOREIGN KEY ([categoría])
        REFERENCES [categorías] (idCategoria),
    CONSTRAINT CK_productos_precio CHECK (precio > 0)
);
GO

SET IDENTITY_INSERT [categorías] ON;

INSERT INTO [categorías] (idCategoria, [descripción]) VALUES
(1, 'Remeras'),
(2, 'Pantalones'),
(3, 'Calzado'),
(4, 'Accesorios');

SET IDENTITY_INSERT [categorías] OFF;
GO

SET IDENTITY_INSERT productos ON;

INSERT INTO productos (idProducto, nombre, precio, [categoría]) VALUES
(1, 'Remera básica negra', 12500.00, 1),
(2, 'Remera estampada', 14900.00, 1),
(3, 'Pantalón jogger', 22000.00, 2),
(4, 'Zapatillas running', 48000.00, 3),
(5, 'Medias deportivas', 3500.00, 4);

SET IDENTITY_INSERT productos OFF;
GO
