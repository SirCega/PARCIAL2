<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %> <!-- Incluir conexión a base de datos -->

<!-- Validar que el usuario tiene el rol de coordinador -->
<c:if test="${sessionScope.idRol == 2}">
    <!-- Verificar que se reciban los parámetros necesarios -->
    <c:if test="${param.idIdea != null && param.idDirector != null}">

        <!-- Realizar la actualización en la base de datos -->
        <sql:update var="actualizarDirector" dataSource="${proyectos}">
            UPDATE anteproyectos
            SET id_director = ?, aprobado_director = 'pendiente'
            WHERE id_idea_proyecto = ?;
            <sql:param value="${param.idDirector}" />
            <sql:param value="${param.idIdea}" />
        </sql:update>

        <!-- Verificar si la actualización fue exitosa -->
        <c:choose>
            <c:when test="${actualizarDirector >= 1}">
                <script>
                    alert("Director asignado exitosamente.");
                    window.location.href = 'verIdeasProyecto.jsp'; <!-- Redirige a la página principal -->
                </script>
            </c:when>
            <c:otherwise>
                <script>
                    alert("Error al asignar el director.");
                    window.location.href = 'verIdeasProyecto.jsp'; <!-- Redirige a la página principal -->
                </script>
            </c:otherwise>
        </c:choose>

    </c:if>

    <!-- Si faltan parámetros -->
    <c:if test="${param.idIdea == null || param.idDirector == null}">
        <script>
            alert("Faltan parámetros necesarios para asignar el director.");
            window.location.href = 'verIdeasProyecto.jsp'; <!-- Redirige a la página principal -->
        </script>
    </c:if>
</c:if>

<!-- Si el usuario no tiene el rol adecuado -->
<c:if test="${sessionScope.idRol != 2}">
    <script>
        alert("No tiene permisos para realizar esta acción.");
        window.location.href = '../login.jsp'; <!-- Redirige al login -->
    </script>
</c:if>
