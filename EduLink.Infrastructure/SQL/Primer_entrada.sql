-- Este es el registro que usaré para la prueba de backend
-- Insertar Cliente
INSERT INTO Usuarios (Id, Nombre, Email, TipoUsuario, Bio)
VALUES (
    '11111111-1111-1111-1111-111111111111',
    'Ana López',
    'ana@example.com',
    'Cliente',
    NULL
);

-- Insertar Proveedor
INSERT INTO Usuarios (Id, Nombre, Email, TipoUsuario, Bio)
VALUES (
    '22222222-2222-2222-2222-222222222222',
    'Carlos Méndez',
    'carlos@edulink.com',
    'Proveedor',
    'Ingeniero en Sistemas, 5 años enseñando C#'
);

-- Insertar Servicio
INSERT INTO Servicios (Id, ProveedorId, Titulo, Descripcion, PrecioBase, DuracionMinutos, Modalidad, Ubicacion)
VALUES (
    '33333333-3333-3333-3333-333333333333',
    '22222222-2222-2222-2222-222222222222',
    'Clase de Cálculo',
    'Repaso para examen final. Temas: integrales, derivadas.',
    25.00,
    60,
    'Online',
    NULL
);

-- SlotHorario
INSERT INTO Slots (Id, ServicioId, Inicio, Fin, CupoMax, CupoActual, Estado)
VALUES (
    '44444444-4444-4444-4444-444444444444',
    '33333333-3333-3333-3333-333333333333',
    DATEADD(HOUR, 24, GETUTCDATE()),  -- Mañana a esta hora
    DATEADD(HOUR, 25, GETUTCDATE()),  -- +1 hora
    3,
    0,
    'Disponible'
);