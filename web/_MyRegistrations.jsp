<%@page import="java.util.List" %>
    <%@page import="com.lab.model.Attendance" %>
        <div class=" flex-grow-1 container-p-y">

            <h4 class="fw-bold py-3 mb-4">
                My Personal Sign-Ups
            </h4>

            <%
                String qrSuccess = request.getParameter("qrSuccess");
                String qrAlreadyCheckedIn = request.getParameter("qrAlreadyCheckedIn");
                String qrAlreadyVerified = request.getParameter("qrAlreadyVerified");
                String qrError = request.getParameter("qrError");
                String checkInSuccess = request.getParameter("checkInSuccess");
                String checkInError = request.getParameter("checkInError");
                if (qrSuccess != null || checkInSuccess != null) {
            %>
                <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm mb-4" role="alert" style="border-radius: 12px;">
                    <div class="d-flex align-items-center">
                        <i class="bx bx-check-circle fs-4 me-2"></i>
                        <div>
                            <strong class="d-block">Self Check-In Successful!</strong>
                            Your check-in has been recorded. Please wait for the chairperson to verify it.
                        </div>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } else if (qrAlreadyCheckedIn != null) { %>
                <div class="alert alert-info alert-dismissible fade show border-0 shadow-sm mb-4" role="alert" style="border-radius: 12px;">
                    <div class="d-flex align-items-center">
                        <i class="bx bx-info-circle fs-4 me-2"></i>
                        <div>
                            <strong class="d-block">Already Checked In!</strong>
                            You have already self checked-in for this event. Awaiting chairperson verification.
                        </div>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } else if (qrAlreadyVerified != null) { %>
                <div class="alert alert-warning alert-dismissible fade show border-0 shadow-sm mb-4" role="alert" style="border-radius: 12px;">
                    <div class="d-flex align-items-center">
                        <i class="bx bx-badge-check fs-4 me-2"></i>
                        <div>
                            <strong class="d-block">Attendance Verified!</strong>
                            Your attendance has already been verified for this event.
                        </div>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } else if (qrError != null || checkInError != null) { %>
                <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm mb-4" role="alert" style="border-radius: 12px;">
                    <div class="d-flex align-items-center">
                        <i class="bx bx-error fs-4 me-2"></i>
                        <div>
                            <strong class="d-block">Check-In Failed!</strong>
                            Could not register your check-in. Make sure you are registered and approved for this event, and that the event is today.
                        </div>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <div class="row">
                <div class="col-md-10 col-lg-8">
                    <div class="card border-0 shadow-sm rounded-3 p-4 mb-4">
                        <h5 class="fw-bold mb-3"><i class="fas fa-history text-muted me-2"></i>
                            Registration History</h5>
                        <p class="text-muted small">This timeline tracks every
                            faculty event you have ever registered for. Once the
                            Chairperson physically verifies your attendance at the
                            event, its status will turn Green (ATTENDED), locking
                            you in for future Merit point payouts!</p>

                        <div class="timeline">
                            <% List<Attendance> myRegistrations = (List<Attendance>)
                                    request.getAttribute("myRegistrations");
                                    if(myRegistrations != null &&
                                    !myRegistrations.isEmpty()) {
                                    for(Attendance a : myRegistrations) {
                                    boolean isPending = "PENDING".equals(a.getStatus());
                                    boolean isRegistered = "REGISTERED".equals(a.getStatus());
                                    boolean isSelfCheckedIn = "SELF_CHECKED_IN".equals(a.getStatus());
                                    boolean isDeclined = "DECLINED".equals(a.getStatus());
                                    boolean isAttended = "ATTENDED".equals(a.getStatus());
                                    boolean isMissed = "MISSED".equals(a.getStatus());

                                    String statusIndicatorClass = isPending ? "pending" :
                                    (isRegistered ? "registered" :
                                    (isSelfCheckedIn ? "self-checked-in" :
                                    (isDeclined ? "declined" :
                                    (isAttended ? "attended" : "missed"))));
                                    %>
                                    <div class="timeline-item <%= statusIndicatorClass %>">
                                        <div class="card border-0 shadow-sm overflow-hidden bg-white">
                                            <% String cardBodyClass="card-body p-4 " + (isPending
                                                ? "border-start border-secondary border-4" : (isRegistered
                                                ? "border-start border-warning border-4" : (isSelfCheckedIn
                                                ? "border-start border-info border-4" : (isAttended
                                                ? "border-start border-success border-4" : "" )))); %>
                                                <div class="<%= cardBodyClass %>">
                                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                                        <h5 class="fw-bold text-dark mb-0">
                                                            <%= a.getEventName() %>
                                                        </h5>
                                                        <% if(isPending) { %>
                                                            <span class="badge bg-secondary text-white"><i
                                                                    class="fas fa-hourglass-half text-white me-1"></i>
                                                                PENDING APPROVAL</span>
                                                            <% } else if(isRegistered) { %>
                                                                <span class="badge bg-warning text-dark"><i
                                                                        class="fas fa-check text-dark me-1"></i>
                                                                    APPROVED &amp; AWAITING EVENT</span>
                                                            <% } else if(isSelfCheckedIn) { %>
                                                                <span class="badge bg-info text-white"><i
                                                                        class="fas fa-fingerprint text-white me-1"></i>
                                                                    SELF CHECKED-IN (AWAITING VERIFICATION)</span>
                                                            <% } else if(isAttended) { %>
                                                                <span class="badge bg-success"><i
                                                                        class="fas fa-check-double text-white me-1"></i>
                                                                    ATTENDED</span>
                                                                <% } else if(isMissed) { %>
                                                                    <span class="badge bg-danger"><i
                                                                            class="fas fa-times text-white me-1"></i>
                                                                        MISSED EVENT</span>
                                                                    <% } else if(isDeclined) { %>
                                                                        <span class="badge bg-dark"><i
                                                                                class="fas fa-ban text-white me-1"></i>
                                                                            DECLINED</span>
                                                                        <% } %>
                                                    </div>
                                                    <p class="small text-muted mb-3">
                                                        <i class="fas fa-flag text-primary me-1"></i>
                                                        Hosted by: <strong>
                                                            <%= a.getClubName() %>
                                                        </strong>
                                                    </p>

                                                    <div class="row text-secondary small fw-bold mt-3">
                                                        <div class="col-sm-6 mb-2 mb-sm-0">
                                                            <i class="far fa-calendar-alt text-danger me-1"></i>
                                                            Event Date: <%= a.getEventDate() %>
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <i class="fas fa-map-marker-alt text-info me-1"></i>
                                                            Venue: <%= a.getEventVenue() %>
                                                        </div>
                                                    </div>
                                                    <hr class="text-muted opacity-25">
                                                    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                                                        <div class="text-muted small">
                                                            <i class="far fa-clock me-1"></i>
                                                            Signed up on <%= a.getRegistrationDate() %>
                                                        </div>
                                                        <%
                                                            boolean isToday = a.getEventDate() != null && a.getEventDate().toString().equals(java.time.LocalDate.now().toString());
                                                            if (isRegistered && isToday) {
                                                        %>
                                                            <form action="attendances" method="POST" class="d-inline m-0">
                                                                <input type="hidden" name="action" value="selfCheckIn">
                                                                <input type="hidden" name="attendanceId" value="<%= a.getAttendanceId() %>">
                                                                <button type="submit" class="btn btn-sm btn-primary fw-bold px-3 py-2 border-0" style="background: linear-gradient(135deg, #696cff, #5f61e6); border-radius: 8px;">
                                                                    <i class="fas fa-fingerprint me-1"></i> Self Check-In
                                                                </button>
                                                            </form>
                                                        <% } %>
                                                    </div>
                                                </div>
                                        </div>
                                    </div>
                                    <% } } else { %>
                                        <div class="text-center py-5 text-muted">
                                            <i class="fas fa-box-open fa-3x mb-3 text-light"></i>
                                            <h6 class="fw-bold">No Registrations
                                                Found</h6>
                                            <p>You haven't signed up for any events
                                                yet. Check out the Event Catalog!
                                            </p>
                                            <a href="events?action=browse" class="btn btn-outline-primary btn-sm"><i
                                                    class="fas fa-compass me-1"></i>
                                                Browse Events</a>
                                        </div>
                                        <% } %>
                        </div>
                    </div>
                </div>
            </div>

        </div>