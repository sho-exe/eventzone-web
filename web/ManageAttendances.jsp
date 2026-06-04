<%@page import="java.util.List" %>
    <%@page import="com.lab.model.Attendance" %>
        <%@page import="com.lab.model.Event" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <jsp:include page="header.jsp" />

                <body class="bg-light">

                    <div class="d-flex" id="wrapper">
                        <!-- Chairperson Sidebar Context -->
                        <jsp:include page="sidebar.jsp" />


                        <!-- Page Content -->
                        <div id="page-content-wrapper" class="w-100">
                            <% Event targetEvent=(Event) request.getAttribute("targetEvent"); %>
                                <nav
                                    class="navbar navbar-expand-lg navbar-light bg-white border-bottom shadow-sm py-3 px-4">
                                    <div class="container-fluid">
                                        <h4 class="mb-0 text-dark fw-bold"><i
                                                class="fas fa-clipboard-check text-success me-2"></i> Roster: <%=
                                                targetEvent.getEventName() %>
                                        </h4>
                                        <div class="d-flex align-items-center">
                                            <span class="badge bg-danger ms-3"><i
                                                    class="fas fa-map-marker-alt me-1"></i>
                                                <%= targetEvent.getVenue() %>
                                            </span>
                                            <span class="badge bg-primary ms-2"><i class="far fa-calendar-alt me-1"></i>
                                                <%= targetEvent.getDate() %>
                                            </span>
                                        </div>
                                    </div>
                                </nav>

                                <div class="container-fluid p-4">

                                    <div class="alert alert-info border-0 shadow-sm bg-info-soft text-dark mb-4">
                                        <i class="fas fa-info-circle me-2 text-info"></i> You are actively managing the
                                        registration list for <strong>
                                            <%= targetEvent.getEventName() %>
                                        </strong>. Students who signed up are listed below. Click
                                        <strong>Verify</strong> when the student physically attends the event. This
                                        allows HEPA to distribute merit points.
                                    </div>

                                    <div class="card shadow-sm border-0">
                                        <div class="card-body p-0">
                                            <div class="table-responsive">
                                                <table class="table table-hover align-middle mb-0">
                                                    <thead class="bg-light text-muted small text-uppercase">
                                                        <tr>
                                                            <th class="ps-4">Student</th>
                                                            <th>Registration Date</th>
                                                            <th>Status</th>
                                                            <th>Verified By</th>
                                                            <th class="text-end pe-4">Verification Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% List<Attendance> roster = (List<Attendance>)
                                                                request.getAttribute("roster");
                                                                if(roster != null && !roster.isEmpty()) {
                                                                for(Attendance a : roster) {
                                                                boolean isPending = "REGISTERED".equals(a.getStatus());
                                                                boolean isAttended = "ATTENDED".equals(a.getStatus());
                                                                boolean isMissed = "MISSED".equals(a.getStatus());
                                                                %>
                                                                <tr class="<%= isPending ? " bg-warning-soft
                                                                    border-start border-warning border-4" : "" %>">
                                                                    <td class="ps-4">
                                                                        <div class="d-flex align-items-center">
                                                                            <div class="bg-secondary text-white rounded-circle d-flex align-items-center justify-content-center me-3 shadow-sm"
                                                                                style="width: 45px; height: 45px;">
                                                                                <i class="fas fa-user"></i>
                                                                            </div>
                                                                            <div>
                                                                                <strong class="text-dark d-block mb-1">
                                                                                    <%= a.getStudentName() %>
                                                                                </strong>
                                                                                <span class="text-muted small"><i
                                                                                        class="fas fa-envelope me-1"></i>
                                                                                    <%= a.getStudentEmail() %>
                                                                                </span>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <span class="text-muted small fw-bold"><i
                                                                                class="far fa-clock me-1 text-primary"></i>
                                                                            <%= a.getRegistrationDate() %>
                                                                        </span>
                                                                    </td>
                                                                    <td>
                                                                        <% if(isPending) { %>
                                                                            <span class="badge bg-warning text-dark"><i
                                                                                    class="fas fa-hourglass-half me-1"></i>
                                                                                AWAITING EVENT</span>
                                                                            <% } else if(isAttended) { %>
                                                                                <span class="badge bg-success"><i
                                                                                        class="fas fa-check-double me-1"></i>
                                                                                    ATTENDED</span>
                                                                                <% } else { %>
                                                                                    <span class="badge bg-danger"><i
                                                                                            class="fas fa-user-slash me-1"></i>
                                                                                        MISSED EVENT</span>
                                                                                    <% } %>
                                                                    </td>
                                                                    <td>
                                                                        <% if(a.getVerifierName() !=null) { %>
                                                                            <strong class="text-dark small"><i
                                                                                    class="fas fa-user-shield text-info me-1"></i>
                                                                                <%= a.getVerifierName() %>
                                                                            </strong>
                                                                            <% } else { %>
                                                                                <span
                                                                                    class="text-muted small fst-italic">Pending...</span>
                                                                                <% } %>
                                                                    </td>
                                                                    <td class="text-end pe-4">
                                                                        <% if(isPending) { %>
                                                                            <div
                                                                                class="d-flex justify-content-end gap-2">
                                                                                <form
                                                                                    action="AttendanceController?action=manageAttendances"
                                                                                    method="POST"
                                                                                    onsubmit="return confirm('Please confirm <%= a.getStudentName() %> is physically present.');">
                                                                                    <input type="hidden" name="eventId"
                                                                                        value="<%= targetEvent.getEventId() %>">
                                                                                    <input type="hidden"
                                                                                        name="attendanceId"
                                                                                        value="<%= a.getAttendanceId() %>">
                                                                                    <input type="hidden" name="action"
                                                                                        value="approve">
                                                                                    <button type="submit"
                                                                                        class="btn btn-sm btn-success fw-bold shadow-sm"><i
                                                                                            class="fas fa-check me-1"></i>
                                                                                        Verify</button>
                                                                                </form>
                                                                                <form
                                                                                    action="AttendanceController?action=manageAttendances"
                                                                                    method="POST"
                                                                                    onsubmit="return confirm('Are you sure you want to mark <%= a.getStudentName() %> as missing?');">
                                                                                    <input type="hidden" name="eventId"
                                                                                        value="<%= targetEvent.getEventId() %>">
                                                                                    <input type="hidden"
                                                                                        name="attendanceId"
                                                                                        value="<%= a.getAttendanceId() %>">
                                                                                    <input type="hidden" name="action"
                                                                                        value="reject">
                                                                                    <button type="submit"
                                                                                        class="btn btn-sm btn-outline-danger shadow-sm"><i
                                                                                            class="fas fa-times me-1"></i>
                                                                                        Absent</button>
                                                                                </form>
                                                                            </div>
                                                                            <% } else { %>
                                                                                <span
                                                                                    class="text-muted small border px-2 py-1 rounded bg-light"><i
                                                                                        class="fas fa-lock me-1"></i>
                                                                                    Locked Status</span>
                                                                                <% } %>
                                                                    </td>
                                                                </tr>
                                                                <% } } else { %>
                                                                    <tr>
                                                                        <td colspan="5"
                                                                            class="text-center py-5 text-muted">
                                                                            <i
                                                                                class="fas fa-users-slash fa-3x mb-3 text-light"></i><br>
                                                                            No students have registered for this event
                                                                            yet.
                                                                        </td>
                                                                    </tr>
                                                                    <% } %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                        </div>
                    </div>

                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
                </body>

                </html>