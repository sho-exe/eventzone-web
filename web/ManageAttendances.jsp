<%@page import="java.util.List" %>
    <%@page import="com.lab.model.Attendance" %>
        <%@page import="com.lab.model.Event" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <jsp:include page="header.jsp" />

                <body>
                    <!-- Layout wrapper -->
                    <div class="layout-wrapper layout-content-navbar">
                        <div class="layout-container">
                            <jsp:include page="sidebar.jsp" />
                            <div class="layout-page">
                                <jsp:include page="navbar.jsp" />
                                <!-- Content wrapper -->
                                <div class="content-wrapper" style="padding: 0px 30px;">
                                    <!-- Content -->
                                    <div class="flex-grow-1 container-p-y">
                                        <% Event targetEvent=(Event) request.getAttribute("targetEvent"); %>
                                        
                                        <!-- Page Header -->
                                        <div class="d-flex justify-content-between align-items-center py-3 mb-4 border-bottom">
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
                                                                    boolean isPending = "PENDING".equals(a.getStatus());
                                                                    boolean isRegistered = "REGISTERED".equals(a.getStatus());
                                                                    boolean isDeclined = "DECLINED".equals(a.getStatus());
                                                                    boolean isAttended = "ATTENDED".equals(a.getStatus());
                                                                    boolean isMissed = "MISSED".equals(a.getStatus());
                                                                    %>
                                                                    <tr class="<%= isPending ? " bg-warning-soft border-start border-warning border-4" : "" %>">
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
                                                                            <span class="badge bg-secondary text-white"><i
                                                                                    class="fas fa-hourglass-half me-1"></i>
                                                                                PENDING APPROVAL</span>
                                                                        <% } else if(isRegistered) { %>
                                                                            <span class="badge bg-warning text-dark"><i
                                                                                    class="fas fa-check me-1"></i>
                                                                                APPROVED & AWAITING EVENT</span>
                                                                        <% } else if(isAttended) { %>
                                                                            <span class="badge bg-success"><i
                                                                                    class="fas fa-check-double me-1"></i>
                                                                                ATTENDED</span>
                                                                        <% } else if(isMissed) { %>
                                                                            <span class="badge bg-danger"><i
                                                                                    class="fas fa-user-slash me-1"></i>
                                                                                MISSED EVENT</span>
                                                                        <% } else if(isDeclined) { %>
                                                                            <span class="badge bg-dark"><i
                                                                                    class="fas fa-ban me-1"></i>
                                                                                DECLINED</span>
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
                                                                            <div class="d-flex justify-content-end gap-2">
                                                                                <form action="attendances" method="POST" onsubmit="return confirm('Accept this student?');">
                                                                                    <input type="hidden" name="eventId" value="<%= targetEvent.getEventId() %>">
                                                                                    <input type="hidden" name="attendanceId" value="<%= a.getAttendanceId() %>">
                                                                                    <input type="hidden" name="action" value="acceptRegistration">
                                                                                    <button type="submit" class="btn btn-sm btn-primary fw-bold shadow-sm"><i class="fas fa-check me-1"></i> Accept</button>
                                                                                </form>
                                                                                <form action="attendances" method="POST" onsubmit="return confirm('Decline this student?');">
                                                                                    <input type="hidden" name="eventId" value="<%= targetEvent.getEventId() %>">
                                                                                    <input type="hidden" name="attendanceId" value="<%= a.getAttendanceId() %>">
                                                                                    <input type="hidden" name="action" value="declineRegistration">
                                                                                    <button type="submit" class="btn btn-sm btn-outline-danger shadow-sm"><i class="fas fa-times me-1"></i> Decline</button>
                                                                                </form>
                                                                            </div>
                                                                        <% } else if(isRegistered) { %>
                                                                            <div
                                                                                class="d-flex justify-content-end gap-2">
                                                                                <form
                                                                                    action="attendances"
                                                                                    method="POST"
                                                                                    onsubmit="return confirm('Please confirm <%= a.getStudentName() %> is physically present.');">
                                                                                    <input type="hidden" name="eventId"
                                                                                        value="<%= targetEvent.getEventId() %>">
                                                                                    <input type="hidden"
                                                                                        name="attendanceId"
                                                                                        value="<%= a.getAttendanceId() %>">
                                                                                    <input type="hidden" name="action"
                                                                                        value="approveAttendance">
                                                                                    <button type="submit"
                                                                                        class="btn btn-sm btn-success fw-bold shadow-sm"><i
                                                                                            class="fas fa-check-double me-1"></i>
                                                                                        Verify</button>
                                                                                </form>
                                                                                <form
                                                                                    action="attendances"
                                                                                    method="POST"
                                                                                    onsubmit="return confirm('Are you sure you want to mark <%= a.getStudentName() %> as missing?');">
                                                                                    <input type="hidden" name="eventId"
                                                                                        value="<%= targetEvent.getEventId() %>">
                                                                                    <input type="hidden"
                                                                                        name="attendanceId"
                                                                                        value="<%= a.getAttendanceId() %>">
                                                                                    <input type="hidden" name="action"
                                                                                        value="rejectAttendance">
                                                                                    <button type="submit"
                                                                                        class="btn btn-sm btn-outline-danger shadow-sm"><i
                                                                                            class="fas fa-user-slash me-1"></i>
                                                                                        Absent</button>
                                                                                </form>
                                                                            </div>
                                                                        <% } else if(isDeclined) { %>
                                                                            <span class="text-muted small border px-2 py-1 rounded bg-light"><i class="fas fa-ban me-1"></i> Declined</span>
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
                                    <div class="content-backdrop fade"></div>
                                </div>
                            </div>
                        </div>
                        <div class="layout-overlay layout-menu-toggle"></div>
                    </div>
                    <jsp:include page="footer.jsp" />
                    <script>
                        document.addEventListener("DOMContentLoaded", function() {
                            // Remove active class from all menu items
                            document.querySelectorAll('.menu-item.active').forEach(function(item) {
                                item.classList.remove('active');
                            });
                            
                            // Add active class to "Manage Events" menu item
                            document.querySelectorAll('.menu-link').forEach(function(link) {
                                if (link.getAttribute('href') === 'events?action=manage') {
                                    link.parentElement.classList.add('active');
                                }
                            });
                        });
                    </script>
                </body>
                </html>