<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>

<div class="login-container">
    <h2>Iniciar Sesión</h2>

    <!-- Mostrar mensaje de advertencia si las credenciales son incorrectas -->
    <c:if test="${param.error == 'true'}">
        <div class="alert alert-danger text-center">
            ID de usuario o contraseña incorrectos.
        </div>
    </c:if>

    <!-- Formulario de Login -->
    <form method="POST" action="logina.jsp">
        <div class="form-group">
            <label for="userId">ID Usuario</label>
            <input type="text" class="form-control" id="userId" name="userId" required>
        </div>
        <div class="form-group position-relative">
            <label for="password">Contraseña</label>
            <input type="password" class="form-control" id="password" name="password" required>
            <span class="position-absolute" style="right: 10px; top: 35%; cursor: pointer;" id="togglePassword">
                <i class="fas fa-eye" id="toggleIcon"></i>
            </span>
        </div>
        <button type="submit" class="btn btn-lg btn-primary btn-block">Ingresar</button>
    </form>

    <!-- Botón para regresar a la página de inicio, fuera del formulario -->
    <div class="mt-3"> <!-- Margen superior para separar del formulario -->
        <a href="index.html" class="btn btn-secondary btn-block">Regresar a Inicio</a>
    </div>
    
</div>

<!-- Librerías JavaScript -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    // Script para mostrar/ocultar la contraseña
    const togglePassword = document.getElementById('togglePassword');
    const passwordInput = document.getElementById('password');
    const toggleIcon = document.getElementById('toggleIcon');

    togglePassword.addEventListener('click', function () {
        const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
        passwordInput.setAttribute('type', type);
        toggleIcon.classList.toggle('fa-eye');
        toggleIcon.classList.toggle('fa-eye-slash');
    });
</script>

</body>
</html>
