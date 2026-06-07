<%@page import="java.util.Map" %>
    <%@page import="java.util.List" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <% String role=(String) session.getAttribute("accountType"); %>

                <jsp:include page="header.jsp" />

                <body>
                    <% if (role==null) { %>
                        <div class="container-xxl container-p-y">
                            <div class="misc-wrapper">
                                <h2 class="mb-2 mx-2">Invalid access or session expired.</h2>
                                <p class="mb-4 mx-2">Please login again to continue.</p>
                                <a href="Login.jsp" class="btn btn-primary">Back to Login</a>
                            </div>
                        </div>
                        <% } else { %>
                            <!-- Layout wrapper -->
                            <div class="layout-wrapper layout-content-navbar">
                                <div class="layout-container">
                                    <jsp:include page="sidebar.jsp" />

                                    <!-- Layout container -->
                                    <div class="layout-page">
                                        <jsp:include page="navbar.jsp" />

                                        <!-- Content wrapper -->
                                        <div class="content-wrapper" style="padding: 0px 30px;">
                                            <!-- Content -->
                                            <div class=" flex-grow-1 container-p-y">

                                                <h4 class="fw-bold py-3 mb-4">
                                                    Merit Transcript
                                                </h4>

                                                <div class="row mb-4">
                                                    <div class="col-12 col-md-6 mb-3">
                                                        <div class="card border-0   h-100">
                                                            <div
                                                                class="card-body p-4 border-start border-warning border-5 d-flex align-items-center">
                                                                <div class="me-4 text-warning">
                                                                    <i class="fas fa-trophy fa-4x"></i>
                                                                </div>
                                                                <div>
                                                                    <h6 class="text-muted text-uppercase fw-bold mb-1">
                                                                        Total Lifetime Merits</h6>
                                                                    <h1 class="display-5 fw-bold text-dark mb-0">
                                                                        ${totalMerits != null ? totalMerits : '0'}</h1>
                                                                </div>

                                                            </div>
                                                            <!-- / Content -->

                                                            <div class="content-backdrop fade"></div>
                                                        </div>
                                                        <!-- Content wrapper -->
                                                    </div>
                                                    <!-- / Layout page -->
                                                </div>

                                                <!-- Overlay -->
                                                <div class="layout-overlay layout-menu-toggle"></div>
                                            </div>
                                            <!-- / Layout wrapper -->

                                            <jsp:include page="footer.jsp" />

                                            <% } %>
                </body>

                </html>