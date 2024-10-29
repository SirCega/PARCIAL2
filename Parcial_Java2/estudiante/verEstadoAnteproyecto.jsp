<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %> <!-- Incluir la conexión -->

<!-- Obtener el ID del estudiante logueado -->
<c:set var="idEstudiante" value="${sessionScope.idUsuario}" />

<!-- Consulta para obtener los detalles del proyecto, versión y calificación -->
<sql:query var="datosProyecto" dataSource="${proyectos}">
    SELECT ap.titulo, 
           va.titulo_anteproyecto, 
           va.enlace_url, 
           ap.id_director,
           ap.id_evaluador,
           va.estado_director,  
           va.estado_evaluador,  
           c.calificacion  
    FROM anteproyectos ap
    LEFT JOIN versionesanteproyecto va ON ap.id = va.id_anteproyecto
    LEFT JOIN calificaciones c ON va.id_version = c.id_version_c 
    WHERE ap.id_estudiante = ?;
    <sql:param value="${idEstudiante}" />
</sql:query>

<!-- Estilos CSS personalizados -->
    <link rel="stylesheet" href="Css/verestado.css">


<!-- Diseño de la página -->
<div class="container">
    <div class="row justify-content-center">
        <div class="col-12 text-center">
            <h1>Detalles del Proyecto y Versión</h1>
        </div>
       <div class="text-center mb-4">
    <a href="estudiante.html" class="btn btn-secondary btn-lg">Volver a estudiante</a>
</div>
    </div>

    <div class="row justify-content-center">
        <div class="col-12">
            <table class="table table-bordered text-center">
                <thead>
                    <tr>
                        <th>Título de la Idea</th>
                        <th>Título del Anteproyecto</th>
                        <th>Enlace</th>
                        <th>Director Asignado</th>
                        <th>Estado del Director</th>
                        <th>Evaluador Asignado</th>
                        <th>Estado del Evaluador</th>
                        <th>Calificación</th> 
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="proyecto" items="${datosProyecto.rows}">
                        <tr>
                            <td>${proyecto.titulo}</td>
                            <td>${proyecto.titulo_anteproyecto}</td>
                            <td><a href="${proyecto.enlace_url}" target="_blank">Ver enlace</a></td>

                            <!-- Consulta para obtener el nombre del director -->
                            <sql:query var="nombreDirector" dataSource="${proyectos}">
                                SELECT nombre FROM usuarios WHERE id_usuario = ?;
                                <sql:param value="${proyecto.id_director}" />
                            </sql:query>

                            <td><c:out value="${nombreDirector.rows[0].nombre}"/></td>
                            <td>${proyecto.estado_director}</td> <!-- Usar estado_director en lugar de aprobado_director -->

                            <!-- Consulta para obtener el nombre del evaluador -->
                            <sql:query var="nombreEvaluador" dataSource="${proyectos}">
                                SELECT nombre FROM usuarios WHERE id_usuario = ?;
                                <sql:param value="${proyecto.id_evaluador}" />
                            </sql:query>

                            <td><c:out value="${nombreEvaluador.rows[0].nombre}"/></td>
                            <td>${proyecto.estado_evaluador}</td> <!-- Usar estado_evaluador en lugar de aprobado_evaluador -->
                            <td>${proyecto.calificacion}</td> 
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
