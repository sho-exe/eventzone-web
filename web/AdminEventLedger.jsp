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
                ? "Proposals submitted by Club Chairpersons will remain completely invisible to the Students Page until you review and <strong>Approve</strong> them."
                : (isPending
                ? "As an Advisor, you can review and approve new event proposals submitted by Club Chairpersons. Approving an event authorizes it and makes it visible to the student body."
                : "This ledger displays the full historical record of all past, present, and pending events proposed by any of the clubs under your jurisdiction."
                ); %>

                <jsp:include page="header.jsp" />

                <style>
                    @media (min-width: 992px) {
                        .border-lg-end {
                            border-right: 1px solid #eef0f4;
                        }
                    }

                    .detail-icon {
                        width: 32px;
                        height: 32px;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        border-radius: 8px;
                        font-size: 1.1rem;
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

                                                <h4 class="fw-bold py-3 mb-4 d-flex align-items-center">
                                                    <%= title%>
                                                        <i class="bx bx-info-circle text-info ms-2"
                                                            style="cursor: pointer; font-size: 1.5rem; vertical-align: middle;"
                                                            data-bs-toggle="collapse" data-bs-target="#pageTipsCollapse"
                                                            title="Toggle Page Guide"></i>
                                                </h4>

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
                                                                        style="font-size: 0.95rem;">Page Guide & Tips
                                                                    </h6>
                                                                    <div class="text-dark"
                                                                        style="font-size: 0.85rem; line-height: 1.45; font-weight: 500;">
                                                                        <%= alertText%>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row mt-4">
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
                                                            String badgeColor = "bg-label-warning"; // PENDING
                                                            String icon = "bx-time-five";
                                                            if("APPROVED".equals(e.getStatus())) {
                                                            badgeColor = "bg-label-success";
                                                            icon = "bx-check-circle"; }
                                                            if("REJECTED".equals(e.getStatus())) {
                                                            badgeColor = "bg-label-danger";
                                                            icon = "bx-x-circle"; }
                                                            %>
                                                            <div class="col-12">
                                                                <div
                                                                    class="card club-card position-relative shadow-sm border-0 mb-4">
                                                                    <div class="card-inner p-4">
                                                                        <div class="row">
                                                                            <!-- Col 1: Index and Basic Meta Information (Club Badge, Status Badge, ID) -->
                                                                            <div
                                                                                class="col-lg-1 col-md-2 col-12 mb-3 mb-md-0 border-lg-end">
                                                                                <div
                                                                                    class="d-flex flex-column align-items-start gap-2 pe-lg-3">
                                                                                    <span
                                                                                        class="badge bg-label-secondary text-secondary fw-bold"
                                                                                        style="font-size: 1.05rem; padding: 8px 14px;">
                                                                                        <%= eventIndex %>
                                                                                    </span>
                                                                                    <span class="badge fw-bold"
                                                                                        style="font-size: 0.9rem; background-color: var(--role-accent-light); color: var(--role-accent); padding: 6px 12px;">
                                                                                        ID: <%= e.getEventId()%>
                                                                                    </span>
                                                                                </div>
                                                                            </div>

                                                                            <!-- Col 2: Event Name & Description -->
                                                                            <div
                                                                                class="col-lg-7 col-md-10 col-12 mb-3 mb-md-0 px-lg-4 border-lg-end">
                                                                                <div class="mb-2">
                                                                                    <span
                                                                                        class="badge bg-label-secondary text-secondary d-inline-block px-3 py-2 fw-semibold"
                                                                                        style="font-size: 0.75rem; border-radius: 6px;">
                                                                                        <i class="bx bx-flag me-1"></i>
                                                                                        <%= e.getClubName()%>
                                                                                    </span>
                                                                                </div>
                                                                                <h5 class="fw-bold text-dark mb-2"
                                                                                    style="font-size: 1.4rem; line-height: 1.3;">
                                                                                    <%= e.getEventName()%>
                                                                                </h5>
                                                                                <p class="text-muted mb-0"
                                                                                    style="line-height: 1.5; font-size: 0.95rem;">
                                                                                    <%= e.getDescription()%>
                                                                                </p>
                                                                            </div>

                                                                            <!-- Col 3: Details & Actions -->
                                                                            <div
                                                                                class="col-lg-4 col-md-12 col-12 mt-4 mt-lg-0 ps-lg-4 d-flex flex-column justify-content-between">
                                                                                <div class="row g-2 mb-3">
                                                                                    <div
                                                                                        class="col-6 d-flex align-items-center gap-2">
                                                                                        <span
                                                                                            class="detail-icon bg-label-primary">
                                                                                            <i
                                                                                                class="bx bx-calendar"></i>
                                                                                        </span>
                                                                                        <div>
                                                                                            <small
                                                                                                class="text-muted d-block"
                                                                                                style="font-size: 0.65rem; text-transform: uppercase;">Date</small>
                                                                                            <span
                                                                                                class="fw-semibold text-dark text-nowrap"
                                                                                                style="font-size: 0.82rem;">
                                                                                                <%= e.getDate()%>
                                                                                            </span>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div
                                                                                        class="col-6 d-flex align-items-center gap-2">
                                                                                        <span
                                                                                            class="detail-icon bg-label-danger">
                                                                                            <i
                                                                                                class="bx bx-map-pin"></i>
                                                                                        </span>
                                                                                        <div>
                                                                                            <small
                                                                                                class="text-muted d-block"
                                                                                                style="font-size: 0.65rem; text-transform: uppercase;">Venue</small>
                                                                                            <span
                                                                                                class="fw-semibold text-dark text-nowrap"
                                                                                                style="font-size: 0.82rem;">
                                                                                                <%= e.getVenue()%>
                                                                                            </span>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div
                                                                                        class="col-6 d-flex align-items-center gap-2">
                                                                                        <span
                                                                                            class="detail-icon bg-label-info">
                                                                                            <i class="bx bx-group"></i>
                                                                                        </span>
                                                                                        <div>
                                                                                            <small
                                                                                                class="text-muted d-block"
                                                                                                style="font-size: 0.65rem; text-transform: uppercase;">Quota</small>
                                                                                            <span
                                                                                                class="fw-semibold text-dark text-nowrap"
                                                                                                style="font-size: 0.82rem;">
                                                                                                <%= e.getQuota()%> Pax
                                                                                            </span>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div
                                                                                        class="col-6 d-flex align-items-center gap-2">
                                                                                        <span
                                                                                            class="detail-icon bg-label-success">
                                                                                            <i
                                                                                                class="bx bx-purchase-tag-alt"></i>
                                                                                        </span>
                                                                                        <div>
                                                                                            <small
                                                                                                class="text-muted d-block"
                                                                                                style="font-size: 0.65rem; text-transform: uppercase;">Category</small>
                                                                                            <span
                                                                                                class="fw-semibold text-dark text-nowrap text-capitalize"
                                                                                                style="font-size: 0.82rem;">
                                                                                                <%= e.getCategory()
                                                                                                    !=null ?
                                                                                                    e.getCategory()
                                                                                                    : "N/A" %>
                                                                                            </span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <div
                                                                                    class="d-flex align-items-center gap-2 mb-3">
                                                                                    <span
                                                                                        class="detail-icon bg-label-warning">
                                                                                        <i class="bx bx-globe"></i>
                                                                                    </span>
                                                                                    <div>
                                                                                        <small
                                                                                            class="text-muted d-block"
                                                                                            style="font-size: 0.65rem; text-transform: uppercase;">SDG
                                                                                            Goals</small>
                                                                                        <span
                                                                                            class="fw-semibold text-dark"
                                                                                            style="font-size: 0.82rem;">
                                                                                            <%= e.getSdgGoals() !=null
                                                                                                &&
                                                                                                !e.getSdgGoals().isEmpty()
                                                                                                ? e.getSdgGoals()
                                                                                                : "N/A" %>
                                                                                        </span>
                                                                                    </div>
                                                                                </div>

                                                                                <div class="mb-2">
                                                                                    <span
                                                                                        class="badge <%= badgeColor %> px-3 py-2 fw-semibold w-100 d-flex align-items-center justify-content-center"
                                                                                        style="font-size: 0.75rem; border-radius: 6px;">
                                                                                        <i
                                                                                            class="bx <%= icon %> me-1"></i>
                                                                                        <%= e.getStatus()%>
                                                                                    </span>
                                                                                </div>
                                                                                <div
                                                                                    class="d-flex flex-nowrap align-items-stretch gap-2 w-100">
                                                                                    <% if (isPendingRow && !isHistory) {
                                                                                        %>
                                                                                        <form action="events"
                                                                                            method="POST"
                                                                                            class="mb-0 flex-grow-1 d-flex"
                                                                                            onsubmit="return confirm('APPROVE: Are you sure you want to authorize this event?');">
                                                                                            <input type="hidden"
                                                                                                name="eventId"
                                                                                                value="<%= e.getEventId()%>">
                                                                                            <input type="hidden"
                                                                                                name="action"
                                                                                                value="approve">
                                                                                            <button type="submit"
                                                                                                class="btn-approve-action w-100 d-flex align-items-center justify-content-center"
                                                                                                style="height: 38px;">
                                                                                                <i
                                                                                                    class="bx bx-check me-1"></i>
                                                                                                Approve
                                                                                            </button>
                                                                                        </form>
                                                                                        <form action="events"
                                                                                            method="POST"
                                                                                            class="mb-0 flex-grow-1 d-flex"
                                                                                            onsubmit="return confirm('REJECT: Are you sure you want to reject this event?');">
                                                                                            <input type="hidden"
                                                                                                name="eventId"
                                                                                                value="<%= e.getEventId()%>">
                                                                                            <input type="hidden"
                                                                                                name="action"
                                                                                                value="reject">
                                                                                            <button type="submit"
                                                                                                class="btn-reject-action w-100 d-flex align-items-center justify-content-center"
                                                                                                style="height: 34;"
                                                                                                title="Reject Event">
                                                                                                <i
                                                                                                    class="bx bx-x me-1"></i>
                                                                                                Reject
                                                                                            </button>
                                                                                        </form>
                                                                                        <% } else { %>
                                                                                            <span
                                                                                                class="badge bg-label-secondary flex-grow-1 d-flex align-items-center justify-content-center border text-muted m-0"
                                                                                                style="font-size: 0.8rem; border-style: dashed !important; height: 38px;">
                                                                                                <i
                                                                                                    class="bx bx-lock-alt me-1"></i>
                                                                                                Locked Status
                                                                                            </span>
                                                                                            <% } %>
                                                                                                <% if (isHepa) { %>
                                                                                                    <form
                                                                                                        action="events"
                                                                                                        method="POST"
                                                                                                        class="mb-0 flex-shrink-0 d-flex align-items-center"
                                                                                                        onsubmit="return confirm('DELETE: Are you sure you want to delete this event? This action cannot be undone.');">
                                                                                                        <input
                                                                                                            type="hidden"
                                                                                                            name="eventId"
                                                                                                            value="<%= e.getEventId()%>">
                                                                                                        <input
                                                                                                            type="hidden"
                                                                                                            name="action"
                                                                                                            value="deleteEvent">
                                                                                                        <button
                                                                                                            type="submit"
                                                                                                            class="btn-delete-inline"
                                                                                                            title="Delete Event">
                                                                                                            <i
                                                                                                                class="bx bx-trash"></i>
                                                                                                        </button>
                                                                                                    </form>
                                                                                                    <% } %>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <% } } else {%>
                                                                <div class="col-12 text-center py-5 text-muted mb-4">
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