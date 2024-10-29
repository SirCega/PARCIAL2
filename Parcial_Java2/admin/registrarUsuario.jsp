<%
    String nombre = request.getParameter("nombre");
    String identificacion = request.getParameter("identificacion");
    String correo = request.getParameter("correo");
    String password = request.getParameter("password");
    String rol = request.getParameter("rol");

    // Verificación de que los parámetros no sean nulos o vacíos
    if (nombre == null || nombre.trim().isEmpty() ||
        identificacion == null || identificacion.trim().isEmpty() ||
        correo == null || correo.trim().isEmpty() ||
        password == null || password.trim().isEmpty() ||
        rol == null || rol.trim().isEmpty()) {
        
        response.sendRedirect("registro.jsp?mensaje=Por favor completa todos los campos.");
    } else {
%>

<sql:update dataSource="${proyectos}" var="result">
    INSERT INTO usuarios (nombre, id_usuario, correo, password, id_rol) 
    VALUES (?, ?, ?, ?, ?);
    <sql:param value="${nombre}" />
    <sql:param value="${identificacion}" />
    <sql:param value="${correo}" />
    <sql:param value="${password}" />
    <sql:param value="${rol}" />
</sql:update>

<%
        if ((Integer) pageContext.getAttribute("result") > 0) {
            response.sendRedirect("agregarUsuario.jsp?mensaje=¡Usuario registrado correctamente!");
        } else {
            response.sendRedirect("agregarUsuario.jsp?mensaje=Error al registrar el usuario.");
        }
    }
%>
