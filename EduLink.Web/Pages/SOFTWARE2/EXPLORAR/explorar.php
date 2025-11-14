<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Explorar Servicios - EduLink</title>

    <link rel="stylesheet" href="CSS/explorar.css">
</head>
<body>

<header class="navbar">
    <div class="logo">
        <img src="Imagenes/Logo.png" alt="">
        <h2>EduLink</h2>
    </div>

    <div class="search-box">
        <input type="text" placeholder="Buscar servicios...">
        <button>🔍</button>
    </div>

    <div class="top-buttons">
        <a href="historial.php" class="btn-historial">📝 Historial</a>
        <a href="#" class="user-icon">SG</a>
    </div>
</header>

<div class="container">

    <h1>Explorar Servicios</h1>

    <!-- FILTROS -->
    <div class="filters">
        <button>Precio</button>
        <button>Ubicación</button>
        <button>Modalidad</button>
        <button>Fecha Disponible</button>
        <button class="active">Disponibles</button>
    </div>

    <!-- TARJETAS DE SERVICIOS -->
    <div class="cards">

        <div class="card">
            <div class="img-placeholder"></div>
            <h3>HTTP vs JSON</h3>
            <p>$14.99</p>
            <p class="mode">Online</p>
            <p class="rating">⭐ 4.8</p>
            <a href="pago.php" class="btn">Reservar</a>
        </div>

        <div class="card">
            <div class="img-placeholder"></div>
            <h3>Introducción a APIs</h3>
            <p>$10.99</p>
            <p class="mode">Presencial</p>
            <p class="rating">⭐ 4.7</p>
            <a href="pago.php" class="btn">Reservar</a>
        </div>

        <div class="card">
            <div class="img-placeholder"></div>
            <h3>Fundamentos de Redes</h3>
            <p>$12.99</p>
            <p class="mode">Online</p>
            <p class="rating">⭐ 4.9</p>
            <a href="pago.php" class="btn">Reservar</a>
        </div>

    </div>

</div>

</body>
</html>
