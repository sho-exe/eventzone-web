<%@page contentType="text/html" pageEncoding="UTF-8" %>
<% String role = (String) session.getAttribute("accountType"); %>

                                        <% if ("STUDENT".equals(role)) { %>
                                            <div class="row">
                                                <div class="col-12">
                                                    <h4 class="fw-bold py-3 mb-4">Your Overview</h4>
                                                </div>
                                                <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                    <div class="card border-start border-primary border-5">
                                                        <div class="card-body">
                                                            <div
                                                                class="card-title d-flex align-items-start justify-content-between">
                                                                <h6 class="text-muted text-uppercase small fw-bold">
                                                                    Accumulated Merits</h6>
                                                            </div>
                                                            <h3 class="card-title text-nowrap mb-1 text-primary">
                                                                ${totalMerits != null ? totalMerits : '0'}</h3>
                                                            <small class="text-muted">Verified through events
                                                                attended</small>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                    <div class="card border-start border-success border-5">
                                                        <div class="card-body">
                                                            <div
                                                                class="card-title d-flex align-items-start justify-content-between">
                                                                <h6 class="text-muted text-uppercase small fw-bold">
                                                                    Upcoming Events</h6>
                                                            </div>
                                                            <h3 class="card-title text-nowrap mb-1 text-success">
                                                                ${upcomingEventCount != null ? upcomingEventCount : '0'}
                                                            </h3>
                                                            <small class="text-muted">Confirmed registrations this
                                                                month</small>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <% } else if ("ADVISOR".equals(role)) { %>
                                                <div class="row">
                                                    <div class="col-12">
                                                        <h4 class="fw-bold py-3 mb-4">Your Overview</h4>
                                                    </div>
                                                    <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                        <div class="card border-start border-warning border-5">
                                                            <div class="card-body">
                                                                <div
                                                                    class="card-title d-flex align-items-start justify-content-between">
                                                                    <h6 class="text-muted text-uppercase small fw-bold">
                                                                        Events Pending Review</h6>
                                                                </div>
                                                                <h3 class="card-title text-nowrap mb-1 text-warning">
                                                                    ${pendingApprovalCount != null ?
                                                                    pendingApprovalCount : '0'}</h3>
                                                                <small class="text-muted">New proposals from your Club
                                                                    Chairperson</small>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                        <div class="card border-start border-success border-5">
                                                            <div class="card-body">
                                                                <div
                                                                    class="card-title d-flex align-items-start justify-content-between">
                                                                    <h6 class="text-muted text-uppercase small fw-bold">
                                                                        Club Participation</h6>
                                                                </div>
                                                                <h3 class="card-title text-nowrap mb-1 text-success">
                                                                    ${clubParticipantCount != null ?
                                                                    clubParticipantCount : '0'}</h3>
                                                                <small class="text-muted">Total students active in your
                                                                    club events</small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <% } else if ("CHAIRPERSON".equals(role)) { %>
                                                    <!-- No overview for chairperson yet -->
                                                    <% } else if ("HEPA".equals(role)) { %>
                                                        <div class="row">
                                                            <div class="col-12">
                                                                <h4 class="fw-bold py-3 mb-4">Your Overview</h4>
                                                            </div>
                                                            <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                                <div class="card border-start border-primary border-5">
                                                                    <div class="card-body">
                                                                        <div
                                                                            class="card-title d-flex align-items-start justify-content-between">
                                                                            <h6
                                                                                class="text-muted text-uppercase small fw-bold">
                                                                                Total Registered Users</h6>
                                                                        </div>
                                                                        <h3
                                                                            class="card-title text-nowrap mb-1 text-primary">
                                                                            ${totalUserCount != null ? totalUserCount :
                                                                            '0'}</h3>
                                                                        <small class="text-muted">Total students and
                                                                            staff in the system</small>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                                <div class="card border-start border-danger border-5">
                                                                    <div class="card-body">
                                                                        <div
                                                                            class="card-title d-flex align-items-start justify-content-between">
                                                                            <h6
                                                                                class="text-muted text-uppercase small fw-bold">
                                                                                Pending Merit Batches</h6>
                                                                        </div>
                                                                        <h3
                                                                            class="card-title text-nowrap mb-1 text-danger">
                                                                            ${pendingMeritBatches != null ?
                                                                            pendingMeritBatches : '0'}</h3>
                                                                        <small class="text-muted">Events with verified
                                                                            attendance awaiting points</small>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                                <div class="card border-start border-warning border-5">
                                                                    <div class="card-body">
                                                                        <div
                                                                            class="card-title d-flex align-items-start justify-content-between">
                                                                            <h6
                                                                                class="text-muted text-uppercase small fw-bold">
                                                                                Active Clubs</h6>
                                                                        </div>
                                                                        <h3
                                                                            class="card-title text-nowrap mb-1 text-warning">
                                                                            ${activeClubCount != null ? activeClubCount
                                                                            : '0'}</h3>
                                                                        <small class="text-muted">Active clubs
                                                                            registered in the system</small>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <% } %>
