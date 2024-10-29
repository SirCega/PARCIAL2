<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %> <!-- Incluir la conexión -->

<!-- Verificar si se ha recibido el parámetro id del director -->
<c:if test="${param.id != null}">
    <!-- Iniciar transacción para eliminar al director y sus anteproyectos asociados -->
    <sql:transaction dataSource="${proyectos}">


        <!-- Eliminar al director -->
        <sql:update var="deleteDirector">
           DELETE FROM usuarios WHERE id_usuario = ?
            <sql:param value="${param.id}" />
        </sql:update>
    </sql:transaction>

    <!-- Verificar si la eliminación fue exitosa -->
    <c:if test="${deleteDirector == 1}">
        <script>
            alert("Director eliminado exitosamente.");
            window.location.href = 'verDirectores.jsp'; <!-- Redirigir a verDirectores.jsp -->
        </script>
    </c:if>

    <!-- Si no se eliminó el director -->
    <c:if test="${deleteDirector != 1}">
        <script>
            alert("Error al eliminar el director.");
            window.location.href = 'verDirectores.jsp'; <!-- Redirigir a verDirectores.jsp -->
        </script>
    </c:if>
</c:if>
