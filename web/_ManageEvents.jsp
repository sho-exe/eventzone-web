<%@page import="java.util.List" %>
    <%@page import="com.lab.model.Event" %>
        <%@page import="com.lab.model.Club" %>
            <div class=" flex-grow-1 container-p-y">

                <h4 class="fw-bold py-3 mb-4">
                    <span class="text-muted fw-light">Chairperson /</span> Manage Events
                </h4>

                <% Club myClub=(Club) request.getAttribute("club"); if (myClub==null) { %>
                    <div class="alert alert-danger  border-0 d-flex align-items-center p-4 ">
                        <i class="fas fa-exclamation-triangle fa-3x me-4 text-danger"></i>
                        <div>
                            <h4 class="fw-bold mb-1">Access Denied: Unassigned
                                Chairperson</h4>
                            <p class="mb-0">You have not been officially appointed
                                as the Chairperson to
                                any active club. Please contact your Advisor or the
                                HEPA Administrator
                                to finish setting up your account profile before
                                proposing events.</p>
                        </div>
                    </div>
                    <% } else { %>

                        <div class="alert alert-primary border-0  bg-primary-soft">
                            <i class="fas fa-info-circle me-2 text-primary"></i> You
                            are actively
                            managing <strong>
                                <%= myClub.getClubName() %>
                            </strong>. Submit event proposals here. The Advisor or
                            HEPA must manually
                            approve them before students can register!
                        </div>

                        <div class="d-flex justify-content-between align-items-center mt-4 mb-3">
                            <h5 class="fw-bold text-dark mb-0"><i class="fas fa-list me-2"></i> Club
                                Event Archive</h5>
                            <button type="button" class="btn btn-primary " data-bs-toggle="modal"
                                data-bs-target="#proposeEventModal">
                                <i class="fas fa-paper-plane me-1"></i> Propose New
                                Event
                            </button>
                        </div>

                        <div class="row gy-4">
                            <% List<Event> eventList = (List<Event>)
                                    request.getAttribute("eventList");
                                    if(eventList != null && !eventList.isEmpty()) {
                                    int eventIndex = 0;
                                    for(Event e : eventList) {
                                    eventIndex++;
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
                                                <div class="d-flex justify-content-between align-items-center mb-1">
                                                    <span class="club-id-badge badge-index mb-0">
                                                        #<%= eventIndex %>
                                                    </span>
                                                    <span class="club-id-badge badge-id mb-0">
                                                        ID: <%= e.getEventId() %>
                                                    </span>
                                                </div>

                                                <div class="mb-3">
                                                    <h5 class="fw-bold text-dark mb-1"
                                                        style="font-size: 1.1rem; line-height: 1.3;">
                                                        <%= e.getEventName() %>
                                                    </h5>
                                                    <span class="badge <%= badgeColor %>"
                                                        style="font-size: 0.72rem; padding: 4px 8px;"><i
                                                            class="bx <%= icon %> me-1"></i>
                                                        <%= e.getStatus() %>
                                                    </span>
                                                </div>

                                                <p class="text-muted small mb-3"
                                                    style="min-height: 55px; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; line-height: 1.4;">
                                                    <%= e.getDescription() %>
                                                </p>

                                                <hr class="divider-soft">

                                                <div class="assign-section mt-3">
                                                    <div class="mb-2 d-flex align-items-center gap-2">
                                                        <i class="bx bx-calendar text-primary fs-5"></i>
                                                        <div>
                                                            <small class="text-muted d-block"
                                                                style="font-size: 0.7rem; text-transform: uppercase; font-weight: 600;">Date</small>
                                                            <span class="fs-6 text-dark fw-semibold">
                                                                <%= e.getDate() %>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="mb-2 d-flex align-items-center gap-2">
                                                        <i class="bx bx-map-pin text-danger fs-5"></i>
                                                        <div>
                                                            <small class="text-muted d-block"
                                                                style="font-size: 0.7rem; text-transform: uppercase; font-weight: 600;">Venue</small>
                                                            <span class="fs-6 text-dark fw-semibold">
                                                                <%= e.getVenue() %>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="mb-2 d-flex align-items-center gap-2">
                                                        <i class="bx bx-group text-info fs-5"></i>
                                                        <div>
                                                            <small class="text-muted d-block"
                                                                style="font-size: 0.7rem; text-transform: uppercase; font-weight: 600;">Quota</small>
                                                            <span class="fs-6 text-dark fw-semibold">
                                                                <%= e.getQuota() %> Pax
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="mb-0 d-flex align-items-center gap-2">
                                                        <i class="bx bx-purchase-tag-alt text-success fs-5"></i>
                                                        <div>
                                                            <small class="text-muted d-block"
                                                                style="font-size: 0.7rem; text-transform: uppercase; font-weight: 600;">Category</small>
                                                            <span class="fs-6 text-dark fw-semibold"
                                                                style="text-transform: capitalize;">
                                                                <%= e.getCategory() %>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <% if("APPROVED".equals(e.getStatus())) { %>
                                                    <div class="mt-3">
                                                        <a href="attendances?action=manageAttendances&eventId=<%= e.getEventId() %>"
                                                            class="btn btn-save mt-0"
                                                            style="display: flex; align-items: center; justify-content: center; font-size: 0.82rem; height: 36px; margin-top: 0 !important;">
                                                            <i class="bx bx-group me-1"></i>
                                                            Attendances
                                                        </a>
                                                    </div>
                                                    <% } %>
                                            </div>
                                        </div>
                                    </div>
                                    <% /* Insert a full-width spacer row after every 3rd card */ if (eventIndex % 3==0)
                                        { %>
                                        <div class="col-12" style="margin-bottom: 20px;"></div>
                                        <% } %>
                                            <% } } else { %>
                                                <div class="col-12 text-center py-5 text-muted">
                                                    <i class="fas fa-folder-open fa-3x mb-3 text-light"></i><br>
                                                    You have not proposed any events yet.
                                                    Click the button above
                                                    to begin!
                                                </div>
                                                <% } %>
                        </div>

                        <!-- Propose Event Modal -->
                        <div class="modal fade" id="proposeEventModal" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content border-0 shadow-lg">
                                    <div class="modal-header bg-primary text-white">
                                        <h5 class="modal-title fw-bold"><i class="fas fa-paper-plane me-2"></i>
                                            Submit Event
                                            Proposal</h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                    </div>
                                    <form action="events" method="POST">
                                        <div class="modal-body p-4 bg-light">
                                            <input type="hidden" name="action" value="proposeEvent">
                                            <input type="hidden" name="clubId" value="<%= myClub.getClubId() %>">

                                            <div class="row">
                                                <div class="col-md-12 mb-3">
                                                    <label class="form-label fw-bold">Event
                                                        Title</label>
                                                    <input type="text" name="eventName"
                                                        class="form-control border-primary"
                                                        placeholder="e.g., Annual Coding Hackathon" required>
                                                </div>

                                                <div class="col-md-12 mb-2">
                                                    <label class="form-label fw-bold">Description</label>
                                                    <textarea name="description" class="form-control border-primary"
                                                        rows="4"
                                                        placeholder="Briefly inform students what this event entails. They will read this during registration..."
                                                        required></textarea>
                                                </div>

                                                <div class="col-md-5 mb-3">
                                                    <label class="form-label fw-bold">Target
                                                        Date</label>
                                                    <input type="date" name="date" class="form-control border-primary"
                                                        required>
                                                </div>

                                                <div class="col-md-5 mb-3">
                                                    <label class="form-label fw-bold">Location
                                                        /
                                                        Venue</label>
                                                    <input type="text" name="venue" class="form-control border-primary"
                                                        placeholder="e.g., Main Hall B" required>
                                                </div>

                                                <div class="col-md-2 mb-3">
                                                    <label class="form-label fw-bold">Quota
                                                        Limit</label>
                                                    <input type="number" name="quota"
                                                        class="form-control border-primary" placeholder="0" required
                                                        min="1">
                                                </div>

                                                <!-- <div class="col-md-12 mb-3">
                                                                    <label class="form-label fw-bold">Merit Decision
                                                                        Criteria <span
                                                                            class="text-muted fw-normal">(Optional
                                                                            context)</span></label>
                                                                    <input type="text" name="criteria"
                                                                        class="form-control"
                                                                        placeholder="e.g., Activity Level, Hardcoded specific tier...">
                                                                </div> -->


                                                <div class="col-md-12 mb-3">
                                                    <label class="form-label fw-bold">Select
                                                        Category:</label>
                                                    <select class="fw-bold form-select" id="kategori" name="kategori">
                                                        <option value="leadership">
                                                            Leadership</option>
                                                        <option value="culture">
                                                            Culture</option>
                                                        <option value="spirituality">
                                                            Spirituality
                                                        </option>
                                                        <option value="entrepreneurship">
                                                            Entrepreneurship
                                                        </option>
                                                        <option value="volunteerism">
                                                            Volunteerism
                                                        </option>
                                                        <option value="career">
                                                            Career</option>
                                                        <option value="sports">
                                                            Sports</option>
                                                        <option value="counseling_wellbeing">
                                                            Student
                                                            Counseling and Wellbeing
                                                        </option>
                                                    </select>
                                                </div>



                                            </div>
                                            <div class="alert alert-warning small border-0 mt-3 mb-0">
                                                <i class="fas fa-lock me-1"></i>
                                                <strong>Note:</strong>
                                                Once submitted, the proposal is
                                                frozen as "PENDING". It
                                                must be approved by Administration
                                                to appear in the
                                                public catalog.
                                            </div>
                                        </div>
                                        <div class="modal-footer bg-white">
                                            <button type="button" class="btn btn-outline-secondary fw-bold"
                                                data-bs-dismiss="modal">Discard
                                                Proposal</button>
                                            <button type="submit" class="btn btn-primary fw-bold px-4">Submit
                                                to
                                                Administration</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <% } %> <!-- End Else Branch -->

            </div>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    var modal = document.getElementById('proposeEventModal');
                    if (modal) {
                        document.body.appendChild(modal);
                    }
                });
            </script>