<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <% String headerRole=(String) session.getAttribute("accountType"); String accentColor="#696cff" ,
        accentLight="rgba(105,108,255,0.12)" , accentHex="#696cff" ; if ("HEPA".equals(headerRole)) {
        accentColor="#ea5455" ; accentLight="rgba(234,84,85,0.12)" ; accentHex="#ea5455" ; } else if
        ("ADVISOR".equals(headerRole)) { accentColor="#28c76f" ; accentLight="rgba(40,199,111,0.12)" ;
        accentHex="#28c76f" ; } else if ("CHAIRPERSON".equals(headerRole)) { accentColor="#ff9f43" ;
        accentLight="rgba(255,159,67,0.12)" ; accentHex="#ff9f43" ; } %>
        <!DOCTYPE html>
        <html lang="en" class="light-style layout-menu-fixed" dir="ltr" data-theme="theme-default"
            data-assets-path="resources/assets/" data-template="vertical-menu-template-free">

        <head>
            <meta charset="utf-8" />
            <meta name="viewport"
                content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
            <title>EventZone Dashboard</title>
            <meta name="description" content="EventZone Dashboard" />

            <!-- Role Theme CSS Variables -->
            <style>
                :root {
                    --role-accent: <%=accentColor %>;
                    --role-accent-light: <%=accentLight %>;
                    --role-accent-hex: <%=accentHex %>;
                }
            </style>

            <!-- Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com" />
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
            <link
                href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
                rel="stylesheet" />

            <!-- Icons -->
            <link rel="stylesheet"
                href="${pageContext.request.contextPath}/resources/assets/vendor/fonts/boxicons.css" />

            <!-- Core CSS -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/vendor/css/core.css"
                class="template-customizer-core-css" />
            <link rel="stylesheet"
                href="${pageContext.request.contextPath}/resources/assets/vendor/css/theme-default.css"
                class="template-customizer-theme-css" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/demo.css" />

            <!-- Vendors CSS -->
            <link rel="stylesheet"
                href="${pageContext.request.contextPath}/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

            <!-- Helpers -->
            <script src="${pageContext.request.contextPath}/resources/assets/vendor/js/helpers.js"></script>
            <script src="${pageContext.request.contextPath}/resources/assets/js/config.js"></script>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css" />
            <style>
                /* --- Premium Modal Theme Overrides --- */
                .modal-content {
                    border-radius: 16px !important;
                    border: none !important;
                    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15) !important;
                    overflow: hidden;
                    background-color: #ffffff !important;
                }

                .modal-header.bg-primary {
                    background: linear-gradient(135deg, var(--role-accent), var(--role-accent-hex)) !important;
                    border-bottom: none !important;
                    padding: 1.5rem 2rem !important;
                }

                .modal-header.bg-primary .modal-title {
                    font-size: 1.35rem !important;
                    font-weight: 700 !important;
                    letter-spacing: -0.02em;
                    color: #ffffff !important;
                }

                .modal-body {
                    padding: 2rem !important;
                }

                .modal-content .form-label {
                    font-size: 0.78rem !important;
                    text-transform: uppercase !important;
                    letter-spacing: 0.06em !important;
                    color: #566a7f !important;
                    margin-bottom: 0.45rem !important;
                    font-weight: 600 !important;
                    display: inline-block;
                }

                .modal-content .border-primary,
                .modal-content .form-control,
                .modal-content .form-select {
                    border: 1.5px solid var(--role-accent) !important;
                    border-radius: 8px !important;
                    padding: 0.625rem 0.95rem !important;
                    font-size: 0.92rem !important;
                    background-color: #ffffff !important;
                    color: #495057 !important;
                    transition: all 0.2s ease-in-out !important;
                }

                .modal-content .form-control:focus,
                .modal-content .form-select:focus {
                    border-color: var(--role-accent) !important;
                    box-shadow: 0 0 0 0.25rem var(--role-accent-light) !important;
                }

                .modal-content .form-check {
                    border: 1.5px solid #d9dee3 !important;
                    border-radius: 8px !important;
                    padding: 0.6rem 0.8rem 0.6rem 2.2rem !important;
                    transition: all 0.2s ease-in-out !important;
                    cursor: pointer !important;
                    background-color: #ffffff !important;
                    position: relative !important;
                    margin-bottom: 0.5rem !important;
                }

                .modal-content .form-check:hover {
                    border-color: var(--role-accent) !important;
                    background-color: var(--role-accent-light) !important;
                }

                .modal-content .form-check:has(.form-check-input:checked) {
                    border-color: var(--role-accent) !important;
                    background-color: var(--role-accent-light) !important;
                    box-shadow: 0 2px 6px var(--role-accent-light) !important;
                }

                .modal-content .form-check-input {
                    border: 1.5px solid var(--role-accent) !important;
                    border-radius: 4px !important;
                    width: 16px !important;
                    height: 16px !important;
                    transition: all 0.15s ease-in-out !important;
                    cursor: pointer !important;
                    position: absolute !important;
                    left: 0.75rem !important;
                    top: 50% !important;
                    transform: translateY(-50%) !important;
                    margin-top: 0 !important;
                }

                .modal-content .form-check-input:checked {
                    background-color: var(--role-accent) !important;
                    border-color: var(--role-accent) !important;
                }

                .modal-content .form-check-label {
                    font-size: 0.82rem !important;
                    color: #495057 !important;
                    cursor: pointer !important;
                    font-weight: 600 !important;
                    user-select: none !important;
                    display: block !important;
                    width: 100% !important;
                    text-align: left !important;
                }

                .modal-footer {
                    padding: 1.25rem 2rem !important;
                    border-top: 1px solid #f2f4f6 !important;
                    background-color: #ffffff !important;
                }

                .modal-content .btn-primary {
                    background: linear-gradient(135deg, var(--role-accent), var(--role-accent-hex)) !important;
                    border: none !important;
                    border-radius: 8px !important;
                    padding: 0.65rem 1.6rem !important;
                    font-weight: 600 !important;
                    box-shadow: 0 4px 12px var(--role-accent-light) !important;
                    transition: all 0.2s ease-in-out !important;
                }

                .modal-content .btn-primary:hover {
                    transform: translateY(-1px);
                    box-shadow: 0 6px 16px var(--role-accent-light) !important;
                    opacity: 0.95 !important;
                }

                .modal-content .btn-outline-secondary {
                    border-radius: 8px !important;
                    padding: 0.65rem 1.6rem !important;
                    font-weight: 600 !important;
                    transition: all 0.2s ease-in-out !important;
                }

                .modal-content .btn-outline-secondary:hover {
                    background-color: #f8f9fa !important;
                    border-color: #c7cfd6 !important;
                    color: #495057 !important;
                }
            </style>
        </head>