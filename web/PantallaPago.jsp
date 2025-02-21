<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Incluir Font Awesome y SweetAlert2 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
  
        background-color: #f5f5f5;
    }
    .pago-container {
        max-width: 600px;
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
    select, button {
        width: 100%;
        padding: 10px;
        margin-top: 10px;
        font-size: 16px;
    }
    button {
        background-color: green;
        color: white;
        border: none;
        cursor: pointer;
        border-radius: 5px;
    }
</style>

<div class="pago-container">
    <h2>Realizar Pago</h2>

    <label for="mesaSelect">Selecciona una mesa:</label>
    <select id="mesaSelect">
        <option value="">-- Selecciona una mesa --</option>
    </select>

    <button onclick="generarPago()">Generar Cuenta</button>
</div>

<script>
    // Simulación de mesas activas y sus consumos
    var mesasActivas = [
        {id: 1, nombre: "Mesa 1", mesero: "Juan Pérez", total: 350, items: [
                {producto: "Pizza", cantidad: 1, precio: 150},
                {producto: "Refresco", cantidad: 2, precio: 50}
            ]},
        {id: 2, nombre: "Mesa 2", mesero: "María López", total: 270, items: [
                {producto: "Hamburguesa", cantidad: 1, precio: 120},
                {producto: "Papas", cantidad: 1, precio: 70},
                {producto: "Cerveza", cantidad: 2, precio: 40}
            ]},
        {id: 3, nombre: "Mesa 3", mesero: "Carlos Martínez", total: 450, items: [
                {producto: "Ensalada", cantidad: 1, precio: 200},
                {producto: "Jugo", cantidad: 1, precio: 50},
                {producto: "Sopa", cantidad: 1, precio: 100}
            ]}
    ];

    // Llenar el select con mesas activas
    function cargarMesas() {
        var select = document.getElementById("mesaSelect");
        select.innerHTML = '<option value="">-- Selecciona una mesa --</option>'; // Limpiar antes de agregar opciones
        mesasActivas.forEach(function (mesa) {
            var option = document.createElement("option");
            option.value = mesa.id;
            option.textContent = mesa.nombre + " - " + mesa.mesero;
            select.appendChild(option);
        });
    }



    // Función para mostrar el detalle de la cuenta y generar pago
     // Función para mostrar el detalle de la cuenta y generar pago
    function generarPago() {
        var idMesa = document.getElementById("mesaSelect").value;
        if (!idMesa) {
            Swal.fire("Error", "Selecciona una mesa para continuar.", "warning");
            return;
        }

        var mesa = mesasActivas.find(function(m) { return m.id == idMesa; });
        if (!mesa) return;

        var detalle = '<div style="font-size: 16px; line-height: 1.6;">' +
            '<strong>Mesero:</strong> ' + mesa.mesero + '<br>' +
            '<strong>Artículos Consumidos:</strong><br>' +
            '<ul style="list-style-type: none; padding-left: 0;">';

        mesa.items.forEach(function(item) {
            // Concatenar el detalle de cada item en la cuenta
            detalle += '<li style="margin-bottom: 10px;">' +
                '<span><strong>' + item.cantidad + 'x ' + item.producto + '</strong></span> - ' +
                '<span style="color: green;">$' + (item.precio * item.cantidad).toFixed(2) + '</span>' +
                '</li>';
        });

        detalle += '</ul>' +
            '<hr style="border-top: 1px solid #ddd;">' +
            '<strong>Total:</strong> <span style="color: green;">$' + mesa.total.toFixed(2) + '</span>' +
            '</div>';

        // Mostrar el modal con los detalles
        Swal.fire({
            title: "Generar cuenta",
            html: detalle,
            icon: "question",
            showCancelButton: true,
            confirmButtonText: "Generar pago",
            cancelButtonText: "Cancelar",
            customClass: {
                popup: 'swal-popup-custom'
            }
        }).then(function(result) {
            if (result.isConfirmed) {
                Swal.fire("Pago Generado", "Se ha generado la notificación de pago para " + mesa.nombre + ".", "success");
            }
        });
    }


    // Cargar mesas al iniciar la página
    document.addEventListener("DOMContentLoaded", cargarMesas);
</script>
