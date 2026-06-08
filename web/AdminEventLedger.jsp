<%@page import="java.util.List" %>
    <%@page import="com.lab.model.Event" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <% String role=(String) session.getAttribute("accountType"); String viewMode=(String)
                request.getAttribute("viewMode"); boolean isHepa="HEPA_GLOBAL" .equals(viewMode); boolean
                isPending="ADVISOR_PENDING" .equals(viewMode); boolean isHistory="ADVISOR_HISTORY" .equals(viewMode);
                String title=isHepa ? "Manage Events" : (isPending ? "Pending Club Proposals" : "Club Event Ledger" );
                String cardTitle=isHepa ? "Master Event Ledger" : (isPending ? "Events Pending Your Review"
                : "All Managed Events" ); String alertClass=isHepa ? "alert-danger bg-danger-soft text-dark" :
                (isPending ? "alert-info bg-info-soft text-dark" : "alert-secondary text-dark" ); String
                alertIcon=isHepa ? "bx-shield text-danger" : (isPending ? "bx-info-circle text-primary" : "bx-book-open"
                ); String alertText=isHepa
                ? "As HEPA Administrator, you possess absolute authority over the entire events pipeline. Proposals submitted by Club Chairpersons will remain completely invisible to the Student Body until you review and <strong>Approve</strong> them."
                : (isPending
                ? "As an Advisor, you can review and approve new event proposals submitted by Club Chairpersons. Approving an event authorizes it and makes it visible to the student body."
                : "This ledger displays the full historical record of all past, present, and pending events proposed by any of the clubs under your jurisdiction."
                ); %>

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
                        <% } else {%>
                            <!-- Layout wrapper -->
                            <div class="layout-wrapper layout-content-navbar">
                                <div class="layout-container">
                                    <jsp:include page="sidebar.jsp" />
                                    <div class="layout-page">
                                        <jsp:include page="navbar.jsp" />
                                        <!-- Content wrapper -->
                                        <div class="content-wrapper" style="padding: 0px 30px;">
                                            <!-- Content -->
                                            <div class=" flex-grow-1 container-p-y">

                                                <h4 class="fw-bold py-3 mb-4">

                                                    <%= title%>
                                                </h4>

                                                <div class="alert <%= alertClass%> border-0">
                                                    <i class="bx <%= alertIcon%> me-2 fs-5"
                                                        style="vertical-align: middle;"></i>
                                                    <%= alertText%>
                                                </div>

                                                <div class="row mt-4 gy-4">
                                                    <% List<Event> eventList = (List<Event>)
                                                            request.getAttribute("adminEventList");
                                                            if (eventList != null
                                                            && !eventList.isEmpty()) {
                                                            int eventIndex = 0;
                                                            for (Event e : eventList) {
                                                            eventIndex++;
                                                            boolean isPendingRow
                                                            = "PENDING".equals(e.getStatus());
                                                            boolean isApproved
                                                            = "APPROVED".equals(e.getStatus());
                                                            String badgeColor = "bg-warning text-dark"; // PENDING
                                                            String icon = "bx-time-five";
                                                            if("APPROVED".equals(e.getStatus())) {
                                                            badgeColor = "bg-success text-white";
                                                            icon = "bx-check-circle"; }
                                                            if("REJECTED".equals(e.getStatus())) {
                                                            badgeColor = "bg-danger text-white";
                                                            icon = "bx-x-circle"; }
                                                            %>
                                                            <div class="col-lg-4 col-md-6">
                                                                <div class="card club-card position-relative">
                                                                    <div class="card-inner">
                                                                        <div
                                                                            class="d-flex justify-content-between align-items-center mb-1">
                                                                            <span
                                                                                class="club-id-badge badge-index mb-0">
                                                                                #<%= eventIndex %>
                                                                            </span>
                                                                            <span class="club-id-badge badge-id mb-0">
                                                                                ID: <%= e.getEventId()%>
                                                                            </span>
                                                                        </div>

                                                                        <div class="mb-3">
                                                                            <span class="badge bg-secondary mb-2"
                                                                                style="font-size: 0.72rem; padding: 4px 8px;"><i
                                                                                    class="bx bx-flag me-1"></i>
                                                                                <%= e.getClubName()%>
                                                                            </span>
                                                                            <h5 class="fw-bold text-dark mb-1"
                                                                                style="font-size: 1.1rem; line-height: 1.3;">
                                                                                <%= e.getEventName()%>
                                                                            </h5>
                                                                            <span class="badge <%= badgeColor %>"
                                                                                style="font-size: 0.72rem; padding: 4px 8px;"><i
                                                                                    class="bx <%= icon %> me-1"></i>
                                                                                <%= e.getStatus()%>
                                                                            </span>
                                                                        </div>

                                                                        <p class="text-muted small mb-3"
                                                                            style="min-height: 55px; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; line-height: 1.4;">
                                                                            <%= e.getDescription()%>
                                                                        </p>

                                                                        <hr class="divider-soft">

                                                                        <div class="assign-section mt-3">
                                                                            <div
                                                                                class="mb-2 d-flex align-items-center gap-2">
                                                                                <i
                                                                                    class="bx bx-calendar text-primary fs-5"></i>
                                                                                <div>
                                                                                    <small class="text-muted d-block"
                                                                                        style="font-size: 0.7rem; text-transform: uppercase; font-weight: 600;">Date</small>
                                                                                    <span
                                                                                        class="fs-6 text-dark fw-semibold">
                                                                                        <%= e.getDate()%>
                                                                                    </span>
                                                                                </div>
                                                                            </div>
                                                                            <div
                                                                                class="mb-2 d-flex align-items-center gap-2">
                                                                                <i
                                                                                    class="bx bx-map-pin text-danger fs-5"></i>
                                                                                <div>
                                                                                    <small class="text-muted d-block"
                                                                                        style="font-size: 0.7rem; text-transform: uppercase; font-weight: 600;">Venue</small>
                                                                                    <span
                                                                                        class="fs-6 text-dark fw-semibold">
                                                                                        <%= e.getVenue()%>
                                                                                    </span>
                                                                                </div>
                                                                            </div>
                                                                            <div
                                                                                class="mb-2 d-flex align-items-center gap-2">
                                                                                <i
                                                                                    class="bx bx-group text-info fs-5"></i>
                                                                                <div>
                                                                                    <small class="text-muted d-block"
                                                                                        style="font-size: 0.7rem; text-transform: uppercase; font-weight: 600;">Quota</small>
                                                                                    <span
                                                                                        class="fs-6 text-dark fw-semibold">
                                                                                        <%= e.getQuota()%> Pax
                                                                                    </span>
                                                                                </div>
                                                                            </div>
                                                                            <div
                                                                                class="mb-0 d-flex align-items-center gap-2">
                                                                                <i
                                                                                    class="bx bx-purchase-tag-alt text-success fs-5"></i>
                                                                                <div>
                                                                                    <small class="text-muted d-block"
                                                                                        style="font-size: 0.7rem; text-transform: uppercase; font-weight: 600;">Category</small>
                                                                                    <span
                                                                                        class="fs-6 text-dark fw-semibold"
                                                                                        style="text-transform: capitalize;">
                                                                                         <%= e.getCategory() != null ? e.getCategory() : "N/A" %>
                                                                                    </span>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <% if (isPendingRow && !isHistory) { %>
                                                                            <div
                                                                                class="d-flex align-items-center gap-2 mt-3 w-100">
                                                                                <form action="events" method="POST"
                                                                                    class="w-50 mb-0"
                                                                                    onsubmit="return confirm('APPROVE: Are you sure you want to authorize this event?');">
                                                                                    <input type="hidden" name="eventId"
                                                                                        value="<%= e.getEventId()%>">
                                                                                    <input type="hidden" name="action"
                                                                                        value="approve">
                                                                                    <button type="submit"
                                                                                        class="btn-approve-action">
                                                                                        <i class="bx bx-check me-1"></i>
                                                                                        Approve
                                                                                    </button>
                                                                                </form>
                                                                                <form action="events" method="POST"
                                                                                    class="w-50 mb-0"
                                                                                    onsubmit="return confirm('REJECT: Are you sure you want to reject this event?');">
                                                                                    <input type="hidden" name="eventId"
                                                                                        value="<%= e.getEventId()%>">
                                                                                    <input type="hidden" name="action"
                                                                                        value="reject">
                                                                                    <button type="submit"
                                                                                        class="btn-reject-action"
                                                                                        title="Reject Event">
                                                                                        <i class="bx bx-x me-1"></i>
                                                                                        Reject
                                                                                    </button>
                                                                                </form>
                                                                            </div>
                                                                            <% } else { %>
                                                                                <div class="mt-3 text-center">
                                                                                    <span
                                                                                        class="text-muted small border px-2 py-1 rounded bg-light d-block"><i
                                                                                            class="bx bx-lock me-1"></i>
                                                                                        Locked Status</span>
                                                                                </div>
                                                                                <% } %>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <% /* Insert a full-width spacer row after every 3rd card */
                                                                if (eventIndex % 3==0) { %>
                                                                <div class="col-12" style="margin-bottom: 280px;"></div>
                                                                <% } %>
                                                                    <% } } else {%>
                                                                        <div class="col-12 text-center py-5 text-muted">
                                                                            <i
                                                                                class="bx bx-check-circle fa-3x mb-3 text-success"></i><br>
                                                                            No events found in this category.
                                                                        </div>
                                                                        <% } %>
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
                            <% }%>
                </body>

                </html>