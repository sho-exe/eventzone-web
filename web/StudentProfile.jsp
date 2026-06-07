<%@page import="com.lab.model.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
    String role = (String) session.getAttribute("accountType");
    User profileUser = (User) request.getAttribute("profileUser");
%>

<jsp:include page="header.jsp" />



<body>
    <% if (role == null) { %>
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

                        <% String success = (String) request.getAttribute("successMessage"); %>
                        <% String error   = (String) request.getAttribute("errorMessage"); %>
                        <% if (success != null) { %>
                        <div class="alert alert-success border-0 shadow-sm mb-4">
                            <i class="fas fa-check-circle me-2"></i> <%= success %>
                        </div>
                        <% } %>
                        <% if (error != null) { %>
                        <div class="alert alert-danger border-0 shadow-sm mb-4">
                            <i class="fas fa-exclamation-triangle me-2"></i> <%= error %>
                        </div>
                        <% } %>

                        <div class="row justify-content-center">
                            <div class="col-lg-7 col-md-9">
                                <div class="profile-card card">

                                    <!-- Profile Header -->
                                    <%
                                        String headerClass = "student";
                                        if ("HEPA".equals(role))        headerClass = "hepa";
                                        else if ("ADVISOR".equals(role))     headerClass = "advisor";
                                        else if ("CHAIRPERSON".equals(role)) headerClass = "chair";
                                        String initials = "?";
                                        if (profileUser != null && profileUser.getFullName() != null) {
                                            String[] parts = profileUser.getFullName().trim().split("\\s+");
                                            initials = parts.length >= 2
                                                ? String.valueOf(parts[0].charAt(0)) + String.valueOf(parts[parts.length-1].charAt(0))
                                                : String.valueOf(parts[0].charAt(0));
                                        }
                                    %>
                                    <div class="profile-header <%= headerClass %>">
                                        <div class="profile-avatar"><%= initials.toUpperCase() %></div>
                                        <h5 class="mb-1 fw-bold"><%= profileUser != null ? profileUser.getFullName() : "—" %></h5>
                                        <div class="text-white-50 small"><%= profileUser != null ? profileUser.getEmail() : "" %></div>
                                        <span class="profile-role-pill"><%= role %></span>
                                    </div>

                                    <!-- Update Form -->
                                    <div class="profile-body">
                                        <form action="users" method="POST">
                                            <input type="hidden" name="action" value="updateProfile">

                                            <p class="form-section-title"><i class="fas fa-id-card me-2"></i>Account Information</p>

                                            <!-- Read-only username -->
                                            <div class="mb-3">
                                                <label class="form-label small fw-semibold text-muted">Username</label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="fas fa-at"></i></span>
                                                    <input type="text" class="form-control profile-input"
                                                           value="<%= profileUser != null ? profileUser.getUsername() : "" %>"
                                                           readonly>
                                                </div>
                                                <small class="text-muted">Username cannot be changed.</small>
                                            </div>

                                            <!-- Full Name -->
                                            <div class="mb-3">
                                                <label class="form-label small fw-semibold text-muted" for="fullName">Full Name</label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                                    <input type="text" id="fullName" name="fullName"
                                                           class="form-control profile-input"
                                                           value="<%= profileUser != null ? profileUser.getFullName() : "" %>"
                                                           required>
                                                </div>
                                            </div>

                                            <!-- Email -->
                                            <div class="mb-4">
                                                <label class="form-label small fw-semibold text-muted" for="email">Email Address</label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                                    <input type="email" id="email" name="email"
                                                           class="form-control profile-input"
                                                           value="<%= profileUser != null ? profileUser.getEmail() : "" %>"
                                                           required>
                                                </div>
                                            </div>

                                            <p class="form-section-title"><i class="fas fa-lock me-2"></i>Change Password</p>

                                            <!-- New Password -->
                                            <div class="mb-3">
                                                <label class="form-label small fw-semibold text-muted" for="newPassword">New Password</label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                                    <input type="password" id="newPassword" name="newPassword"
                                                           class="form-control profile-input"
                                                           placeholder="Leave blank to keep current password">
                                                </div>
                                            </div>

                                            <div class="d-flex justify-content-end mt-4">
                                                <button type="submit" class="btn btn-update">
                                                    <i class="fas fa-save me-2"></i> Save Changes
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

    <jsp:include page="footer.jsp" />

    <% } %>
</body>
</html>
