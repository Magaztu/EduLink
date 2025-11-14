<?php
session_start();

// Esto puedes cambiarlo luego para que venga de base de datos
$servicio = $_GET['servicio'] ?? 1;

$datos = [
    1 => ["titulo" => "Tutoría HTTP vs JSON", "precio" => 20, "modalidad" => "Online", "duracion" => "3 horas"],
    2 => ["titulo" => "Tutoría Presencial Programación", "precio" => 30, "modalidad" => "Presencial", "duracion" => "3 horas"],
];

$info = $datos[$servicio];
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservar Servicio</title>
    <link rel="stylesheet" href="CSS/reservar.css">
</head>
<body>

<header class="top-nav">
    <div class="logo">
        <img src="Imagenes/Logo.png" alt="" style="height:38px;">
        <span>EduLink</span>
    </div>

    <div class="search-bar">
        <input type="text" placeholder="Buscar servicios...">
        <button>🔍</button>
    </div>

    <div class="profile-icon">
        <a href="historial.php">🛒</a>
        <a href="#"><span class="user-icon">👤</span></a>
    </div>
</header>

<div class="container">

    <h2>Reservar Servicio</h2>

    <div class="contenido">

        <div class="left-panel">
            <div class="card">
                <div class="img-placeholder"></div>

                <h3><?= $info["titulo"] ?></h3>
                <p><?= $info["duracion"] ?></p>
                <p><?= $info["modalidad"] ?></p>
            </div>

            <label>Selecciona una fecha:</label>
            <input type="date" id="fecha" class="date-box" required>
        </div>

        <div class="right-panel">
            <h3>Tu reserva</h3>

            <p><strong><?= $info["titulo"] ?></strong></p>
            <p>Fecha seleccionada: <span id="fechaSeleccionada">No elegida</span></p>
            <p>Precio: <span class="precio">$<?= $info["precio"] ?></span></p>

            <button class="confirmar" onclick="continuarReserva()">Confirmar Reserva</button>
        </div>

    </div>

</div>

<script>
let fecha = document.getElementById("fecha");
let fechaTexto = document.getElementById("fechaSeleccionada");

fecha.addEventListener("change", () => {
    fechaTexto.textContent = fecha.value || "No elegida";
});

function continuarReserva() {
    if (fecha.value === "") {
        alert("Selecciona una fecha antes de continuar.");
        return;
    }

    window.location.href =
        "pago.php?fecha=" + fecha.value + "&servicio=<?= $servicio ?>";
}
</script>

</body>
</html>
