-- Crear base de datos EduLinkDb
-- CREATE DATABASE EduLinkDb;
-- GO

--USE EduLinkDb;
--GO

-- Usuarios (Contiene tanto clientes como proveedores)
CREATE TABLE Usuarios (
    Id UNIQUEIDENTIFIER PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    TipoUsuario NVARCHAR(20) NOT NULL CHECK (TipoUsuario IN ('Cliente', 'Proveedor')),
    -- Campos específicos de Proveedor (nullable para Cliente)
    Bio NVARCHAR(500) NULL
);
GO

-- Servicios (publicados por Proveedores)
CREATE TABLE Servicios (
    Id UNIQUEIDENTIFIER PRIMARY KEY,
    ProveedorId UNIQUEIDENTIFIER NOT NULL,
    Titulo NVARCHAR(200) NOT NULL,
    Descripcion NVARCHAR(MAX),
    PrecioBase DECIMAL(10,2) NOT NULL,
    DuracionMinutos INT NOT NULL,
    Modalidad NVARCHAR(20) NOT NULL CHECK (Modalidad IN ('Online', 'Presencial')),
    Ubicacion NVARCHAR(300) NULL,
    FOREIGN KEY (ProveedorId) REFERENCES Usuarios(Id)
);
GO

-- Slots horarios (dentro de un Servicio)
CREATE TABLE Slots (
    Id UNIQUEIDENTIFIER PRIMARY KEY,
    ServicioId UNIQUEIDENTIFIER NOT NULL,
    Inicio DATETIME2 NOT NULL,
    Fin DATETIME2 NOT NULL,
    CupoMax INT NOT NULL CHECK (CupoMax > 0),
    CupoActual INT NOT NULL DEFAULT 0,
    Estado NVARCHAR(20) NOT NULL DEFAULT 'Disponible' CHECK (Estado IN ('Disponible', 'Reservado', 'Bloqueado', 'Cancelado', 'Expirado')),
    FOREIGN KEY (ServicioId) REFERENCES Servicios(Id) ON DELETE CASCADE
);
GO

-- Reservas (Cliente + Servicio + Slot)
CREATE TABLE Reservas (
    Id UNIQUEIDENTIFIER PRIMARY KEY,
    ClienteId UNIQUEIDENTIFIER NOT NULL,
    ServicioId UNIQUEIDENTIFIER NOT NULL,
    SlotId UNIQUEIDENTIFIER NOT NULL,
    Estado NVARCHAR(20) NOT NULL DEFAULT 'Pendiente' CHECK (Estado IN ('Pendiente', 'Confirmada', 'Cancelada', 'Completada')),
    PlazoMaximoCancelacionHoras INT NOT NULL DEFAULT 24,
    PorcentajeCargo DECIMAL(3,2) NOT NULL DEFAULT 0.10,
    FOREIGN KEY (ClienteId) REFERENCES Usuarios(Id),
    FOREIGN KEY (ServicioId) REFERENCES Servicios(Id),
    FOREIGN KEY (SlotId) REFERENCES Slots(Id)
);
GO

-- Pagos (asociados a una Reserva)
CREATE TABLE Pagos (
    Id UNIQUEIDENTIFIER PRIMARY KEY,
    ReservaId UNIQUEIDENTIFIER NOT NULL UNIQUE,
    Metodo NVARCHAR(30) NOT NULL,
    Estado NVARCHAR(20) NOT NULL DEFAULT 'Pendiente' CHECK (Estado IN ('Pendiente', 'Aprobado', 'Fallido', 'Reembolsado')),
    MontoTotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ReservaId) REFERENCES Reservas(Id)
);
GO