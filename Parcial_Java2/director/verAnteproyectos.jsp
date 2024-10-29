<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %> <!-- Incluir la conexión -->

<!-- Obtener el ID del director logueado desde la sesión -->
<c:set var="idDirector" value="${sessionScope.idUsuario}" />

<!-- Consultar los proyectos asignados al director -->
<sql:query var="proyectosAsignados" dataSource="${proyectos}">
    SELECT ap.id , 
           u.nombre, 
           va.id_version,
           va.titulo_anteproyecto, 
           va.enlace_url, 
           ap.aprobado_director, 
           ap.titulo, 
           va.estado_director
    FROM anteproyectos ap
    LEFT JOIN usuarios u ON ap.id_estudiante = u.id_usuario
    LEFT JOIN versionesanteproyecto va ON ap.id = va.id_anteproyecto
    WHERE ap.id_director = ?;
    <sql:param value="${idDirector}" />
</sql:query>

        <link rel="stylesheet" href="Css/anteproyectos.css">

<div class="back-to-login">
    <a href="director.html" class="btn-back">Volver a Administrador</a>
</div>


<!-- Diseño de la página -->
<div class="container">
    <div class="row justify-content-center">
        <div class="col-12 text-center">
            <h1>Proyectos Asignados</h1>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-12">
            <table class="table table-bordered text-center">
                
                <thead>
    <tr>
        <th>Idea de Proyecto</th>
        <th>Estudiante</th>
        <th>Título del Anteproyecto</th>
        <th>Enlace</th>
        <th>ID de Anteproyecto</th> 
         <th>ID de Version</th>            
        <th>Cambiar Estado</th>
        <th>Estado Director</th>
    </tr>
     <footer class="footer">
            <p>&copy; 2024 Proyectos de Grado. Todos los derechos reservados.</p>
          </footer>
</thead>
<tbody>
    <c:if test="${not empty proyectosAsignados.rows}">
        <c:forEach var="proyecto" items="${proyectosAsignados.rows}">
            <tr>
                <td>${proyecto.titulo}</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty proyecto.nombre}">
                            <a href="verDatosEstudiante.jsp?idEstudiante=${proyecto.id}" class="btn btn-primary">
                                ${proyecto.nombre}
                            </a>
                        </c:when>
                        <c:otherwise>
                            No hay por el momento.
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${not empty proyecto.titulo_anteproyecto}">
                            ${proyecto.titulo_anteproyecto}
                        </c:when>
                        <c:otherwise>
                            No hay anteproyecto.
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${not empty proyecto.enlace_url}">
                            <a href="${proyecto.enlace_url}" target="_blank">Ver enlace</a>
                        </c:when>
                        <c:otherwise>
                            No disponible
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${not empty proyecto.id}">  
                            ${proyecto.id}
                        </c:when>
                        <c:otherwise>
                            No disponible
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                        <c:choose>
                        <c:when test="${not empty proyecto.id_version}">  
                            ${proyecto.id_version}
                        </c:when>
                        <c:otherwise>
                            No disponible
                        </c:otherwise>
                    </c:choose>                
                    
                </td>
                <td>
                    <c:choose>
                        <c:when test="${not empty proyecto.enlace_url}">
                            <form action="actualizarEstado.jsp" method="post">
                                <!-- Campo oculto para almacenar el ID de la versión -->
                                <input type="hidden" name="idVersion" value="${proyecto.id_version}" />
                                <select name="estado" class="form-control" onchange="this.form.submit()">
                                    <option value="Pendiente" ${proyecto.aprobado_director == 'Pendiente' ? 'selected' : ''}>Pendiente</option>
                                    <option value="No Aprobado" ${proyecto.aprobado_director == 'No Aprobado' ? 'selected' : ''}>No Aprobado</option>
                                    <option value="Aprobado" ${proyecto.aprobado_director == 'Aprobado' ? 'selected' : ''}>Aprobado</option>
                                </select>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <span>No se puede cambiar estado</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${not empty proyecto.estado_director}">
                            ${proyecto.estado_director}
                        </c:when>
                        <c:otherwise>
                            No disponible
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </c:if>
    <c:if test="${empty proyectosAsignados.rows}">
        <tr>
            <td colspan="7">No hay proyectos asignados.</td> <!-- Cambiar el colspan a 7 -->
        </tr>
    </c:if>
</tbody>

            </table>
        </div>
    </div>
</div>
