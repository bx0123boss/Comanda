<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Incluir Font Awesome y SweetAlert2 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- Estilos -->
<style>
    .table-selection {
        max-width: 1200px;
        margin: 40px auto;
        padding: 20px;
        font-family: Arial, sans-serif;
    }
    .table-selection h2 {
        text-align: center;
        margin-bottom: 30px;
        font-size: 28px;
        color: #333;
    }
    .mesas-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    .mesa-card {
        position: relative;
        display: flex;
        flex-direction: column;
        align-items: center;
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        padding: 15px;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .mesa-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.15);
    }
    /* Botón para inhabilitar la mesa */
    .mesa-disable {
        position: absolute;
        top: 5px;
        right: 5px;
        background: transparent;
        border: none;
        font-size: 16px;
        cursor: pointer;
        color: #888;
    }
    .mesa-disable:hover {
        color: #000;
    }
    /* Botón de la mesa: muestra un ícono en lugar del número */
    .mesa-button {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        border: none;
        font-size: 24px;
        color: #fff;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: background-color 0.3s ease;
    }
    /* Estado: disponible = verde, ocupada = amarillo */
    .disponible {
        background-color: #28a745;
    }
    .ocupada {
        background-color: #ffc107;
    }
    /* Campo editable para el nombre de la mesa */
    .mesa-name {
        border: none;
        text-align: center;
        font-size: 16px;
        font-weight: bold;
        outline: none;
        width: 100%;
        background: transparent;
        margin-top: 10px;
    }
    .mesa-name:focus {
        border-bottom: 1px dashed #333;
    }
    /* Botón de acción (+) para cada mesa */
    .mesa-plus {
        background-color: #f0f0f0;
        border: none;
        border-radius: 50%;
        width: 30px;
        height: 30px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        margin-top: 10px;
    }
    .mesa-plus i {
        color: #333;
    }
    .btn-actions {
        text-align: center;
    }
    .btn-action {
        padding: 12px 25px;
        margin: 10px;
        font-size: 16px;
        cursor: pointer;
        border: none;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }
    .btn-add {
        background-color: #007bff;
        color: #fff;
    }
    .btn-more {
        background-color: #6c757d;
        color: #fff;
    }
    .btn-action:hover {
        opacity: 0.9;
    }
</style>

<div class="table-selection">
    <h2>Selecciona una Mesa</h2>
    <div class="mesas-container">
        <c:choose>
            <c:when test="${not empty mesas}">
                <c:forEach var="mesa" items="${mesas}">
                    <div class="mesa-card" id="mesa-card-${mesa.id}"
                         data-mesero="${mesa.mesero != null ? mesa.mesero : 'Sin asignar'}"
                         data-comensales="${mesa.comensales != null ? mesa.comensales : 0}">
                        <!-- Botón para inhabilitar la mesa -->
                        <button type="button" class="mesa-disable" onclick="inhabilitarMesa(${mesa.id})">
                            <i class="fas fa-times"></i>
                        </button>
                        <!-- Botón que simula la mesa (muestra ícono) -->
                        <button type="button"
                                class="mesa-button ${mesa.estado eq 'ocupada' ? 'ocupada' : 'disponible'}"
                                onclick="seleccionarMesa(${mesa.id})">
                            <i class="fas fa-chair"></i>
                        </button>
                        <!-- Campo editable para el nombre -->
                        <input type="text" class="mesa-name" value="${mesa.nombre != null ? mesa.nombre : 'Mesa'}" 
                               onchange="actualizarNombre(${mesa.id}, this.value)" />
                        <!-- Botón de acción (+) para mostrar detalles -->
                        <button type="button" class="mesa-plus" onclick="accionMesa(${mesa.id})">
                            <i class="fas fa-plus"></i>
                        </button>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <!-- Simulación de 10 mesas disponibles -->
                <c:forEach var="i" begin="1" end="10">
                    <div class="mesa-card" id="mesa-card-${i}" data-mesero="Sin asignar" data-comensales="0">
                        <button type="button" class="mesa-disable" onclick="inhabilitarMesa(${i})">
                            <i class="fas fa-times"></i>
                        </button>
                        <button type="button"
                                class="mesa-button disponible"
                                onclick="seleccionarMesa(${i})">
                            <i class="fas fa-chair"></i>
                        </button>
                        <input type="text" class="mesa-name" value="Mesa ${i}" onchange="actualizarNombre(${i}, this.value)" />
                        <button type="button" class="mesa-plus" onclick="accionMesa(${i})">
                            <i class="fas fa-plus"></i>
                        </button>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="btn-actions">
        <!-- Botón para agregar una nueva mesa mediante swal -->
        <button type="button" class="btn-action btn-add" onclick="agregarMesa()">Agregar Mesa</button>
        <button type="button" class="btn-action btn-more" onclick="verMas()">Ver Más</button>
    </div>
</div>

