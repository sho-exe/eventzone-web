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
                                                    <span class="text-muted fw-light">SERS /</span> Club Event Ledger
                                                </h4>

                                                <div class="alert alert-secondary border-0  text-dark">
                                                    <i class="fas fa-book me-2"></i> This ledger displays the full
                                                    historical record of all past, present, and pending events proposed
                                                    by any of the clubs under your jurisdiction.
                                                </div>

                                                <div class="row mt-4">
                                                    <div class="col-12">
                                                        <div class="card  border-0">
                                                            <div class="card-header bg-white p-3 border-bottom">
                                                                <h5 class="mb-0 fw-bold"><i
                                                                        class="fas fa-list me-2"></i> All Managed Events
                                                                </h5>
                                                            </div>
                                                            <div class="card-body p-0">
                                                                <div class="table-responsive">
                                                                    <table class="table table-hover align-middle mb-0">
                                                                        <thead
                                                                            class="bg-light text-muted small text-uppercase">
                                                                            <tr>
                                                                                <th class="ps-4">Record ID</th>
                                                                                <th>Proposing Club</th>
                                                                                <th>Event Summary</th>
                                                                                <th>Key Logistics</th>
                                                                                <th class="text-end pe-4">Pipeline
                                                                                    Status</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <% List<Event> eventList = (List<Event>)
                                                                                    request.getAttribute("clubEvents");
                                                                                    if(eventList != null &&
                                                                                    !eventList.isEmpty()) {
                                                                                    for(Event e : eventList) {
                                                                                    boolean isPending =
                                                                                    "PENDING".equals(e.getStatus());
                                                                                    boolean isApproved =
                                                                                    "APPROVED".equals(e.getStatus());
                                                                                    %>
                                                                                    <tr class="<%= isPending ? "
                                                                                        bg-light opacity-75" : "" %>">
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
                                                                                            <% if(isPending) { %>
                                                                                                <span
                                                                                                    class="badge bg-warning text-dark"><i
                                                                                                        class="fas fa-hourglass-half me-1"></i>
                                                                                                    PENDING
                                                                                                    VERIFICATION</span>
                                                                                                <% } else if(isApproved)
                                                                                                    { %>
                                                                                                    <span
                                                                                                        class="badge bg-success"><i
                                                                                                            class="fas fa-check-double me-1"></i>
                                                                                                        AUTHORIZED &
                                                                                                        LIVE</span>
                                                                                                    <% } else { %>
                                                                                                        <span
                                                                                                            class="badge bg-danger"><i
                                                                                                                class="fas fa-ban me-1"></i>
                                                                                                            PERMANENTLY
                                                                                                            REJECTED</span>
                                                                                                        <% } %>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <% } } else { %>
                                                                                        <tr>
                                                                                            <td colspan="5"
                                                                                                class="text-center py-5 text-muted">
                                                                                                <i
                                                                                                    class="fas fa-inbox fa-3x mb-3 text-light"></i><br>
                                                                                                Your clubs have not
                                                                                                proposed any events yet.
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