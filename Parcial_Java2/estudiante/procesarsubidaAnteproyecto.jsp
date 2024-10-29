<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %> <!-- Incluir la conexión -->

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Procesar Subida de Anteproyecto</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Procesando Subida de Anteproyecto</h2>

        <!-- Obtener el id del usuario logueado -->
        <c:set var="id_estudiante" value="${sessionScope.idUsuario}" />

        <!-- Obtener el id del proyecto seleccionado (id_anteproyecto) -->
        <sql:query var="buscarAnteproyecto" dataSource="${proyectos}">
            SELECT id 
            FROM anteproyectos 
            WHERE id_estudiante = ?;
            <sql:param value="${id_estudiante}" />
        </sql:query>

        <c:choose>
            <c:when test="${not empty buscarAnteproyecto.rows}">
                <c:set var="id_anteproyecto" value="${buscarAnteproyecto.rows[0].id}" />

                <!-- Insertar el nuevo registro en la tabla versionesanteproyecto -->
                <sql:update var="insertVersion" dataSource="${proyectos}">
                    INSERT INTO versionesanteproyecto (id_anteproyecto, titulo_anteproyecto, enlace_url, fecha_subida, cambios)
                    VALUES (?, ?, ?, CURRENT_TIMESTAMP, NULL);
                    <sql:param value="${id_anteproyecto}" />
                    <sql:param value="${param.titulo}" /> 
                    <sql:param value="${param.url}" /> 
                </sql:update>

                <c:if test="${insertVersion > 0}">
                    <div class="alert alert-success">
                        <strong>Éxito!</strong> El anteproyecto ha sido subido correctamente.
                    </div>
                </c:if>
            </c:when>

            <c:otherwise>
                <div class="alert alert-danger">
                    <strong>Error!</strong> No se encontró el anteproyecto asociado al estudiante logueado.
                </div>
            </c:otherwise>
        </c:choose>

        <a href="estudiante.html" class="btn btn-primary mt-3">Volver</a>
    </div>

</body>
</html>
