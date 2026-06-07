<%@page import="java.util.List" %>
    <%@page import="com.lab.model.Event" %>
        <%@page import="com.lab.model.Attendance" %>
            <%@page import="com.lab.model.Club" %>
                <%@page contentType="text/html" pageEncoding="UTF-8" %>
                    <% String role=(String) session.getAttribute("accountType"); String activeTab=(String)
                        request.getAttribute("activeTab"); if (activeTab==null) activeTab="explore" ; %>

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
                                                    <div class="flex-grow-1 container-p-y">

                                                        <div
                                                            class="d-flex justify-content-between align-items-center mb-4">
                                                            <h4 class="fw-bold m-0 py-3">
                                                                Events Hub
                                                            </h4>
                                                        </div>

                                                        <div class="nav-align-top mb-4">
                                                            <ul class="nav nav-tabs nav-fill">
                                                                <li class="nav-item">
                                                                    <a class="nav-link <%= "explore".equals(activeTab) ? "active" : "" %>" href="events?action=browse">
                                                                        <i class="tf-icons bx bx-compass me-1"></i>
                                                                        Explore Events
                                                                    </a>
                                                                </li>

                                                                <li class="nav-item">
                                                                    <a class="nav-link <%= "registrations".equals(activeTab) ? "active" : ""
                                                                        %>" href="attendances?action=myAttendance">
                                                                        <i class="tf-icons bx bx-list-check me-1"></i>
                                                                        My Registrations
                                                                    </a>
                                                                </li>

                                                                <% if("CHAIRPERSON".equals(role)) { %>
                                                                    <li class="nav-item">
                                                                        <a class="nav-link <%= "manage".equals(activeTab) ? "active" : ""
                                                                            %>" href="events?action=manage">
                                                                            <i
                                                                                class="tf-icons bx bx-briefcase-alt-2 me-1"></i>
                                                                            Manage Club Events
                                                                        </a>
                                                                    </li>
                                                                    <% } %>
                                                            </ul>

                                                            <div
                                                                class="tab-content border-0 shadow-none bg-transparent px-0 py-4">
                                                                <% if("explore".equals(activeTab)) { %>
                                                                    <div class="tab-pane fade show active">
                                                                        <jsp:include page="_BrowseEvents.jsp" />
                                                                    </div>
                                                                    <% } else if("registrations".equals(activeTab)) { %>
                                                                        <div class="tab-pane fade show active">
                                                                            <jsp:include page="_MyRegistrations.jsp" />
                                                                        </div>
                                                                        <% } else if("manage".equals(activeTab)
                                                                            && "CHAIRPERSON" .equals(role)) { %>
                                                                            <div class="tab-pane fade show active">
                                                                                <jsp:include page="_ManageEvents.jsp" />
                                                                            </div>
                                                                            <% } %>
                                                            </div>
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