<%@page import="java.util.List" %>
    <%@page import="com.lab.model.Attendance" %>
        <%@page import="com.lab.model.Event" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <jsp:include page="header.jsp" />

                <body>
                    <div class="layout-wrapper layout-content-navbar">
                        <div class="layout-container">
                            <jsp:include page="sidebar.jsp" />
                            <div class="layout-page">
                                <jsp:include page="navbar.jsp" />
                                <div class="content-wrapper" style="padding: 0px 30px;">
                                    <div class="flex-grow-1 container-p-y">
                                        <% Event targetEvent=(Event) request.getAttribute("targetEvent"); // Check if today is the event day 
                                                    boolean isEventDay=targetEvent !=null &&
                                            targetEvent.getDate() !=null &&
                                            targetEvent.getDate().toString().equals(java.time.LocalDate.now().toString());
                                            // QR token for chairperson 
                                            String qrToken=targetEvent !=null ?
                                            java.util.UUID.nameUUIDFromBytes((targetEvent.getEventId() + "SECRET_SERS").getBytes()).toString() : "" ; String
                                            baseUrl=request.getRequestURL().toString().replace(request.getRequestURI(),
                                            request.getContextPath()); String qrUrl=baseUrl
                                            + "/attendances?action=scanQR&eventId=" + (targetEvent !=null ?
                                            targetEvent.getEventId() : 0) + "&token=" + qrToken;%>


                                            <div
                                                class="d-flex justify-content-between align-items-center py-3 mb-4 border-bottom">
                                                <h4 class="mb-0 text-dark fw-bold d-flex align-items-center">
                                                    <i class="fas fa-clipboard-check text-success me-2"></i>
                                                    <%=targetEvent.getEventName()%>
                                                        <i class="bx bx-info-circle text-info ms-2"
                                                            style="cursor: pointer; font-size: 1.5rem; vertical-align: middle;"
                                                            data-bs-toggle="collapse" data-bs-target="#pageTipsCollapse"
                                                            title="Toggle Page Guide"></i>
                                                </h4>
                                                <div class="d-flex align-items-center">
                                                    <% if ("CHAIRPERSON".equals(session.getAttribute("accountType")))
                                                        {%>
                                                         <!-- <button class="btn btn-sm btn-dark ms-3 fw-bold"
                                                                     data-bs-toggle="modal" data-bs-target="#qrCodeModal"
                                                                     <%=!isEventDay
                                                                             ? "disabled title='QR code is only available on the event day'"
                                                                             : ""%>>
                                                                     <i class="bx bx-qr-scan me-1"></i> Show QR Code
                                                                 </button> -->
                                                        <% }%>
                                                            <span class="badge bg-danger ms-3"><i
                                                                    class="fas fa-map-marker-alt me-1"></i>
                                                                <%= targetEvent.getVenue()%>
                                                            </span>
                                                             <span class="badge bg-primary ms-2"><i
                                                                     class="far fa-calendar-alt me-1"></i>
                                                                 <%= targetEvent.getDate()%>
                                                                 <% if (targetEvent.getTime() != null) { %>
                                                                     <%= targetEvent.getTime().toString().substring(0, 5) %>
                                                                     <%= targetEvent.getEndTime() != null ? " - " + targetEvent.getEndTime().toString().substring(0, 5) : "" %>
                                                                 <% } %>
                                                             </span>
                                                </div>
                                            </div>

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
                                                                    style="font-size: 0.95rem;">Page Guide & Tips</h6>
                                                                <div class="text-dark"
                                                                    style="font-size: 0.85rem; line-height: 1.45; font-weight: 500;">
                                                                    You are actively managing the registration list for
                                                                    <strong>
                                                                        <%= targetEvent.getEventName()%>
                                                                    </strong>. Students who signed up are listed below.
                                                                    Click <strong>Verify</strong> when the student
                                                                    physically attends the event. This allows HEPA to
                                                                    distribute merit points.
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
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
                                                                    <th>Position</th>
                                                                    <th>Verified By</th>
                                                                    <th class="text-end pe-4">Verification Actions</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% List<Attendance> roster = (List<Attendance>)
                                                                        request.getAttribute("roster");
                                                                        if (roster != null && !roster.isEmpty()) {
                                                                        for (Attendance a : roster) {
                                                                         boolean isPending
                                                                         = "PENDING".equals(a.getStatus());
                                                                         boolean isRegistered
                                                                         = "REGISTERED".equals(a.getStatus());
                                                                         boolean isSelfCheckedIn
                                                                         = "SELF_CHECKED_IN".equals(a.getStatus());
                                                                         boolean isDeclined
                                                                         = "DECLINED".equals(a.getStatus());
                                                                         boolean isAttended
                                                                         = "ATTENDED".equals(a.getStatus());
                                                                         boolean isMissed
                                                                         = "MISSED".equals(a.getStatus());
                                                                        %>
                                                                        <tr>
                                                                            <td class="ps-4">
                                                                                <div class="d-flex align-items-center">
                                                                                    <div class="bg-secondary text-white rounded-circle d-flex align-items-center justify-content-center me-3 shadow-sm"
                                                                                        style="width: 45px; height: 45px;">
                                                                                        <i class="fas fa-user"></i>
                                                                                    </div>
                                                                                    <div>
                                                                                        <strong
                                                                                            class="text-dark d-block mb-1">
                                                                                            <%= a.getStudentName()%>
                                                                                        </strong>
                                                                                        <span
                                                                                            class="text-muted small"><i
                                                                                                class="fas fa-envelope me-1"></i>
                                                                                            <%= a.getStudentEmail()%>
                                                                                        </span>
                                                                                    </div>
                                                                                </div>
                                                                            </td>
                                                                            <td>
                                                                                <span
                                                                                    class="text-muted small fw-bold"><i
                                                                                        class="far fa-clock me-1 text-primary"></i>
                                                                                    <%= a.getRegistrationDate()%>
                                                                                </span>
                                                                            </td>
                                                                            <td>
                                                                                <% if (isPending) { %>
                                                                                    <span
                                                                                        class="badge bg-warning text-dark"><i
                                                                                            class="fas fa-hourglass-half me-1"></i>PENDING
                                                                                        APPROVAL</span>
                                                                                    <% } else if (isRegistered) { %>
                                                                                        <span
                                                                                            class="badge bg-info text-white"><i
                                                                                                class="fas fa-check me-1"></i>APPROVED
                                                                                            &amp; AWAITING EVENT</span>
                                                                                    <% } else if (isSelfCheckedIn) { %>
                                                                                        <span
                                                                                            class="badge bg-warning text-dark"><i
                                                                                                class="fas fa-fingerprint me-1"></i>SELF CHECKED-IN</span>
                                                                                        <% } else if (isAttended) { %>
                                                                                            <span
                                                                                                class="badge bg-success"><i
                                                                                                    class="fas fa-check-double me-1"></i>ATTENDED</span>
                                                                                            <% } else if (isMissed) { %>
                                                                                                <span
                                                                                                    class="badge bg-danger"><i
                                                                                                        class="fas fa-user-slash me-1"></i>MISSED
                                                                                                    EVENT</span>
                                                                                                <% } else if
                                                                                                    (isDeclined) { %>
                                                                                                    <span
                                                                                                        class="badge bg-dark"><i
                                                                                                            class="fas fa-ban me-1"></i>DECLINED</span>
                                                                                                    <% } else {%>
                                                                                                        <span
                                                                                                            class="badge bg-secondary">
                                                                                                            <%=a.getStatus()%>
                                                                                                        </span>
                                                                                                        <% } %>
                                                                            </td>
                                                                            <td>
                                                                                <% if
                                                                                    ("CHAIRPERSON".equals(session.getAttribute("accountType"))
                                                                                    && (isPending || isRegistered || isSelfCheckedIn)) {%>
                                                                                    <form action="attendances"
                                                                                        method="POST"
                                                                                        class="d-inline-block m-0">
                                                                                        <input type="hidden"
                                                                                            name="action"
                                                                                            value="assignPosition">
                                                                                        <input type="hidden"
                                                                                            name="eventId"
                                                                                            value="<%= targetEvent.getEventId()%>">
                                                                                        <input type="hidden"
                                                                                            name="attendanceId"
                                                                                            value="<%= a.getAttendanceId()%>">
                                                                                         <select name="position"
                                                                                             class="form-select form-select-sm fw-bold border-primary text-dark"
                                                                                             style="min-width: 160px;"
                                                                                             onchange="this.form.submit()">
                                                                                            <option value="Peserta biasa"
                                                                                                <%="Peserta biasa"
                                                                                                .equals(a.getPosition())
                                                                                                ? "selected" : "" %>
                                                                                                >Peserta biasa (10)
                                                                                            </option>
                                                                                            <option value="Ahli Kelab"
                                                                                                <%="Ahli Kelab"
                                                                                                .equals(a.getPosition())
                                                                                                || a.getPosition()==null
                                                                                                ? "selected" : "" %>
                                                                                                >Ahli Kelab (20)
                                                                                            </option>
                                                                                            <option value="AJK Kelab"
                                                                                                <%="AJK Kelab"
                                                                                                .equals(a.getPosition())
                                                                                                ? "selected" : "" %>>AJK
                                                                                                Kelab (40)</option>
                                                                                            <option value="MT Kelab"
                                                                                                <%="MT Kelab"
                                                                                                .equals(a.getPosition())
                                                                                                ? "selected" : "" %>>MT
                                                                                                Kelab (50)</option>
                                                                                            <option
                                                                                                value="Setiausaha Kelab"
                                                                                                <%="Setiausaha Kelab"
                                                                                                .equals(a.getPosition())
                                                                                                ? "selected" : "" %>
                                                                                                >Setiausaha Kelab (60)
                                                                                            </option>
                                                                                            <option
                                                                                                value="Presiden Kelab"
                                                                                                <%="Presiden Kelab"
                                                                                                .equals(a.getPosition())
                                                                                                ? "selected" : "" %>
                                                                                                >Presiden Kelab (80)
                                                                                            </option>
                                                                                        </select>
                                                                                    </form>
                                                                                    <% } else {%>
                                                                                        <span
                                                                                            class="badge bg-secondary fw-semibold">
                                                                                            <%= a.getPosition() !=null
                                                                                                &&
                                                                                                !a.getPosition().isEmpty()
                                                                                                ? a.getPosition()
                                                                                                : "Ahli Kelab" %>
                                                                                        </span>
                                                                                        <% } %>
                                                                            </td>
                                                                            <td>
                                                                                <% if (a.getVerifierName() !=null) {
                                                                                    String vRole=a.getVerifierRole()
                                                                                    !=null ? a.getVerifierRole() : "" ;
                                                                                    String vColor="#6c757d" ; String
                                                                                    vLabel=vRole; if
                                                                                    ("HEPA".equals(vRole)) {
                                                                                    vColor="#ea5455" ; vLabel="HEPA" ; }
                                                                                    else if ("ADVISOR".equals(vRole)) {
                                                                                    vColor="#28c76f" ; vLabel="Advisor"
                                                                                    ; } else if
                                                                                    ("CHAIRPERSON".equals(vRole)) {
                                                                                    vColor="#ff9f43" ;
                                                                                    vLabel="Chairperson" ; }%>
                                                                                    <div class="d-flex flex-column">
                                                                                        <strong
                                                                                            class="text-dark small"><i
                                                                                                class="fas fa-user-shield me-1"
                                                                                                style="color: <%= vColor%>"></i>
                                                                                            <%= a.getVerifierName()%>
                                                                                        </strong>
                                                                                        <span class="badge mt-1"
                                                                                            style="background-color: <%= vColor%>; font-size: 0.65rem; width: fit-content;">
                                                                                            <%= vLabel%>
                                                                                        </span>
                                                                                    </div>
                                                                                    <% } else { %>
                                                                                        <span
                                                                                            class="text-muted small fst-italic">Pending...</span>
                                                                                        <% } %>
                                                                            </td>
                                                                            <td class="text-end pe-4">
                                                                                <% if (isPending) {%>
                                                                                    <div
                                                                                        class="d-flex justify-content-end gap-2">
                                                                                        <form action="attendances"
                                                                                            method="POST"
                                                                                            onsubmit="return confirm('Accept this student?');">
                                                                                            <input type="hidden"
                                                                                                name="eventId"
                                                                                                value="<%= targetEvent.getEventId()%>">
                                                                                            <input type="hidden"
                                                                                                name="attendanceId"
                                                                                                value="<%= a.getAttendanceId()%>">
                                                                                            <input type="hidden"
                                                                                                name="action"
                                                                                                value="acceptRegistration">
                                                                                            <button type="submit"
                                                                                                class="btn btn-sm btn-primary fw-bold shadow-sm"><i
                                                                                                    class="fas fa-check me-1"></i>Accept</button>
                                                                                        </form>
                                                                                        <form action="attendances"
                                                                                            method="POST"
                                                                                            onsubmit="return confirm('Decline this student?');">
                                                                                            <input type="hidden"
                                                                                                name="eventId"
                                                                                                value="<%= targetEvent.getEventId()%>">
                                                                                            <input type="hidden"
                                                                                                name="attendanceId"
                                                                                                value="<%= a.getAttendanceId()%>">
                                                                                            <input type="hidden"
                                                                                                name="action"
                                                                                                value="declineRegistration">
                                                                                            <button type="submit"
                                                                                                class="btn btn-sm btn-danger fw-bold shadow-sm"><i
                                                                                                    class="fas fa-times me-1"></i>Decline</button>
                                                                                        </form>
                                                                                    </div>
                                                                                    <% } else if (isRegistered || isSelfCheckedIn) { %>
                                                                                        <div
                                                                                            class="d-flex justify-content-end gap-2">
                                                                                            <% if (isEventDay) {%>
                                                                                                <form
                                                                                                    action="attendances"
                                                                                                    method="POST"
                                                                                                    onsubmit="return confirm('<%= isSelfCheckedIn ? "Verify " + a.getStudentName() + " is present?" : "Confirm " + a.getStudentName() + " is present?" %>');">
                                                                                                    <input type="hidden"
                                                                                                        name="eventId"
                                                                                                        value="<%= targetEvent.getEventId()%>">
                                                                                                    <input type="hidden"
                                                                                                        name="attendanceId"
                                                                                                        value="<%= a.getAttendanceId()%>">
                                                                                                    <input type="hidden"
                                                                                                        name="action"
                                                                                                        value="approveAttendance">
                                                                                                    <button
                                                                                                        type="submit"
                                                                                                        class="btn btn-sm btn-success fw-bold shadow-sm"><i
                                                                                                            class="<%= isSelfCheckedIn ? "fas fa-user-check me-1" : "fas fa-check-double me-1" %>"></i><%= isSelfCheckedIn ? "Verify" : "Attend" %></button>
                                                                                                </form>
                                                                                                <form
                                                                                                    action="attendances"
                                                                                                    method="POST"
                                                                                                    onsubmit="return confirm('Mark <%= a.getStudentName()%> as absent?');">
                                                                                                    <input type="hidden"
                                                                                                        name="eventId"
                                                                                                        value="<%= targetEvent.getEventId()%>">
                                                                                                    <input type="hidden"
                                                                                                        name="attendanceId"
                                                                                                        value="<%= a.getAttendanceId()%>">
                                                                                                    <input type="hidden"
                                                                                                        name="action"
                                                                                                        value="rejectAttendance">
                                                                                                    <button
                                                                                                        type="submit"
                                                                                                        class="btn btn-sm btn-danger fw-bold shadow-sm"><i
                                                                                                            class="fas fa-user-slash me-1"></i>Absent</button>
                                                                                                </form>
                                                                                                <% } else { %>
                                                                                                    <span
                                                                                                        class="text-muted small border px-2 py-1 rounded bg-light"><i
                                                                                                            class="fas fa-lock me-1"></i>Available
                                                                                                        on event
                                                                                                        day</span>
                                                                                                    <% } %>
                                                                                        </div>
                                                                                        <% } else if (isDeclined) { %>
                                                                                            <span
                                                                                                class="text-muted small border px-2 py-1 rounded bg-light"><i
                                                                                                    class="fas fa-ban me-1"></i>Declined</span>
                                                                                            <% } else { %>
                                                                                                <span
                                                                                                    class="text-muted small border px-2 py-1 rounded bg-light"><i
                                                                                                        class="fas fa-lock me-1"></i>Locked
                                                                                                    Status</span>
                                                                                                <% } %>
                                                                            </td>
                                                                        </tr>
                                                                        <% } } else { %>
                                                                            <tr>
                                                                                <td colspan="6"
                                                                                    class="text-center py-5 text-muted">
                                                                                    <i
                                                                                        class="fas fa-users-slash fa-3x mb-3 text-light"></i><br>
                                                                                    No students have registered for this
                                                                                    event yet.
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

                    <% if ("CHAIRPERSON".equals(session.getAttribute("accountType"))) {%>
                        <div class="modal fade" id="qrCodeModal" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-sm">
                                <div class="modal-content border-0 shadow-lg rounded-3">
                                    <div class="modal-header border-0 pb-0">
                                        <h5 class="modal-title fw-bold"><i class="bx bx-qr-scan me-2 text-dark"></i>Scan
                                            to Attend</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body text-center pb-4 px-4">
                                        <p class="text-muted small mb-3">Students scan this QR code to automatically
                                            mark their attendance for <strong>
                                                <%= targetEvent.getEventName()%>
                                            </strong>.</p>
                                        <img src="https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=<%= java.net.URLEncoder.encode(qrUrl, "UTF-8")%>" alt="Attendance QR Code" class="img-fluid rounded-2 border p-2
                                        shadow-sm mb-3" style="max-width: 220px;">
                                        <div class="alert alert-info py-2 px-3 small mb-0">
                                            <i class="bx bx-info-circle me-1"></i>Only students with <strong>approved
                                                registration</strong> can use this QR.
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% }%>


                            <script>
                                document.addEventListener("DOMContentLoaded", function () {
                                    // Remove active class from all menu items
                                    document.querySelectorAll('.menu-item.active').forEach(function (item) {
                                        item.classList.remove('active');
                                    });

                                    // Add active class to "Manage Events" menu item
                                    document.querySelectorAll('.menu-link').forEach(function (link) {
                                        if (link.getAttribute('href') === 'events?action=manage') {
                                            link.parentElement.classList.add('active');
                                        }
                                    });
                                });
                            </script>
                </body>

                </html>