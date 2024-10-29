<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %> <!-- Incluir la conexión -->

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actualizar Estudiante</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>



    <div class="container">
        <h2>Actualizar Estudiante en Anteproyecto</h2>

        <!-- Obtener el ID del proyecto y del estudiante -->
        <c:set var="id_proyecto" value="${param.id_idea_proyecto}" />
        <c:set var="id_estudiante" value="${sessionScope.idUsuario}" /> 
        

        <c:if test="${not empty id_proyecto and not empty id_estudiante}">
            <!-- Actualizar el campo id_estudiante en la tabla anteproyectos -->
            <sql:update var="updateAnteproyecto" dataSource="${proyectos}">
                UPDATE anteproyectos 
                SET id_estudiante = ? 
                WHERE id_idea_proyecto = ?;
                <sql:param value="${id_estudiante}" /> 
                <sql:param value="${id_proyecto}" />
            </sql:update>

            <!-- Si se actualizó correctamente el anteproyecto, incrementar num_estudiantes -->
            <c:if test="${updateAnteproyecto > 0}">
                <h3>Registro actualizado con éxito.</h3>

                <!-- Incrementar el campo num_estudiantes en la tabla ideasproyecto -->
                <sql:update var="updateNumEstudiantes" dataSource="${proyectos}">
                    UPDATE ideasproyecto 
                    SET num_estudiantes = num_estudiantes + 1 
                    WHERE id = ?;
                    <sql:param value="${id_proyecto}" />
                </sql:update>

                <!-- Mostrar un mensaje dependiendo de si se incrementó correctamente -->
                <c:choose>
                    <c:when test="${updateNumEstudiantes > 0}">
                        <h4>El número de estudiantes en el proyecto ha sido incrementado.</h4>
                    </c:when>
                    <c:otherwise>
                        <h4>No se pudo incrementar el número de estudiantes.</h4>
                    </c:otherwise>
                </c:choose>

            </c:if>

            <c:if test="${updateAnteproyecto == 0}">
                <h3>No se encontró el proyecto para actualizar.</h3>
            </c:if>
        </c:if>

        <c:if test="${empty id_proyecto or empty id_estudiante}">
            <h3>Faltan parámetros necesarios para la actualización.</h3>
        </c:if>

        <!-- Botón para volver a la página anterior -->
        <a href="seleccionarIdeaProyecto.jsp" class="btn btn-primary">Volver</a>
    </div>

</body>
</html>
