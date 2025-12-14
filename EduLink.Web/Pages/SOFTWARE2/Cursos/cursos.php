<?php
$buscar = $_GET['buscar'] ?? '';

$cursos = [
    [
        "titulo" => "Curso de PHP desde 0",
        "descripcion" => "Aprende desarrollo web con PHP paso a paso.",
        "categoria" => "Programacion"
    ],
    [
        "titulo" => "HTML y CSS profesional",
        "descripcion" => "Domina el diseño de páginas web modernas.",
        "categoria" => "Programacion"
    ],
    [
        "titulo" => "JavaScript avanzado",
        "descripcion" => "Crea sitios web interactivos y dinámicos.",
        "categoria" => "Programacion"
    ],
    [
        "titulo" => "Marketing Digital",
        "descripcion" => "Estrategias para crecer en redes y ventas.",
        "categoria" => "Marketing"
    ],
    [
        "titulo" => "Diseño Gráfico",
        "descripcion" => "Aprende diseño visual profesional.",
        "categoria" => "Diseño"
    ],
    [
        "titulo" => "Inteligencia Artificial",
        "descripcion" => "Introducción al mundo de la IA.",
        "categoria" => "Tecnología"
    ]
];
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Resultados | EduLink</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f7fa;
            margin: 0;
        }

        .container {
            padding: 40px;
            max-width: 1200px;
            margin: auto;
        }

        h2 {
            margin-bottom: 25px;
        }

        .course-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .course-card {
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.08);
            transition: transform 0.3s ease;
        }

        .course-card:hover {
            transform: translateY(-6px);
        }

        .course-card h3 {
            margin: 0 0 10px;
        }

        .course-card p {
            color: #555;
        }

        .course-card span {
            display: inline-block;
            margin-top: 10px;
            font-size: 13px;
            color: #007bff;
        }

        .course-card button {
            margin-top: 15px;
            padding: 10px;
            width: 100%;
            border: none;
            border-radius: 8px;
            background: #007bff;
            color: #fff;
            cursor: pointer;
        }

        .course-card button:hover {
            background: #0056b3;
        }

        .no-results {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Resultados para: "<strong><?php echo htmlspecialchars($buscar); ?></strong>"</h2>

    <div class="course-grid">
        <?php
        $encontrado = false;

        foreach ($cursos as $curso) {
            if (
                stripos($curso['titulo'], $buscar) !== false ||
                stripos($curso['categoria'], $buscar) !== false
            ) {
                $encontrado = true;
                ?>
                <div class="course-card">
                    <h3><?php echo $curso['titulo']; ?></h3>
                    <p><?php echo $curso['descripcion']; ?></p>
                    <span>📂 <?php echo $curso['categoria']; ?></span>
                    <button>Ver curso</button>
                </div>
                <?php
            }
        }

        if (!$encontrado) {
            echo "<div class='no-results'>❌ No se encontraron cursos.</div>";
        }
        ?>
    </div>
</div>

</body>
</html>
