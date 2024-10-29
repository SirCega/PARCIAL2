<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="WEB-INF/jspf/conexion.jspf" %>

<!-- Verifica que los parámetros userId y password están presentes -->
<c:if test="${empty param.userId || empty param.password}">
    <c:redirect url="login.jsp?error=true&message=missingParams" />
</c:if>

<!-- Conexión a la base de datos y validación de login -->
<sql:query var="user" dataSource="${proyectos}">
    SELECT * FROM usuarios WHERE id_usuario = ? AND password = ?;
    <sql:param value="${param.userId}" />
    <sql:param value="${param.password}" />
</sql:query>

<!-- Redireccionamiento según el rol -->
<c:choose>
    <c:when test="${not empty user.rows}">
        <c:set var="idUsuario" value="${user.rows[0].id_usuario}" scope="session" />
        <c:set var="idRol" value="${user.rows[0].id_rol}" scope="session" />

        <c:choose>
            <c:when test="${idRol == 1}">
                <c:redirect url="admin/admin.html" />
            </c:when>
            <c:when test="${idRol == 2}">
                <c:redirect url="coordinador/coordinador.html" />
            </c:when>
            <c:when test="${idRol == 3}">
                <c:redirect url="director/director.html" />
            </c:when>
            <c:when test="${idRol == 4}">
                <c:redirect url="evaluador/evaluador.html" />
            </c:when>
            <c:when test="${idRol == 5}">
                <c:redirect url="estudiante/estudiante.html" />
            </c:when>
            <c:otherwise>
                <c:redirect url="login.jsp?error=true&message=invalidRole" />
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <!-- Si no se encuentra el usuario, redirigir al login con un error de credenciales -->
        <c:redirect url="login.jsp?error=true&message=invalidCredentials" />
    </c:otherwise>
</c:choose>
