<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %> <!-- Incluir la conexión -->

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proyectos Disponibles</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="Css/ideadeproyecto.css">
</head>
<body>
    <div class="header">
        <h1>Proyectos Disponibles</h1>
        <a href="estudiante.html" class="btn btn-back">Volver</a>
    </div>

    <div class="container">
        <!-- Consultar si el id_usuario logueado ya está en id_estudiante -->
        <c:set var="id_estudiante" value="${sessionScope.idUsuario}" />
        <sql:query var="verificarEstudiante" dataSource="${proyectos}">
            SELECT COUNT(*) AS cantidad 
            FROM anteproyectos 
            WHERE id_estudiante = ?;
            <sql:param value="${id_estudiante}" />
        </sql:query>

        <c:choose>
            <c:when test="${verificarEstudiante.rows[0].cantidad > 0}">
                <h3 class="alert alert-warning">Ya escogió un proyecto. Suba su anteproyecto.</h3>
                <a href="subirAnteProyecto.jsp" class="btn btn-primary">Subir Anteproyecto</a>
            </c:when>
            <c:otherwise>
                <h2>Proyectos Disponibles</h2>
                <div class="table-container">
                    <table class="table table-bordered text-center">
                        <thead>
                            <tr>
                                <th>Título</th>
                                <th>Descripción</th>
                                <th>Evaluador</th>
                                <th>Director</th>
                                <th>Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <sql:query var="proyectosDisponibles" dataSource="${proyectos}">
                                SELECT ip.id, ip.titulo, ip.descripcion, ip.num_estudiantes, ap.id_evaluador, ap.id_director
                                FROM ideasproyecto ip
                                LEFT JOIN anteproyectos ap ON ip.id = ap.id_idea_proyecto;
                            </sql:query>

                            <c:forEach var="proyecto" items="${proyectosDisponibles.rows}">
                                <tr>
                                    <td>${proyecto.titulo}</td>
                                    <td>${proyecto.descripcion}</td>

                                    <!-- Consulta para obtener el nombre del evaluador -->
                                    <sql:query var="buscarEvaluador" dataSource="${proyectos}">
                                        SELECT nombre 
                                        FROM usuarios 
                                        WHERE id_usuario = ?;
                                        <sql:param value="${proyecto.id_evaluador}" />
                                    </sql:query>

                                    <td>
                                        <c:if test="${not empty buscarEvaluador.rows}">
                                            <c:out value="${buscarEvaluador.rows[0].nombre}" />
                                        </c:if>
                                        <c:if test="${empty buscarEvaluador.rows}">
                                            No asignado
                                        </c:if>
                                    </td>

                                    <!-- Consulta para obtener el nombre del director -->
                                    <sql:query var="buscarDirector" dataSource="${proyectos}">
                                        SELECT nombre 
                                        FROM usuarios 
                                        WHERE id_usuario = ?;
                                        <sql:param value="${proyecto.id_director}" />
                                    </sql:query>

                                    <td>
                                        <c:if test="${not empty buscarDirector.rows}">
                                            <c:out value="${buscarDirector.rows[0].nombre}" />
                                        </c:if>
                                        <c:if test="${empty buscarDirector.rows}">
                                            No asignado
                                        </c:if>
                                    </td>

                                    <!-- Verificar si el proyecto está disponible -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${proyecto.num_estudiantes >= 2}">
                                                <span class="text-danger">No disponible</span>
                                            </c:when>
                                            <c:otherwise>
                                                <form action="tuAccion.jsp" method="post">
                                                    <input type="hidden" name="id_idea_proyecto" value="${proyecto.id}" /> 
                                                    <button type="submit" class="btn btn-custom">Elegir</button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
