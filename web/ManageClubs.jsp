<%@page import="java.util.List" %>
    <%@page import="com.lab.model.User" %>
        <%@page import="com.lab.model.Club" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <% String role=(String) session.getAttribute("accountType"); %>

                    <jsp:include page="header.jsp" />

                    <style>
                        .club-card {
                            border: none !important;
                            border-radius: 16px !important;
                            background: #ffffff;
                            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
                            transition: transform 0.2s ease, box-shadow 0.2s ease;
                            overflow: hidden;
                            margin-bottom: 1.75rem;
                        }

                        .club-card:hover {
                            transform: translateY(-4px);
                            box-shadow: 0 8px 28px rgba(0, 0, 0, 0.13);
                        }

                        .club-card .card-banner {
                            height: 6px;
                            background: linear-gradient(90deg, #696cff, #a78bfa);
                        }

                        .club-card .card-inner {
                            padding: 20px 22px 22px;
                        }

                        .club-id-badge {
                            font-size: 0.68rem;
                            font-weight: 600;
                            letter-spacing: 0.05em;
                            color: #8592a3;
                            text-transform: uppercase;
                            margin-bottom: 6px;
                            display: block;
                        }

                        .club-name-input {
                            border: none !important;
                            border-bottom: 2px dashed #d8dee6 !important;
                            border-radius: 0 !important;
                            padding: 4px 2px !important;
                            font-size: 1.1rem !important;
                            font-weight: 700 !important;
                            color: #2d3748 !important;
                            background: transparent !important;
                            box-shadow: none !important;
                            width: 100%;
                            transition: border-color 0.2s;
                            margin-bottom: 12px;
                        }

                        .club-name-input:focus {
                            border-bottom-color: #696cff !important;
                            outline: none;
                        }

                        .club-desc-textarea {
                            border: 1px dashed #d8dee6 !important;
                            border-radius: 10px !important;
                            background: #f8f9fc !important;
                            font-size: 0.82rem !important;
                            color: #6c7a8d !important;
                            resize: none;
                            box-shadow: none !important;
                            transition: border-color 0.2s;
                        }

                        .club-desc-textarea:focus {
                            border-color: #696cff !important;
                            outline: none;
                            box-shadow: none !important;
                        }

                        .assign-section {
                            background: #f8f9fc;
                            border-radius: 12px;
                            padding: 14px 16px;
                            margin-top: 14px;
                        }

                        .assign-label {
                            font-size: 0.72rem;
                            font-weight: 700;
                            letter-spacing: 0.06em;
                            text-transform: uppercase;
                            margin-bottom: 5px;
                            display: flex;
                            align-items: center;
                            gap: 5px;
                        }

                        .assign-label.advisor {
                            color: #28c76f;
                        }

                        .assign-label.chair {
                            color: #ff9f43;
                        }

                        .assign-select {
                            font-size: 0.82rem !important;
                            border-radius: 8px !important;
                            border: 1.5px solid #e2e7ef !important;
                            background: #fff !important;
                            color: #3d4a5c !important;
                            box-shadow: none !important;
                            transition: border-color 0.2s;
                        }

                        .assign-select:focus {
                            border-color: #696cff !important;
                            box-shadow: 0 0 0 3px rgba(105, 108, 255, 0.12) !important;
                        }

                        .btn-save {
                            background: linear-gradient(135deg, #696cff, #5a5ed6);
                            border: none;
                            border-radius: 10px;
                            color: #fff;
                            font-size: 0.83rem;
                            font-weight: 600;
                            padding: 9px 0;
                            width: 100%;
                            margin-top: 16px;
                            transition: opacity 0.2s, transform 0.15s;
                            letter-spacing: 0.02em;
                        }

                        .btn-save:hover {
                            opacity: 0.92;
                            transform: translateY(-1px);
                            color: #fff;
                        }

                        .btn-delete {
                            position: absolute;
                            top: 14px;
                            right: 14px;
                            z-index: 10;
                            width: 30px;
                            height: 30px;
                            border-radius: 50%;
                            border: none;
                            background: rgba(234, 84, 85, 0.1);
                            color: #ea5455;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 0.75rem;
                            transition: background 0.2s, transform 0.15s;
                            cursor: pointer;
                        }

                        .btn-delete:hover {
                            background: #ea5455;
                            color: #fff;
                            transform: scale(1.1);
                        }

                        .divider-soft {
                            border: none;
                            border-top: 1px solid #eef0f4;
                            margin: 14px 0 0;
                        }

                        .empty-state {
                            padding: 60px 20px;
                            text-align: center;
                            color: #a0aab4;
                        }

                        .empty-state i {
                            font-size: 3rem;
                            margin-bottom: 12px;
                            display: block;
                            opacity: 0.3;
                        }

                        /* Row spacer after every 3rd card (lg breakpoint) */
                        @media (min-width: 992px) {
                            .club-row-spacer {
                                display: none;
                            }

                            .col-lg-4:nth-child(3n+1):nth-last-child(-n+3)~.col-lg-4,
                            .col-lg-4:nth-child(3n+1):nth-last-child(-n+3) {
                                /* handled by mb-4 on each card col */
                            }
                        }

                        .clubs-grid {
                            padding-bottom: 2rem;
                        }
                    </style>

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
                                                        <span class="text-muted fw-light">SERS /</span> Manage Clubs
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