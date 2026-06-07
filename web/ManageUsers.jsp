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
                                                    Manage Users
                                                </h4>

                                                <% String message = request.getParameter("message"); %>
                                                <% if (message != null && !message.trim().isEmpty()) { %>
                                                    <div class="alert alert-success border-0 shadow-sm mb-4 alert-dismissible fade show" role="alert" id="successAlert">
                                                        <i class="bx bx-check-circle me-2"></i> <%= message %>
                                                        <span class="badge bg-white text-success ms-2 countdown-badge" style="font-size: 0.75rem; vertical-align: middle;">3s</span>
                                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                                    </div>
                                                <% } %>

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
                                                                    <th class="text-center" style="width: 70px;">#</th>
                                                                    <th onclick="sortTable(1)" style="cursor: pointer; user-select: none;">ID <i class="bx bx-sort-alt-2 ms-1 small text-muted"></i></th>
                                                                    <th onclick="sortTable(2)" style="cursor: pointer; user-select: none;">Full Name <i class="bx bx-sort-alt-2 ms-1 small text-muted"></i></th>
                                                                    <th>Email Address</th>
                                                                    <th onclick="sortTable(4)" style="cursor: pointer; user-select: none;">Current Role <i class="bx bx-sort-alt-2 ms-1 small text-muted"></i></th>
                                                                    <th class="text-center">Actions</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% List<User> userList = (List<User>)
                                                                        request.getAttribute("userList");
                                                                        if(userList != null && !userList.isEmpty()) {
                                                                        int userIndex = 0;
                                                                        for(User u : userList) {
                                                                        userIndex++;
                                                                        String roleClass = "bg-label-primary";
                                                                        if(u.getRole().equals("HEPA")) roleClass =
                                                                        "bg-label-danger";
                                                                        if(u.getRole().equals("ADVISOR")) roleClass =
                                                                        "bg-label-success";
                                                                        if(u.getRole().equals("CHAIRPERSON")) roleClass
                                                                        = "bg-label-warning";
                                                                        %>
                                                                        <tr>
                                                                            <td class="text-center fw-semibold text-muted">
                                                                                <%= userIndex %>
                                                                            </td>
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
                                                                                                 class="form-select form-select-sm assign-select"
                                                                                                 style="max-width: 150px; border-top-right-radius: 0 !important; border-bottom-right-radius: 0 !important; border-right: none !important;">
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
                                                                                                 class="btn btn-save"
                                                                                                 style="width: auto; padding: 0 16px; border-top-left-radius: 0 !important; border-bottom-left-radius: 0 !important; margin-top: 0 !important; display: flex; align-items: center; font-size: 0.82rem; height: 35px;">Update</button>
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
                                                                                <td colspan="6"
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

                             document.addEventListener("DOMContentLoaded", function() {
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