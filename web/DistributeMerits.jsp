<%@page import="java.util.List" %>
    <%@page import="com.lab.model.Event" %>
        <%@page import="com.lab.dao.MeritDAO" %>
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


                                            <!--SINI-->

                                            <!-- Content wrapper -->
                                            <div class="content-wrapper" style="padding: 0px 30px;">
                                                <!-- Content -->
                                                <div class=" flex-grow-1 container-p-y">

                                                    <h4 class="fw-bold py-3 mb-4 d-flex align-items-center">
                                                        Distribute Merits
                                                        <i class="bx bx-info-circle text-info ms-2"
                                                            style="cursor: pointer; font-size: 1.5rem; vertical-align: middle;"
                                                            data-bs-toggle="collapse" data-bs-target="#pageTipsCollapse"
                                                            title="Toggle Page Guide"></i>
                                                    </h4>

                                                    <% if(request.getParameter("success") !=null) { %>
                                                        <div class="alert alert-success border-0 shadow-sm mb-4 alert-dismissible fade show d-flex align-items-center"
                                                            role="alert" id="successAlert">
                                                            <i class="bx bx-check-circle me-3 fs-3"></i>
                                                            <div>
                                                                <strong>Merits Distributed Successfully!</strong><br>
                                                                Students have automatically received their event points
                                                                on their immutable
                                                                transcript.
                                                                <span
                                                                    class="badge bg-white text-success ms-2 countdown-badge"
                                                                    style="font-size: 0.75rem; vertical-align: middle;">3s</span>
                                                            </div>
                                                            <button type="button" class="btn-close"
                                                                data-bs-dismiss="alert" aria-label="Close"></button>
                                                        </div>
                                                        <% } %>

                                                            <% if(request.getParameter("deleted") !=null) { %>
                                                                <div class="alert alert-success border-0 shadow-sm mb-4 alert-dismissible fade show d-flex align-items-center"
                                                                    role="alert" id="successAlert">
                                                                    <i class="bx bx-check-circle me-3 fs-3"></i>
                                                                    <div>
                                                                        <strong>Merits Revoked
                                                                            Successfully!</strong><br>
                                                                        Students points for this event have been
                                                                        removed.
                                                                        <span
                                                                            class="badge bg-white text-success ms-2 countdown-badge"
                                                                            style="font-size: 0.75rem; vertical-align: middle;">3s</span>
                                                                    </div>
                                                                    <button type="button" class="btn-close"
                                                                        data-bs-dismiss="alert"
                                                                        aria-label="Close"></button>
                                                                </div>
                                                                <% } %>

                                                                    <div class="collapse show mb-4"
                                                                        id="pageTipsCollapse">
                                                                        <div class="card border-0 bg-label-info shadow-none"
                                                                            style="border-radius: 12px;">
                                                                            <div class="card-body p-3">
                                                                                <div
                                                                                    class="d-flex align-items-center gap-3">
                                                                                    <div class="bg-info text-white d-flex align-items-center justify-content-center"
                                                                                        style="width: 36px; height: 36px; border-radius: 8px; font-size: 1.2rem; flex-shrink: 0;">
                                                                                        <i
                                                                                            class="bx bx-info-circle"></i>
                                                                                    </div>
                                                                                    <div class="flex-grow-1">
                                                                                        <h6 class="mb-1 text-info fw-bold"
                                                                                            style="font-size: 0.95rem;">
                                                                                            Page Guide & Tips</h6>
                                                                                        <div class="text-dark"
                                                                                            style="font-size: 0.85rem; line-height: 1.45; font-weight: 500;">
                                                                                            Select a finalized event
                                                                                            below to systematically drop
                                                                                            merit points to its verified
                                                                                            attendees. Doing this locks
                                                                                            the specific event
                                                                                            transcript permanently.
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="card  border-0">
                                                                        <div class="card-body p-0">
                                                                            <div class="table-responsive">
                                                                                <table
                                                                                    class="table table-hover align-middle mb-0">
                                                                                    <thead
                                                                                        class="bg-light text-muted small text-uppercase">
                                                                                        <tr>
                                                                                            <th class="text-center"
                                                                                                style="width: 70px;">#
                                                                                            </th>
                                                                                            <th class="ps-4">ID</th>
                                                                                            <th>Event Details</th>
                                                                                            <th>Criteria Info</th>
                                                                                            <th>Status</th>
                                                                                            <th class="text-end pe-4">
                                                                                                Actions
                                                                                            </th>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody>
                                                                                        <% List<Event> approvedEvents =
                                                                                            (List
                                                                                            <Event>)
                                                                                                request.getAttribute("approvedEvents");
                                                                                                MeritDAO meritDAO =
                                                                                                (MeritDAO)
                                                                                                request.getAttribute("meritDAO");

                                                                                                int rowIndex = 1;
                                                                                                if(approvedEvents !=
                                                                                                null &&
                                                                                                !approvedEvents.isEmpty())
                                                                                                {
                                                                                                for(Event e :
                                                                                                approvedEvents) {
                                                                                                boolean
                                                                                                isAlreadyDistributed =
                                                                                                meritDAO.isDistributed(e.getEventId());
                                                                                                %>

                                                                                                <% String
                                                                                                    temporary=isAlreadyDistributed
                                                                                                    ? "opacity-75 bg-light"
                                                                                                    : "" ; %>
                                                                                                    <tr
                                                                                                        class="<%= temporary %>">
                                                                                                        <td
                                                                                                            class="ps-4 fw-bold">
                                                                                                            <%= rowIndex++
                                                                                                                %>
                                                                                                        </td>
                                                                                                        <td
                                                                                                            class="ps-4">
                                                                                                            <span
                                                                                                                class="badge bg-secondary">#EVENT-
                                                                                                                <%= e.getEventId()
                                                                                                                    %>
                                                                                                            </span>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <strong
                                                                                                                class="d-block text-dark">
                                                                                                                <%= e.getEventName()
                                                                                                                    %>
                                                                                                            </strong>
                                                                                                            <span
                                                                                                                class="small text-muted"><i
                                                                                                                    class="fas fa-flag text-primary me-1"></i>
                                                                                                                <%= e.getClubName()
                                                                                                                    %>
                                                                                                            </span>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <span
                                                                                                                class="badge bg-info-soft text-info"><i
                                                                                                                    class="fas fa-bullseye me-1"></i>
                                                                                                                <%= e.getCriteria()
                                                                                                                    %> |
                                                                                                                    <%= e.getCategory()
                                                                                                                        %>
                                                                                                            </span>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <% if(isAlreadyDistributed)
                                                                                                                { %>
                                                                                                                <span
                                                                                                                    class="badge bg-success"><i
                                                                                                                        class="fas fa-lock me-1"></i>
                                                                                                                    LOGGED</span>
                                                                                                                <% } else
                                                                                                                    { %>
                                                                                                                    <span
                                                                                                                        class="badge bg-warning text-dark"><i
                                                                                                                            class="fas fa-hourglass-start me-1"></i>
                                                                                                                        PENDING
                                                                                                                        MASS-PAYOUT</span>
                                                                                                                    <% }
                                                                                                                        %>
                                                                                                        </td>
                                                                                                        <td
                                                                                                            class="text-end pe-4">
                                                                                                            <% if(isAlreadyDistributed)
                                                                                                                { %>
                                                                                                                <div
                                                                                                                    class="d-inline-flex gap-2 align-items-center">
                                                                                                                    <button
                                                                                                                        class="btn btn-sm btn-secondary "
                                                                                                                        disabled><i
                                                                                                                            class="fas fa-check-double me-1"></i>
                                                                                                                        Points
                                                                                                                        Sent</button>
                                                                                                                    <form
                                                                                                                        action="merits"
                                                                                                                        method="POST"
                                                                                                                        class="m-0"
                                                                                                                        onsubmit="return confirm('DELETE MERITS: Are you sure you want to revoke points for this event?');">
                                                                                                                        <input
                                                                                                                            type="hidden"
                                                                                                                            name="action"
                                                                                                                            value="deleteMerits">
                                                                                                                        <input
                                                                                                                            type="hidden"
                                                                                                                            name="eventId"
                                                                                                                            value="<%= e.getEventId() %>">
                                                                                                                        <button
                                                                                                                            type="submit"
                                                                                                                            class="btn btn-sm btn-danger fw-bold px-3"><i
                                                                                                                                class="fas fa-trash me-1"></i>
                                                                                                                            Revoke</button>
                                                                                                                    </form>
                                                                                                                </div>
                                                                                                                <% } else
                                                                                                                    { %>
                                                                                                                    <form
                                                                                                                        action="merits?action=distributeMerits"
                                                                                                                        method="POST"
                                                                                                                        class="d-inline-flex gap-2 align-items-center"
                                                                                                                        onsubmit="return confirm('WARNING: You are about to mass distribute points to all physically verified attendees for <%= e.getEventName() %>. This is immutable. Proceed?'
                                                                                        );">
                                                                                                                        <input
                                                                                                                            type="hidden"
                                                                                                                            name="eventId"
                                                                                                                            value="<%= e.getEventId() %>">

                                                                                                                        <button
                                                                                                                            type="submit"
                                                                                                                            class="btn btn-sm btn-success fw-bold  px-3"><i
                                                                                                                                class="fas fa-bolt me-1"></i>
                                                                                                                            Issue
                                                                                                                            Points</button>
                                                                                                                    </form>
                                                                                                                    <% }
                                                                                                                        %>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <% } } else { %>
                                                                                                        <tr>
                                                                                                            <td colspan="5"
                                                                                                                class="text-center py-5 text-muted">
                                                                                                                <i
                                                                                                                    class="fas fa-clipboard-check fa-3x mb-3 text-light"></i><br>
                                                                                                                No
                                                                                                                approved
                                                                                                                events
                                                                                                                available.
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <% } %>
                                                                                    </tbody>
                                                                                </table>
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

                                <jsp:include page="footer.jsp" />

                                <% } %>
                                    <script>
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