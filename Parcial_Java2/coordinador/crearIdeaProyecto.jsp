<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %> <!-- Incluir la conexión -->

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Idea de Proyecto</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="CSS/ideaproyecto.css">


</head>
<body>

   <div class="header">
    <h1>COORDINADOR</h1>
    <a href="coordinador.html" class="back-button">VOLVER</a>
</div>

    <!-- Consultar los usuarios con el rol de evaluador (id_rol = 4) -->
    <sql:query var="evaluadores" dataSource="${proyectos}">
        SELECT id_usuario, nombre FROM usuarios WHERE id_rol = 4;
    </sql:query>

    <!-- Contenedor del formulario -->
    <div class="form-container">
        <h2>CREA UNA IDEA DE PROYECTO</h2>

        <!-- Formulario para crear idea de proyecto -->
        <form action="procesarIdeaProyecto.jsp" method="POST">
            <!-- Campo para el título -->
            <div class="form-group">
                <label for="titulo">TÍTULO</label>
                <input type="text" class="form-control" id="titulo" name="titulo" placeholder="Ingresa un título" required>
            </div>

            <!-- Campo para la descripción -->
            <div class="form-group">
                <label for="descripcion">DESCRIPCIÓN</label>
                <textarea class="form-control" id="descripcion" name="descripcion" rows="3" placeholder="Ingresa una descripción" required></textarea>
            </div>

            <!-- Campo para seleccionar evaluador -->
            <div class="form-group">
                <label for="evaluator">EVALUADOR</label>
                <select class="form-control" id="evaluator" name="evaluator" required>
                    <option value="">Asigne un evaluador</option>
                    <!-- Llenar dinámicamente el select con los evaluadores de la base de datos -->
                    <c:forEach var="evaluador" items="${evaluadores.rows}">
                        <option value="${evaluador.id_usuario}">${evaluador.nombre}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Botón para crear la idea -->
            <div class="text-center">
                <button type="submit" class="btn btn-custom">CREAR</button>
            </div>
        </form>
    </div>
 <footer class="footer">
        <p>&copy; 2024 Proyectos de Grado. Todos los derechos reservados.</p>
      </footer>
</body>
</html>
