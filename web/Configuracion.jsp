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
    .menu-container {
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
    .categoria {
        margin-bottom: 20px;
        padding: 15px;
        background: #ffffff;
        border-radius: 10px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .categoria h3 {
        margin: 0 0 10px;
        color: #444;
    }
    .producto {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 8px;
        border-bottom: 1px solid #ddd;
    }
    .producto:last-child {
        border-bottom: none;
    }
    .producto input {
        width: 60px;
        text-align: right;
        border: none;
        background: transparent;
        font-size: 16px;
    }
    .producto input:focus {
        border-bottom: 1px solid #007bff;
        outline: none;
    }
    .boton-agregar {
        display: block;
        margin: 10px auto;
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        text-align: center;
    }
    .boton-agregar:hover {
        background-color: #0056b3;
    }
    .acciones {
        text-align: center;
        margin-top: 20px;
    }
</style>

<div class="menu-container">
    <h2>Gestión del Menú</h2>

    <!-- Contenedor de categorías -->
    <div id="categorias"></div>

    <!-- Botón para agregar una nueva categoría -->
    <button class="boton-agregar" onclick="agregarCategoria()">+ Agregar Categoría</button>
</div>

<script>
    // Simulación de un menú inicial con productos y precios
    var menu = {
        "Entradas": [
            { nombre: "Ensalada César", precio: 50 },
            { nombre: "Sopa de Tortilla", precio: 40 }
        ],
        "Platos Fuertes": [
            { nombre: "Pechuga a la plancha", precio: 120 },
            { nombre: "Bistec encebollado", precio: 140 }
        ],
        "Postres": [
            { nombre: "Pastel de chocolate", precio: 60 },
            { nombre: "Flan napolitano", precio: 50 }
        ],
        "Bebidas": [
            { nombre: "Agua natural", precio: 20 },
            { nombre: "Refresco", precio: 30 }
        ]
    };

    // Función para renderizar el menú
    function renderizarMenu() {
        var contenedor = document.getElementById("categorias");
        contenedor.innerHTML = ""; // Limpiar contenido

        Object.keys(menu).forEach(categoria => {
            var divCategoria = document.createElement("div");
            divCategoria.className = "categoria";
            divCategoria.innerHTML = `<h3>${categoria}</h3>`;

            menu[categoria].forEach((producto, index) => {
                var divProducto = document.createElement("div");
                divProducto.className = "producto";
                divProducto.innerHTML = `
                    <span>${producto.nombre}</span>
                    <input type="number" value="${producto.precio}" onchange="actualizarPrecio('${categoria}', ${index}, this.value)" />
                    <button onclick="eliminarProducto('${categoria}', ${index})" style="background: none; border: none; cursor: pointer; color: red;">
                        <i class="fas fa-trash"></i>
                    </button>
                `;
                divCategoria.appendChild(divProducto);
            });

            // Botón para agregar productos dentro de la categoría
            divCategoria.innerHTML += `<button class="boton-agregar" onclick="agregarProducto('${categoria}')">+ Agregar Producto</button>`;

            contenedor.appendChild(divCategoria);
        });
    }

    // Función para actualizar el precio de un producto
    function actualizarPrecio(categoria, index, nuevoPrecio) {
        if (isNaN(nuevoPrecio) || nuevoPrecio <= 0) {
            Swal.fire("Error", "El precio debe ser un número mayor a 0", "error");
            return;
        }
        menu[categoria][index].precio = parseFloat(nuevoPrecio);
        console.log("Nuevo precio actualizado", menu);
    }

    // Función para agregar un nuevo producto a una categoría
    function agregarProducto(categoria) {
        Swal.fire({
            title: 'Agregar Producto',
            html: `
                <input id="nombreProducto" class="swal2-input" placeholder="Nombre del producto">
                <input id="precioProducto" class="swal2-input" type="number" placeholder="Precio">
            `,
            showCancelButton: true,
            confirmButtonText: 'Agregar',
            preConfirm: () => {
                let nombre = document.getElementById("nombreProducto").value.trim();
                let precio = parseFloat(document.getElementById("precioProducto").value);

                if (!nombre || isNaN(precio) || precio <= 0) {
                    Swal.showValidationMessage("Todos los campos deben ser válidos.");
                    return false;
                }

                return { nombre, precio };
            }
        }).then((result) => {
            if (result.isConfirmed) {
                menu[categoria].push(result.value);
                renderizarMenu();
            }
        });
    }

    // Función para eliminar un producto
    function eliminarProducto(categoria, index) {
        Swal.fire({
            title: '¿Eliminar producto?',
            text: "Esta acción no se puede deshacer.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Sí, eliminar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                menu[categoria].splice(index, 1);
                renderizarMenu();
            }
        });
    }

    // Función para agregar una nueva categoría
    function agregarCategoria() {
        Swal.fire({
            title: "Nueva Categoría",
            input: "text",
            inputPlaceholder: "Nombre de la categoría",
            showCancelButton: true,
            confirmButtonText: "Agregar"
        }).then((result) => {
            if (result.isConfirmed && result.value.trim() !== "") {
                menu[result.value.trim()] = [];
                renderizarMenu();
            }
        });
    }

    // Renderizar menú al cargar la página
    renderizarMenu();
</script>
