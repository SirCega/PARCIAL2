<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %> <!-- Incluir la conexión -->

<!-- Obtener el ID del coordinador logueado desde la sesión -->
<c:set var="idCoordinador" value="${sessionScope.idUsuario}" />

<!-- Consultar las ideas de proyecto creadas por el coordinador logueado -->
<sql:query var="ideasProyecto" dataSource="${proyectos}">
    SELECT ip.id, ip.titulo, ip.descripcion, u.nombre , ap.aprobado_evaluador, ap.aprobado_director, ap.id_director 
    FROM ideasproyecto ip 
    LEFT JOIN anteproyectos ap ON ip.id = ap.id_idea_proyecto 
    LEFT JOIN usuarios u ON ap.id_evaluador = u.id_usuario
    WHERE ip.id_coordinador = ?
    ORDER BY ip.id;
    <sql:param value="${idCoordinador}" />
</sql:query>
    <link rel="stylesheet" href="CSS/verideas.css">


<div class="container">
    <button class="btn-back" onclick="window.location.href='coordinador.html'">Volver a Coordinador</button>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-12 text-center">
            <h1>Ideas de Proyectos</h1>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-12">
            <table class="table table-bordered text-center">
                <thead>
                    <tr>
                        <th>Título</th>
                        <th>Descripción</th>
                        <th>Evaluador</th>
                        <th>Estado del Evaluador</th>
                        <th>Director Asignado</th>
                        <th>Asignar Director</th>
                        <th>Estado del Director</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="idea" items="${ideasProyecto.rows}">
                        <tr>
                            <td>${idea.titulo}</td>
                            <td>${idea.descripcion}</td>

                            <!-- Mostrar el nombre del evaluador -->
                            <td>
                                <c:out value="${idea.nombre}" />
                            </td>

                            <td>${idea.aprobado_evaluador}</td>

                            <!-- Mostrar el nombre del director asignado si existe -->
                            <td>
                                <c:choose>
                                    <c:when test="${not empty idea.id_director}">
                                        <!-- Consultar el nombre del director asignado -->
                                        <sql:query var="nombreDirector" dataSource="${proyectos}">
                                            SELECT nombre FROM usuarios WHERE id_usuario = ?;
                                            <sql:param value="${idea.id_director}" />
                                        </sql:query>
                                        <c:out value="${nombreDirector.rows[0].nombre}" />
                                    </c:when>
                                    <c:otherwise>
                                        <span>No asignado</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <!-- Opción para asignar un director sin condiciones adicionales -->
                            <td>
                                <c:choose>
                                    <c:when test="${empty idea.id_director}">
                                        <form action="asignarDirector.jsp" method="post">
                                            <input type="hidden" name="idIdea" value="${idea.id}" />
                                            <select name="idDirector" class="form-control">
                                                <option value="" disabled selected>Asigne un director</option>
                                                <!-- Obtener los usuarios que tienen el rol de director (id_rol = 3) -->
                                                <sql:query var="directores" dataSource="${proyectos}">
                                                    SELECT id_usuario, nombre FROM usuarios WHERE id_rol = 3;
                                                </sql:query>
                                                <c:forEach var="director" items="${directores.rows}">
                                                    <option value="${director.id_usuario}">
                                                        ${director.nombre}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <button type="submit" class="btn btn-primary mt-2">Asignar</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <span>No disponible</span> <!-- Mensaje cuando no se puede asignar -->
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>${idea.aprobado_director}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
 <footer class="footer">
        <p>&copy; 2024 Proyectos de Grado. Todos los derechos reservados.</p>
      </footer>