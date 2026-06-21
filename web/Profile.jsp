<%@page import="com.lab.model.User" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% String role=(String) session.getAttribute("accountType"); User profileUser=(User)
            request.getAttribute("profileUser"); %>

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

                        <div class="layout-wrapper layout-content-navbar">
                            <div class="layout-container">
                                <jsp:include page="sidebar.jsp" />
                                <div class="layout-page">
                                    <jsp:include page="navbar.jsp" />
                                    <div class="content-wrapper" style="padding: 0 30px;">
                                        <div class="flex-grow-1 container-p-y">

                                            <h4 class="fw-bold py-3 mb-4">
                                                Update Profile
                                            </h4>

                                            <% String success=(String) request.getAttribute("successMessage"); %>
                                                <% String error=(String) request.getAttribute("errorMessage"); %>

                                                    <div class="row">
                                                        <div class="col-lg-5 col-md-8 col-12">
                                                            <% if (success !=null) { %>
                                                                <div
                                                                    class="alert alert-success border-0 shadow-sm mb-3">
                                                                    <i class="fas fa-check-circle me-2"></i>
                                                                    <%= success %>
                                                                </div>
                                                                <% } %>
                                                                    <% if (error !=null) { %>
                                                                        <div
                                                                            class="alert alert-danger border-0 shadow-sm mb-3">
                                                                            <i
                                                                                class="fas fa-exclamation-triangle me-2"></i>
                                                                            <%= error %>
                                                                        </div>
                                                                        <% } %>
                                                                            <div class="card club-card mt-3">
                                                                                <div class="card-inner">
                                                                                    <h5 class="fw-bold mb-4">Profile
                                                                                        Details</h5>
                                                                                    <form action="users" method="POST">
                                                                                        <input type="hidden"
                                                                                            name="action"
                                                                                            value="updateProfile">

                                                                                        <!-- Username (Read-only) -->
                                                                                        <div class="mb-3">
                                                                                            <label
                                                                                                class="form-label fw-semibold"
                                                                                                for="username">Username</label>
                                                                                            <input type="text"
                                                                                                id="username"
                                                                                                class="form-control"
                                                                                                value="<%= profileUser != null ? profileUser.getUsername() : "" %>"
                                                                                                readonly>
                                                                                        </div>

                                                                                        <!-- Full Name -->
                                                                                        <div class="mb-3">
                                                                                            <label
                                                                                                class="form-label fw-semibold"
                                                                                                for="fullName">Full
                                                                                                Name</label>
                                                                                            <input type="text"
                                                                                                id="fullName"
                                                                                                name="fullName"
                                                                                                class="form-control"
                                                                                                value="<%= profileUser != null ? profileUser.getFullName() : "" %>"
                                                                                                required>
                                                                                        </div>

                                                                                        <!-- Email -->
                                                                                        <div class="mb-3">
                                                                                            <label
                                                                                                class="form-label fw-semibold"
                                                                                                for="email">Email
                                                                                                Address</label>
                                                                                            <input type="email"
                                                                                                id="email" name="email"
                                                                                                class="form-control"
                                                                                                value="<%= profileUser != null ? profileUser.getEmail() : "" %>"
                                                                                                required>
                                                                                        </div>

                                                                                        <!-- New Password -->
                                                                                        <div class="mb-4">
                                                                                            <label
                                                                                                class="form-label fw-semibold"
                                                                                                for="newPassword">New
                                                                                                Password</label>
                                                                                            <input type="password"
                                                                                                id="newPassword"
                                                                                                name="newPassword"
                                                                                                class="form-control"
                                                                                                placeholder="Leave blank to keep current password">
                                                                                        </div>

                                                                                        <hr class="divider-soft">
                                                                                        <div
                                                                                            class="d-flex justify-content-end">
                                                                                            <button type="submit"
                                                                                                style="font-weight: 600;"
                                                                                                class="btn btn-primary">
                                                                                                <i
                                                                                                    class="bx bx-save me-1"></i>
                                                                                                Save Changes
                                                                                            </button>
                                                                                        </div>

                                                                                    </form>
                                                                                </div>
                                                                            </div>
                                                        </div>
                                                    </div>

                                        </div>
                                        <div class="content-backdrop fade"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="layout-overlay layout-menu-toggle"></div>
                        </div>



                        <% } %>
                <jsp:include page="footer.jsp" />
</body>

            </html>