<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %>

<!-- Obtener el ID del director logueado desde la sesión -->
<c:set var="idDirector" value="${sessionScope.idUsuario}" />

<!-- Consultar los estudiantes asignados al director -->
<sql:query var="estudiantesAsignados" dataSource="${proyectos}">
    SELECT 
        u.id_usuario,
        u.nombre,
        u.correo
    FROM 
        usuarios u
    INNER JOIN 
        anteproyectos ap ON u.id_usuario = ap.id_estudiante
    WHERE 
        ap.id_director = ? AND u.id_rol = 5; 
    <sql:param value="${idDirector}" />
</sql:query>
        <link rel="stylesheet" href="Css/datosestudiante.css">
<div class="back-to-login">
    <a href="director.html" class="btn-back">Volver a Administrador</a>
</div>
<!-- Estilos CSS personalizados -->


<!-- Diseño de la página -->
<div class="container">
    <div class="row justify-content-center">
        <div class="col-12 text-center">
            <h1>Estudiantes Asignados</h1>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-12">
            <table class="table table-bordered text-center">
                <thead>
                    <tr>
                        <th>ID Estudiante</th>
                        <th>Nombre</th>
                        <th>Correo</th>
                    </tr>
                </thead>
                  <footer class="footer">
            <p>&copy; 2024 Proyectos de Grado. Todos los derechos reservados.</p>
          </footer>
                <tbody>
                    <c:if test="${not empty estudiantesAsignados.rows}">
                        <c:forEach var="estudiante" items="${estudiantesAsignados.rows}">
                            <tr>
                                <td>${estudiante.id_usuario}</td>
                                <td>${estudiante.nombre}</td>
                                <td>${estudiante.correo}</td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty estudiantesAsignados.rows}">
                        <tr>
                            <td colspan="3">No hay estudiantes asignados.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
