<%@page import="java.util.List" %>
    <%@page import="com.lab.model.Event" %>
        <%@page import="com.lab.dao.MeritDAO" %>
            <%@page import="com.lab.dao.AttendanceDAO" %>
                <%@page import="com.lab.model.Attendance" %>
                    <%@page contentType="text/html" pageEncoding="UTF-8" %>
                        <% String role=(String) session.getAttribute("accountType"); %>
                            <jsp:include page="header.jsp" />
                            <style>
                                .event-title-link {
                                    transition: color 0.15s ease-in-out;
                                }

                                .event-title-link:hover {
                                    color: #696cff !important;
                                }

                                .shadow-xs {
                                    box-shadow: 0 2px 4px rgba(0, 0, 0, .04) !important;
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
                                                                    data-bs-toggle="collapse"
                                                                    data-bs-target="#pageTipsCollapse"
                                                                    title="Toggle Page Guide"></i>
                                                            </h4>
                                                            <% if (request.getParameter("success") !=null) { %>
                                                                <div class="alert alert-success border-0 shadow-sm mb-4 alert-dismissible fade show d-flex align-items-center"
                                                                    role="alert" id="successAlert">
                                                                    <i class="bx bx-check-circle me-3 fs-3"></i>
                                                                    <div>
                                                                        <strong>Merits Distributed
                                                                            Successfully!</strong><br>
                                                                        Students have automatically received their event
                                                                        points
                                                                        on their immutable
                                                                        transcript.
                                                                        <span
                                                                            class="badge bg-white text-success ms-2 countdown-badge"
                                                                            style="font-size: 0.75rem; vertical-align: middle;">3s</span>
                                                                    </div>
                                                                    <button type="button" class="btn-close"
                                                                        data-bs-dismiss="alert"
                                                                        aria-label="Close"></button>
                                                                </div>
                                                                <% } %>
                                                                    <% if (request.getParameter("deleted") !=null) { %>
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
                                                                                                    Page Guide & Tips
                                                                                                </h6>
                                                                                                <div class="text-dark"
                                                                                                    style="font-size: 0.85rem; line-height: 1.45; font-weight: 500;">
                                                                                                    Select a finalized
                                                                                                    event
                                                                                                    below to
                                                                                                    systematically drop
                                                                                                    merit points to its
                                                                                                    verified
                                                                                                    attendees. Doing
                                                                                                    this locks
                                                                                                    the specific event
                                                                                                    transcript
                                                                                                    permanently.
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <!-- Positions and Merits Legend Card -->
                                                                            <div class="card border-0 mb-4 shadow-sm"
                                                                                style="background: linear-gradient(135deg, rgba(105, 108, 255, 0.05) 0%, rgba(198, 204, 255, 0.05) 100%); border-radius: 12px;">
                                                                                <div class="card-body p-4">
                                                                                    <div
                                                                                        class="d-flex align-items-center mb-3">
                                                                                        <div>
                                                                                            <h5
                                                                                                class="fw-bold text-dark mb-0">
                                                                                                Club Position Merit
                                                                                                Structure</h5>
                                                                                            <small
                                                                                                class="text-muted">Merits
                                                                                                are automatically
                                                                                                calculated and
                                                                                                distributed based on the
                                                                                                student's verified role
                                                                                                position.</small>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="row g-3">
                                                                                        <div class="col-md-2 col-sm-4">
                                                                                            <div
                                                                                                class="p-3 bg-white text-center rounded-3 border border-light shadow-xs h-100">
                                                                                                <span
                                                                                                    class="badge bg-label-danger mb-2">Presiden</span>
                                                                                                <h4
                                                                                                    class="fw-bold mb-0 text-dark">
                                                                                                    80</h4>
                                                                                                <small
                                                                                                    class="text-muted">Merits</small>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-md-2 col-sm-4">
                                                                                            <div
                                                                                                class="p-3 bg-white text-center rounded-3 border border-light shadow-xs h-100">
                                                                                                <span
                                                                                                    class="badge bg-label-warning mb-2">Setiausaha</span>
                                                                                                <h4
                                                                                                    class="fw-bold mb-0 text-dark">
                                                                                                    60</h4>
                                                                                                <small
                                                                                                    class="text-muted">Merits</small>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-md-2 col-sm-4">
                                                                                            <div
                                                                                                class="p-3 bg-white text-center rounded-3 border border-light shadow-xs h-100">
                                                                                                <span
                                                                                                    class="badge bg-label-info mb-2">MT
                                                                                                    Kelab</span>
                                                                                                <h4
                                                                                                    class="fw-bold mb-0 text-dark">
                                                                                                    50</h4>
                                                                                                <small
                                                                                                    class="text-muted">Merits</small>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-md-2 col-sm-4">
                                                                                            <div
                                                                                                class="p-3 bg-white text-center rounded-3 border border-light shadow-xs h-100">
                                                                                                <span
                                                                                                    class="badge bg-label-success mb-2">AJK
                                                                                                    Kelab</span>
                                                                                                <h4
                                                                                                    class="fw-bold mb-0 text-dark">
                                                                                                    40</h4>
                                                                                                <small
                                                                                                    class="text-muted">Merits</small>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-md-2 col-sm-4">
                                                                                            <div
                                                                                                class="p-3 bg-white text-center rounded-3 border border-light shadow-xs h-100">
                                                                                                <span
                                                                                                    class="badge bg-label-primary mb-2">Ahli
                                                                                                    Kelab</span>
                                                                                                <h4
                                                                                                    class="fw-bold mb-0 text-dark">
                                                                                                    20</h4>
                                                                                                <small
                                                                                                    class="text-muted">Merits</small>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-md-2 col-sm-4">
                                                                                            <div
                                                                                                class="p-3 bg-white text-center rounded-3 border border-light shadow-xs h-100 d-flex flex-column align-items-center justify-content-center">
                                                                                                <span
                                                                                                    class="badge bg-label-secondary mb-2">Status
                                                                                                    Lock</span>
                                                                                                <small
                                                                                                    class="text-muted text-center"
                                                                                                    style="font-size: 0.72rem; font-weight: 500;">Only
                                                                                                    verified
                                                                                                    <strong>ATTENDED</strong>
                                                                                                    status receives
                                                                                                    merits.</small>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="card border-0">
                                                                                <div class="card-body p-0">
                                                                                    <div class="table-responsive">
                                                                                        <table
                                                                                            class="table table-hover align-middle mb-0">
                                                                                            <thead
                                                                                                class="bg-light text-muted small text-uppercase">
                                                                                                <tr>
                                                                                                    <th class="text-center"
                                                                                                        style="width: 70px;">
                                                                                                        #
                                                                                                    </th>
                                                                                                    <th class="ps-4">ID
                                                                                                    </th>
                                                                                                    <th>Event Details
                                                                                                    </th>
                                                                                                    <th>Criteria Info
                                                                                                    </th>
                                                                                                    <th>Status</th>
                                                                                                    <th
                                                                                                        class="text-end pe-4">
                                                                                                        Actions
                                                                                                    </th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>

                                                                                                <% List<Event>
                                                                                                    approvedEvents =
                                                                                                    (List<Event>)
                                                                                                        request.getAttribute("approvedEvents");
                                                                                                        MeritDAO
                                                                                                        meritDAO =
                                                                                                        (MeritDAO)
                                                                                                        request.getAttribute("meritDAO");
                                                                                                        AttendanceDAO
                                                                                                        attendanceDAO =
                                                                                                        new
                                                                                                        AttendanceDAO();
                                                                                                        int rowIndex =
                                                                                                        1;
                                                                                                        if
                                                                                                        (approvedEvents
                                                                                                        != null &&
                                                                                                        !approvedEvents.isEmpty())
                                                                                                        {
                                                                                                        for (Event e :
                                                                                                        approvedEvents)
                                                                                                        {
                                                                                                        boolean
                                                                                                        isAlreadyDistributed
                                                                                                        =
                                                                                                        meritDAO.isDistributed(e.getEventId());
                                                                                                        %>
                                                                                                        <% String
                                                                                                            temporary=isAlreadyDistributed
                                                                                                            ? "opacity-75 bg-light"
                                                                                                            : "" ;%>
                                                                                                            <tr
                                                                                                                class="<%= temporary%>">
                                                                                                                <td
                                                                                                                    class="ps-4 fw-bold">
                                                                                                                    <%=
                                                                                                                        rowIndex++%>
                                                                                                                </td>
                                                                                                                <td
                                                                                                                    class="ps-4">
                                                                                                                    <span
                                                                                                                        class="club-id-badge badge-id mb-0">
                                                                                                                        <%=e.getEventId()%>
                                                                                                                    </span>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <a href="javascript:void(0);"
                                                                                                                        data-bs-toggle="modal"
                                                                                                                        data-bs-target="#attendeesModal_<%= e.getEventId()%>"
                                                                                                                        class="d-block text-dark fw-bold event-title-link"
                                                                                                                        style="text-decoration: none;">
                                                                                                                        <%=
                                                                                                                            e.getEventName()%>
                                                                                                                            <i class="bx bx-show-alt text-muted small ms-1"
                                                                                                                                style="font-size: 0.9rem;"></i>
                                                                                                                    </a>
                                                                                                                    <span
                                                                                                                        class="small text-muted"><i
                                                                                                                            class="fas fa-flag text-primary me-1"></i>
                                                                                                                        <%=
                                                                                                                            e.getClubName()%>
                                                                                                                    </span>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <span
                                                                                                                        class="badge bg-info-soft text-info"><i
                                                                                                                            class="fas fa-bullseye me-1"></i>
                                                                                                                        <%=
                                                                                                                            e.getCriteria()%>
                                                                                                                            |
                                                                                                                            <%=
                                                                                                                                e.getCategory()%>
                                                                                                                    </span>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <% if
                                                                                                                        (isAlreadyDistributed)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <span
                                                                                                                            class="badge bg-success"><i
                                                                                                                                class="fas fa-lock me-1"></i>
                                                                                                                            LOGGED</span>
                                                                                                                        <% } else
                                                                                                                            {
                                                                                                                            %>
                                                                                                                            <span
                                                                                                                                class="badge bg-warning text-dark"><i
                                                                                                                                    class="fas fa-hourglass-start me-1"></i>
                                                                                                                                PENDING</span>
                                                                                                                            <% }
                                                                                                                                %>
                                                                                                                </td>
                                                                                                                <td
                                                                                                                    class="text-end pe-4">
                                                                                                                    <% if
                                                                                                                        (isAlreadyDistributed)
                                                                                                                        {%>
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
                                                                                                                                    value="<%= e.getEventId()%>">
                                                                                                                                <button
                                                                                                                                    type="submit"
                                                                                                                                    class="btn btn-sm btn-danger fw-bold px-3"><i
                                                                                                                                        class="fas fa-trash me-1"></i>
                                                                                                                                    Revoke</button>
                                                                                                                            </form>
                                                                                                                        </div>
                                                                                                                        <% } else
                                                                                                                            {%>
                                                                                                                            <button
                                                                                                                                type="button"
                                                                                                                                class="btn btn-sm btn-success fw-bold px-3"
                                                                                                                                data-bs-toggle="modal"
                                                                                                                                data-bs-target="#attendeesModal_<%= e.getEventId()%>">
                                                                                                                                <i
                                                                                                                                    class="fas fa-bolt me-1"></i>
                                                                                                                                Issue
                                                                                                                                Points
                                                                                                                            </button>
                                                                                                                            <%
                                                                                                                                }%>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <% } } else
                                                                                                                { %>
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

                                                                            <% if (approvedEvents !=null &&
                                                                                !approvedEvents.isEmpty()) { for (Event
                                                                                e : approvedEvents) { boolean
                                                                                isAlreadyDistributed=meritDAO.isDistributed(e.getEventId());
                                                                                %>
                                                                                <!-- Modal for Event Attendees -->
                                                                                <div class="modal fade"
                                                                                    id="attendeesModal_<%= e.getEventId()%>"
                                                                                    tabindex="-1" aria-hidden="true">
                                                                                    <div
                                                                                        class="modal-dialog modal-dialog-centered modal-lg">
                                                                                        <div class="modal-content border-0 shadow-lg"
                                                                                            style="border-radius: 12px; overflow: hidden;">
                                                                                            <div
                                                                                                class="modal-header bg-dark text-white p-3">
                                                                                                <h5
                                                                                                    class="modal-title fw-bold text-white mb-0">
                                                                                                    <i
                                                                                                        class="fas fa-users me-2"></i>Attendees
                                                                                                    for: <%=
                                                                                                        e.getEventName()%>
                                                                                                </h5>
                                                                                                <button type="button"
                                                                                                    class="btn-close btn-close-white"
                                                                                                    data-bs-dismiss="modal"
                                                                                                    aria-label="Close"></button>
                                                                                            </div>
                                                                                            <div
                                                                                                class="modal-body p-4 bg-light">
                                                                                                <div
                                                                                                    class="mb-3 d-flex justify-content-between align-items-center">
                                                                                                    <span
                                                                                                        class="badge bg-label-primary font-monospace"
                                                                                                        style="font-size: 0.8rem;">Club:
                                                                                                        <%=
                                                                                                            e.getClubName()%>
                                                                                                    </span>
                                                                                                    <span
                                                                                                        class="badge bg-label-info"
                                                                                                        style="font-size: 0.8rem;">Category:
                                                                                                        <%=
                                                                                                            e.getCriteria()%>
                                                                                                            | <%=
                                                                                                                e.getCategory()%>
                                                                                                    </span>
                                                                                                </div>
                                                                                                <h6
                                                                                                    class="fw-bold mb-3 text-dark">
                                                                                                    <i
                                                                                                        class="bx bx-list-check me-1"></i>Attendee
                                                                                                    Merit Roster:
                                                                                                </h6>
                                                                                                <div
                                                                                                    class="table-responsive rounded bg-white shadow-xs border">
                                                                                                    <table
                                                                                                        class="table table-sm table-hover align-middle mb-0">
                                                                                                        <thead
                                                                                                            class="bg-light text-muted small text-uppercase">
                                                                                                            <tr>
                                                                                                                <th
                                                                                                                    class="ps-3">
                                                                                                                    Student
                                                                                                                    Name
                                                                                                                </th>
                                                                                                                <th>Email
                                                                                                                </th>
                                                                                                                <th>Position
                                                                                                                </th>
                                                                                                                <th>Status
                                                                                                                </th>
                                                                                                                <th
                                                                                                                    class="text-end pe-3 text-success">
                                                                                                                    Expected
                                                                                                                    Merits
                                                                                                                </th>
                                                                                                            </tr>
                                                                                                        </thead>
                                                                                                        <tbody>
                                                                                                            <%
                                                                                                                List<com.lab.model.Attendance>
                                                                                                                attendees
                                                                                                                =
                                                                                                                attendanceDAO.getAttendancesForEvent(e.getEventId());
                                                                                                                if
                                                                                                                (attendees
                                                                                                                != null
                                                                                                                &&
                                                                                                                !attendees.isEmpty())
                                                                                                                {
                                                                                                                for
                                                                                                                (com.lab.model.Attendance
                                                                                                                a :
                                                                                                                attendees)
                                                                                                                {
                                                                                                                boolean
                                                                                                                isAttended
                                                                                                                =
                                                                                                                "ATTENDED".equals(a.getStatus());
                                                                                                                int
                                                                                                                expectedPoints
                                                                                                                = 0;
                                                                                                                if
                                                                                                                (isAttended)
                                                                                                                {
                                                                                                                String
                                                                                                                pos =
                                                                                                                a.getPosition();
                                                                                                                if
                                                                                                                ("Presiden
                                                                                                                Kelab".equals(pos))
                                                                                                                {
                                                                                                                expectedPoints
                                                                                                                = 80; }
                                                                                                                else if
                                                                                                                ("Setiausaha
                                                                                                                Kelab".equals(pos))
                                                                                                                {
                                                                                                                expectedPoints
                                                                                                                = 60; }
                                                                                                                else if
                                                                                                                ("MT
                                                                                                                Kelab".equals(pos))
                                                                                                                {
                                                                                                                expectedPoints
                                                                                                                = 50; }
                                                                                                                else if
                                                                                                                ("AJK
                                                                                                                Kelab".equals(pos))
                                                                                                                {
                                                                                                                expectedPoints
                                                                                                                = 40; }
                                                                                                                else {
                                                                                                                expectedPoints
                                                                                                                = 20; }
                                                                                                                }
                                                                                                                String
                                                                                                                badgeColor
                                                                                                                =
                                                                                                                "bg-label-secondary";
                                                                                                                if
                                                                                                                ("ATTENDED".equals(a.getStatus()))
                                                                                                                badgeColor
                                                                                                                =
                                                                                                                "bg-label-success";
                                                                                                                else if
                                                                                                                ("ABSENT".equals(a.getStatus()))
                                                                                                                badgeColor
                                                                                                                =
                                                                                                                "bg-label-danger";
                                                                                                                else if
                                                                                                                ("REGISTERED".equals(a.getStatus()))
                                                                                                                badgeColor
                                                                                                                =
                                                                                                                "bg-label-info";%>
                                                                                                                <tr>
                                                                                                                    <td
                                                                                                                        class="ps-3">
                                                                                                                        <span
                                                                                                                            class="fw-semibold text-dark">
                                                                                                                            <%=
                                                                                                                                a.getStudentName()%>
                                                                                                                        </span>
                                                                                                                    </td>
                                                                                                                    <td><span
                                                                                                                            class="text-muted small">
                                                                                                                            <%=
                                                                                                                                a.getStudentEmail()%>
                                                                                                                        </span>
                                                                                                                    </td>
                                                                                                                    <td><span
                                                                                                                            class="badge bg-label-secondary text-capitalize"
                                                                                                                            style="font-size: 0.75rem;">
                                                                                                                            <%= a.getPosition()
                                                                                                                                !=null
                                                                                                                                ?
                                                                                                                                a.getPosition()
                                                                                                                                : "Ahli Kelab"
                                                                                                                                %>
                                                                                                                        </span>
                                                                                                                    </td>
                                                                                                                    <td><span
                                                                                                                            class="badge <%= badgeColor%>"
                                                                                                                            style="font-size: 0.7rem;">
                                                                                                                            <%=
                                                                                                                                a.getStatus()%>
                                                                                                                        </span>
                                                                                                                    </td>
                                                                                                                    <td class="text-end pe-3 fw-bold <%= isAttended ? "
                                                                                                                        text-success"
                                                                                                                        : "text-muted"
                                                                                                                        %>
                                                                                                                        ">
                                                                                                                        <%= isAttended
                                                                                                                            ? "+"
                                                                                                                            +
                                                                                                                            expectedPoints
                                                                                                                            + " Points"
                                                                                                                            : "0 Points (Not Attended)"
                                                                                                                            %>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <% } }
                                                                                                                    else
                                                                                                                    { %>
                                                                                                                    <tr>
                                                                                                                        <td colspan="5"
                                                                                                                            class="text-center py-4 text-muted">
                                                                                                                            <i
                                                                                                                                class="fas fa-users-slash mb-2 text-light fs-3"></i><br>
                                                                                                                            No
                                                                                                                            registered
                                                                                                                            students
                                                                                                                            found
                                                                                                                            for
                                                                                                                            this
                                                                                                                            event.
                                                                                                                        </td>
                                                                                                                    </tr>
                                                                                                                    <% }
                                                                                                                        %>
                                                                                                        </tbody>
                                                                                                    </table>
                                                                                                </div>
                                                                                            </div>
                                                                                            <div
                                                                                                class="modal-footer border-top-0 bg-white">
                                                                                                <button type="button"
                                                                                                    class="btn btn-outline-secondary"
                                                                                                    data-bs-dismiss="modal">Close</button>
                                                                                                <% if
                                                                                                    (!isAlreadyDistributed
                                                                                                    && attendees !=null
                                                                                                    &&
                                                                                                    !attendees.isEmpty())
                                                                                                    {%>
                                                                                                    <form
                                                                                                        action="merits?action=distributeMerits"
                                                                                                        method="POST"
                                                                                                        class="m-0"
                                                                                                        onsubmit="return confirm('WARNING: You are about to mass distribute points to all physically verified attendees for <%= e.getEventName()%>. This is immutable. Proceed?');">
                                                                                                        <input
                                                                                                            type="hidden"
                                                                                                            name="eventId"
                                                                                                            value="<%= e.getEventId()%>">
                                                                                                        <button
                                                                                                            type="submit"
                                                                                                            class="btn btn-success fw-bold px-4">
                                                                                                            <i
                                                                                                                class="fas fa-bolt me-1"></i>
                                                                                                            Issue Points
                                                                                                            Now
                                                                                                        </button>
                                                                                                    </form>
                                                                                                    <% } %>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <% } } %>

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
                                        <% }%>
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