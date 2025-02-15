<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="CSS/HexCore.css" rel="stylesheet" type="text/css"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="JS/HexGates.js" type="text/javascript"></script>
    <title>Login</title>
</head>

<body>
    <div class="container">
        <!-- Logo de la empresa -->
        <img src="Imagenes/LOGO.png" alt="Logo de la empresa" class="logo"/>
   
        <h2>Bienvenido</h2>

        <!-- Formulario de Login -->
        <form id="loginForm" action="svtLogin" method="post">
            <label for="token">Token</label>
            <div class="input-group">
                <input type="password" id="token" name="token" required>
            </div>
            <button type="submit">Entrar</button>
        </form>

        <!-- Pie de página con derechos reservados -->
       
    </div>

    <script>
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const token = document.getElementById('token').value;
            if (token.trim() === '') {
                e.preventDefault();
                Swal.fire({
                    icon: 'error',
                    title: 'Campo vacío',
                    text: 'Por favor, ingrese el token.',
                    confirmButtonColor: '#3085d6'
                });
            }
        });
    </script>
    
     <div class="footer">
            <p>&copy; 2025 Jaegersoft. Todos los derechos reservados.</p>
        </div>
</body>
</html>
