
<?php
// -----------------------
// Procesamiento del POST
// -----------------------

$servicio = $_GET["servicio"] ?? "";
$fecha = $_GET["fecha"] ?? "";
$precio = $_GET["precio"] ?? "0.00";
function luhn_check($number) {
    $number = preg_replace('/\D/', '', $number);
    $sum = 0;
    $alt = false;
    for ($i = strlen($number) - 1; $i >= 0; $i--) {
        $n = intval($number[$i]);
        if ($alt) {
            $n *= 2;
            if ($n > 9) $n -= 9;
        }
        $sum += $n;
        $alt = !$alt;
    }
    return ($sum % 10) == 0;
}

$errors = [];
$success = false;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $metodo = $_POST['metodo'] ?? '';

    if ($metodo === 'googlepay') {
        header("Location: https://pay.google.com");
        exit;
    }
    if ($metodo === 'paypal') {
        header("Location: https://www.paypal.com");
        exit;
    }

    if ($metodo === 'tarjeta') {
        $numero = $_POST['numero'] ?? '';
        $fecha = $_POST['fecha'] ?? '';
        $cvv = $_POST['cvv'] ?? '';
        $nombre = trim($_POST['nombre'] ?? '');

        $numero_dig = preg_replace('/\D/', '', $numero);
        if (strlen($numero_dig) < 13 || strlen($numero_dig) > 19) {
            $errors[] = "El número de tarjeta debe tener entre 13 y 19 dígitos.";
        } elseif (!luhn_check($numero_dig)) {
            $errors[] = "Número de tarjeta inválido (falló verificación Luhn).";
        }

        if (!preg_match('/^(0[1-9]|1[0-2])\/\d{2}$/', $fecha)) {
            $errors[] = "Formato de fecha inválido. Usa MM/YY (ej: 08/25).";
        } else {
            $parts = explode('/', $fecha);
            $mm = intval($parts[0]);
            $yy = intval($parts[1]) + 2000;
            $exp = DateTime::createFromFormat('Y-n-j', sprintf('%04d-%d-%d', $yy, $mm, 1));
            $now = new DateTime('first day of this month');
            if ($exp < $now) {
                $errors[] = "La tarjeta está vencida.";
            }
        }

        if (!preg_match('/^\d{3}$/', $cvv)) {
            $errors[] = "CVV inválido. Debe contener 3 dígitos.";
        }

        if (empty($nombre)) {
            $errors[] = "Ingresa el nombre que aparece en la tarjeta.";
        }

        if (empty($errors)) {
            $success = true;
        }
    } else {
        $errors[] = "Selecciona un método de pago válido.";
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>EduLink - Pago</title>
<link rel="stylesheet" href="CSS/Pago.css">
</head>
<body>
<div class="container">
  <div class="pago">
    <h2>Pago Seguro</h2>

    <?php if (!empty($errors)): ?>
      <div class="error"><strong>Errores:</strong><ul><?php foreach ($errors as $e) echo "<li>" . htmlspecialchars($e) . "</li>"; ?></ul></div>
    <?php endif; ?>
    <?php if ($success): ?>
      <div class="success">Pago procesado correctamente (modo demostración).</div>
    <?php endif; ?>

    <form id="formPago" method="post" action="">

      <div class="payment-box">
        <div class="payment-header">
          <h3>Método de pago</h3>
          <a href="#">Seguro y cifrado 🔒</a>
        </div>

        <div class="payment-method">
          <label>
            <input type="radio" name="metodo" value="tarjeta" <?php if(!isset($metodo) || $metodo==='tarjeta') echo 'checked'; ?>>
            <span>Tarjetas</span>
          </label>
          <div class="payment-logos">
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqaQ4_qijHYV_qc8goLCsxCFIWqy10Eu2sIg&s" alt="Visa">
            <img src="https://dbdzm869oupei.cloudfront.net/img/sticker/preview/6574.png" alt="Mastercard">
          </div>
        </div>

        <div class="payment-method">
          <label>
            <input type="radio" name="metodo" value="googlepay" <?php if(isset($metodo) && $metodo==='googlepay') echo 'checked'; ?>>
            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Google_Pay_Logo.svg/1200px-Google_Pay_Logo.svg.png" alt="Google Pay" style="height:20px;">
            <span>Google Pay</span>
          </label>
        </div>

        <div class="payment-method">
          <label>
            <input type="radio" name="metodo" value="paypal" <?php if(isset($metodo) && $metodo==='paypal') echo 'checked'; ?>>
            <img src="https://www.shutterstock.com/image-illustration/paypal-logo-on-transparent-background-260nw-2311643717.jpg" alt="PayPal" style="height:20px;">
            <span>PayPal</span>
          </label>
        </div>

        <div id="paypal-info" class="payment-info">Para completar la transacción, te enviaremos a los servidores seguros de PayPal.</div>
      </div>

      <div id="datosTarjeta" style="margin-top:15px;">
        <label>Número de tarjeta</label>
        <input type="text" id="numero" name="numero" placeholder="1234 5678 9012 3456" maxlength="23" value="<?php echo isset($_POST['numero'])?htmlspecialchars($_POST['numero']):''; ?>">
        <label>Fecha de vencimiento (MM/YY)</label>
        <input type="text" id="fecha" name="fecha" placeholder="MM/YY" maxlength="5" value="<?php echo isset($_POST['fecha'])?htmlspecialchars($_POST['fecha']):''; ?>">
        <label>CVV</label>
        <input type="text" id="cvv" name="cvv" placeholder="123" maxlength="4" value="<?php echo isset($_POST['cvv'])?htmlspecialchars($_POST['cvv']):''; ?>">
        <label>Nombre en la tarjeta</label>
        <input type="text" id="nombre" name="nombre" placeholder="Juan Pérez" value="<?php echo isset($_POST['nombre'])?htmlspecialchars($_POST['nombre']):''; ?>">
      </div>

      <p class="small">Solo en modo demostración — no se envía información real.</p>
      <button type="submit">Pagar Ahora</button>
    </form>
  </div>

  <div class="resumen">
    <h2>Resumen del pedido</h2>
    <p><strong>Servicio:</strong> <?= htmlspecialchars($servicio) ?></p>
<p><strong>Fecha seleccionada:</strong> <?= htmlspecialchars($fecha) ?></p>
<p><strong>Precio total:</strong> $<?= htmlspecialchars($precio) ?> USD</p>
<p><strong>Total:</strong> $<?= htmlspecialchars($precio) ?> USD</p>

    <label style="display:flex; gap:8px; align-items:center; margin-top:10px;">
      <input type="checkbox" id="acepto" required>
      <span class="small">Acepto términos y condiciones</span>
    </label>
    <p id="mensajeAprobado" style="display:none; color:green; font-weight:bold; margin-top:5px;">
      ✅ Aprobado por García, Toala, Carpio y Sánchez</p>
    <button id="btnPagoResumen">PAGO $<?= htmlspecialchars($precio) ?> USD</button>
  </div>
</div>

<script>
// Mostrar info de PayPal y ocultar campos de tarjeta si no aplica
const radios = document.querySelectorAll('input[name="metodo"]');
const paypalInfo = document.getElementById('paypal-info');
const datosTarjeta = document.getElementById('datosTarjeta');
radios.forEach(r => {
  r.addEventListener('change', () => {
    paypalInfo.style.display = r.value === 'paypal' ? 'block' : 'none';
    datosTarjeta.style.display = r.value === 'tarjeta' ? 'block' : 'none';
  });
});

// --- Validación cliente ---
function luhnCheck(num) {
  num = num.replace(/\D/g, '');
  let sum = 0, alt = false;
  for (let i = num.length - 1; i >= 0; i--) {
    let n = parseInt(num.charAt(i), 10);
    if (alt) { n *= 2; if (n > 9) n -= 9; }
    sum += n; alt = !alt;
  }
  return sum % 10 === 0;
}

document.getElementById('formPago').addEventListener('submit', function(e){
  const metodo = document.querySelector('input[name="metodo"]:checked').value;
  if (metodo === 'googlepay') { window.location.href = 'https://pay.google.com'; e.preventDefault(); return; }
  if (metodo === 'paypal') { window.location.href = 'https://www.paypal.com'; e.preventDefault(); return; }

  const numero = document.getElementById('numero').value.trim();
  const fecha = document.getElementById('fecha').value.trim();
  const cvv = document.getElementById('cvv').value.trim();
  const nombre = document.getElementById('nombre').value.trim();
  let clientErrors = [];

  const numeroDigits = numero.replace(/\D/g, '');
  if (numeroDigits.length < 13 || numeroDigits.length > 19) {
    clientErrors.push("El número de tarjeta debe tener entre 13 y 19 dígitos.");
  } else if (!luhnCheck(numeroDigits)) {
    clientErrors.push("Número de tarjeta inválido (cliente).");
  }

  if (!/^(0[1-9]|1[0-2])\/\d{2}$/.test(fecha)) {
    clientErrors.push("Formato de fecha inválido. Usa MM/YY.");
  } else {
    const parts = fecha.split('/');
    const mm = parseInt(parts[0], 10);
    const yy = 2000 + parseInt(parts[1], 10);
    const exp = new Date(yy, mm);
    const now = new Date();
    if (exp <= new Date(now.getFullYear(), now.getMonth(), 1)) {
      clientErrors.push("La tarjeta está vencida.");
    }
  }

  if (!/^\d{3}$/.test(cvv)) {
    clientErrors.push("CVV inválido. Debe tener 3 dígitos.");
  }

  if (nombre.length === 0) {
    clientErrors.push("Ingresa el nombre de la tarjeta.");
  }

  if (clientErrors.length > 0) {
    alert("Errores:\n- " + clientErrors.join("\n- "));
    e.preventDefault();
    return;
  }
});

// Máscaras
document.getElementById('numero').addEventListener('input', function(){
  let val = this.value.replace(/\D/g, '').slice(0,19);
  let parts = [];
  for (let i=0; i<val.length; i+=4) parts.push(val.substring(i, i+4));
  this.value = parts.join(' ');
});
document.getElementById('fecha').addEventListener('input', function(){
  let v = this.value.replace(/\D/g,'').slice(0,4);
  if (v.length >= 3) this.value = v.slice(0,2) + '/' + v.slice(2);
  else if (v.length >= 1) this.value = v;
});

// Botón del resumen
document.getElementById('btnPagoResumen').addEventListener('click', function(e){
  e.preventDefault();
  if (!document.getElementById('acepto').checked) {
    alert('Debes aceptar términos y condiciones.');
    return;
  }
  document.getElementById('formPago').requestSubmit();
});

// Mostrar mensaje de aprobación cuando se aceptan los términos
const check = document.getElementById('acepto');
const mensaje = document.getElementById('mensajeAprobado');

check.addEventListener('change', () => {
  if (check.checked) {
    mensaje.style.display = 'block';
  } else {
    mensaje.style.display = 'none';
  }
});

</script>
</body>
</html>


