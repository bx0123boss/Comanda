<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Incluir Font Awesome y SweetAlert2 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f5f5f5;
    }
    .admin-container {
        max-width: 800px;
        margin: auto;
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    h2 {
        text-align: center;
        color: #333;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    th {
        background-color: #007bff;
        color: white;
    }
    .acciones {
        display: flex;
        gap: 10px;
    }
    button {
        padding: 5px 10px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .btn-desactivar {
        background-color: red;
        color: white;
    }
    .btn-token {
        background-color: orange;
        color: white;
    }
</style>

<div class="admin-container">
    <h2>Administración de Usuarios</h2>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Usuario</th>
                <th>Estado</th>
                <th>Token</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody id="tablaUsuarios"></tbody>
    </table>
</div>

<script>
    // Simulación de usuarios activos con ID, nombre y token
    var usuarios = [
        { id: 1, nombre: "Juan Pérez", activo: true, token: "abc123" },
        { id: 2, nombre: "María López", activo: true, token: "xyz456" },
        { id: 3, nombre: "Carlos Martínez", activo: true, token: "lmn789" }
    ];

    // Función para renderizar la lista de usuarios
    function renderizarUsuarios() {
        var tabla = document.getElementById("tablaUsuarios");
        tabla.innerHTML = ""; // Limpiar tabla

        usuarios.forEach(usuario => {
            var fila = document.createElement("tr");
            fila.innerHTML = `
                <td>${usuario.id}</td>
                <td>${usuario.nombre}</td>
                <td>${usuario.activo ? "Activo" : "Inactivo"}</td>
                <td>${usuario.token}</td>
                <td class="acciones">
                    <button class="btn-desactivar" onclick="desactivarUsuario(${usuario.id})">
                        <i class="fas fa-user-slash"></i>
                    </button>
                    <button class="btn-token" onclick="cambiarToken(${usuario.id})">
                        <i class="fas fa-key"></i>
                    </button>
                </td>
            `;
            tabla.appendChild(fila);
        });
    }

    // Función para desactivar un usuario
    function desactivarUsuario(id) {
        Swal.fire({
            title: "¿Desactivar usuario?",
            text: "El usuario perderá acceso al sistema.",
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: "Sí, desactivar",
            cancelButtonText: "Cancelar"
        }).then((result) => {
            if (result.isConfirmed) {
                usuarios = usuarios.map(user => user.id === id ? { ...user, activo: false } : user);
                renderizarUsuarios();
                Swal.fire("Desactivado", "El usuario ha sido desactivado.", "success");
            }
        });
    }

    // Función para cambiar el token de un usuario
    function cambiarToken(id) {
        let nuevoToken = Math.random().toString(36).substr(2, 8);
        usuarios = usuarios.map(user => user.id === id ? { ...user, token: nuevoToken } : user);
        renderizarUsuarios();
        Swal.fire("Token actualizado", "El nuevo token es: " + nuevoToken, "success");
    }

    // Renderizar usuarios al cargar la página
    renderizarUsuarios();
</script>
