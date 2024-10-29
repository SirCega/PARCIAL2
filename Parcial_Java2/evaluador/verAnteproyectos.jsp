<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %>

<!-- Obtener el ID del evaluador logueado -->
<c:set var="idEvaluador" value="${sessionScope.idUsuario}" />

<!-- Consulta para obtener las versiones aprobadas por el director -->
<sql:query var="versionesAprobadas" dataSource="${proyectos}">
    SELECT va.id_version, 
           va.titulo_anteproyecto, 
           va.enlace_url, 
           va.estado_director, 
           va.estado_evaluador, 
           va.id_anteproyecto,
           ap.id_estudiante
    FROM versionesanteproyecto va
    LEFT JOIN anteproyectos ap ON va.id_anteproyecto = ap.id
    WHERE va.estado_director = 'Aprobado' 
      AND ap.id_evaluador = ?;
    <sql:param value="${idEvaluador}" />
</sql:query>
    <link rel="stylesheet" href="Css/verante.css">



<div class="container">
<div class="d-flex justify-content-end">
        <a href="evaluador.html" class="btn btn-primary mb-4">Regresar</a>
    </div>
    <div class="row justify-content-center">
        <div class="col-12 text-center">
            <h1>Anteproyectos Aprobados</h1>

        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-12">
            <table class="table table-bordered text-center">
                <thead>
                    <tr>
                        <th>Título del Anteproyecto</th>
                        <th>Enlace</th>
                        <th>Cambiar Estado</th>
                        <th>Estado Actual</th> <!-- Nueva columna para mostrar el estado -->
                        <th>Calificar</th>
                    </tr>
                    
                </thead>

                <tbody>
                    <c:if test="${not empty versionesAprobadas.rows}">
                        <c:forEach var="version" items="${versionesAprobadas.rows}">
                            <tr>
                                <td>${version.titulo_anteproyecto}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty version.enlace_url}">
                                            <a href="${version.enlace_url}" target="_blank">Ver enlace</a>
                                        </c:when>
                                        <c:otherwise>
                                            No disponible
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <form action="actualizarEstadoEvaluador.jsp" method="post">
                                        <input type="hidden" name="idVersion" value="${version.id_version}" />
                                        <select name="estadoEvaluador" class="form-control" onchange="this.form.submit()">
                                            <option value="Pendiente">Pendiente</option>
                                            <option value="Aprobado">Aprobado</option>
                                            <option value="No Aprobado">No Aprobado</option>
                                        </select>
                                    </form>
                                </td>
                                <td>${version.estado_evaluador}</td> <!-- Mostrar el estado actual -->
                                <td>
<a href="calificar.jsp?idVersion=${version.id_version}&idEstudiante=${version.id_estudiante}" class="btn btn-success">Calificar</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty versionesAprobadas.rows}">
                        <tr>
                            <td colspan="5">No hay versiones aprobadas por el director.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