<script>
    // Contador de mesas (para la simulación y mesas dinámicas)
    var mesaCount = document.querySelectorAll('.mesa-card').length;

    function seleccionarMesa(id) {
        console.log("Mesa seleccionada:", id);
        // Lógica de selección de mesa si es necesario
    }

    function actualizarNombre(id, nuevoNombre) {
        console.log("Actualizar nombre de la mesa", id, "a", nuevoNombre);
        // Aquí se podría enviar el nuevo nombre al servidor mediante AJAX
    }

    // Función para mostrar detalles en una ventana emergente (con SweetAlert2)
    function accionMesa(id) {
        var mesaCard = document.getElementById("mesa-card-" + id);
        if(!mesaCard) return;
        var mesaNameElem = mesaCard.querySelector(".mesa-name");
        var nombreMesa = mesaNameElem ? mesaNameElem.value : "";
        var mesero = mesaCard.dataset.mesero || "Sin asignar";
        var numPersonas = mesaCard.dataset.comensales || 0;
        var productos = ["Producto 1", "Producto 2", "Producto 3"];
        var subtotal = "$35.50";
        
        // Construir la lista de productos en formato HTML
        var listaProductos = "<ul style='text-align:left;'>";
        productos.forEach(function(prod) {
            listaProductos += "<li>" + prod + "</li>";
        });
        listaProductos += "</ul>";
        
        Swal.fire({
            title: 'Detalle de ' + nombreMesa,
            html: "<p><strong>Mesero:</strong> " + mesero + "</p>" +
                  "<p><strong>Número de comensales:</strong> " + numPersonas + "</p>" +
                  "<p><strong>Productos consumidos:</strong></p>" +
                  listaProductos +
                  "<p><strong>Subtotal:</strong> " + subtotal + "</p>",
            confirmButtonText: 'Cerrar'
        });
    }

    // Función para inhabilitar (eliminar) la mesa visualmente
     function inhabilitarMesa(id) {
        Swal.fire({
            title: "¿Estás seguro?",
            text: "Esta acción eliminará la mesa de la vista.",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "Sí, eliminar",
            cancelButtonText: "Cancelar"
        }).then((result) => {
            if (result.isConfirmed) {
                var mesaCard = document.getElementById("mesa-card-" + id);
                if (mesaCard && mesaCard.parentNode) {
                    mesaCard.parentNode.removeChild(mesaCard);
                    Swal.fire("Eliminado", "La mesa ha sido eliminada.", "success");
                } else {
                    Swal.fire("Error", "No se encontró la mesa.", "error");
                }
            }
        });
    }

    // Función para agregar una nueva mesa usando SweetAlert2 para solicitar datos
    function agregarMesa() {
    Swal.fire({
        title: 'Agregar nueva mesa',
        html: 
            '<input id="swal-mesero" class="swal2-input" placeholder="Nombre del Mesero">' +
            '<input id="swal-comensales" class="swal2-input" placeholder="Número de Comensales" type="number">' +
            '<input id="swal-nombre" class="swal2-input" placeholder="Nombre de la Mesa">',
        focusConfirm: false,
        showCancelButton: true,
        confirmButtonText: 'Agregar',
        preConfirm: () => {
            var mesero = document.getElementById('swal-mesero').value.trim();
            var comensales = document.getElementById('swal-comensales').value.trim();
            var nombre = document.getElementById('swal-nombre').value.trim();

            // Validar que los campos no estén vacíos
            if (!mesero || !comensales || !nombre) {
                Swal.showValidationMessage("Todos los campos son obligatorios.");
                return false;
            }

            // Validar que el número de comensales sea un número válido
            if (isNaN(comensales) || parseInt(comensales) <= 0) {
                Swal.showValidationMessage("El número de comensales debe ser mayor a 0.");
                return false;
            }

            return { mesero, comensales, nombre };
        }
    }).then((result) => {
        if (result.isConfirmed) {
            var data = result.value;
            mesaCount++;

            var container = document.querySelector('.mesas-container');
            var newMesaCard = document.createElement('div');
            newMesaCard.className = 'mesa-card';
            newMesaCard.id = 'mesa-card-' + mesaCount;
            // Guardar datos en atributos para usarlos en el swal de detalles
            newMesaCard.dataset.mesero = data.mesero;
            newMesaCard.dataset.comensales = data.comensales;

            newMesaCard.innerHTML =
                '<button type="button" class="mesa-disable" onclick="inhabilitarMesa(' + mesaCount + ')">' +
                    '<i class="fas fa-times"></i>' +
                '</button>' +
                '<button type="button" class="mesa-button disponible" onclick="seleccionarMesa(' + mesaCount + ')">' +
                    '<i class="fas fa-chair"></i>' +
                '</button>' +
                '<input type="text" class="mesa-name" value="' + data.nombre + '" onchange="actualizarNombre(' + mesaCount + ', this.value)" />' +
                '<button type="button" class="mesa-plus" onclick="accionMesa(' + mesaCount + ')">' +
                    '<i class="fas fa-plus"></i>' +
                '</button>';

            container.appendChild(newMesaCard);
            console.log("Nueva mesa agregada:", mesaCount, data);
        }
    });
}


    function verMas() {
        console.log("Ver más mesas");
        // Lógica para mostrar más mesas si fuese necesario
    }
</script>
