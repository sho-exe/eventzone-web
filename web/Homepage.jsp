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

                            <div class="layout-page">
                                <jsp:include page="navbar.jsp" />

                                <div class="content-wrapper" style="padding: 0px 30px;">
                                    <div class=" flex-grow-1 container-p-y">
                                        <jsp:include page="quick_actions.jsp" />
                                        <jsp:include page="overview.jsp" />
                                    </div>

                                    <div class="content-backdrop fade"></div>
                                </div>
                            </div>
                        </div>

                        <div class="layout-overlay layout-menu-toggle"></div>
                    </div>

                    <script <jsp:include page="footer.jsp" />

                    <% } %>
        </body>

        </html>