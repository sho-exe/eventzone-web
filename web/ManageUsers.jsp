<%@page import="java.util.List" %>
    <%@page import="com.lab.model.User" %>
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
                                                    <span class="text-muted fw-light">Admin /</span> User Directory
                                                    Matrix
                                                </h4>

                                                <div class="alert alert-info border-0 shadow-sm">
                                                    <i class="fas fa-info-circle me-2"></i> As a <strong>HEPA
                                                        Administrator</strong>, you can assign
                                                    users to the <strong>ADVISOR</strong> role, or revoke roles back to
                                                    <strong>STUDENT</strong>.
                                                    Chairpersons are assigned automatically via Club creation.
                                                </div>

                                                <div class="card mt-4">
                                                    <div class="table-responsive text-nowrap">
                                                        <table class="table table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <th>ID</th>
                                                                    <th>Full Name</th>
                                                                    <th>Email Address</th>
                                                                    <th>Current Role</th>
                                                                    <th class="text-center">Actions</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% List<User> userList = (List<User>)
                                                                        request.getAttribute("userList");
                                                                        if(userList != null && !userList.isEmpty()) {
                                                                        for(User u : userList) {
                                                                        String roleClass = "bg-label-primary";
                                                                        if(u.getRole().equals("HEPA")) roleClass =
                                                                        "bg-label-danger";
                                                                        if(u.getRole().equals("ADVISOR")) roleClass =
                                                                        "bg-label-success";
                                                                        if(u.getRole().equals("CHAIRPERSON")) roleClass
                                                                        = "bg-label-warning";
                                                                        %>
                                                                        <tr>
                                                                            <td class="px-4 text-muted">#<%=
                                                                                    u.getUserId() %>
                                                                            </td>
                                                                            <td class="fw-bold">
                                                                                <%= u.getFullName() %>
                                                                            </td>
                                                                            <td class="text-muted">
                                                                                <%= u.getEmail() %>
                                                                            </td>
                                                                            <td>
                                                                                <span
                                                                                    class="badge rounded-pill <%= roleClass %> badges-role">
                                                                                    <%= u.getRole() %>
                                                                                </span>
                                                                            </td>
                                                                            <td class="text-center">
                                                                                <% if(!u.getRole().equals("HEPA")) { %>
                                                                                    <form action="users" method="POST"
                                                                                        class="d-inline">
                                                                                        <input type="hidden"
                                                                                            name="action"
                                                                                            value="updateRole">
                                                                                        <input type="hidden"
                                                                                            name="userId"
                                                                                            value="<%= u.getUserId() %>">
                                                                                        <div
                                                                                            class="input-group input-group-sm d-flex justify-content-center">
                                                                                            <select name="newRole"
                                                                                                class="form-select form-select-sm"
                                                                                                style="max-width: 150px;">
                                                                                                <option value="STUDENT"
                                                                                                    <%=u.getRole().equals("STUDENT")
                                                                                                    ? "selected" : "" %>
                                                                                                    >Student</option>
                                                                                                <option value="ADVISOR"
                                                                                                    <%=u.getRole().equals("ADVISOR")
                                                                                                    ? "selected" : "" %>
                                                                                                    >Advisor</option>
                                                                                                <option
                                                                                                    value="CHAIRPERSON"
                                                                                                    <%=u.getRole().equals("CHAIRPERSON")
                                                                                                    ? "selected" : "" %>
                                                                                                    >Chairperson
                                                                                                </option>
                                                                                            </select>
                                                                                            <button type="submit"
                                                                                                class="btn btn-dark">Update</button>
                                                                                        </div>
                                                                                    </form>
                                                                                    <% } else { %>
                                                                                        <span
                                                                                            class="text-muted small fst-italic">System
                                                                                            Admin
                                                                                            (Locked)</span>
                                                                                        <% } %>
                                                                            </td>
                                                                        </tr>
                                                                        <% } } else { %>
                                                                            <tr>
                                                                                <td colspan="5"
                                                                                    class="text-center py-5 text-muted">
                                                                                    <i
                                                                                        class="fas fa-folder-open fa-3x mb-3 text-light"></i><br>
                                                                                    No users found in the system
                                                                                    registry.
                                                                                </td>
                                                                            </tr>
                                                                            <% } %>
                                                            </tbody>
                                                        </table>
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