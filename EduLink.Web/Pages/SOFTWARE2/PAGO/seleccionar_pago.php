<?php
$servicio = $_GET["servicio"];
$fecha = $_GET["fecha"];
?>

<!DOCTYPE html>
<html lang="es">
<body>

<h2>Reserva confirmada</h2>

<p>Servicio ID: <?= $servicio ?></p>
<p>Fecha: <?= $fecha ?></p>

<a class="btn pagar" 
   href="pago.php?servicio=<?= urlencode($servicio) ?>&fecha=<?= urlencode($fecha) ?>&precio=<?= urlencode($precio) ?>">
   💳 Pagar ahora
</a>

<a href="historial.php">📄 Ir al historial (Pendiente de pago)</a>

</body>
</html>
