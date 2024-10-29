<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %> <!-- Incluir la conexión -->

<!-- Verificar si se ha recibido el parámetro id del coordinador -->
<c:if test="${param.id != null}">
    <!-- Iniciar transacción para eliminar al coordinador, sus ideas y anteproyectos asociados -->
    <sql:transaction dataSource="${proyectos}">
        
        <!-- Eliminar los anteproyectos asociados a las ideas de proyecto del coordinador -->
        <sql:update var="deleteAnteproyectos">
            DELETE FROM anteproyectos 
            WHERE id_idea_proyecto IN (
                SELECT id FROM ideasproyecto WHERE id_coordinador = ?
            );
            <sql:param value="${param.id}" />
        </sql:update>

        <!-- Eliminar las ideas de proyecto asociadas al coordinador -->
        <sql:update var="deleteIdeas">
            DELETE FROM ideasproyecto WHERE id_coordinador = ?
            <sql:param value="${param.id}" />
        </sql:update>

        <!-- Eliminar al coordinador -->
        <sql:update var="deleteCoordinador">
            DELETE FROM usuarios WHERE id_usuario = ?
            <sql:param value="${param.id}" />
        </sql:update>
    </sql:transaction>

    <!-- Verificar si la eliminación fue exitosa -->
    <c:if test="${deleteCoordinador == 1}">
        <script>
            alert("Coordinador, sus ideas de proyecto y anteproyectos asociados eliminados exitosamente.");
            window.location.href = 'vercoordinadores.jsp'; <!-- Redirigir a vercoordinadores.jsp -->
        </script>
    </c:if>

    <!-- Si no se eliminó el coordinador -->
    <c:if test="${deleteCoordinador != 1}">
        <script>
            alert("Error al eliminar el coordinador.");
            window.location.href = 'vercoordinadores.jsp'; <!-- Redirigir a vercoordinadores.jsp -->
        </script>
    </c:if>
</c:if>
