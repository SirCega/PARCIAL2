<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Usuario</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitterbootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fontawesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="Css/agregarusuario.css">
</head>
<body>
<header class="encabezado" id="registro-encabezado">
    <h1>Registro de Usuarios</h1>
    <p>Agregar Nuevo Usuario</p>
    <button class="btn btn-back" onclick="window.location.href='admin.html'">Volver a Administrador</button> <!-- Botón para volver -->
</header>

<c:if test="${param.nombre == null}">
    <div class="form-ui">
        <form class="form needs-validation" id="registro-form" method="post">
            <div class="form-body">
                <div class="content" id="registro-content">
                    <div class="titulo-lines">
                        <div id="registro-titulo-line-1">Ingrese los datos del nuevo usuario</div>
                    </div>
                    <div class="input-area">
                        <div class="form-group">
                            <label for="nombre">Nombre</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ingrese el nombre" required>
                        </div>
                        <div class="form-group">
                            <label for="identificacion">Identificación</label>
                            <input type="text" class="form-control" id="identificacion" name="identificacion" placeholder="Ingrese la identificación" required>
                        </div>
                        <div class="form-group">
                            <label for="correo">Correo Electrónico</label>
                            <input type="email" class="form-control" id="correo" name="correo" placeholder="Ingrese el correo electrónico" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Contraseña</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Ingrese una contraseña" required>
                        </div>
                        <div class="form-group">
                            <label for="rol">Rol del Usuario</label>
                            <select class="form-control" id="rol" name="rol" required>
                                <option value="1">Administrador</option>
                                <option value="2">Coordinador</option>
                                <option value="3">Director</option>
                                <option value="4">Evaluador</option>
                                <option value="5">Estudiante</option>
                            </select>
                        </div>
                        <input type="submit" class="btn btn-success" value="Registrar" />
                    </div>
                </div>
            </div>
        </form>
    </div>
</c:if>

<c:if test="${param.nombre != null}">
    <!-- Verificar si el usuario ya existe -->
    <sql:query var="checkUser" dataSource="${proyectos}">
        SELECT COUNT(*) as count FROM usuarios WHERE id_usuario = ?;
        <sql:param value="${param.identificacion}" />
    </sql:query>

    <c:choose>
        <c:when test="${checkUser.rows[0].count > 0}">
            <div class="alert alert-danger" role="alert">
                Error: El usuario con esta identificación ya está registrado.
            </div>
            <button class="btn btn-primary" onclick="window.location.href='agregarUsuario.jsp'">Volver</button>
        </c:when>
        <c:otherwise>
            <sql:update var="result" dataSource="${proyectos}">
                INSERT INTO usuarios (nombre, id_usuario, correo, password, id_rol)
                VALUES (?, ?, ?, ?, ?);
                <sql:param value="${param.nombre}" />
                <sql:param value="${param.identificacion}" />
                <sql:param value="${param.correo}" />
                <sql:param value="${param.password}" />
                <sql:param value="${param.rol}" />
            </sql:update>

            <c:if test="${result == 1}">
                <div class="alert alert-success" role="alert">
                    ¡Usuario registrado satisfactoriamente!
                </div>
                <button class="btn btn-primary" onclick="window.location.href='admin.html'">Volver</button>
            </c:if>
            <c:if test="${result != 1}">
                <div class="alert alert-danger" role="alert">
                    Error al registrar el usuario.
                </div>
                <button class="btn btn-primary" onclick="window.location.href='admin.html'">Volver</button>
            </c:if>
        </c:otherwise>
    </c:choose>
</c:if>

<footer class="footer">
    <div class="container">
        <p>&copy; 2024 Sistema Universitario. Todos los derechos reservados.</p>
    </div>
</footer>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitterbootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>
