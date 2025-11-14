<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduLink - Iniciar Sesión</title>
    <link rel="stylesheet" href="CSS/login.css">
</head>
<body>

<!-- NAV -->
<nav class="navbar">
    <ul>
        <li><a href="#">Home</a></li>
        <li><a href="#">Services</a></li>
        <li><a href="#">Contact</a></li>
        <li><a href="#">About</a></li>
    </ul>

    <div class="logo-nav">
        <img src="Imagenes/Logo.png" alt="">
    </div>
</nav>

<!-- LOGIN BOX -->
<div class="login-container">
    <div class="login-box">
        <h2>Iniciar Sesión</h2>

        <form action="dashboard.php" method="POST">
    <label>Correo</label>
    <input type="email" name="correo" placeholder="correo@example.com" required>

    <label>Contraseña</label>
    <input type="password" name="pass" placeholder="********" required>

    <div class="extras">
        <label><input type="checkbox"> Recuérdame</label>
        <a href="#">¿Olvidó su contraseña?</a>
    </div>

    <button type="submit">Iniciar Sesión</button>

    <p>¿No tienes una cuenta? <a href="registro.php">Registrarte</a></p>
</form>


    </div>
</div>

</body>
</html>
