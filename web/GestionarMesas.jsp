<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Pedidos</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .table-selection {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
            font-family: Arial, sans-serif;
        }
        .mesas-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 20px;
        }
        .mesa-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            padding: 15px;
            transition: transform 0.2s ease;
        }
        .mesa-card:hover {
            transform: translateY(-3px);
        }
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
        }
        .disponible { background-color: #28a745; }
        .ocupada { background-color: #ffc107; }
        .mesa-name {
            text-align: center;
            font-size: 16px;
            font-weight: bold;
            width: 100%;
            background: transparent;
            margin-top: 10px;
            border: none;
        }
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
        .mesa-plus i { color: #333; }
    </style>
</head>
<body>
    <div class="table-selection">
        <h2>Gestión de Pedidos</h2>
        <div class="mesas-container">
            <div class="mesa-card" id="mesa-1" data-mesero="Juan" data-comensales="4" data-productos="Pizza, Refresco, Ensalada" data-total="$25.00">
                <button type="button" class="mesa-button ocupada" onclick="verPedido(1)"><i class="fas fa-chair"></i></button>
                <div class="mesa-name">Mesa 1</div>
                <button type="button" class="mesa-plus" onclick="verPedido(1)"><i class="fas fa-eye"></i></button>
            </div>
        </div>
    </div>
    <script>
        function verPedido(id) {
            var mesaCard = document.getElementById("mesa-" + id);
            var mesero = mesaCard.dataset.mesero;
            var comensales = mesaCard.dataset.comensales;
            var productos = mesaCard.dataset.productos;
            var total = mesaCard.dataset.total;
            Swal.fire({
                title: 'Pedido de Mesa ' + id,
                html: `<p><strong>Mesero:</strong> ${mesero}</p>
                       <p><strong>Número de comensales:</strong> ${comensales}</p>
                       <p><strong>Productos consumidos:</strong> ${productos}</p>
                       <p><strong>Total:</strong> ${total}</p>`,
                confirmButtonText: 'Cerrar'
            });
        }
    </script>
</body>
</html>
