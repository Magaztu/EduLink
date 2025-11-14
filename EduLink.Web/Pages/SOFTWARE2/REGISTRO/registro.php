<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - EduLink</title>

    <!-- Vincular CSS -->
    <link rel="stylesheet" href="CSS/registro.css">
</head>
<body>

<!-- NAV -->
<header class="navbar">
    <div class="links">
        <a href="#">Home</a>
        <a href="#">Services</a>
        <a href="#">Contact</a>
        <a href="#">About</a>
    </div>

    <div class="logo">
        Edu<span>Link</span>
    </div>
</header>

<!-- FORMULARIO -->
<div class="register-box">
    <h2>Registro</h2>

    <form action="procesar_registro.php" method="POST">

        <div class="input-group">
            <label>Nombre</label>
            <input type="text" name="nombre" required>
        </div>

        <div class="input-group">
            <label>Correo</label>
            <input type="email" name="correo" required>
        </div>

        <div class="input-group">
            <label>Contraseña</label>
            <input type="password" name="password" required>
        </div>

        <div class="checkbox">
            <input type="checkbox" required>
            <span>Acepto los términos y condiciones</span>
        </div>

        <button type="submit" class="btn">Registrarme</button>

        <p class="switch">¿Ya tienes una cuenta?
            <a href="login.php">Inicia Sesión</a>
        </p>

    </form>
</div>

</body>
</html>
