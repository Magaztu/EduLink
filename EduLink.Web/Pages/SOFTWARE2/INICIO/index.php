<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>EduLink - Aprende sin límites</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<!-- HEADER -->
<header class="header">
    <div class="logo">
    <img src="/SOFTWARE2/Imagenes/Logo.png" alt="Logo EduLink" class="logo-img">
    </div>


    <nav class="nav">
        <a href="#">Cursos</a>
        <a href="#">Categorías</a>
        <a href="#">Empresas</a>
        <a href="#sobre-nosotros">Sobre nosotros</a>
    </nav>

    <div class="auth">
        <a href="/SOFTWARE2/login.php" class="btn-login">Iniciar sesión</a>
    </div>
</header>

<!-- HERO SECTION -->
<section class="hero">
    <div class="hero-content">
        <h1>Aprende nuevas habilidades <br> desde cualquier lugar</h1>
        <p>Accede a miles de cursos online y mejora tu futuro profesional</p>

        <form class="search-box" action="/SOFTWARE2/cursos.php" method="GET">
    <input type="text" name="buscar" placeholder="¿Qué quieres aprender hoy?" required>
    <button type="submit">Buscar</button>
</form>

    </div>
</section>

<!-- CATEGORIES -->
<section class="categories">
    <h2>Categorías populares</h2>

    <div class="category-grid">
        <div class="card">💻 Programación</div>
        <div class="card">🎨 Diseño Gráfico</div>
        <div class="card">📈 Marketing Digital</div>
        <div class="card">📚 Desarrollo Personal</div>
        <div class="card">🤖 Inteligencia Artificial</div>
        <div class="card">📱 Desarrollo Móvil</div>
    </div>
</section>

<!-- FEATURED COURSES -->
<section class="courses">
    <h2>Cursos destacados</h2>

    <div class="course-grid">
        <div class="course-card">
            <h3>Curso de PHP desde 0</h3>
            <p>Aprende desarrollo web con PHP paso a paso.</p>
            <button>Ver curso</button>
        </div>

        <div class="course-card">
            <h3>HTML y CSS profesional</h3>
            <p>Domina el diseño de páginas web modernas.</p>
            <button>Ver curso</button>
        </div>

        <div class="course-card">
            <h3>JavaScript avanzado</h3>
            <p>Haz páginas interactivas y dinámicas.</p>
            <button>Ver curso</button>
        </div>
    </div>
</section>

<section id="sobre-nosotros" class="about">
    <div class="about-container">
        <div class="about-text">
            <h2>Sobre nosotros</h2>
            <p>
                Somos un grupo de estudiantes universitarios de la Universidad ECOTEC, 
                actualmente cursando el sexto semestre, quienes desarrollaron este proyecto 
                como parte de nuestra formación académica. Nuestro objetivo es crear una 
                plataforma innovadora que facilite el acceso a la educación digital y 
                potencie el aprendizaje mediante la tecnología.
            </p>
            
        </div>

        <div class="about-image">
            <img src="/SOFTWARE2/Imagenes/Dueños.jpg" alt="Equipo de desarrollo">
        </div>
    </div>
</section>

<!-- CTA FINAL -->
<section class="cta">
    <h2>Empieza hoy tu camino de aprendizaje</h2>
    <a href="/SOFTWARE2/registro.php" class="btn-cta">Crear cuenta gratis</a>
</section>

<!-- FOOTER -->
<footer class="footer">
    <p>© 2025 EduLink - Plataforma de aprendizaje online</p>
</footer>

</body>
</html>

