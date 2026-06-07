<%@page import="com.lab.model.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
    String role = (String) session.getAttribute("accountType");
    User profileUser = (User) request.getAttribute("profileUser");
%>

<jsp:include page="header.jsp" />

<style>
    .profile-card {
        border: none;
        border-radius: 20px;
        box-shadow: 0 4px 24px rgba(0,0,0,0.08);
        overflow: hidden;
    }
    .profile-header {
        background: linear-gradient(135deg, #696cff 0%, #a78bfa 100%);
        padding: 40px 32px 60px;
        position: relative;
        text-align: center;
        color: #fff;
    }
    .profile-header.hepa     { background: linear-gradient(135deg, #ea5455, #ff7675); }
    .profile-header.advisor  { background: linear-gradient(135deg, #28c76f, #48d68c); }
    .profile-header.chair    { background: linear-gradient(135deg, #ff9f43, #ffbe76); }
    .profile-header.student  { background: linear-gradient(135deg, #696cff, #a78bfa); }

    .profile-avatar {
        width: 90px;
        height: 90px;
        border-radius: 50%;
        background: rgba(255,255,255,0.25);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2.5rem;
        color: #fff;
        margin: 0 auto 12px;
        border: 4px solid rgba(255,255,255,0.4);
        font-weight: 700;
    }
    .profile-role-pill {
        display: inline-block;
        background: rgba(255,255,255,0.2);
        border: 1px solid rgba(255,255,255,0.4);
        border-radius: 20px;
        padding: 3px 14px;
        font-size: 0.75rem;
        font-weight: 700;
        letter-spacing: 0.06em;
        text-transform: uppercase;
        color: #fff;
        margin-top: 6px;
    }
    .profile-body {
        padding: 32px;
        background: #fff;
    }
    .form-section-title {
        font-size: 0.72rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.07em;
        color: #8592a3;
        margin-bottom: 16px;
        padding-bottom: 8px;
        border-bottom: 1px solid #f0f2f5;
    }
    .profile-input {
        border: 1.5px solid #e2e7ef !important;
        border-radius: 10px !important;
        padding: 10px 14px !important;
        font-size: 0.9rem !important;
        color: #3d4a5c !important;
        background: #fafbfc !important;
        box-shadow: none !important;
        transition: border-color 0.2s, background 0.2s;
    }
    .profile-input:focus {
        border-color: #696cff !important;
        background: #fff !important;
        box-shadow: 0 0 0 3px rgba(105,108,255,0.1) !important;
    }
    .profile-input[readonly] {
        background: #f0f2f5 !important;
        color: #8592a3 !important;
        cursor: not-allowed;
    }
    .btn-update {
        background: linear-gradient(135deg, #696cff, #5a5ed6);
        border: none;
        border-radius: 10px;
        color: #fff;
        font-weight: 600;
        font-size: 0.9rem;
        padding: 11px 28px;
        transition: opacity 0.2s, transform 0.15s;
    }
    .btn-update:hover {
        opacity: 0.9;
        transform: translateY(-1px);
        color: #fff;
    }
    .input-group-text {
        background: #f0f2f5 !important;
        border: 1.5px solid #e2e7ef !important;
        border-right: none !important;
        border-radius: 10px 0 0 10px !important;
        color: #8592a3;
    }
    .input-group .profile-input {
        border-left: none !important;
        border-radius: 0 10px 10px 0 !important;
    }
</style>

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
