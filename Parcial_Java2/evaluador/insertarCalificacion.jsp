<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %> <!-- Incluir la conexión -->

<!-- Obtener los valores enviados por el formulario -->
<c:set var="idEstudiante" value="${param.idEstudiante}" />
<c:set var="idVersion" value="${param.idVersion}" />
<c:set var="calificacion" value="${param.calificacion}" />

<!-- Obtener el ID del evaluador logueado (asumiendo que el evaluador está logueado) -->
<c:set var="idEvaluador" value="${sessionScope.idUsuario}" />

<!-- Insertar la calificación en la tabla 'calificaciones' -->
<sql:update var="resultado" dataSource="${proyectos}">
    INSERT INTO calificaciones (id_estudiante, id_evaluador, id_version_c, calificacion, fecha_calificacion)
    VALUES (?, ?, ?, ?, CURRENT_DATE);
    <sql:param value="${idEstudiante}" />
    <sql:param value="${idEvaluador}" />
    <sql:param value="${idVersion}" />
    <sql:param value="${calificacion}" />
</sql:update>

<c:if test="${resultado > 0}">
    <p>Calificación insertada correctamente.</p>
</c:if>
<c:if test="${resultado == 0}">
    <p>Error al insertar la calificación.</p>
</c:if>

<!-- Botón para volver -->
<a href="verAnteproyectos.jsp" class="btn btn-secondary">Volver</a>
