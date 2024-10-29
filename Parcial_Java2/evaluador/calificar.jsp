<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%@ include file="../WEB-INF/jspf/conexion.jspf" %>
    <link rel="stylesheet" href="Css/caliactu.css">

<!-- Obtener parámetros de la URL -->
<c:set var="idVersion" value="${param.idVersion}" />
<c:set var="idEstudiante" value="${param.idEstudiante}" />
<c:set var="idEvaluador" value="${sessionScope.idUsuario}" />

<!-- Consulta para verificar si ya existe una calificación -->
<sql:query var="calificacionExistente" dataSource="${proyectos}">
    SELECT calificacion 
    FROM calificaciones 
    WHERE id_version_c = ? AND id_estudiante = ?;
    <sql:param value="${idVersion}" />
    <sql:param value="${idEstudiante}" />
</sql:query>

<!-- Comprobar si existe una calificación -->
<c:choose>
    <c:when test="${not empty calificacionExistente.rows}">
        <c:set var="calificacion" value="${calificacionExistente.rows[0].calificacion}" />
        <p>Ya existe una calificación para esta versión: <strong>${calificacion}</strong></p>
        <a href="verAnteproyectos.jsp" class="btn btn-secondary">Volver</a>

    </c:when>
    <c:otherwise>
        <form action="insertarCalificacion.jsp" method="post">
            <input type="hidden" name="idVersion" value="${idVersion}" />
            <input type="hidden" name="idEstudiante" value="${idEstudiante}" />
            <input type="hidden" name="idEvaluador" value="${idEvaluador}" />
            
            <div>
                <label for="calificacion">Calificación:</label>
                <input type="number" name="calificacion" id="calificacion" min="0" max="5" required />
            </div>

            <div>
                <button type="submit">Guardar Calificación</button>
            </div>
        </form>
    </c:otherwise>
</c:choose>
