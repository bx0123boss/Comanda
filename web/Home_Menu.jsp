<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link href="CSS/Hextech.css" rel="stylesheet" type="text/css"/>


<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Jaggersoft</title>
    </head>

    <body>
        <!-- Cabecera -->
        <header>
            <div class="logo">
                <img src="Imagenes/RESTAURANTE2.ico" alt="Logo Comandas">
            </div>
        </header>

        <!-- Menú lateral de navegación -->
        <nav>
            <!-- Información del usuario al inicio del menú -->
            <div class="full-box dashboard-sideBar-UserInfo" style="text-align: center; padding-bottom: 20px;">
                <figure class="full-box">
                    <img src="Imagenes/avatar.png" alt="UserIcon" />
                    <br><br>
                    <!-- Nombre del usuario -->
                    <figcaption class="text-center text-titles"><c:out value="${sessionScope.Nombre}" /></figcaption>
                    <br>
                </figure>
                <!-- Botón de Cerrar sesión -->
                <ul class="list-unstyled full-box dashboard-sideBar-Menu">
                    <li>
                        <form action="logout.jsp" method="post">
                            <button type="submit" class="btn-exit-system" style="color: #f8f8f8; font-size: 18px; background: none; border: none;">
                                <i class="fas fa-sign-out-alt" style="margin-right: 8px;"></i>Cerrar sesión
                            </button>
                        </form>
                    </li>
                </ul>
                <hr style="border: 1px solid #ccc; margin: 10px 0;"/>
            </div>

            <!-- Enlaces del menú -->
           <ul class="list-unstyled full-box dashboard-sideBar-Menu">
    <!-- Dashboard -->
    <li class="sidebar-item">
        <a href="svtDashboard">
            <i class="fas fa-tachometer-alt"></i> Dashboard
        </a>
    </li>

    <!-- Nueva Comanda -->
    <li class="sidebar-item">
        <a href="svtMesas">
            <i class="fas fa-plus-circle"></i> Nueva Comanda
        </a>
    </li>

    <!-- Gestionar Comandas -->
    <li class="sidebar-item">
        <a href="svtGestionMesas">
            <i class="fas fa-edit"></i> Gestionar Comandas
        </a>
    </li>

    <!-- Pantalla de Pago -->
    <li class="sidebar-item">
        <a href="svtPago">
            <i class="fas fa-credit-card"></i> Pantalla de Pago
        </a>
    </li>

    <!-- Historial de Comandas -->
    <li class="sidebar-item">
        <a href="svtHistorico">
            <i class="fas fa-history"></i> Historial de Comandas
        </a>
    </li>

    <!-- Administración -->
    <li class="sidebar-item">
        <a href="#" onclick="toggleSubMenu(this)">
            <i class="fas fa-cogs"></i> Administración <i class="fas fa-caret-down"></i>
        </a>
        <ul class="list-unstyled full-box sub-menu">
            <li>
                <a href="svtAdministracionGrl">
                    <i class="fas fa-tools"></i> Administracion Productos
                </a>
            </li>
            <li>
                <a href="svtUsuarios">
                    <i class="fas fa-users"></i> Gestión de Usuarios
                </a>
            </li>
        </ul>
    </li>

    <!-- Notificaciones -->
    <li class="sidebar-item">
        <a href="svtNotificaciones">
            <i class="fas fa-bell"></i> Notificaciones
        </a>
    </li>
</ul>

<script>
    function toggleSubMenu(button) {
        const subMenu = button.nextElementSibling;
        if (subMenu) {
            subMenu.classList.toggle("show");
        }
    }
</script>

        </nav>

        <!-- Contenido principal -->
        <main>
            <c:if test="${not empty contenido}">
                <jsp:include page="${contenido}" />
            </c:if>
        </main>

        <!-- Pie de página -->
        <footer>
            &copy; 2025 Jaegersoft. Todos los derechos reservados.
        </footer>

        <script>
            document.addEventListener("DOMContentLoaded", function() {
                // Seleccionar los elementos de menú con submenú
                const menuItems = document.querySelectorAll(".btn-sideBar-SubMenu");

                // Iterar sobre los elementos y agregarles un evento de clic
                menuItems.forEach(function(menuItem) {
                    menuItem.addEventListener("click", function(e) {
                        e.preventDefault();  // Evitar que el enlace se siga (si lo hay)
                        const subMenu = menuItem.nextElementSibling;

                        // Verificar si el submenú está abierto o cerrado y cambiar su estado
                        if (subMenu) {
                            subMenu.classList.toggle("show");
                        }
                    });
                });
            });

            // Función para alternar la visibilidad del submenú
            function toggleSubMenu(button) {
                const subMenu = button.nextElementSibling;
                subMenu.classList.toggle("show");
            }
        </script>
    </body>
</html>
