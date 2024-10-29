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
    <title>Editar Coordinador</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="Css/editaradmin.css">
</head>
<body>
    <header class="encabezado">
        <h1>Editar Coordinador</h1>
    </header>

    <div class="form-ui">
        <div class="card-container">
            <div class="card">
                <div class="content">
                    <p class="heading">Actualizar Coordinador</p>
                    <div class="container">
                        <c:if test="${param.modifica == null}">
                            <!-- Consulta para obtener los datos del coordinador a editar -->
                            <sql:query var="coordinador" dataSource="${proyectos}">
                                SELECT * FROM usuarios WHERE id_usuario = ? AND id_rol = 2;
                                <sql:param value="${param.id}" />
                            </sql:query>

                            <div class="input-area">
                                <form class="form needs-validation" method="post">
                                    <table class="table">
                                        <c:forEach var="item" items="${coordinador.rows}">
                                            <tr>
                                                <td></td>
                                                <td><input type="hidden" name="id_usuario" value="${item.id_usuario}" /></td>
                                            </tr>
                                            <tr>
                                                <td>Nombre</td>
                                                <td><input type="text" name="nombre" value="${item.nombre}" required /></td>
                                            </tr>
                                            <tr>
                                                <td>Correo</td>
                                                <td><input type="email" name="correo" value="${item.correo}" required /></td>
                                            </tr>
                                        </c:forEach>
                                    </table>
                                    <br>
                                    <input type="submit" class="btn btn-success" value="Actualizar" />
                                    <input type="hidden" name="modifica" value="ST" />
                                </form>
                            </div>
                        </c:if>

                        <!-- Bloque para ejecutar la actualización -->
                        <c:if test="${param.modifica != null}">
                            <sql:update var="result" dataSource="${proyectos}">
                                UPDATE usuarios
                                SET nombre = '${param.nombre}', correo = '${param.correo}'
                                WHERE id_usuario = ${param.id_usuario} AND id_rol = 2;
                            </sql:update>

                            <!-- Verificación del éxito de la actualización -->
                            <c:if test="${result >= 1}">
                                <p class="para">¡Coordinador actualizado con éxito!</p>
                                <a href="vercoordinadores.jsp" class="btn btn-primary">Volver</a>
                            </c:if>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 Sistema Universitario. Todos los derechos reservados.</p>
        </div>
    </footer>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>
