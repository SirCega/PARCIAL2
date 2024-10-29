<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buscar Estudiante</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="CSS/datosestu.css">
</head>
<body>

    <div class="container mt-5">
        <h1 class="text-center">DATOS DEL ESTUDIANTE</h1>

        <form method="get" action="verDatosEstudiante.jsp">
            <div class="form-group">
                <label for="id_estudiante">Ingrese la identificación del estudiante</label>
                <input type="text" class="form-control" id="id_estudiante" name="id_estudiante" placeholder="Ingrese una identificación" required>
            </div>
            <button type="submit" class="btn btn-primary">Enviar</button>
        </form>

        <c:if test="${not empty param.id_estudiante}">
            <div class="results-container">
                <sql:query var="buscarEstudiante" dataSource="${proyectos}">
                    SELECT 
                        u.nombre, 
                        u.correo, 
                        u.id_usuario, 
                        ap.titulo,  
                        ap.id_evaluador, 
                        ap.aprobado_evaluador, 
                        ap.id_director, 
                        ap.aprobado_director 
                    FROM 
                        usuarios u
                    LEFT JOIN 
                        anteproyectos ap ON u.id_usuario = ap.id_estudiante
                    WHERE 
                        u.id_usuario = ? AND u.id_rol = 5;
                    <sql:param value="${param.id_estudiante}" />
                </sql:query>

                <c:choose>
                    <c:when test="${not empty buscarEstudiante.rows}">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Nombre</th>
                                        <th>Correo</th>
                                        <th>Título del Anteproyecto</th>
                                        <th>Evaluador</th>
                                        <th>Estado Evaluador</th>
                                        <th>Director</th>
                                        <th>Estado Director</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="estudiante" items="${buscarEstudiante.rows}">
                                        <tr>
                                            <td>${estudiante.nombre}</td>
                                            <td>${estudiante.correo}</td>
                                            <td><c:out value="${estudiante.titulo != null ? estudiante.titulo : 'No asignado'}"/></td>

                                            <sql:query var="buscarEvaluador" dataSource="${proyectos}">
                                                SELECT nombre 
                                                FROM usuarios 
                                                WHERE id_usuario = ?;
                                                <sql:param value="${estudiante.id_evaluador}" />
                                            </sql:query>
                                            
                                            <td>
                                                <c:if test="${not empty buscarEvaluador.rows}">
                                                    <c:out value="${buscarEvaluador.rows[0].nombre}" />
                                                </c:if>
                                                <c:if test="${empty buscarEvaluador.rows}">
                                                    No asignado
                                                </c:if>
                                            </td>

                                            <td>
                                                <c:out value="${estudiante.aprobado_evaluador != null ? estudiante.aprobado_evaluador : 'No evaluado'}"/>
                                            </td>

                                            <sql:query var="buscarDirector" dataSource="${proyectos}">
                                                SELECT nombre 
                                                FROM usuarios 
                                                WHERE id_usuario = ?;
                                                <sql:param value="${estudiante.id_director}" />
                                            </sql:query>

                                            <td>
                                                <c:if test="${not empty buscarDirector.rows}">
                                                    <c:out value="${buscarDirector.rows[0].nombre}" />
                                                </c:if>
                                                <c:if test="${empty buscarDirector.rows}">
                                                    No asignado
                                                </c:if>
                                            </td>

                                            <td>
                                                <c:out value="${estudiante.aprobado_director != null ? estudiante.aprobado_director : 'No evaluado'}"/>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p>No se encontró el estudiante con el ID proporcionado.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Botón para volver al login, ubicado debajo de la información -->
            <div class="text-center mt-3">
                <a href="coordinador.html" class="btn btn-secondary">Volver a Administrador</a>
            </div>
        </c:if>
    </div>
 
    <footer class="footer">
        <p>&copy; 2024 Proyectos de Grado. Todos los derechos reservados.</p>
    </footer>

</body>
</html>
