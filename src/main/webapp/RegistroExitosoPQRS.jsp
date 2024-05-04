<%-- 
    Document   : RegistroExitosoPQRS
    Created on : 3/05/2024, 3:34:14 p. m.
    Author     : Hugo
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro Exitoso</title>
    <!-- Aquí puedes agregar enlaces a CSS si deseas personalizar el estilo -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }

        .content {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #007bff;
        }

        p {
            color: #6c757d;
        }

        .timer {
            font-size: 18px;
            margin-top: 20px;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="content">
        <h1>¡Se ha registrado su solicitud PQRS!</h1>
        <p>Serás redirigido a la página principal en <span id="countdown">5</span> segundos.</p>
        <script>
            var seconds = 5;
            function countdown() {
                var countdownElement = document.getElementById("countdown");
                if (seconds > 0) {
                    countdownElement.textContent = seconds;
                    seconds--;
                    setTimeout(countdown, 1000);
                } else {
                    window.location.href = "indexEntrada.jsp";
                }
            }
            countdown();
        </script>
    </div>
</body>
</html>

