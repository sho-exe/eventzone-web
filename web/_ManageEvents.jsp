<%@page import="java.util.List" %>
    <%@page import="com.lab.model.Event" %>
        <%@page import="com.lab.model.Club" %>
            <div class=" flex-grow-1 container-p-y">

                <h4 class="fw-bold py-3 mb-4 d-flex align-items-center">
                    <span class="text-muted fw-light">Chairperson /&nbsp;</span>Manage Events
                    <i class="bx bx-info-circle text-info ms-2"
                        style="cursor: pointer; font-size: 1.5rem; vertical-align: middle;" data-bs-toggle="collapse"
                        data-bs-target="#pageTipsCollapse" title="Toggle Page Guide"></i>
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

                        <div class="collapse show mb-4" id="pageTipsCollapse">
                            <div class="card border-0 bg-label-info shadow-none" style="border-radius: 12px;">
                                <div class="card-body p-3">
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="bg-info text-white d-flex align-items-center justify-content-center"
                                            style="width: 36px; height: 36px; border-radius: 8px; font-size: 1.2rem; flex-shrink: 0;">
                                            <i class="bx bx-info-circle"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="mb-1 text-info fw-bold" style="font-size: 0.95rem;">Page Guide &
                                                Tips</h6>
                                            <div class="text-dark"
                                                style="font-size: 0.85rem; line-height: 1.45; font-weight: 500;">
                                                You are actively managing <strong>
                                                    <%= myClub.getClubName() %>
                                                </strong>. Submit event proposals here. The Advisor or HEPA must
                                                manually approve them before students can register!
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mt-4 mb-3 flex-wrap gap-2">
                            <h5 class="fw-bold text-dark mb-0"><i class="fas fa-list me-2"></i> Club Event Archive</h5>
                            <div class="d-flex align-items-center flex-nowrap gap-2">
                                <input type="text" id="manageEventsSearch" class="form-control"
                                    placeholder="Search events..." style="width: 250px; margin-bottom: -15px">
                                <button type="button" class="btn btn-primary text-nowrap" data-bs-toggle="modal"
                                    style="font-weight: 1000" data-bs-target="#proposeEventModal">
                                    <i class="fas fa-paper-plane me-1"></i> Propose New Event
                                </button>
                            </div>
                        </div>

                        <div class="row">
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
                                    <div class="col-lg-4 col-md-6 manage-event-card-wrapper">
                                        <div class="card club-card position-relative">
                                            <% String imgPath=e.getImage(); if (imgPath !=null &&
                                                !imgPath.trim().isEmpty()) { if (!imgPath.startsWith("http://") &&
                                                !imgPath.startsWith("https://")) { imgPath=request.getContextPath()
                                                + "/" + imgPath; } } else { imgPath=request.getContextPath()
                                                + "/resources/assets/img/default-event.png" ; } %>
                                                <div class="event-image-wrapper">
                                                    <img src="<%= imgPath %>" class="event-image"
                                                        alt="<%= e.getEventName() %>"
                                                        onerror="this.onerror=null; this.src='<%= request.getContextPath() %>/resources/assets/img/default-event.png';">
                                                </div>
                                                <div class="card-inner">
                                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                                        <span class="club-id-badge badge-index mb-0">
                                                            <%= eventIndex %>
                                                        </span>
                                                        <span class="club-id-badge badge-id mb-0">
                                                            ID: <%= e.getEventId() %>
                                                        </span>
                                                    </div>

                                                    <div class="mb-3">
                                                        <h5 class="fw-bold text-dark mb-1 manage-event-title"
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
                                                                    style="font-size: 0.7rem; text-transform: uppercase; font-weight: 600;">Date
                                                                    & Time</small>
                                                                <span class="fs-6 text-dark fw-semibold">
                                                                    <%= e.getDate() %>
                                                                        <% if (e.getTime() !=null) { %>
                                                                            <%= e.getTime().toString().substring(0, 5)
                                                                                %>
                                                                                <%= e.getEndTime() !=null ? " - " +
                                                                                    e.getEndTime().toString().substring(0,
                                                                                    5) : "" %>
                                                                                    <% } %>
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
                                                        <div class="mb-2 d-flex align-items-center gap-2">
                                                            <i class="bx bx-purchase-tag-alt text-success fs-5"></i>
                                                            <div>
                                                                <small class="text-muted d-block"
                                                                    style="font-size: 0.7rem; text-transform: uppercase; font-weight: 600;">Category</small>
                                                                <span class="fs-6 text-dark fw-semibold"
                                                                    style="text-transform: capitalize;">
                                                                    <%= e.getCategory() !=null ? e.getCategory() : "N/A"
                                                                        %>
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="mb-0 d-flex align-items-center gap-2">
                                                            <i class="bx bx-globe text-primary fs-5"></i>
                                                            <div>
                                                                <small class="text-muted d-block"
                                                                    style="font-size: 0.7rem; text-transform: uppercase; font-weight: 600;">SDG
                                                                    Goals</small>
                                                                <span class="fs-6 text-dark fw-semibold">
                                                                    <%= e.getSdgGoals() !=null &&
                                                                        !e.getSdgGoals().isEmpty() ? e.getSdgGoals()
                                                                        : "N/A" %>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <% if ("APPROVED".equals(e.getStatus())) { %>
                                                        <div class="mt-3">
                                                            <a href="attendances?action=manageAttendances&eventId=<%= e.getEventId() %>"
                                                                class="btn btn-save mt-0"
                                                                style="display: flex; align-items: center; justify-content: center; font-size: 0.82rem; height: 36px; margin-top: 0 !important;">
                                                                <i class="bx bx-group me-1"></i> Attendances
                                                            </a>
                                                        </div>
                                                        <% } else if ("PENDING".equals(e.getStatus())) { %>
                                                            <div class="mt-3 d-flex gap-2">
                                                                <button type="button"
                                                                    class="btn btn-outline-primary w-50 edit-event-btn"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#editEventModal"
                                                                    data-id="<%= e.getEventId() %>"
                                                                    data-name="<%= e.getEventName().replace("\"", "&quot;" ) %>"
                                                                    data-desc="<%=
                                                                        e.getDescription().replace("\"", "&quot;" ) %>"
                                                                        data-date="<%= e.getDate() %>"
                                                                            data-time="<%= e.getTime() !=null ?
                                                                                e.getTime().toString().substring(0, 5)
                                                                                : "" %>"
                                                                                data-endtime="<%= e.getEndTime() !=null
                                                                                    ?
                                                                                    e.getEndTime().toString().substring(0,
                                                                                    5) : "" %>"
                                                                                    data-venue="<%=
                                                                                        e.getVenue().replace("\"", "&quot;"
                                                                                        ) %>"
                                                                                        data-quota="<%= e.getQuota() %>"
                                                                                            data-cat="<%=
                                                                                                e.getCategory() %>"
                                                                                                data-sdg="<%=
                                                                                                    e.getSdgGoals()
                                                                                                    !=null ?
                                                                                                    e.getSdgGoals() : ""
                                                                                                    %>"
                                                                                                    data-image="<%=
                                                                                                        e.getImage()
                                                                                                        !=null ?
                                                                                                        e.getImage().replace("\"", "&quot;"
                                                                                                        ) : "" %>"
                                                                                                        style="display:
                                                                                                        flex;
                                                                                                        align-items:
                                                                                                        center;
                                                                                                        justify-content:
                                                                                                        center;
                                                                                                        font-size:
                                                                                                        0.82rem;
                                                                                                        height:
                                                                                                        36px;">
                                                                                                        <i
                                                                                                            class="bx bx-edit-alt me-1"></i>
                                                                                                        Edit
                                                                </button>
                                                                <form action="events" method="POST" class="w-50 mb-0"
                                                                    onsubmit="return confirm('Are you sure you want to delete this pending event?');">
                                                                    <input type="hidden" name="action"
                                                                        value="deleteEvent">
                                                                    <input type="hidden" name="eventId"
                                                                        value="<%= e.getEventId() %>">
                                                                    <button type="submit"
                                                                        class="btn btn-outline-danger w-100"
                                                                        style="display: flex; align-items: center; justify-content: center; font-size: 0.82rem; height: 36px;">
                                                                        <i class="bx bx-trash me-1"></i> Delete
                                                                    </button>
                                                                </form>
                                                            </div>
                                                            <% } %>
                                                </div><%-- card-inner --%>
                                        </div><%-- card club-card --%>
                                    </div><%-- col-lg-4 --%>

                                        <% /* Insert a full-width spacer row after every 3rd card */ if (eventIndex %
                                            3==0) { %>
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
                                    <form action="events" method="POST" enctype="multipart/form-data">
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

                                                <div class="col-md-3 mb-3">
                                                    <label class="form-label fw-bold">Target Date</label>
                                                    <input type="date" name="date" class="form-control border-primary"
                                                        required>
                                                </div>

                                                <div class="col-md-2 mb-3">
                                                    <label class="form-label fw-bold">Start Time</label>
                                                    <input type="time" name="time" class="form-control border-primary"
                                                        required>
                                                </div>

                                                <div class="col-md-2 mb-3">
                                                    <label class="form-label fw-bold">End Time</label>
                                                    <input type="time" name="endTime"
                                                        class="form-control border-primary">
                                                </div>

                                                <div class="col-md-3 mb-3">
                                                    <label class="form-label fw-bold">Location / Venue</label>
                                                    <select name="venue" class="form-select border-primary" required>
                                                        <option value="" disabled selected>Select Venue</option>
                                                        <option value="DSM">DSM</option>
                                                        <option value="IBH-01">IBH-01</option>
                                                        <option value="MP1">MP1</option>
                                                        <option value="DS1-02">DS1-02</option>
                                                    </select>
                                                </div>

                                                <div class="col-md-2 mb-3">
                                                    <label class="form-label fw-bold">Quota Limit</label>
                                                    <input type="number" name="quota"
                                                        class="form-control border-primary" placeholder="0" required
                                                        min="1">
                                                </div>

                                                <div class="col-md-12 mb-3">
                                                    <label class="form-label fw-bold">Event Image</label>
                                                    <input type="file" name="image" class="form-control border-primary"
                                                        accept="image/*">
                                                </div>

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

                                                <div class="col-md-12 mb-3">
                                                    <label class="form-label fw-bold d-block">Select SDG Goals:</label>
                                                    <div class="row">
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 1" id="sdg1">
                                                                <label class="form-check-label text-dark" for="sdg1">SDG
                                                                    1: No Poverty</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 2" id="sdg2">
                                                                <label class="form-check-label text-dark" for="sdg2">SDG
                                                                    2: Zero Hunger</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 3" id="sdg3">
                                                                <label class="form-check-label text-dark" for="sdg3">SDG
                                                                    3: Good Health and Well-being</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 4" id="sdg4">
                                                                <label class="form-check-label text-dark" for="sdg4">SDG
                                                                    4: Quality Education</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 5" id="sdg5">
                                                                <label class="form-check-label text-dark" for="sdg5">SDG
                                                                    5: Gender Equality</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 6" id="sdg6">
                                                                <label class="form-check-label text-dark" for="sdg6">SDG
                                                                    6: Clean Water and Sanitation</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 7" id="sdg7">
                                                                <label class="form-check-label text-dark" for="sdg7">SDG
                                                                    7: Affordable and Clean Energy</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 8" id="sdg8">
                                                                <label class="form-check-label text-dark" for="sdg8">SDG
                                                                    8: Decent Work and Economic Growth</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 9" id="sdg9">
                                                                <label class="form-check-label text-dark" for="sdg9">SDG
                                                                    9: Industry, Innovation and Infrastructure</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 10" id="sdg10">
                                                                <label class="form-check-label text-dark"
                                                                    for="sdg10">SDG 10: Reduced Inequalities</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 11" id="sdg11">
                                                                <label class="form-check-label text-dark"
                                                                    for="sdg11">SDG 11: Sustainable Cities and
                                                                    Communities</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 12" id="sdg12">
                                                                <label class="form-check-label text-dark"
                                                                    for="sdg12">SDG 12: Responsible Consumption and
                                                                    Production</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 13" id="sdg13">
                                                                <label class="form-check-label text-dark"
                                                                    for="sdg13">SDG 13: Climate Action</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 14" id="sdg14">
                                                                <label class="form-check-label text-dark"
                                                                    for="sdg14">SDG 14: Life Below Water</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 15" id="sdg15">
                                                                <label class="form-check-label text-dark"
                                                                    for="sdg15">SDG 15: Life on Land</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 16" id="sdg16">
                                                                <label class="form-check-label text-dark"
                                                                    for="sdg16">SDG 16: Peace, Justice and Strong
                                                                    Institutions</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox"
                                                                    name="sdgGoals" value="SDG 17" id="sdg17">
                                                                <label class="form-check-label text-dark"
                                                                    for="sdg17">SDG 17: Partnerships for the
                                                                    Goals</label>
                                                            </div>
                                                        </div>
                                                    </div>
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

            </div>

            <!-- Edit Event Modal -->
            <div class="modal fade" id="editEventModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content border-0 shadow-lg">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title fw-bold"><i class="fas fa-edit me-2"></i>
                                Modify Event
                                Proposal</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                        </div>
                        <form action="events" method="POST" enctype="multipart/form-data">
                            <div class="modal-body p-4 bg-light">
                                <input type="hidden" name="action" value="editEvent">
                                <input type="hidden" name="eventId" id="editEventId">

                                <div class="row">
                                    <div class="col-md-12 mb-3">
                                        <label class="form-label fw-bold">Event
                                            Title</label>
                                        <input type="text" name="eventName" id="editEventName"
                                            class="form-control border-primary"
                                            placeholder="e.g., Annual Coding Hackathon" required>
                                    </div>

                                    <div class="col-md-12 mb-2">
                                        <label class="form-label fw-bold">Description</label>
                                        <textarea name="description" id="editDescription"
                                            class="form-control border-primary" rows="4"
                                            placeholder="Briefly inform students what this event entails. They will read this during registration..."
                                            required></textarea>
                                    </div>

                                    <div class="col-md-3 mb-3">
                                        <label class="form-label fw-bold">Target Date</label>
                                        <input type="date" name="date" id="editDate" class="form-control border-primary"
                                            required>
                                    </div>

                                    <div class="col-md-2 mb-3">
                                        <label class="form-label fw-bold">Start Time</label>
                                        <input type="time" name="time" id="editTime" class="form-control border-primary"
                                            required>
                                    </div>

                                    <div class="col-md-2 mb-3">
                                        <label class="form-label fw-bold">End Time</label>
                                        <input type="time" name="endTime" id="editEndTime"
                                            class="form-control border-primary">
                                    </div>

                                    <div class="col-md-3 mb-3">
                                        <label class="form-label fw-bold">Location / Venue</label>
                                        <select name="venue" id="editVenue" class="form-select border-primary" required>
                                            <option value="" disabled selected>Select Venue</option>
                                            <option value="DSM">DSM</option>
                                            <option value="IBH-01">IBH-01</option>
                                            <option value="MP1">MP1</option>
                                            <option value="DS1-02">DS1-02</option>
                                        </select>
                                    </div>

                                    <div class="col-md-2 mb-3">
                                        <label class="form-label fw-bold">Quota Limit</label>
                                        <input type="number" name="quota" id="editQuota"
                                            class="form-control border-primary" placeholder="0" required min="1">
                                    </div>

                                    <div class="col-md-12 mb-3">
                                        <label class="form-label fw-bold">Event Image <span
                                                class="text-muted fw-normal">(Leave blank to keep existing
                                                image)</span></label>
                                        <input type="file" name="image" id="editImage"
                                            class="form-control border-primary" accept="image/*">
                                        <div id="editImagePreviewContainer" class="mt-2 d-none">
                                            <small class="text-muted d-block mb-1">Current Image Preview:</small>
                                            <img id="editImagePreview" src="" alt="Current Event Image"
                                                style="height: 100px; border-radius: 8px; object-fit: cover;">
                                        </div>
                                    </div>

                                    <div class="col-md-12 mb-3">
                                        <label class="form-label fw-bold">Select
                                            Category:</label>
                                        <select class="fw-bold form-select" id="editKategori" name="kategori">
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

                                    <div class="col-md-12 mb-3">
                                        <label class="form-label fw-bold d-block">Select SDG Goals:</label>
                                        <div class="row">
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 1" id="editSdg1">
                                                    <label class="form-check-label text-dark" for="editSdg1">SDG 1: No
                                                        Poverty</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 2" id="editSdg2">
                                                    <label class="form-check-label text-dark" for="editSdg2">SDG 2: Zero
                                                        Hunger</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 3" id="editSdg3">
                                                    <label class="form-check-label text-dark" for="editSdg3">SDG 3: Good
                                                        Health and Well-being</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 4" id="editSdg4">
                                                    <label class="form-check-label text-dark" for="editSdg4">SDG 4:
                                                        Quality Education</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 5" id="editSdg5">
                                                    <label class="form-check-label text-dark" for="editSdg5">SDG 5:
                                                        Gender Equality</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 6" id="editSdg6">
                                                    <label class="form-check-label text-dark" for="editSdg6">SDG 6:
                                                        Clean Water and Sanitation</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 7" id="editSdg7">
                                                    <label class="form-check-label text-dark" for="editSdg7">SDG 7:
                                                        Affordable and Clean Energy</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 8" id="editSdg8">
                                                    <label class="form-check-label text-dark" for="editSdg8">SDG 8:
                                                        Decent Work and Economic Growth</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 9" id="editSdg9">
                                                    <label class="form-check-label text-dark" for="editSdg9">SDG 9:
                                                        Industry, Innovation and Infrastructure</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 10" id="editSdg10">
                                                    <label class="form-check-label text-dark" for="editSdg10">SDG 10:
                                                        Reduced Inequalities</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 11" id="editSdg11">
                                                    <label class="form-check-label text-dark" for="editSdg11">SDG 11:
                                                        Sustainable Cities and Communities</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 12" id="editSdg12">
                                                    <label class="form-check-label text-dark" for="editSdg12">SDG 12:
                                                        Responsible Consumption and Production</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 13" id="editSdg13">
                                                    <label class="form-check-label text-dark" for="editSdg13">SDG 13:
                                                        Climate Action</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 14" id="editSdg14">
                                                    <label class="form-check-label text-dark" for="editSdg14">SDG 14:
                                                        Life Below Water</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 15" id="editSdg15">
                                                    <label class="form-check-label text-dark" for="editSdg15">SDG 15:
                                                        Life on Land</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 16" id="editSdg16">
                                                    <label class="form-check-label text-dark" for="editSdg16">SDG 16:
                                                        Peace, Justice and Strong Institutions</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="sdgGoals"
                                                        value="SDG 17" id="editSdg17">
                                                    <label class="form-check-label text-dark" for="editSdg17">SDG 17:
                                                        Partnerships for the Goals</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="alert alert-warning small border-0 mt-3 mb-0">
                                    <i class="fas fa-lock me-1"></i>
                                    <strong>Note:</strong>
                                    Once edited, the proposal remains
                                    frozen as "PENDING" until approved.
                                </div>
                            </div>
                            <div class="modal-footer bg-white">
                                <button type="button" class="btn btn-outline-secondary fw-bold"
                                    data-bs-dismiss="modal">Discard
                                    Changes</button>
                                <button type="submit" class="btn btn-primary fw-bold px-4">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <% } %> <!-- End Else Branch -->

                </div>

                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        // Append modals to body so they render properly
                        var proposeModal = document.getElementById('proposeEventModal');
                        if (proposeModal) {
                            document.body.appendChild(proposeModal);
                        }
                        var editModal = document.getElementById('editEventModal');
                        if (editModal) {
                            document.body.appendChild(editModal);
                        }

                        // Handle population of edit modal fields
                        var editButtons = document.querySelectorAll('.edit-event-btn');
                        editButtons.forEach(function (btn) {
                            btn.addEventListener('click', function () {
                                document.getElementById('editEventId').value = btn.getAttribute('data-id');
                                document.getElementById('editEventName').value = btn.getAttribute('data-name');
                                document.getElementById('editDescription').value = btn.getAttribute('data-desc');
                                document.getElementById('editDate').value = btn.getAttribute('data-date');
                                document.getElementById('editTime').value = btn.getAttribute('data-time');
                                document.getElementById('editEndTime').value = btn.getAttribute('data-endtime');
                                document.getElementById('editVenue').value = btn.getAttribute('data-venue');
                                document.getElementById('editQuota').value = btn.getAttribute('data-quota');
                                document.getElementById('editKategori').value = btn.getAttribute('data-cat');
                                // Reset the file input value
                                document.getElementById('editImage').value = '';

                                // Handle preview container
                                var imgVal = btn.getAttribute('data-image');
                                var previewContainer = document.getElementById('editImagePreviewContainer');
                                var previewImg = document.getElementById('editImagePreview');
                                if (imgVal && imgVal.trim() !== "") {
                                    var finalPath = imgVal;
                                    if (!finalPath.startsWith("http://") && !finalPath.startsWith("https://")) {
                                        finalPath = window.location.pathname.substring(0, window.location.pathname.indexOf('/', 1)) + "/" + finalPath;
                                    }
                                    previewImg.src = finalPath;
                                    previewContainer.classList.remove('d-none');
                                } else {
                                    previewImg.src = "";
                                    previewContainer.classList.add('d-none');
                                }

                                // Reset checkboxes first
                                var checkboxes = document.querySelectorAll('#editEventModal input[name="sdgGoals"]');
                                checkboxes.forEach(function (cb) {
                                    cb.checked = false;
                                });

                                // Parse and check selected SDGs
                                var sdgString = btn.getAttribute('data-sdg');
                                if (sdgString) {
                                    var sdgs = sdgString.split(', ');
                                    checkboxes.forEach(function (cb) {
                                        if (sdgs.indexOf(cb.value) !== -1) {
                                            cb.checked = true;
                                        }
                                    });
                                }
                            });
                        });

                        // Handle event search filtering
                        var searchInput = document.getElementById('manageEventsSearch');
                        if (searchInput) {
                            searchInput.addEventListener('keyup', function () {
                                var filter = this.value.toLowerCase();
                                var eventCards = document.querySelectorAll('.manage-event-card-wrapper');

                                eventCards.forEach(function (card) {
                                    var titleEl = card.querySelector('.manage-event-title');
                                    if (titleEl) {
                                        var titleText = titleEl.textContent || titleEl.innerText;
                                        if (titleText.toLowerCase().indexOf(filter) > -1) {
                                            card.style.display = "";
                                        } else {
                                            card.style.display = "none";
                                        }
                                    }
                                });
                            });
                        }
                    });
                </script>