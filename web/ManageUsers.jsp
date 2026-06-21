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

                                                <div class="d-flex justify-content-between align-items-center mb-4">
                                                    <h4 class="fw-bold mb-0 d-flex align-items-center">
                                                        Manage Users
                                                        <i class="bx bx-info-circle text-info ms-2"
                                                            style="cursor: pointer; font-size: 1.5rem; vertical-align: middle;"
                                                            data-bs-toggle="collapse" data-bs-target="#pageTipsCollapse"
                                                            title="Toggle Page Guide"></i>
                                                    </h4>
                                                    <button class="btn btn-primary" style="font-weight: 600;"
                                                        data-bs-toggle="modal" data-bs-target="#createUserModal">
                                                        <i class="bx bx-plus me-1" style="font-weight: 800;"></i>
                                                        Add User
                                                    </button>
                                                </div>

                                                <% String message=request.getParameter("message"); %>
                                                    <% if (message !=null && !message.trim().isEmpty()) { %>
                                                        <div class="alert alert-success border-0 shadow-sm mb-4 alert-dismissible fade show"
                                                            role="alert" id="successAlert">
                                                            <i class="bx bx-check-circle me-2"></i>
                                                            <%= message %>
                                                                <span
                                                                    class="badge bg-white text-success ms-2 countdown-badge"
                                                                    style="font-size: 0.75rem; vertical-align: middle;">3s</span>
                                                                <button type="button" class="btn-close"
                                                                    data-bs-dismiss="alert" aria-label="Close"></button>
                                                        </div>
                                                        <% } %>

                                                            <div class="collapse show mb-4" id="pageTipsCollapse">
                                                                <div class="card border-0 bg-label-info shadow-none"
                                                                    style="border-radius: 12px;">
                                                                    <div class="card-body p-3">
                                                                        <div class="d-flex align-items-center gap-3">
                                                                            <div class="bg-info text-white d-flex align-items-center justify-content-center"
                                                                                style="width: 36px; height: 36px; border-radius: 8px; font-size: 1.2rem; flex-shrink: 0;">
                                                                                <i class="bx bx-info-circle"></i>
                                                                            </div>
                                                                            <div class="flex-grow-1">
                                                                                <h6 class="mb-1 text-info fw-bold"
                                                                                    style="font-size: 0.95rem;">Page
                                                                                    Guide & Tips</h6>
                                                                                <div class="text-dark"
                                                                                    style="font-size: 0.85rem; line-height: 1.45; font-weight: 500;">
                                                                                    As a <strong>HEPA
                                                                                        Administrator</strong>, you can
                                                                                    assign users to the
                                                                                    <strong>ADVISOR</strong> role, or
                                                                                    revoke roles back to
                                                                                    <strong>STUDENT</strong>.
                                                                                    Chairpersons are assigned
                                                                                    automatically via Club creation.
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="card mt-4">
                                                                <div class="table-responsive text-nowrap">
                                                                    <table class="table table-hover">
                                                                        <thead>
                                                                            <tr>
                                                                                <th class="text-center"
                                                                                    style="width: 70px;">#</th>
                                                                                <th onclick="sortTable(1)"
                                                                                    style="cursor: pointer; user-select: none;">
                                                                                    ID <i
                                                                                        class="bx bx-sort-alt-2 ms-1 small text-muted"></i>
                                                                                </th>
                                                                                <th onclick="sortTable(2)"
                                                                                    style="cursor: pointer; user-select: none;">
                                                                                    Full Name <i
                                                                                        class="bx bx-sort-alt-2 ms-1 small text-muted"></i>
                                                                                </th>
                                                                                <th onclick="sortTable(3)"
                                                                                    style="cursor: pointer; user-select: none;">
                                                                                    Username <i
                                                                                        class="bx bx-sort-alt-2 ms-1 small text-muted"></i>
                                                                                </th>
                                                                                <th>Email Address</th>
                                                                                <th onclick="sortTable(5)"
                                                                                    style="cursor: pointer; user-select: none;">
                                                                                    Current Role <i
                                                                                        class="bx bx-sort-alt-2 ms-1 small text-muted"></i>
                                                                                </th>
                                                                                <th class="text-center">Actions</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <% List<User> userList = (List<User>)
                                                                                    request.getAttribute("userList");
                                                                                    if(userList != null &&
                                                                                    !userList.isEmpty()) {
                                                                                    int userIndex = 0;
                                                                                    for(User u : userList) {
                                                                                    userIndex++;
                                                                                    String roleClass =
                                                                                    "bg-label-primary";
                                                                                    if(u.getRole().equals("HEPA"))
                                                                                    roleClass =
                                                                                    "bg-label-danger";
                                                                                    if(u.getRole().equals("ADVISOR"))
                                                                                    roleClass =
                                                                                    "bg-label-success";
                                                                                    if(u.getRole().equals("CHAIRPERSON"))
                                                                                    roleClass
                                                                                    = "bg-label-warning";
                                                                                    %>
                                                                                    <tr>
                                                                                        <td
                                                                                            class="text-center fw-semibold text-muted">
                                                                                            <%= userIndex %>
                                                                                        </td>
                                                                                        <td class="px-4 text-muted">#<%=
                                                                                                u.getUserId() %>
                                                                                        </td>
                                                                                        <td class="fw-bold">
                                                                                            <%= u.getFullName() %>
                                                                                        </td>
                                                                                        <td
                                                                                            class="text-muted fst-italic">
                                                                                            <%= u.getUsername() %>
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
                                                                                            <% if(!u.getRole().equals("HEPA"))
                                                                                                { %>
                                                                                                <div
                                                                                                    class="d-flex justify-content-center align-items-center">
                                                                                                    <form action="users"
                                                                                                        method="POST"
                                                                                                        class="m-0">
                                                                                                        <input
                                                                                                            type="hidden"
                                                                                                            name="action"
                                                                                                            value="updateRole">
                                                                                                        <input
                                                                                                            type="hidden"
                                                                                                            name="userId"
                                                                                                            value="<%= u.getUserId() %>">
                                                                                                        <div
                                                                                                            class="input-group input-group-sm">
                                                                                                            <select
                                                                                                                name="newRole"
                                                                                                                class="form-select form-select-sm assign-select"
                                                                                                                style="max-width: 150px; border-top-right-radius: 0 !important; border-bottom-right-radius: 0 !important; border-right: none !important;">
                                                                                                                <option
                                                                                                                    value="STUDENT"
                                                                                                                    <%=u.getRole().equals("STUDENT")
                                                                                                                    ? "selected"
                                                                                                                    : ""
                                                                                                                    %>
                                                                                                                    >Student
                                                                                                                </option>
                                                                                                                <option
                                                                                                                    value="ADVISOR"
                                                                                                                    <%=u.getRole().equals("ADVISOR")
                                                                                                                    ? "selected"
                                                                                                                    : ""
                                                                                                                    %>
                                                                                                                    >Advisor
                                                                                                                </option>
                                                                                                                <option
                                                                                                                    value="CHAIRPERSON"
                                                                                                                    <%=u.getRole().equals("CHAIRPERSON")
                                                                                                                    ? "selected"
                                                                                                                    : ""
                                                                                                                    %>
                                                                                                                    >Chairperson
                                                                                                                </option>
                                                                                                            </select>
                                                                                                            <button
                                                                                                                type="submit"
                                                                                                                class="btn btn-save"
                                                                                                                style="width: auto; padding: 0 16px; border-top-left-radius: 0 !important; border-bottom-left-radius: 0 !important; margin-top: 0 !important; display: flex; align-items: center; font-size: 0.82rem; height: 35px;">Update</button>
                                                                                                        </div>
                                                                                                    </form>
                                                                                                    <form action="users"
                                                                                                        method="POST"
                                                                                                        class="m-0 ms-2"
                                                                                                        onsubmit="return confirm('Are you sure you want to delete this user? This action cannot be undone.');">
                                                                                                        <input
                                                                                                            type="hidden"
                                                                                                            name="action"
                                                                                                            value="deleteUser">
                                                                                                        <input
                                                                                                            type="hidden"
                                                                                                            name="userId"
                                                                                                            value="<%= u.getUserId() %>">
                                                                                                        <button
                                                                                                            type="submit"
                                                                                                            class="btn-delete-inline"
                                                                                                            title="Delete User">
                                                                                                            <i
                                                                                                                class="bx bx-trash"></i>
                                                                                                        </button>
                                                                                                    </form>
                                                                                                </div>
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
                                                                                            <td colspan="7"
                                                                                                class="text-center py-5 text-muted">
                                                                                                <i
                                                                                                    class="fas fa-folder-open fa-3x mb-3 text-light"></i><br>
                                                                                                No users found in the
                                                                                                system
                                                                                                registry.
                                                                                            </td>
                                                                                        </tr>
                                                                                        <% } %>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </div>

                                                            <!-- Create User Modal -->
                                                            <div class="modal fade" id="createUserModal" tabindex="-1"
                                                                aria-hidden="true">
                                                                <div class="modal-dialog modal-dialog-centered"
                                                                    role="document">
                                                                    <div class="modal-content">
                                                                        <form action="users" method="POST">
                                                                            <input type="hidden" name="action"
                                                                                value="createUser">
                                                                            <div class="modal-header">
                                                                                <h5 class="modal-title fw-bold">Create
                                                                                    New User</h5>
                                                                                <button type="button" class="btn-close"
                                                                                    data-bs-dismiss="modal"
                                                                                    aria-label="Close"></button>
                                                                            </div>
                                                                            <div class="modal-body">
                                                                                <div class="row g-3">
                                                                                    <div class="col-12 mb-3">
                                                                                        <label class="form-label">Full
                                                                                            Name <span
                                                                                                class="text-danger">*</span></label>
                                                                                        <input type="text"
                                                                                            name="fullName"
                                                                                            class="form-control"
                                                                                            required
                                                                                            placeholder="John Doe">
                                                                                    </div>
                                                                                    <div class="col-6 mb-3">
                                                                                        <label
                                                                                            class="form-label">Username
                                                                                            <span
                                                                                                class="text-danger">*</span></label>
                                                                                        <input type="text"
                                                                                            name="username"
                                                                                            class="form-control"
                                                                                            required
                                                                                            placeholder="johndoe">
                                                                                    </div>
                                                                                    <div class="col-6 mb-3">
                                                                                        <label
                                                                                            class="form-label">Password
                                                                                            <span
                                                                                                class="text-danger">*</span></label>
                                                                                        <input type="password"
                                                                                            name="password"
                                                                                            class="form-control"
                                                                                            required
                                                                                            placeholder="••••••••">
                                                                                    </div>
                                                                                    <div class="col-12 mb-3">
                                                                                        <label class="form-label">Email
                                                                                            Address <span
                                                                                                class="text-danger">*</span></label>
                                                                                        <input type="email" name="email"
                                                                                            class="form-control"
                                                                                            required
                                                                                            placeholder="john@example.com">
                                                                                    </div>
                                                                                    <div class="col-12 mb-3">
                                                                                        <label class="form-label">System
                                                                                            Role <span
                                                                                                class="text-danger">*</span></label>
                                                                                        <select name="role"
                                                                                            class="form-select"
                                                                                            required>
                                                                                            <option value="STUDENT">
                                                                                                Student</option>
                                                                                            <option value="CHAIRPERSON">
                                                                                                Chairperson</option>
                                                                                            <option value="ADVISOR">
                                                                                                Advisor</option>
                                                                                            <option value="HEPA">HEPA
                                                                                                Admin</option>
                                                                                        </select>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="modal-footer">
                                                                                <button type="button"
                                                                                    class="btn btn-label-secondary"
                                                                                    data-bs-dismiss="modal">Cancel</button>
                                                                                <button type="submit"
                                                                                    class="btn btn-primary">Create
                                                                                    User</button>
                                                                            </div>
                                                                        </form>
                                                                    </div>
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



                            <% } %>

                                <script>
                                    let sortDirections = {};

                                    function sortTable(colIndex) {
                                        const table = document.querySelector(".table");
                                        const tbody = table.querySelector("tbody");
                                        const rows = Array.from(tbody.querySelectorAll("tr"));

                                        if (rows.length === 1 && rows[0].querySelector("td[colspan]")) {
                                            return;
                                        }

                                        const currentDir = sortDirections[colIndex] || 'desc';
                                        const nextDir = currentDir === 'desc' ? 'asc' : 'desc';
                                        sortDirections[colIndex] = nextDir;

                                        rows.sort((a, b) => {
                                            let valA = a.cells[colIndex].textContent.trim();
                                            let valB = b.cells[colIndex].textContent.trim();

                                            if (colIndex === 1) {
                                                valA = parseInt(valA.replace(/[^0-9]/g, '')) || 0;
                                                valB = parseInt(valB.replace(/[^0-9]/g, '')) || 0;
                                                return nextDir === 'asc' ? valA - valB : valB - valA;
                                            }

                                            return nextDir === 'asc'
                                                ? valA.localeCompare(valB)
                                                : valB.localeCompare(valA);
                                        });

                                        rows.forEach(row => tbody.appendChild(row));

                                        const updatedRows = tbody.querySelectorAll("tr");
                                        updatedRows.forEach((row, i) => {
                                            const indexCell = row.cells[0];
                                            if (indexCell && !indexCell.hasAttribute("colspan")) {
                                                indexCell.textContent = i + 1;
                                            }
                                        });

                                        table.querySelectorAll("thead th i").forEach(icon => {
                                            if (icon.classList.contains("bx-chevron-up") || icon.classList.contains("bx-chevron-down") || icon.classList.contains("bx-sort-alt-2")) {
                                                icon.className = "bx bx-sort-alt-2 ms-1 small text-muted";
                                            }
                                        });

                                        const activeHeader = table.querySelectorAll("thead th")[colIndex];
                                        if (activeHeader) {
                                            const icon = activeHeader.querySelector("i");
                                            if (icon) {
                                                icon.className = nextDir === 'asc' ? "bx bx-chevron-up ms-1 text-primary" : "bx bx-chevron-down ms-1 text-primary";
                                            }
                                        }
                                    }

                                    document.addEventListener("DOMContentLoaded", function () {
                                        const alertEl = document.getElementById("successAlert");
                                        if (alertEl) {
                                            const badge = alertEl.querySelector(".countdown-badge");
                                            let timeLeft = 3;
                                            const interval = setInterval(() => {
                                                timeLeft--;
                                                if (badge) {
                                                    badge.textContent = timeLeft + "s";
                                                }
                                                if (timeLeft <= 0) {
                                                    clearInterval(interval);
                                                    const bsAlert = new bootstrap.Alert(alertEl);
                                                    bsAlert.close();
                                                }
                                            }, 1000);
                                        }
                                    });
                                </script>
                </body>

                </html>