<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ include file="WEB-INF/jspf/conexion.jspf" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema Universitario</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header class="encabezado" id="ejercicio1-encabezado">
        <h1>Programación Java</h1>
        <p>Actualizar Profesor</p>
    </header>

    <div class="form-ui">
        <div class="card-container">
            <div class="card" id="ejercicio1-card">
                <div class="content" id="ejercicio1-content">
                    <p class="heading">Actualizar Profesor</p>
                    <div class="container">
                        <c:if test="${param.modifica == null}">
                            <sql:query var="profesores" dataSource="${Profesores}">
                                select * from profesor where id = ?;
                                <sql:param value="${param.id}" />
                            </sql:query>
                            <div class="input-area">
                                <div class="form-group">
                                    <form class="form needs-validation" id="ejercicio1-form" method="post">
                                        <table>
                                            <c:forEach var="itema" items="${profesores.rows}">
                                                <tr>
                                                    <td></td>
                                                    <td><input type="hidden" name="id" value="${itema.id}" /></td>
                                                </tr>
                                                <tr>
                                                    <td>Cédula</td>
                                                    <td class="para"><input type="text" name="cedula" value="${itema.cedula}" readonly /></td>
                                                </tr>
                                                <tr>
                                                    <td>Nombre</td>
                                                    <td class="para"><input type="text" name="nombre" value="${itema.nombre}" /></td>
                                                </tr>
                                                <tr>
                                                    <td>Área</td>
                                                    <td class="para"><input type="text" name="area" value="${itema.area}" /></td>
                                                </tr>
                                                <tr>
                                                    <td>Teléfono</td>
                                                    <td class="para"><input type="text" name="telefono" value="${itema.telefono}" /></td>
                                                </tr>
                                                <tr>
                                                    <td>Cátegoria</td>
                                                    <td class="para">
                                                        <sql:query var="rsCategoria" dataSource="${Profesores}">
                                                            select * from categoria;
                                                        </sql:query>
                                                        <select name="categoria_id">
                                                            <option value="0">-- Seleccione --</option>
                                                            <c:forEach var="categoria" items="${rsCategoria.rows}">
                                                                <c:set var="selected" value="${categoria.id == itema.categoria_id ? 'selected' : ''}" />
                                                                <option value="${categoria.id}" ${selected}>${categoria.descripcion}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </table>
                                        <br>
                                        <input type="submit" class="btn btn-success" value="Actualizar" />
                                        <input type="hidden" name="modifica" value="ST" />
                                    </form>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${param.modifica != null}">
                            <sql:update var="result" dataSource="${Profesores}">
                                update profesor
                                set cedula ='${param.cedula}',
                                    nombre = '${param.nombre}',
                                    area = '${param.area}',
                                    telefono = '${param.telefono}',
                                    categoria_id = ${param.categoria_id}
                                where id = ${param.id};
                            </sql:update>
                            <c:if test="${result == 1}">
                                <p class="para">¡Registro Actualizado Satisfactoriamente!</p>
                                <a href="index.jsp" class="custom-button" id="ejercicio1-buttonvolver">Volver</a>
                            </c:if>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 Programación en Java. Todos los derechos reservados.</p>
        </div>
    </footer>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>
