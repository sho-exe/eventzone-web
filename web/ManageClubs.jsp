<%@page import="java.util.List" %>
    <%@page import="com.lab.model.User" %>
        <%@page import="com.lab.model.Club" %>
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

                                        <!-- Layout page -->
                                        <div class="layout-page">
                                            <jsp:include page="navbar.jsp" />

                                            <!-- Content wrapper -->
                                            <div class="content-wrapper" style="padding: 0 30px;">
                                                <!-- Content -->
                                                <div class="flex-grow-1 container-p-y">

                                                    <h4 class="fw-bold py-3 mb-4">
                                                        Manage Clubs
                                                    </h4>

                                                    <div class="alert alert-secondary border-0">
                                                        <i class="fas fa-info-circle me-2"></i> Select established
                                                        <strong>Advisors</strong> and <strong>Chairpersons</strong> to
                                                        assign them to clubs. Unassigned clubs cannot propose events!
                                                    </div>

                                                    <div class="row mt-4 gy-4 clubs-grid">
                                                        <% List<Club> clubList = (List<Club>)
                                                                request.getAttribute("clubList");
                                                                List<User> userList = (List<User>)
                                                                        request.getAttribute("userList");

                                                                        if (clubList != null && !clubList.isEmpty()) {
                                                                        int clubIndex = 0;
                                                                        for (Club c : clubList) {
                                                                        clubIndex++;
                                                                        %>
                                                                        <div class="col-lg-4 col-md-6">
                                                                            <div
                                                                                class="card club-card position-relative">

                                                                                <!-- Accent top bar -->
                                                                                <div class="card-banner"></div>

                                                                                <!-- Delete Button -->
                                                                                <form action="clubs" method="POST"
                                                                                    onsubmit="return confirm('WARNING: Are you absolutely sure you want to permanently delete this club?');">
                                                                                    <input type="hidden" name="action"
                                                                                        value="deleteClub">
                                                                                    <input type="hidden" name="clubId"
                                                                                        value="<%= c.getClubId() %>">
                                                                                    <button type="submit"
                                                                                        class="btn-delete"
                                                                                        title="Delete Club">
                                                                                        <i class="fas fa-trash-alt"></i>
                                                                                    </button>
                                                                                </form>

                                                                                <!-- Update Form -->
                                                                                <form action="clubs" method="POST">
                                                                                    <input type="hidden" name="action"
                                                                                        value="updateClub">
                                                                                    <input type="hidden" name="clubId"
                                                                                        value="<%= c.getClubId() %>">

                                                                                    <div class="card-inner">
                                                                                        <span class="club-id-badge">#
                                                                                            <%= c.getClubId() %>
                                                                                        </span>
                                                                                        <input type="text"
                                                                                            name="clubName"
                                                                                            class="club-name-input"
                                                                                            value="<%= c.getClubName() %>"
                                                                                            required
                                                                                            placeholder="Club Name">

                                                                                        <textarea name="description"
                                                                                            class="form-control club-desc-textarea"
                                                                                            rows="3" required
                                                                                            placeholder="Club description..."><%= c.getDescription() %></textarea>

                                                                                        <hr class="divider-soft">

                                                                                        <div class="assign-section">
                                                                                            <!-- Advisor -->
                                                                                            <div class="mb-3">
                                                                                                <div
                                                                                                    class="assign-label advisor">
                                                                                                    <i
                                                                                                        class="fas fa-user-tie"></i>
                                                                                                    Club Advisor
                                                                                                </div>
                                                                                                <select name="advisorId"
                                                                                                    class="form-select form-select-sm assign-select">
                                                                                                    <option value="">—
                                                                                                        No Advisor
                                                                                                        Assigned —
                                                                                                    </option>
                                                                                                    <% for (User u :
                                                                                                        userList) { if
                                                                                                        (u.getRole().equals("ADVISOR")
                                                                                                        ||
                                                                                                        u.getRole().equals("HEPA"))
                                                                                                        { boolean
                                                                                                        selected=(c.getAdvisorId()
                                                                                                        !=null &&
                                                                                                        c.getAdvisorId()==u.getUserId());
                                                                                                        %>
                                                                                                        <option
                                                                                                            value="<%= u.getUserId() %>"
                                                                                                            <%=selected
                                                                                                            ? "selected"
                                                                                                            : "" %>><%=
                                                                                                                u.getFullName()
                                                                                                                %>
                                                                                                        </option>
                                                                                                        <% } } %>
                                                                                                </select>
                                                                                            </div>

                                                                                            <!-- Chairperson -->
                                                                                            <div class="mb-0">
                                                                                                <div
                                                                                                    class="assign-label chair">
                                                                                                    <i
                                                                                                        class="fas fa-user-graduate"></i>
                                                                                                    Chairperson
                                                                                                </div>
                                                                                                <select
                                                                                                    name="chairpersonId"
                                                                                                    class="form-select form-select-sm assign-select">
                                                                                                    <option value="">—
                                                                                                        No Chairperson
                                                                                                        Assigned —
                                                                                                    </option>
                                                                                                    <% for (User u :
                                                                                                        userList) { if
                                                                                                        (u.getRole().equals("CHAIRPERSON"))
                                                                                                        { boolean
                                                                                                        selected=(c.getChairpersonId()
                                                                                                        !=null &&
                                                                                                        c.getChairpersonId()==u.getUserId());
                                                                                                        %>
                                                                                                        <option
                                                                                                            value="<%= u.getUserId() %>"
                                                                                                            <%=selected
                                                                                                            ? "selected"
                                                                                                            : "" %>><%=
                                                                                                                u.getFullName()
                                                                                                                %>
                                                                                                        </option>
                                                                                                        <% } } %>
                                                                                                </select>
                                                                                            </div>
                                                                                        </div>

                                                                                        <button type="submit"
                                                                                            class="btn btn-save">
                                                                                            <i
                                                                                                class="fas fa-save me-1"></i>
                                                                                            Save Changes
                                                                                        </button>
                                                                                    </div>
                                                                                </form>

                                                                            </div>
                                                                        </div>
                                                                        <% /* Insert a full-width spacer row after every
                                                                            3rd card */ if (clubIndex % 3==0) { %>
                                                                            <div class="col-12"
                                                                                style="margin-bottom: 170px;"></div>
                                                                            <% } } } else { %>
                                                                                <div class="col-12">
                                                                                    <div class="empty-state">
                                                                                        <i class="fas fa-flag"></i>
                                                                                        No clubs have been registered
                                                                                        yet. Click "New Club" to begin!
                                                                                    </div>
                                                                                </div>
                                                                                <% } %>
                                                    </div>

                                                </div>
                                                <!-- / Content -->

                                                <div class="content-backdrop fade"></div>
                                            </div>
                                            <!-- / Content wrapper -->
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