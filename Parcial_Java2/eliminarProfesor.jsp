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
<header class="encabezado" id="mostrar5-encabezado">
<h1>Programacion Java</h1>
<p>Datos del Profesor</p>
</header>
<div class="form-ui">
<div class="card-container">
<div class="card" id="mostrar5-card">
<div class="content" id="mostrar5-content">
<div class="heading">Resultado</div>
<div class="container">
<c:if test="${param.id != null}">
<sql:update var="result" dataSource="${Profesores}">
DELETE FROM PROFESOR
WHERE id= ${param.id}
</sql:update>
<c:if test="${result == 1}">
<p>Registro eliminado satisfactoriamente...</p>
</c:if>
</c:if>
<button class="custom-button" id="mostrar5-button-volver"
onclick="window.location.href='index.jsp'">Volver</button>
</div>
</div>
</div>
</div>
</div>
</div>
<footer class="footer" id="mostrar5-footer">
<div class="container">
<p>&copy; 2024 Programacion en Java. Todos los derechos reservados.
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
