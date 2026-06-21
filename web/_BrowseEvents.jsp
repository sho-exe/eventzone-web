<%@page import="java.util.List" %>
    <%@page import="com.lab.model.Event" %>
        <div class=" flex-grow-1 container-p-y">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="fw-bold py-3 mb-0">
                    Explore Campus Events
                </h4>
                <div class="d-flex align-items-center gap-2">
                    <label for="eventDateFilter" class="form-label mb-0 text-nowrap fw-semibold">Filter by Date:</label>
                    <input type="date" id="eventDateFilter" class="form-control" style="max-width: 200px;">
                    <button type="button" id="clearDateFilter" class="btn btn-outline-secondary btn-sm" style="display:none;">Clear</button>
                </div>
            </div>

            <div class="row" id="eventsContainer">
                <% List<Event> eventCatalog = (List<Event>)
                        request.getAttribute("eventCatalog");
                        if(eventCatalog != null && !eventCatalog.isEmpty()) {
                        int eventIndex = 0;
                        for(Event e : eventCatalog) {
                        eventIndex++;
                        boolean isFull = e.getCurrentEnrollments() >= e.getQuota();
                        int spotsLeft = e.getQuota() - e.getCurrentEnrollments();
                        %>

                        <div class="col-lg-4 col-md-6 event-card-wrapper" data-event-date="<%= e.getDate() %>">
                            <div class="card club-card position-relative">
                                <% 
                                    String imgPath = e.getImage();
                                    if (imgPath != null && !imgPath.trim().isEmpty()) {
                                        if (!imgPath.startsWith("http://") && !imgPath.startsWith("https://")) {
                                            imgPath = request.getContextPath() + "/" + imgPath;
                                        }
                                    } else {
                                        imgPath = request.getContextPath() + "/resources/assets/img/default-event.png";
                                    }
                                %>
                                <div class="event-image-wrapper">
                                    <img src="<%= imgPath %>" class="event-image" alt="<%= e.getEventName() %>" onerror="this.onerror=null; this.src='<%= request.getContextPath() %>/resources/assets/img/default-event.png';">
                                </div>
                                        <div class="card-inner">
                                            <div class="d-flex justify-content-between align-items-center mb-1">
                                                <span class="club-id-badge badge-index mb-0"
                                                    style="font-size: 0.72rem; font-weight: 700; background: rgba(105, 108, 255, 0.08); color: #696cff; border-radius: 6px; padding: 4px 8px;">
                                                    <i class="bx bx-flag me-1"></i>
                                                    <%= e.getClubName() %>
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
                                                <% if(!isFull && !e.isAlreadyRegistered()) { %>
                                                    <span class="badge bg-success text-white"
                                                        style="font-size: 0.72rem; padding: 4px 8px;">
                                                        <i class="bx bx-check-circle me-1"></i>
                                                        <%= spotsLeft %> Spots Left!
                                                    </span>
                                                    <% } else if(isFull && !e.isAlreadyRegistered()) { %>
                                                        <span class="badge bg-danger text-white"
                                                            style="font-size: 0.72rem; padding: 4px 8px;">
                                                            <i class="bx bx-x-circle me-1"></i> Fully Booked
                                                        </span>
                                                        <% } else if(e.isAlreadyRegistered()) { %>
                                                            <span class="badge bg-primary text-white"
                                                                style="font-size: 0.72rem; padding: 4px 8px;">
                                                                <i class="bx bx-user-check me-1"></i> Enrolled
                                                            </span>
                                                            <% } %>
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
                                                                    <%= e.getTime().toString().substring(0, 5) %>
                                                                        <%= e.getEndTime() !=null ? " - " +
                                                                            e.getEndTime().toString().substring(0, 5)
                                                                            : "" %>
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
                                                            <%= e.getCurrentEnrollments() %> / <%= e.getQuota() %> Pax
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
                                                            <%= e.getCategory() !=null ? e.getCategory() : "N/A" %>
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
                                                            <%= e.getSdgGoals() !=null && !e.getSdgGoals().isEmpty() ?
                                                                e.getSdgGoals() : "N/A" %>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="mt-3">
                                                <% if (e.isAlreadyRegistered()) { %>
                                                    <button class="btn btn-success disabled w-100" disabled
                                                        style="display: flex; align-items: center; justify-content: center; font-size: 0.82rem; height: 36px; opacity: 0.85;">
                                                        <i class="bx bx-check-circle me-1"></i> Enrolled
                                                    </button>
                                                    <% } else if (isFull) { %>
                                                        <button class="btn btn-secondary disabled w-100" disabled
                                                            style="display: flex; align-items: center; justify-content: center; font-size: 0.82rem; height: 36px;">
                                                            <i class="bx bx-ban me-1"></i> Filled
                                                        </button>
                                                        <% } else { %>
                                                            <% String confirmMsg="Register for " +
                                                                e.getEventName().replace("'", "\\'" ) + "?" ; %>
                                                                <form action="events" method="POST" class="m-0"
                                                                    onsubmit="return confirm('<%= confirmMsg %>');">
                                                                    <input type="hidden" name="action" value="register">
                                                                    <input type="hidden" name="eventId"
                                                                        value="<%= e.getEventId() %>">
                                                                    <button type="submit" class="btn btn-primary w-100"
                                                                        style="display: flex; align-items: center; justify-content: center; font-size: 0.82rem; height: 36px;">
                                                                        Sign Up <i
                                                                            class="bx bx-right-arrow-alt ms-1"></i>
                                                                    </button>
                                                                </form>
                                                                <% } %>
                                            </div>
                                        </div>
                            </div>
                        </div>

                        <% /* Insert a full-width spacer row after every 3rd card */ if (eventIndex % 3==0) { %>
                            <div class="col-12" style="margin-bottom: 530px;"></div>
                            <% } %>

                                <% } %>
                                <div id="noFilterResults" class="col-12 text-center py-5 text-muted w-100" style="display: none; margin-top: -300px;">
                                    <i class="bx bx-calendar-x fa-3x mb-3 text-light" style="font-size: 3rem;"></i>
                                    <h5 class="fw-bold">No Events on this Date</h5>
                                    <p>Try selecting a different date or clear the filter to see all upcoming events.</p>
                                </div>
                                <% } else { %>
                                    <div class="col-12 text-center py-5 text-muted w-100">
                                        <i class="bx bx-folder-open fa-3x mb-3 text-light" style="font-size: 3rem;"></i>
                                        <h5 class="fw-bold">No Events Found</h5>
                                        <p>There are currently no approved campus events to sign up for. Check back
                                            soon!</p>
                                    </div>
                                    <% } %>
            </div>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const dateFilter = document.getElementById("eventDateFilter");
                    const clearFilter = document.getElementById("clearDateFilter");
                    const eventCards = document.querySelectorAll(".event-card-wrapper");

                    dateFilter.addEventListener("change", function () {
                        const selectedDate = this.value; // Format: YYYY-MM-DD
                        if (selectedDate) {
                            clearFilter.style.display = "inline-block";
                        } else {
                            clearFilter.style.display = "none";
                        }

                        let visibleCount = 0;
                        eventCards.forEach(card => {
                            if (!selectedDate || card.getAttribute("data-event-date") === selectedDate) {
                                card.style.display = "block";
                                visibleCount++;
                            } else {
                                card.style.display = "none";
                            }
                        });

                        const noResultsMsg = document.getElementById("noFilterResults");
                        if (noResultsMsg) {
                            if (visibleCount === 0 && selectedDate) {
                                noResultsMsg.style.display = "block";
                            } else {
                                noResultsMsg.style.display = "none";
                            }
                        }
                    });

                    clearFilter.addEventListener("click", function () {
                        dateFilter.value = "";
                        dateFilter.dispatchEvent(new Event("change"));
                    });
                });
            </script>

        </div>