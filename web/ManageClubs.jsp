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

                                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                                        <h4 class="fw-bold m-0 py-3">
                                                            Manage Clubs
                                                        </h4>
                                                        <button type="button" class="btn btn-primary"
                                                            data-bs-toggle="modal" data-bs-target="#createClubModal">
                                                            <i class="bx bx-plus me-1"></i> New Club
                                                        </button>
                                                    </div>

                                                    <% String message=request.getParameter("message"); %>
                                                        <% if (message !=null && !message.trim().isEmpty()) { %>
                                                            <div class="alert alert-success border-0 shadow-sm mb-4 alert-dismissible fade show"
                                                                role="alert" id="successAlert">
                                                                <i class="bx bx-check-circle me-2"></i>
                                                                <%= message %>
                                                                    <span class="badge bg-white text-success ms-2 countdown-badge" style="font-size: 0.75rem; vertical-align: middle;">3s</span>
                                                                    <button type="button" class="btn-close"
                                                                        data-bs-dismiss="alert"
                                                                        aria-label="Close"></button>
                                                            </div>
                                                            <% } %>

                                                                <div class="alert alert-secondary border-0">
                                                                    <i class="bx bx-info-circle me-2"></i> Select
                                                                    established
                                                                    <strong>Advisors</strong> and
                                                                    <strong>Chairpersons</strong> to
                                                                    assign them to clubs. Unassigned clubs cannot
                                                                    propose events!
                                                                </div>

                                                                <div class="row mt-4 gy-4 clubs-grid">
                                                                    <% List<Club> clubList = (List<Club>)
                                                                            request.getAttribute("clubList");
                                                                            List<User> userList = (List<User>)
                                                                                    request.getAttribute("userList");

                                                                                    if (clubList != null &&
                                                                                    !clubList.isEmpty()) {
                                                                                    int clubIndex = 0;
                                                                                    for (Club c : clubList) {
                                                                                    clubIndex++;
                                                                                    %>
                                                                                    <div class="col-lg-4 col-md-6">
                                                                                        <div
                                                                                            class="card club-card position-relative">


                                                                                            <!-- Delete Form -->
                                                                                            <form id="deleteForm-<%= c.getClubId() %>" action="clubs" method="POST"
                                                                                                onsubmit="return confirm('WARNING: Are you absolutely sure you want to permanently delete this club?');">
                                                                                                <input type="hidden" name="action" value="deleteClub">
                                                                                                <input type="hidden" name="clubId" value="<%= c.getClubId() %>">
                                                                                            </form>

                                                                                            <!-- Update Form -->
                                                                                            <form action="clubs"
                                                                                                method="POST">
                                                                                                <input type="hidden"
                                                                                                    name="action"
                                                                                                    value="updateClub">
                                                                                                <input type="hidden"
                                                                                                    name="clubId"
                                                                                                    value="<%= c.getClubId() %>">

                                                                                                <div class="card-inner">
                                                                                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                                                                                        <span class="club-id-badge badge-index mb-0">
                                                                                                            #<%= clubIndex %>
                                                                                                        </span>
                                                                                                        <span class="club-id-badge badge-id mb-0">
                                                                                                            ID: <%= c.getClubId() %>
                                                                                                        </span>
                                                                                                    </div>
                                                                                                    <div class="position-relative mb-2">
                                                                                                        <input type="text"
                                                                                                            name="clubName"
                                                                                                            class="club-name-input"
                                                                                                            value="<%= c.getClubName() %>"
                                                                                                            required
                                                                                                            style="padding-right: 24px !important;"
                                                                                                            placeholder="Club Name">
                                                                                                        <i class="bx bx-pencil text-muted position-absolute" style="right: 4px; top: 8px; font-size: 0.9rem; pointer-events: none;"></i>
                                                                                                    </div>

                                                                                                    <div class="position-relative">
                                                                                                        <textarea
                                                                                                            name="description"
                                                                                                            class="form-control club-desc-textarea"
                                                                                                            rows="3"
                                                                                                            required
                                                                                                            style="padding-right: 28px !important; text-decoration: none !important;"
                                                                                                            spellcheck="false"
                                                                                                            placeholder="Club description..."><%= c.getDescription() %></textarea>
                                                                                                        <i class="bx bx-pencil text-muted position-absolute" style="right: 12px; top: 12px; font-size: 0.85rem; pointer-events: none;"></i>
                                                                                                    </div>

                                                                                                    <hr
                                                                                                        class="divider-soft">

                                                                                                    <div
                                                                                                        class="assign-section">
                                                                                                        <!-- Advisor -->
                                                                                                        <div
                                                                                                            class="mb-3">
                                                                                                            <div
                                                                                                                class="assign-label advisor">
                                                                                                                <i
                                                                                                                    class="bx bx-user-pin"></i>
                                                                                                                Club
                                                                                                                Advisor
                                                                                                            </div>
                                                                                                            <select
                                                                                                                name="advisorId"
                                                                                                                class="form-select form-select-sm assign-select"
                                                                                                                required>
                                                                                                                <option
                                                                                                                    value=""
                                                                                                                    disabled
                                                                                                                    <%= c.getAdvisorId() == null ? "selected" : "" %>>
                                                                                                                    — Select Advisor —
                                                                                                                </option>
                                                                                                                <% for
                                                                                                                    (User
                                                                                                                    u :
                                                                                                                    userList)
                                                                                                                    { if
                                                                                                                    (u.getRole().equals("ADVISOR")
                                                                                                                    ||
                                                                                                                    u.getRole().equals("HEPA"))
                                                                                                                    {
                                                                                                                    boolean
                                                                                                                    selected=(c.getAdvisorId()
                                                                                                                    !=null
                                                                                                                    &&
                                                                                                                    c.getAdvisorId()==u.getUserId());
                                                                                                                    %>
                                                                                                                    <option
                                                                                                                        value="<%= u.getUserId() %>"
                                                                                                                        <%=selected
                                                                                                                        ? "selected"
                                                                                                                        : ""
                                                                                                                        %>
                                                                                                                        >
                                                                                                                        <%= u.getFullName()
                                                                                                                            %>
                                                                                                                    </option>
                                                                                                                    <% } }
                                                                                                                        %>
                                                                                                            </select>
                                                                                                        </div>

                                                                                                        <!-- Chairperson -->
                                                                                                        <div
                                                                                                            class="mb-0">
                                                                                                            <div
                                                                                                                class="assign-label chair">
                                                                                                                <i
                                                                                                                    class="bx bx-user"></i>
                                                                                                                Chairperson
                                                                                                            </div>
                                                                                                            <select
                                                                                                                name="chairpersonId"
                                                                                                                class="form-select form-select-sm assign-select"
                                                                                                                required>
                                                                                                                <option
                                                                                                                    value=""
                                                                                                                    disabled
                                                                                                                    <%= c.getChairpersonId() == null ? "selected" : "" %>>
                                                                                                                    — Select Chairperson —
                                                                                                                </option>
                                                                                                                <% for
                                                                                                                    (User
                                                                                                                    u :
                                                                                                                    userList)
                                                                                                                    { if
                                                                                                                    (u.getRole().equals("CHAIRPERSON"))
                                                                                                                    {
                                                                                                                    boolean
                                                                                                                    selected=(c.getChairpersonId()
                                                                                                                    !=null
                                                                                                                    &&
                                                                                                                    c.getChairpersonId()==u.getUserId());
                                                                                                                    %>
                                                                                                                    <option
                                                                                                                        value="<%= u.getUserId() %>"
                                                                                                                        <%=selected
                                                                                                                        ? "selected"
                                                                                                                        : ""
                                                                                                                        %>
                                                                                                                        >
                                                                                                                        <%= u.getFullName()
                                                                                                                            %>
                                                                                                                    </option>
                                                                                                                    <% } }
                                                                                                                        %>
                                                                                                            </select>
                                                                                                        </div>
                                                                                                    </div>

                                                                                                    <div class="d-flex align-items-center gap-2 mt-3">
                                                                                                        <button
                                                                                                            type="submit"
                                                                                                            class="btn btn-save flex-grow-1"
                                                                                                            style="margin-top: 0 !important;">
                                                                                                            <i
                                                                                                                class="bx bx-save me-1"></i>
                                                                                                            Save Changes
                                                                                                        </button>
                                                                                                        <button type="submit" form="deleteForm-<%= c.getClubId() %>" class="btn-delete-inline" title="Delete Club">
                                                                                                            <i class="bx bx-trash"></i>
                                                                                                        </button>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </form>

                                                                                        </div>
                                                                                    </div>
                                                                                    <% /* Insert a full-width spacer row
                                                                                        after every 3rd card */ if
                                                                                        (clubIndex % 3==0) { %>
                                                                                        <div class="col-12"
                                                                                            style="margin-bottom: 170px;">
                                                                                        </div>
                                                                                        <% } } } else { %>
                                                                                            <div class="col-12">
                                                                                                <div
                                                                                                    class="empty-state">
                                                                                                    <i
                                                                                                        class="bx bx-flag"></i>
                                                                                                    No clubs have been
                                                                                                    registered
                                                                                                    yet. Click "New
                                                                                                    Club" to begin!
                                                                                                </div>
                                                                                            </div>
                                                                                            <% } %>
                                                                </div>

                                                </div>
                                                <!-- / Content -->

                                                <!-- Create Club Modal -->
                                                <div class="modal fade" id="createClubModal" tabindex="-1"
                                                    aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title fw-bold"
                                                                    id="createClubModalLabel">Create New Club</h5>
                                                                <button type="button" class="btn-close"
                                                                    data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <form action="clubs" method="POST">
                                                                <input type="hidden" name="action" value="createClub">
                                                                <div class="modal-body">
                                                                    <div class="row">
                                                                        <div class="col mb-3">
                                                                            <label for="clubName"
                                                                                class="form-label fw-semibold">Club
                                                                                Name</label>
                                                                            <input type="text" id="clubName"
                                                                                name="clubName" class="form-control"
                                                                                placeholder="Enter Club Name" required>
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <div class="col mb-3">
                                                                            <label for="description"
                                                                                class="form-label fw-semibold">Description</label>
                                                                            <textarea id="description"
                                                                                name="description" class="form-control"
                                                                                rows="3"
                                                                                placeholder="Enter Club Description"></textarea>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button"
                                                                        class="btn btn-outline-secondary"
                                                                        data-bs-dismiss="modal">Close</button>
                                                                    <button type="submit" class="btn btn-primary">Create
                                                                        Club</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>

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

                                <script>
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