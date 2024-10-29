<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calendario Académico</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="CSS/calendario.css">
</head>
<body>

    <div class="container mt-5">
        <h1 class="text-center">Calendario Académico</h1>
        <p class="text-center mb-4">Aquí puedes ver y descargar el calendario académico oficial.</p>

        <!-- Contenedor para mostrar el PDF -->
        <div class="pdf-container">
            <object data="URL_DEL_PDF" type="application/pdf" width="100%" height="600px">
                <p>Tu navegador no puede mostrar el PDF. Puedes <a href="https://www.uts.edu.co/sitio/wp-content/uploads/2019/10/ACUERDO-No-03-045-CALENDARIO-ACADEMICO-MODALIDAD-PRESENCIAL-I-SEMESTRE-2025.pdf" target="_blank">descargarlo aquí</a>.</p>
            </object>
        </div>

        <div class="text-center mt-4">
            <a href="coordinador.html"  class="btn btn-primary">Volver a Coordinador</a>
        </div>
    </div>
<footer class="footer">
        <p>&copy; 2024 Proyectos de Grado. Todos los derechos reservados.</p>
      </footer>
</body>
</html>
