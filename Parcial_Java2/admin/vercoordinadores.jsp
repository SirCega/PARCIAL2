<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %>   
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta name="Description" content="Enter your description here"/>
<title>Sistema Universitario</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fontawesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="Css/administracion.css">
</head>
<body id="index-body">
<header class="encabezado" id="index-encabezado">
    <h1>Programación Java</h1>
    <p>Sistema Universitario</p>
</header>

<div class="card-container">
    <div class="card" id="mostrar9-card">
        <div class="content" id="mostrar9-content">
            <div class="heading">Coordinadores</div>
            <br>    

            <!-- Consulta a la base de datos para obtener los usuarios con id_rol = 2 -->
            <sql:query var="result" dataSource="${proyectos}">
                SELECT id_usuario, nombre, correo FROM usuarios WHERE id_rol = 2;
            </sql:query>

            <!-- Tabla para mostrar los resultados -->
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Identificación</th>
                        <th>Nombre</th>
                        <th>Correo Electrónico</th>
                        <th colspan="2">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Iteración sobre los resultados obtenidos de la consulta -->
                    <c:forEach var="fila" items="${result.rows}">
                        <tr>
                            <td><c:out value="${fila.id_usuario}" /></td>
                            <td><c:out value="${fila.nombre}" /></td>
                            <td><c:out value="${fila.correo}" /></td>
                            <td>
                                <a href="editarCoordinador.jsp?id=${fila.id_usuario}">
                                    <input type="submit" class="btn btn-primary" value="Editar" />
                                </a>
                            </td>
                            <td>
                                <a href="eliminarCoordinador.jsp?id=${fila.id_usuario}">
                                    <input type="submit" class="btn btn-danger" value="Eliminar" />
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
                                            <a href="admin.html" class="btn btn-primary">Volver</a>

            <br>
        </div>
    </div>
</div>

<footer class="footer" id="index-footer">
    <div class="container">
        <p>&copy; 2024 Programación en Java. Todos los derechos reservados.</p>
    </div>
</footer>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>
