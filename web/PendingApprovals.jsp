<%@page import="java.util.List" %>
    <%@page import="com.lab.model.Event" %>
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
                                                    <span class="text-muted fw-light">SERS /</span> Pending Club
                                                    Proposals
                                                </h4>

                                                <div class="alert alert-info border-0  bg-info-soft text-dark">
                                                    <i class="fas fa-info-circle me-2 text-primary"></i> As an Advisor,
                                                    you can review and approve new event proposals submitted by Club
                                                    Chairpersons. Approving an event authorizes it and makes it visible
                                                    to the student body.
                                                </div>

                                                <div class="row mt-4">
                                                    <div class="col-12">
                                                        <div class="card  border-0">
                                                            <div class="card-header bg-white p-3 border-bottom">
                                                                <h5 class="mb-0 fw-bold"><i
                                                                        class="fas fa-clipboard-list me-2"></i> Events
                                                                    Pending Your Review</h5>
                                                            </div>
                                                            <div class="card-body p-0">
                                                                <div class="table-responsive">
                                                                    <table class="table table-hover align-middle mb-0">
                                                                        <thead
                                                                            class="bg-light text-muted small text-uppercase">
                                                                            <tr>
                                                                                <th class="ps-4">Trx ID</th>
                                                                                <th>Proposing Club</th>
                                                                                <th>Event Details</th>
                                                                                <th>Logistics</th>
                                                                                <th class="text-end pe-4">Advisor
                                                                                    Actions</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <% List<Event> eventList = (List<Event>)
                                                                                    request.getAttribute("pendingEvents");
                                                                                    if(eventList != null &&
                                                                                    !eventList.isEmpty()) {
                                                                                    for(Event e : eventList) {
                                                                                    %>
                                                                                    <tr
                                                                                        class="bg-warning-soft border-start border-warning border-4">
                                                                                        <td
                                                                                            class="ps-4 text-muted fw-bold">
                                                                                            #<%= e.getEventId() %>
                                                                                        </td>
                                                                                        <td>
                                                                                            <span
                                                                                                class="badge bg-secondary"><i
                                                                                                    class="fas fa-flag me-1"></i>
                                                                                                <%= e.getClubName() %>
                                                                                            </span>
                                                                                        </td>
                                                                                        <td>
                                                                                            <strong
                                                                                                class="text-dark d-block mb-1">
                                                                                                <%= e.getEventName() %>
                                                                                            </strong>
                                                                                            <small
                                                                                                class="text-muted d-block text-truncate"
                                                                                                style="max-width: 250px;">
                                                                                                <%= e.getDescription()
                                                                                                    %>
                                                                                            </small>
                                                                                            <span
                                                                                                class="badge bg-light text-dark border mt-1"><i
                                                                                                    class="fas fa-bullseye me-1"></i>
                                                                                                <%= e.getCriteria() %> |
                                                                                                    <%= e.getCategory()
                                                                                                        %>
                                                                                            </span>
                                                                                        </td>
                                                                                        <td>
                                                                                            <div
                                                                                                class="small fw-bold text-dark">
                                                                                                <i
                                                                                                    class="far fa-calendar-alt text-primary me-2"></i>
                                                                                                <%= e.getDate() %>
                                                                                            </div>
                                                                                            <div
                                                                                                class="small text-muted">
                                                                                                <i
                                                                                                    class="fas fa-map-marker-alt text-danger me-2"></i>
                                                                                                <%= e.getVenue() %>
                                                                                            </div>
                                                                                            <div
                                                                                                class="small text-muted">
                                                                                                <i
                                                                                                    class="fas fa-users text-info me-2"></i>
                                                                                                <%= e.getQuota() %> Pax
                                                                                                    Limit
                                                                                            </div>
                                                                                        </td>
                                                                                        <td class="text-end pe-4">
                                                                                            <div
                                                                                                class="d-flex justify-content-end gap-2">
                                                                                                <form
                                                                                                    action="EventController?action=pending"
                                                                                                    method="POST"
                                                                                                    onsubmit="return confirm('APPROVE: Are you sure you want to authorize this event and make it live?');">
                                                                                                    <input type="hidden"
                                                                                                        name="eventId"
                                                                                                        value="<%= e.getEventId() %>">
                                                                                                    <input type="hidden"
                                                                                                        name="action"
                                                                                                        value="approve">
                                                                                                    <button
                                                                                                        type="submit"
                                                                                                        class="btn btn-sm btn-success fw-bold "><i
                                                                                                            class="fas fa-check me-1"></i>
                                                                                                        Approve</button>
                                                                                                </form>
                                                                                                <form
                                                                                                    action="EventController?action=pending"
                                                                                                    method="POST"
                                                                                                    onsubmit="return confirm('REJECT: Are you sure you want to reject this event proposal?');">
                                                                                                    <input type="hidden"
                                                                                                        name="eventId"
                                                                                                        value="<%= e.getEventId() %>">
                                                                                                    <input type="hidden"
                                                                                                        name="action"
                                                                                                        value="reject">
                                                                                                    <button
                                                                                                        type="submit"
                                                                                                        class="btn btn-sm btn-outline-danger "><i
                                                                                                            class="fas fa-times me-1"></i>
                                                                                                        Reject</button>
                                                                                                </form>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <% } } else { %>
                                                                                        <tr>
                                                                                            <td colspan="5"
                                                                                                class="text-center py-5 text-muted">
                                                                                                <i
                                                                                                    class="fas fa-check-circle fa-3x mb-3 text-success"></i><br>
                                                                                                You're all caught up! No
                                                                                                events pending your
                                                                                                approval.
                                                                                            </td>
                                                                                        </tr>
                                                                                        <% } %>
                                                                        </tbody>
                                                                    </table>
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