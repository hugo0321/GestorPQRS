<%-- 
    Document   : index
    Created on : 1/05/2024, 9:23:45 p. m.
    Author     : Hugo
--%>

<%@page import="com.mycompany.tutorial.Motivo"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.mycompany.tutorial.ControladorPQRS"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.tutorial.ConexionBaseDeDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession miSesion = request.getSession(false);
    if (miSesion == null || miSesion.getAttribute("username") == null) {
        // Si no hay sesión o el nombre de usuario no está presente en la sesión, redirigir al formulario de inicio de sesión
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Creative - Constructora </title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap Icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic" rel="stylesheet" type="text/css" />
        <!-- SimpleLightbox plugin CSS-->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="#page-top">Constructora</a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto my-2 my-lg-0">
                        <li class="nav-item"><a class="nav-link" href="#about">Acerca de nosotros</a></li>
                        <li class="nav-item"><a class="nav-link" href="#services">Servicios</a></li>
                        <li class="nav-item"><a class="nav-link" href="#portfolio">Portfolio</a></li>
                        <li class="nav-item"><a class="nav-link" href="#contact">PQRS</a></li>
                        <li class="nav-item"><a class="nav-link" href="ListadoPQRSUsuario.jsp">Sigue tus PQRS</a></li>
                        <!-- Dropdown para el usuario -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <%
                                    // Obtener la sesión
                                    HttpSession laSesion = request.getSession(false);
                                    if (laSesion != null && laSesion.getAttribute("username") != null) {
                                        // Obtener el nombre de usuario de la sesión
                                        String username = (String) laSesion.getAttribute("username");
                                %>
                                Bienvenido, <%= username%>!
                                <% } else { %>
                                No se ha iniciado sesión
                                <% }%>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <!-- Formulario para solicitar contraseña -->


                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="svCerrarSesionUsuario ">Cerrar sesión</a></li>
                            </ul>
                        </li>
                        <!-- Fin del Dropdown -->
                    </ul>
                </div>
            </div>
        </nav>



        <!-- Encabezado -->
        <header class="masthead">
            <div class="container px-4 px-lg-5 h-100">
                <div class="row gx-4 gx-lg-5 h-100 align-items-center justify-content-center text-center">
                    <div class="col-lg-8 align-self-end">
                        <h1 class="text-white font-weight-bold">Tu lugar favorito para realizar todo tipo de construcción</h1>
                        <hr class="divider" />
                    </div>
                    <div class="col-lg-8 align-self-baseline">
                        <p class="text-white-75 mb-5">¡Constructora XYZ puede ayudarte a construir mejores proyectos con nuestro equipo de expertos! ¡Solo contáctanos y comienza a diseñar tus sueños, sin compromisos!</p>
                        <a class="btn btn-primary btn-xl" href="#about">Descubre más</a>
                    </div>
                </div>
            </div>
        </header>
        <!-- Acerca de -->
        <section class="page-section bg-primary" id="about">
            <div class="container px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-lg-8 text-center">
                        <h2 class="text-white mt-0">¡Tenemos lo que necesitas!</h2>
                        <hr class="divider divider-light" />
                        <p class="text-white-75 mb-4">¡Constructora XYZ tiene todo lo que necesitas para convertir tus ideas en realidad! ¡Contamos con los mejores profesionales, diseños innovadores y materiales de calidad para tus proyectos de construcción!</p>
                        <a class="btn btn-light btn-xl" href="#services">¡Comienza ahora!</a>
                    </div>
                </div>
            </div>
        </section>
        <!-- Servicios -->
        <section class="page-section" id="services">
            <div class="container px-4 px-lg-5">
                <h2 class="text-center mt-0">A tu disposición</h2>
                <hr class="divider" />
                <div class="row gx-4 gx-lg-5">
                    <div class="col-lg-3 col-md-6 text-center">
                        <div class="mt-5">
                            <div class="mb-2"><i class="bi-gem fs-1 text-primary"></i></div>
                            <h3 class="h4 mb-2">Proyectos sólidos</h3>
                            <p class="text-muted mb-0">¡Nuestros proyectos se actualizan regularmente para garantizar su solidez y durabilidad!</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 text-center">
                        <div class="mt-5">
                            <div class="mb-2"><i class="bi-laptop fs-1 text-primary"></i></div>
                            <h3 class="h4 mb-2">Actualizados</h3>
                            <p class="text-muted mb-0">Mantenemos actualizados todos nuestros métodos y tecnologías para garantizar la excelencia en cada construcción.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 text-center">
                        <div class="mt-5">
                            <div class="mb-2"><i class="bi-globe fs-1 text-primary"></i></div>
                            <h3 class="h4 mb-2">Listos para Construir</h3>
                            <p class="text-muted mb-0">Puedes optar por nuestros diseños predefinidos o personalizarlos según tus necesidades.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 text-center">
                        <div class="mt-5">
                            <div class="mb-2"><i class="bi-heart fs-1 text-primary"></i></div>
                            <h3 class="h4 mb-2">Hechos con Pasión</h3>
                            <p class="text-muted mb-0">¿Realmente es un proyecto de Constructora XYZ si no está hecho con pasión y dedicación?</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Portfolio-->
        <div id="portfolio">
            <div class="container-fluid p-0">
                <div class="row g-0">
                    <div class="col-lg-4 col-sm-6">
                        <a class="portfolio-box" href="assets/img/portfolio/fullsize/1.jpg" title="Project Name">
                            <img class="img-fluid" src="assets/img/portfolio/thumbnails/1.jpg" alt="..." />
                            <div class="portfolio-box-caption">
                                <div class="project-category text-white-50">Category</div>
                                <div class="project-name">Project Name</div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <a class="portfolio-box" href="assets/img/portfolio/fullsize/2.jpg" title="Project Name">
                            <img class="img-fluid" src="assets/img/portfolio/thumbnails/2.jpg" alt="..." />
                            <div class="portfolio-box-caption">
                                <div class="project-category text-white-50">Category</div>
                                <div class="project-name">Project Name</div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <a class="portfolio-box" href="assets/img/portfolio/fullsize/3.jpg" title="Project Name">
                            <img class="img-fluid" src="assets/img/portfolio/thumbnails/3.jpg" alt="..." />
                            <div class="portfolio-box-caption">
                                <div class="project-category text-white-50">Category</div>
                                <div class="project-name">Project Name</div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <a class="portfolio-box" href="assets/img/portfolio/fullsize/4.jpg" title="Project Name">
                            <img class="img-fluid" src="assets/img/portfolio/thumbnails/4.jpg" alt="..." />
                            <div class="portfolio-box-caption">
                                <div class="project-category text-white-50">Category</div>
                                <div class="project-name">Project Name</div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <a class="portfolio-box" href="assets/img/portfolio/fullsize/5.jpg" title="Project Name">
                            <img class="img-fluid" src="assets/img/portfolio/thumbnails/5.jpg" alt="..." />
                            <div class="portfolio-box-caption">
                                <div class="project-category text-white-50">Category</div>
                                <div class="project-name">Project Name</div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <a class="portfolio-box" href="assets/img/portfolio/fullsize/6.jpg" title="Project Name">
                            <img class="img-fluid" src="assets/img/portfolio/thumbnails/6.jpg" alt="..." />
                            <div class="portfolio-box-caption p-3">
                                <div class="project-category text-white-50">Category</div>
                                <div class="project-name">Project Name</div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Contact-->
        <section class="page-section" id="contact">
            <div class="container px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-lg-8 col-xl-6 text-center">
                        <h2 class="mt-0">Ayudanos a mejorar</h2>
                        <hr class="divider" />
                        <p class="text-muted mb-5">Realiza tu PQRS te responderemos lo antes posible</p>
                    </div>
                </div>

                <div class="row gx-4 gx-lg-5 justify-content-center mb-5">
                    <div class="col-lg-6">
                        <!-- * * * * * * * * * * * * * * *-->
                        <!-- * * SB Forms Contact Form * *-->
                        <!-- * * * * * * * * * * * * * * *-->
                        <!-- This form is pre-integrated with SB Forms.-->
                        <!-- To make this form functional, sign up at-->
                        <!-- https://startbootstrap.com/solution/contact-forms-->
                        <!-- to get an API token!-->
                        <form id="contactForm" action="InsertarPQRSServlet" method="post" enctype="multipart/form-data" onsubmit="return validarFormulario()">

                            <!-- Primer Nombre input -->
                            <div class="form-floating mb-3">
                                <input class="form-control required" id="primerNombre" type="text" placeholder="Enter your name..." name="primerNombre" oninput="formatName(this)">
                                <label for="primerNombre">Primer nombre</label>
                            </div>

                            <!-- Segundo Nombre input -->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="segundoNombre" type="text" placeholder="Enter your name..." name="segundoNombre" oninput="formatName(this)">
                                <label for="segundoNombre">Segundo Nombre (Opcional)</label>
                            </div>

                            <!-- Primer Apellido input -->
                            <div class="form-floating mb-3">
                                <input class="form-control required" id="primerApellido" type="text" placeholder="Enter your name..." name="primerApellido" oninput="formatName(this)">
                                <label for="primerApellido">Primer Apellido</label>
                            </div>

                            <!-- Segundo Apellido input -->
                            <div class="form-floating mb-3">
                                <input class="form-control" id="segundoApellido" type="text" placeholder="Enter your name..." name="segundoApellido" oninput="formatName(this)">
                                <label for="segundoApellido">Segundo Apellido (Opcional)</label>
                            </div>



                            <%
                                List<Motivo> motivos = null;
                                try {
                                    motivos = ControladorPQRS.obtenerMotivos();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            %>

                            <!-- Motivo select -->
                            <div class="form-floating mb-3">
                                <select class="form-select required" id="motivo" name="motivo">
                                    <option value="">Selecciona un motivo...</option>
                                    <!-- Iterar sobre la lista de motivos y generar opciones -->
                                    <% for (Motivo motivo : motivos) {%>
                                    <option value="<%= motivo.getIdMotivo()%>"><%= motivo.getNombreMotivo()%></option>
                                    <% }%>
                                </select>
                                <label for="motivo">Motivo</label>
                            </div>

                            <!-- Email address input -->
                            <div class="form-floating mb-3">
                                <input class="form-control required" id="email" type="email" placeholder="name@example.com" name="email" />
                                <label for="email">Correo</label>
                            </div>

                            <!-- Phone number input -->
                            <div class="form-floating mb-3">
                                <input class="form-control required" id="phone" type="tel" placeholder="(123) 456-7890" name="telefono" />
                                <label for="phone">Número de celular</label>
                            </div>

                            <!-- Message input -->
                            <div class="form-floating mb-3">
                                <textarea class="form-control" id="message" type="text" placeholder="Enter your message here..." style="height: 10rem" name="mensaje"></textarea>

                                <label for="message">Mensaje</label>
                            </div>

                            <!-- Campo de carga de archivo PDF -->
                            <div class="form-group mb-3">
                                <label for="pdfFile">Adjuntar PDF (máximo 20 MB)</label>
                                <input type="file" class="form-control-file" id="pdfFile" name="pdfFile" accept=".pdf" onchange="validarPDF(this)">
                                <small id="pdfHelp" class="form-text text-muted">Por favor, seleccione un archivo PDF de máximo 20 MB.</small>
                                <div id="pdfError" class="invalid-feedback">Solo se permiten archivos PDF.</div>
                            </div>

                            <!-- Submit Button -->
                            <div class="d-grid">
                                <button class="btn btn-primary btn-xl" id="submitButton" type="submit">Enviar</button>
                            </div>

                        </form>

                        <script>
                            function formatName(input) {
                                // Obtiene el valor del campo de entrada
                                let nombre = input.value.toLowerCase();

                                // Remueve tildes
                                nombre = nombre.normalize("NFD").replace(/[\u0300-\u036f]/g, "");

                                // Reemplaza "ñ" con "n"
                                nombre = nombre.replace(/ñ/g, 'n');

                                // Capitaliza la primera letra
                                nombre = nombre.charAt(0).toUpperCase() + nombre.slice(1);

                                // Actualiza el valor del campo de entrada con el nombre formateado
                                input.value = nombre;
                            }
                            function validarFormulario() {
                                var inputs = document.querySelectorAll('.required');
                                var pdfFile = document.getElementById('pdfFile');
                                var message = document.getElementById('message').value.trim();

                                // Verificar si se proporciona un PDF o un mensaje
                                if (pdfFile.files.length === 0 && message === '') {
                                    alert('Debe adjuntar un archivo PDF o completar el campo de mensaje.');
                                    return false;
                                }

                                // Si se proporciona un PDF, verificar si es un archivo PDF válido
                                if (pdfFile.files.length > 0) {
                                    var isValidPDF = validarPDF(pdfFile);
                                    if (!isValidPDF) {
                                        return false;
                                    }
                                }

                                // Validar campos de texto requeridos
                                var valid = true;
                                inputs.forEach(function (input) {
                                    if (input.value.trim() === '') {
                                        input.classList.add('is-invalid');
                                        valid = false;
                                    } else {
                                        input.classList.remove('is-invalid');
                                    }
                                });

                                return valid;
                            }

                            function toggleRequiredAttribute() {
                                var pdfFile = document.getElementById('pdfFile');
                                var messageInput = document.getElementById('message');

                                // Si se selecciona un archivo PDF, el campo de mensaje no es obligatorio
                                if (pdfFile.files.length > 0) {
                                    messageInput.removeAttribute('required');
                                } else {
                                    messageInput.setAttribute('required', 'required');
                                }
                            }

                            // Validar PDF
                            function validarPDF(input) {
                                var file = input.files[0];
                                var fileSize = file.size / 1024 / 1024; // Tamaño en MB

                                if (file.type !== 'application/pdf') {
                                    alert("El archivo seleccionado no es un PDF válido. Por favor, seleccione un archivo PDF.");
                                    input.value = ''; // Limpiar el valor del input para que el usuario pueda seleccionar otro archivo
                                    return false;
                                } else if (fileSize > 20) {
                                    alert("El archivo seleccionado excede el tamaño máximo permitido (20 MB). Por favor, seleccione otro archivo.");
                                    input.value = ''; // Limpiar el valor del input para que el usuario pueda seleccionar otro archivo
                                    return false;
                                } else {
                                    return true;
                                }
                            }

                            document.getElementById('pdfFile').addEventListener('change', toggleRequiredAttribute);
                        </script>




                        <style>
                            .is-invalid {
                                border-color: #dc3545 !important;
                            }
                        </style>


                    </div>
                </div>
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-lg-4 text-center mb-5 mb-lg-0">
                        <i class="bi-phone fs-2 mb-3 text-muted"></i>
                        <div>+57 (333) 333-3333</div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Footer-->
        <footer class="bg-light py-5">
            <div class="container px-4 px-lg-5"><div class="small text-center text-muted">Copyright &copy; 2023 - Company Name</div></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- SimpleLightbox plugin JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    </body>
</html>