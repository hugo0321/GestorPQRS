<%-- 
    Document   : indexEntrada
    Created on : 3/05/2024, 8:03:44 p. m.
    Author     : Hugo
--%>

<%-- 
    Document   : index
    Created on : 1/05/2024, 9:23:45 p. m.
    Author     : Hugo
--%>
<%@page import="com.mycompany.tutorial.ConexionBaseDeDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
        <style>
            .btn-recuperar {
                background-color: #ffcccc; /* Color rojo suave */
                color: #ffffff; /* Texto blanco */
                border-color: #ffcccc; /* Borde rojo suave */
            }

            .btn-recuperar:hover {
                background-color: #ff9999; /* Color rojo suave al pasar el ratón */
                border-color: #ff9999; /* Borde rojo suave al pasar el ratón */
            }

        </style>
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
                        <p class="text-muted mb-5">Inicie sesión o registrese para mandar sus PQRS</p>
                    </div>
                </div>


                <div id="LoginServlet">
                    <form action="LoginServlet" method="post">
                        <div class="mb-3">
                            <input type="text" class="form-control" id="usuario" name="usuario" placeholder="Usuario" required>
                        </div>
                        <div class="mb-3">
                            <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Contraseña" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Iniciar sesión</button>
                        <!-- Botón para abrir la ventana flotante de registro -->
                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#registroModal">Crear cuenta</button>
                        <!-- Botón para abrir la ventana flotante de recuperación de contraseña o usuario -->
                        <button type="button" class="btn btn-recuperar" data-bs-toggle="modal" data-bs-target="#recuperarModal">Recuperar contraseña o usuario</button>
                    </form>
                </div>

                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        const cedulaInput = document.getElementById('cedulaRecuperar');
                        const correoInput = document.getElementById('correoRecuperar');



                        // Acción del botón Recuperar
                        document.querySelector('#recuperarModal button.btn-primary').addEventListener('click', function () {
                            // Validar que la cédula solo contenga números
                            if (!/^[0-9]+$/.test(cedulaInput.value)) {
                                cedulaInput.classList.add('is-invalid');
                                return;
                            } else {
                                cedulaInput.classList.remove('is-invalid');
                            }

                            // Validar el correo electrónico
                            if (!/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(correoInput.value)) {
                                correoInput.classList.add('is-invalid');
                                return;
                            } else {
                                correoInput.classList.remove('is-invalid');
                            }

                            // Aquí puedes agregar la lógica para recuperar la contraseña o usuario
                            // Por ejemplo, puedes enviar una solicitud AJAX al servidor
                        });
                    });
                </script>
                <!-- Modal para recuperar contraseña o usuario -->
                <div class="modal fade" id="recuperarModal" tabindex="-1" aria-labelledby="recuperarModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="recuperarModalLabel">Recuperar contraseña o usuario</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form method="post" action="RecuperarUsuarioServlet">
                                    <div class="mb-3">
                                        <input type="text" class="form-control" id="cedulaRecuperar" name="cedulaRecuperar" placeholder="Cédula" required pattern="[0-9]{1,12}">
                                        <div class="invalid-feedback">La cédula debe ser un número de hasta 12 dígitos.</div>
                                    </div>
                                    <div class="mb-3">
                                        <input type="email" class="form-control" id="correoRecuperar" name="correoRecuperar" placeholder="Correo electrónico" required>
                                        <div class="invalid-feedback">Por favor, introduce un correo electrónico válido.</div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                        <button type="submit" class="btn btn-primary">Recuperar</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>








                <!-- Ventana flotante de registro -->
                <div class="modal fade" id="registroModal" tabindex="-1" aria-labelledby="registroModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="registroModalLabel">Registro de usuario</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="registroForm" action="RegistroServlet" method="post">
                                    <div class="mb-3">
                                        <label for="nombreUsuario" class="form-label">Nombre de usuario</label>
                                        <input type="text" class="form-control" id="nombreUsuario" name="nombreUsuario" pattern="[a-zA-Z0-9.,]+" title="Solo letras, números, '.' y ',' son permitidos" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="cedula" class="form-label">Cédula</label>
                                        <input type="text" class="form-control" id="cedula" name="cedula" pattern="[0-9]+" title="Solo números son permitidos" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Correo electrónico</label>
                                        <input type="email" class="form-control" id="email" name="email" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="contrasenaRegistro" class="form-label">Contraseña</label>
                                        <input type="password" class="form-control" id="contrasenaRegistro" name="contrasenaRegistro" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Registrarse</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                </form>
                <!-- Modal -->
                <div class="modal fade" id="registroExitosoModal" tabindex="-1" role="dialog" aria-labelledby="registroExitosoModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="registroExitosoModalLabel">Registro exitoso</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                Registro exitoso: se ha enviado un correo con los detalles de la cuenta.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>




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
