<?php
// Aquí normalmente guardarías en la BD.
// Pero por ahora simulamos que todo salió bien.

// Mensaje de éxito + redirección al login
echo "
<!DOCTYPE html>
<html lang='es'>
<head>
    <meta charset='UTF-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <title>Registro Exitoso</title>
    <style>
        body {
            background: #f7f3ff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial, sans-serif;
        }
        .box {
            background: white;
            padding: 40px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .box h2 {
            color: #4CAF50;
        }
        .box p {
            margin-top: 10px;
            font-size: 16px;
        }
    </style>

    <meta http-equiv='refresh' content='2;url=login.php'>
</head>
<body>

<div class='box'>
    <h2>¡Registro Exitoso!</h2>
    <p>Serás redirigido al inicio de sesión...</p>
</div>

</body>
</html>
";
?>
