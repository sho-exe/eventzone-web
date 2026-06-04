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

                                                    <h4 class="fw-bold py-3 mb-4">
                                                        <span class="text-muted fw-light">SERS /</span> System Merit
                                                        Distribution
                                                    </h4>

                                                    <% if(request.getParameter("success") !=null) { %>
                                                        <div class="alert alert-success d-flex align-items-center "
                                                            role="alert">
                                                            <i class="fas fa-check-circle fa-2x me-3"></i>
                                                            <div>
                                                                <strong>Merits Distributed Successfully!</strong><br>
                                                                Students have automatically received their event points
                                                                on their immutable
                                                                transcript.
                                                            </div>
                                                        </div>
                                                        <% } %>

                                                            <div
                                                                class="alert alert-info border-0  bg-primary-soft text-dark mb-4">
                                                                <i class="fas fa-info-circle me-2 text-primary"></i>
                                                                Select a finalized
                                                                event below to systematically drop merit points to its
                                                                verified attendees.
                                                                Doing this locks the specific event transcript
                                                                permanently.
                                                            </div>

                                                            <div class="card  border-0">
                                                                <div class="card-body p-0">
                                                                    <div class="table-responsive">
                                                                        <table
                                                                            class="table table-hover align-middle mb-0">
                                                                            <thead
                                                                                class="bg-light text-muted small text-uppercase">
                                                                                <tr>
                                                                                    <th class="ps-4">Identifier</th>
                                                                                    <th>Event Details</th>
                                                                                    <th>Criteria Info</th>
                                                                                    <th>Status</th>
                                                                                    <th class="text-end pe-4">Execute
                                                                                        Distribution</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <% List<Event> approvedEvents = (List
                                                                                    <Event>)
                                                                                        request.getAttribute("approvedEvents");
                                                                                        MeritDAO meritDAO = (MeritDAO)
                                                                                        request.getAttribute("meritDAO");

                                                                                        if(approvedEvents != null &&
                                                                                        !approvedEvents.isEmpty()) {
                                                                                        for(Event e : approvedEvents) {
                                                                                        boolean isAlreadyDistributed =
                                                                                        meritDAO.isDistributed(e.getEventId());
                                                                                        %>

                                                                                        <% String
                                                                                            temporary=isAlreadyDistributed
                                                                                            ? "opacity-75 bg-light" : ""
                                                                                            ; %>
                                                                                            <tr
                                                                                                class="<%= temporary %>">
                                                                                                <td class="ps-4">
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
                                                                                                            %> | <%=
                                                                                                                e.getCategory()
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
                                                                                                        <% } else { %>
                                                                                                            <span
                                                                                                                class="badge bg-warning text-dark"><i
                                                                                                                    class="fas fa-hourglass-start me-1"></i>
                                                                                                                PENDING
                                                                                                                MASS-PAYOUT</span>
                                                                                                            <% } %>
                                                                                                </td>
                                                                                                <td
                                                                                                    class="text-end pe-4">
                                                                                                    <% if(isAlreadyDistributed)
                                                                                                        { %>
                                                                                                        <button
                                                                                                            class="btn btn-sm btn-secondary "
                                                                                                            disabled><i
                                                                                                                class="fas fa-check-double me-1"></i>
                                                                                                            Points
                                                                                                            Sent</button>
                                                                                                        <% } else { %>
                                                                                                            <form
                                                                                                                action="MeritController?action=distributeMerits"
                                                                                                                method="POST"
                                                                                                                class="d-inline-flex gap-2 align-items-center"
                                                                                                                onsubmit="return confirm('WARNING: You are about to mass distribute points to all physically verified attendees for <%= e.getEventName() %>. This is immutable. Proceed?'
                                                                                        );">
                                                                                                                <input
                                                                                                                    type="hidden"
                                                                                                                    name="eventId"
                                                                                                                    value="<%= e.getEventId() %>">
                                                                                                                <div
                                                                                                                    class="input-group input-group-sm w-auto ">
                                                                                                                    <span
                                                                                                                        class="input-group-text bg-light text-muted"><i
                                                                                                                            class="fas fa-star"></i></span>
                                                                                                                    <input
                                                                                                                        type="number"
                                                                                                                        name="points"
                                                                                                                        class="form-control"
                                                                                                                        style="width: 80px;"
                                                                                                                        min="1"
                                                                                                                        max="100"
                                                                                                                        value="10"
                                                                                                                        required>
                                                                                                                </div>
                                                                                                                <button
                                                                                                                    type="submit"
                                                                                                                    class="btn btn-sm btn-success fw-bold  px-3"><i
                                                                                                                        class="fas fa-bolt me-1"></i>
                                                                                                                    Issue
                                                                                                                    Points</button>
                                                                                                            </form>
                                                                                                            <% } %>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <% } } else { %>
                                                                                                <tr>
                                                                                                    <td colspan="5"
                                                                                                        class="text-center py-5 text-muted">
                                                                                                        <i
                                                                                                            class="fas fa-clipboard-check fa-3x mb-3 text-light"></i><br>
                                                                                                        No approved
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
                    </body>

                    </html>