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
    <link rel="stylesheet" href="Css/subir.css">

</head>
<body>

    <!-- Encabezado con botón para volver -->
    <div class="header">
        <div>ESTUDIANTE</div>
        <a href="estudiante.html">VOLVER</a>
    </div>

    
    <!-- Contenedor del formulario -->
    <div class="form-container">
        <h2>SUBIR UN ANTEPROYECTO</h2>

        <!-- Formulario para crear idea de proyecto -->
        <form action="procesarsubidaAnteproyecto.jsp" method="POST">
            <!-- Campo para el título -->
            <div class="form-group">
                <label for="titulo">TÍTULO</label>
                <input type="text" class="form-control" id="titulo" name="titulo" placeholder="Ingresa un título" required>
            </div>

            <!-- Nuevo campo para la URL -->
            <div class="form-group">
                <label for="urlAnteproyecto">URL DEL ANTEPROYECTO</label>
                <input type="url" class="form-control" id="url" name="url" placeholder="Ingresa la URL del anteproyecto" required>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-custom">SUBIR</button>
            </div>
        </form>
    </div>

</body>
</html>
