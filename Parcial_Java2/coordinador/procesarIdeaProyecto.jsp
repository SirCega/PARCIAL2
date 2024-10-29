<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="../WEB-INF/jspf/conexion.jspf" %> <!-- Incluir la conexión -->

<!-- Verificar si el usuario está logueado y tiene el rol de coordinador -->
<c:if test="${sessionScope.idUsuario != null && sessionScope.idRol == 2}"> <!-- 2 = Rol de coordinador -->

    <!-- Verificar si se han recibido los parámetros del formulario -->
    <c:if test="${param.titulo != null && param.descripcion != null && param.evaluator != null}">
        
        <!-- Iniciar transacción para insertar en ideasproyecto y anteproyectos -->
        <sql:transaction dataSource="${proyectos}">

            <!-- 1. Insertar la nueva idea en la tabla ideasproyecto con estado 'Disponible' -->
            <sql:update var="insertIdeaProyecto">
                INSERT INTO ideasproyecto (titulo, descripcion, id_coordinador, max_estudiantes, estado)
                VALUES (?, ?, ?, 2, 'Disponible');
                <sql:param value="${param.titulo}" />
                <sql:param value="${param.descripcion}" />
                <sql:param value="${sessionScope.idUsuario}" /> 
            </sql:update>

            <!-- 2. Verificar si la inserción fue exitosa -->
            <c:if test="${insertIdeaProyecto >= 1}">
                <!-- Recuperar el ID de la idea de proyecto recién insertada -->
                <sql:query var="getLastInsertedIdeaId">
                    SELECT LAST_INSERT_ID() AS id_idea_proyecto;
                </sql:query>
                <c:set var="idIdeaProyecto" value="${getLastInsertedIdeaId.rows[0].id_idea_proyecto}" />

                <sql:update var="insertAnteproyecto">
    INSERT INTO anteproyectos (id_idea_proyecto, id_evaluador, titulo,  fecha_aprobacion, aprobado_director, aprobado_evaluador, id_estudiante)
    VALUES (?, ?, ?, NULL, NULL, 'pendiente', NULL);
    <sql:param value="${idIdeaProyecto}" />
    <sql:param value="${param.evaluator}" />
    <sql:param value="${param.titulo}" />
</sql:update>

                <!-- Verificar si la inserción en anteproyectos fue exitosa -->
                <c:if test="${insertAnteproyecto >= 1}">
                    <script>
                        alert("Idea de proyecto y anteproyecto creados exitosamente.");
                        window.location.href = 'verIdeasProyecto.jsp'; <!-- Redirigir a la página de visualización de ideas -->
                    </script>
                </c:if>

                <!-- Si hubo algún error al insertar en anteproyectos -->
                <c:if test="${insertAnteproyecto < 1}">
                    <script>
                        alert("Error al crear el anteproyecto.");
                        window.location.href = 'crearIdeaProyecto.jsp'; <!-- Redirigir a la página de creación -->
                    </script>
                </c:if>
            </c:if>

            <!-- Si hubo un error al insertar la idea de proyecto -->
            <c:if test="${insertIdeaProyecto < 1}">
                <script>
                    alert("Error al crear la idea de proyecto.");
                    window.location.href = 'crearIdeaProyecto.jsp'; <!-- Redirigir a la página de creación -->
                </script>
            </c:if>
        </sql:transaction>
    </c:if>

    <!-- Si no se recibieron parámetros, volver a la página de creación -->
    <c:if test="${param.titulo == null || param.descripcion == null || param.evaluator == null}">
        <script>
            alert("Por favor complete todos los campos.");
            window.location.href = 'crearIdeaProyecto.jsp'; <!-- Redirigir a la página de creación -->
        </script>
    </c:if>
</c:if>

<!-- Si el usuario no está logueado o no tiene el rol adecuado -->
<c:if test="${sessionScope.idUsuario == null || sessionScope.idRol != 2}">
    <script>
        alert("No tiene permisos para realizar esta acción.");
        window.location.href = '../login.jsp'; <!-- Redirigir al login -->
    </script>
</c:if>
