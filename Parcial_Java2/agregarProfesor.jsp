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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitterbootstrap/4.6.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fontawesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="styles.css">
</head>
<body>
<header class="encabezado" id="ejercicio2-encabezado">
<h1>Programación Java</h1>
<p>Agregar Profesor</p>
</header>
<c:if test="${param.nombre == null}">
<div class="form-ui">
<form class="form needs-validation" id="ejercicio2-form" method="post">
<div class="form-body">
<div class="content" id="ejercicio2-content">
<div class="titulo-lines">
<div id="ejercicio2-titulo-line-1">Ingrese los datos de la persona</div>
</div>
<div class="input-area">
<div class="form-group">
<table>
<tr>
<td></td>
<td class="para"><input type="hidden" name="id" value="${fila.id}" />
</td>
</tr>
<tr>
<td>Cédula</td>
<td class="para"><input type="text" name="cedula"
value="${fila.cedula}" /></td>
</tr>
<tr>
<td>Nombre</td>
<td class="para"><input type="text" name="nombre"
value="${fila.nombre}" /></td>
</tr>
<tr>
<td>Área</td>
<td class="para"><input type="text" name="area" value="${fila.area}"
/></td>
</tr>
<tr>
<td>Teléfono</td>
<td class="para"><input type="text" name="telefono"
value="${fila.telefono}" /></td>
</tr>
<tr>
<td>Cátegoria</td>
<td class="para">
<sql:query var="rsCategoria" dataSource="${Profesores}">
select * from categoria;
</sql:query>
<select name="categoria_id">
<option value="0">-- Seleccione --</option>
<c:forEach var="item" items="${rsCategoria.rows}">
<option value="${item.id}">
<c:out value="${item.descripcion}" />
</option>
</c:forEach>
</select>
</td>
</tr>
</table>
<br>
<input type="submit" class="btn btn-success" value="insertar" />
</div>
</div>
</div>
</div>
</form>
</div>
</c:if>
<c:if test="${param.nombre != null}">
<sql:update var="result" dataSource="${Profesores}">
INSERT INTO
profesor (cedula, nombre, area, telefono, categoria_id)
VALUES
('${param.cedula}',
'${param.nombre}',
'${param.area}',
'${param.telefono}',
${param.categoria_id});
</sql:update>
<c:if test="${result == 1}">
<div class="card-container">
<div class="card" id="mostrar2-card">
<div class="content" id="mostrar2-content">
<div class="heading">Registro Insertado Satisfactoriamente!</div>
<button class="custom-button" id="mostrar2-button-volver"
onclick="window.location.href='index.jsp'">Volver</button>
</div>
</div>
</div>
</c:if>
<footer class="footer" id="mostrar2-footer">
<div class="container">
<p>&copy; 2024 Programación en Java. Todos los derechos reservados.
</p>
</div>
</footer>
</c:if>
<footer class="footer" id="ejercicio3-footer">
<div class="container">
<p>&copy; 2024 Programación en Java. Todos los derechos reservados.
</p>
</div>
</footer>
<script
src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js">
</script>
<script
src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.j
s"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitterbootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>