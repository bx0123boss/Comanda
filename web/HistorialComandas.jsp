<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Incluir Font Awesome y SweetAlert2 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        background-color: #f5f5f5;
    }
    .historial-container {
        max-width: 900px;
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
    select, table {
        width: 100%;
        margin-top: 10px;
        padding: 10px;
    }
    table {
        border-collapse: collapse;
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
    .btn-ver {
        background-color: green;
        color: white;
        border: none;
        padding: 5px 10px;
        cursor: pointer;
        border-radius: 5px;
    }
</style>

<div class="historial-container">
    <h2>Historial de Comandas</h2>

    <label for="filtroUsuario">Filtrar por mesero:</label>
    <select id="filtroUsuario" onchange="filtrarComandas()">
        <option value="todos">Todos</option>
        <option value="Juan Pérez">Juan Pérez</option>
        <option value="María López">María López</option>
        <option value="Carlos Martínez">Carlos Martínez</option>
    </select>

    <table>
        <thead>
            <tr>
                <th>Mesa</th>
                <th>Mesero</th>
                <th>Total</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody id="tablaComandas"></tbody>
    </table>
</div>

<script>
    // Simulación de historial de comandas
    var comandas = [
        { id: 1, mesa: "Mesa 1", mesero: "Juan Pérez", total: 350, items: [
            { producto: "Pizza", cantidad: 1, precio: 150 },
            { producto: "Refresco", cantidad: 2, precio: 50 }
        ]},
        { id: 2, mesa: "Mesa 2", mesero: "María López", total: 270, items: [
            { producto: "Hamburguesa", cantidad: 1, precio: 120 },
            { producto: "Papas", cantidad: 1, precio: 70 },
            { producto: "Cerveza", cantidad: 2, precio: 40 }
        ]},
        { id: 3, mesa: "Mesa 3", mesero: "Carlos Martínez", total: 450, items: [
            { producto: "Ensalada", cantidad: 1, precio: 200 },
            { producto: "Jugo", cantidad: 1, precio: 50 },
            { producto: "Sopa", cantidad: 1, precio: 100 }
        ]}
    ];

    // Función para renderizar la lista de comandas
    function renderizarComandas(lista) {
        var tabla = document.getElementById("tablaComandas");
        tabla.innerHTML = ""; // Limpiar tabla

        lista.forEach(comanda => {
            var fila = document.createElement("tr");
            fila.innerHTML = `
                <td>${comanda.mesa}</td>
                <td>${comanda.mesero}</td>
                <td>$${comanda.total.toFixed(2)}</td>
                <td><button class="btn-ver" onclick="verComanda(${comanda.id})">Ver</button></td>
            `;
            tabla.appendChild(fila);
        });
    }

    // Función para filtrar comandas por mesero
    function filtrarComandas() {
        var filtro = document.getElementById("filtroUsuario").value;
        var filtradas = filtro === "todos" ? comandas : comandas.filter(c => c.mesero === filtro);
        renderizarComandas(filtradas);
    }

    // Función para mostrar el detalle de la comanda
    function verComanda(id) {
        var comanda = comandas.find(c => c.id === id);
        if (comanda) {
            var detalle = "<strong>Mesero:</strong> " + comanda.mesero + "<br>" +
                          "<strong>Mesa:</strong> " + comanda.mesa + "<br>" +
                          "<strong>Artículos Consumidos:</strong><br><ul>";
            comanda.items.forEach(function(item) {
                detalle += "<li>" + item.cantidad + "x " + item.producto + " - $" + (item.precio * item.cantidad).toFixed(2) + "</li>";
            });
            detalle += "</ul><strong>Total:</strong> $" + comanda.total.toFixed(2);

            Swal.fire({
                title: "Detalle de la Comanda",
                html: detalle,
                icon: "info"
            });
        }
    }

    // Renderizar comandas al cargar la página
    renderizarComandas(comandas);
</script>
