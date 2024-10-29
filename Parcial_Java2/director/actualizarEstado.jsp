<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %> <!-- Incluir la conexión -->

<!-- Obtener el ID de la versión de anteproyecto y el nuevo estado desde el formulario -->
<c:set var="idVersion" value="${param.idVersion}" /> 
<c:set var="nuevoEstado" value="${param.estado}" />

<c:if test="${not empty idVersion && not empty nuevoEstado}">
    <!-- Actualizar el estado de la versión -->
    <sql:update var="updateEstado" dataSource="${proyectos}">
        UPDATE versionesanteproyecto 
        SET estado_director = ?
        WHERE id_version = ? 
        <sql:param value="${nuevoEstado}" />
        <sql:param value="${idVersion}" /> 
    </sql:update>

    <c:if test="${updateEstado > 0}">
        <c:set var="mensaje" value="Estado actualizado con éxito." />
        
        <!-- Verificar si hay alguna versión del anteproyecto con estado_director = 'Aprobado' -->
        <sql:query var="checkAprobado" dataSource="${proyectos}">
            SELECT COUNT(*) AS cantidad 
            FROM versionesanteproyecto 
            WHERE estado_director = 'Aprobado' 
            AND id_anteproyecto = (SELECT id_anteproyecto FROM versionesanteproyecto WHERE id_version = ?);
            <sql:param value="${idVersion}" />
        </sql:query>

        <c:if test="${checkAprobado.rows[0].cantidad > 0}">
            <!-- Actualizar el campo aprobado_director en anteproyectos a 'Aprobado' -->
            <sql:update var="updateAprobado" dataSource="${proyectos}">
                UPDATE anteproyectos 
                SET aprobado_director = 'Aprobado' 
                WHERE id = (SELECT id_anteproyecto FROM versionesanteproyecto WHERE id_version = ?);
                <sql:param value="${idVersion}" />
            </sql:update>
        </c:if>

        <c:if test="${checkAprobado.rows[0].cantidad == 0}">
            <!-- Si no hay versiones aprobadas, dejar en 'Pendiente' -->
            <sql:update var="updatePendiente" dataSource="${proyectos}">
                UPDATE anteproyectos 
                SET aprobado_director = 'Pendiente' 
                WHERE id = (SELECT id_anteproyecto FROM versionesanteproyecto WHERE id_version = ?);
                <sql:param value="${idVersion}" />
            </sql:update>
        </c:if>
        
    </c:if>
    <c:if test="${updateEstado == 0}">
        <c:set var="mensaje" value="Error al actualizar el estado. Verifica el ID de la versión." />
    </c:if>
</c:if>

<c:if test="${empty idVersion || empty nuevoEstado}">
    <c:set var="mensaje" value="Parámetros inválidos." />
</c:if>

<!-- Mostrar mensaje si existe -->
<c:if test="${not empty mensaje}">
    <div class="alert alert-info">${mensaje}</div>
</c:if>

<!-- Botón para volver -->
<div>
    <a href="verAnteproyectos.jsp" class="btn btn-secondary">Volver</a>
</div>
