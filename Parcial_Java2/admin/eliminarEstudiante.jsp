<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %> <!-- Incluir la conexión -->

<!-- Verificar si se ha recibido el parámetro id del estudiante -->
<c:if test="${param.id != null}">
    <!-- Iniciar transacción para verificar si el estudiante está asociado a un anteproyecto -->
    <sql:transaction dataSource="${proyectos}">
        <!-- Verificar si el estudiante tiene algún anteproyecto asignado -->
        <sql:query var="anteproyectoEstudiante">
            SELECT COUNT(*) AS total FROM anteproyectos WHERE id_estudiante = ?
            <sql:param value="${param.id}" />
        </sql:query>
        
        <!-- Si el estudiante tiene un anteproyecto -->
        <c:if test="${anteproyectoEstudiante.rows[0].total > 0}">
            <!-- Actualizar la tabla anteproyectos estableciendo id_estudiante en NULL para eliminar al estudiante -->
            <sql:update var="updateAnteproyecto">
                UPDATE anteproyectos 
                SET id_estudiante = NULL 
                WHERE id_estudiante = ?
                <sql:param value="${param.id}" />
            </sql:update>
        </c:if>

        <!-- Eliminar al estudiante de la tabla usuarios -->
        <sql:update var="deleteEstudiante">
            DELETE FROM usuarios WHERE id_usuario = ?
            <sql:param value="${param.id}" />
        </sql:update>
    </sql:transaction>

    <!-- Verificar si la eliminación del estudiante fue exitosa -->
    <c:choose>
        <c:when test="${deleteEstudiante == 1}">
            <script>
                alert("Estudiante eliminado exitosamente.");
                window.location.href = 'verEstudiantes.jsp'; 
            </script>
        </c:when>
        <c:otherwise>
            <script>
                alert("Error al eliminar el estudiante.");
                window.location.href = 'verEstudiantes.jsp';
            </script>
        </c:otherwise>
    </c:choose>
</c:if>
