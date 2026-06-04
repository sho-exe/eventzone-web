<%@page contentType="text/html" pageEncoding="UTF-8" %>
<% String role = (String) session.getAttribute("accountType"); %>
<div class="row">
    <div class="col-12">
        <h4 class="fw-bold py-3 mb-4">Quick Actions</h4>
    </div>
</div>
<% if ("STUDENT".equals(role)) { %>
<div class="row">
    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
        <a href="events?action=browse" class="text-decoration-none">
            <div class="card h-100 card-action bg-soft-info">
                <div class="card-body text-center">
                    <div class="avatar avatar-md mx-auto mb-3">
                        <span class="avatar-initial rounded-circle bg-label-info"><i
                                class="bx bx-search fs-3"></i></span>
                    </div>
                    <h5 class="card-title text-dark">Explore Events</h5>
                    <p class="card-text text-muted small">Discover and
                        register for upcoming faculty activities.</p>
                </div>
            </div>
        </a>
    </div>

    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
        <a href="attendances?action=myAttendance" class="text-decoration-none">
            <div class="card h-100 card-action bg-soft-success">
                <div class="card-body text-center">
                    <div class="avatar avatar-md mx-auto mb-3">
                        <span class="avatar-initial rounded-circle bg-label-success"><i
                                class="bx bx-clipboard fs-3"></i></span>
                    </div>
                    <h5 class="card-title text-dark">My Registrations</h5>
                    <p class="card-text text-muted small">View and manage
                        your current event registrations.</p>
                </div>
            </div>
        </a>
    </div>

    <div class="col-lg-4 col-md-12 col-sm-12 mb-4">
        <a href="merits?action=meritHistory" class="text-decoration-none">
            <div class="card h-100 card-action bg-soft-primary">
                <div class="card-body text-center">
                    <div class="avatar avatar-md mx-auto mb-3">
                        <span class="avatar-initial rounded-circle bg-label-primary"><i
                                class="bx bx-medal fs-3"></i></span>
                    </div>
                    <h5 class="card-title text-dark">Merit Transcript</h5>
                    <p class="card-text text-muted small">Check your current
                        point balance and transcript.</p>
                </div>
            </div>
        </a>
    </div>
</div>

<% } else if ("ADVISOR".equals(role)) { %>
<div class="row">
    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
        <a href="events?action=pending" class="text-decoration-none">
            <div class="card h-100 card-action bg-soft-info">
                <div class="card-body text-center">
                    <div class="avatar avatar-md mx-auto mb-3">
                        <span class="avatar-initial rounded-circle bg-label-info"><i
                                class="bx bx-check-circle fs-3"></i></span>
                    </div>
                    <h5 class="card-title text-dark">Pending Approvals
                    </h5>
                    <p class="card-text text-muted small">Review and
                        approve new event proposals from Chairpersons.
                    </p>
                </div>
            </div>
        </a>
    </div>

    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
        <a href="events?action=global" class="text-decoration-none">
            <div class="card h-100 card-action bg-soft-warning">
                <div class="card-body text-center">
                    <div class="avatar avatar-md mx-auto mb-3">
                        <span class="avatar-initial rounded-circle bg-label-warning"><i
                                class="bx bx-award fs-3"></i></span>
                    </div>
                    <h5 class="card-title text-dark">System-Wide Events
                    </h5>
                    <p class="card-text text-muted small">Authorize and
                        review all pending event proposals.</p>
                </div>
            </div>
        </a>
    </div>

    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
        <a href="events?action=clubEvents" class="text-decoration-none">
            <div class="card h-100 card-action bg-soft-success">
                <div class="card-body text-center">
                    <div class="avatar avatar-md mx-auto mb-3">
                        <span class="avatar-initial rounded-circle bg-label-success"><i
                                class="bx bx-history fs-3"></i></span>
                    </div>
                    <h5 class="card-title text-dark">Club Event History
                    </h5>
                    <p class="card-text text-muted small">Browse past
                        and ongoing events managed by your club.</p>
                </div>
            </div>
        </a>
    </div>

    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
        <a href="merits?action=meritReports" class="text-decoration-none">
            <div class="card h-100 card-action bg-soft-primary">
                <div class="card-body text-center">
                    <div class="avatar avatar-md mx-auto mb-3">
                        <span class="avatar-initial rounded-circle bg-label-primary"><i
                                class="bx bx-bar-chart-alt-2 fs-3"></i></span>
                    </div>
                    <h5 class="card-title text-dark">Merit Reports</h5>
                    <p class="card-text text-muted small">View
                        statistics on student participation and merit
                        distribution.</p>
                </div>
            </div>
        </a>
    </div>
</div>

<% } else if ("CHAIRPERSON".equals(role)) { %>
<div class="row">
    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
        <a href="events?action=manage" class="text-decoration-none">
            <div class="card h-100 card-action bg-soft-info">
                <div class="card-body text-center">
                    <div class="avatar avatar-md mx-auto mb-3">
                        <span class="avatar-initial rounded-circle bg-label-info"><i
                                class="bx bx-calendar-plus fs-3"></i></span>
                    </div>
                    <h5 class="card-title text-dark">Manage Events
                    </h5>
                    <p class="card-text text-muted small">Discover
                        and register for upcoming faculty
                        activities.</p>
                </div>
            </div>
        </a>
    </div>

    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
        <a href="merits?action=meritHistory" class="text-decoration-none">
            <div class="card h-100 card-action bg-soft-primary">
                <div class="card-body text-center">
                    <div class="avatar avatar-md mx-auto mb-3">
                        <span class="avatar-initial rounded-circle bg-label-primary"><i
                                class="bx bx-medal fs-3"></i></span>
                    </div>
                    <h5 class="card-title text-dark">View Merits
                    </h5>
                    <p class="card-text text-muted small">Check your
                        current point balance and transcript.</p>
                </div>
            </div>
        </a>
    </div>
</div>

<% } else if ("HEPA".equals(role)) { %>
<div class="row">
    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
        <a href="users?action=manage" class="text-decoration-none">
            <div class="card h-100 card-action bg-soft-info">
                <div class="card-body text-center">
                    <div class="avatar avatar-md mx-auto mb-3">
                        <span class="avatar-initial rounded-circle bg-label-info"><i
                                class="bx bx-group fs-3"></i></span>
                    </div>
                    <h5 class="card-title text-dark">Manage
                        Users</h5>
                    <p class="card-text text-muted small">View
                        and manage all registered students and
                        staff.</p>
                </div>
            </div>
        </a>
    </div>

    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
        <a href="clubs?action=manage" class="text-decoration-none">
            <div class="card h-100 card-action bg-soft-secondary">
                <div class="card-body text-center">
                    <div class="avatar avatar-md mx-auto mb-3">
                        <span class="avatar-initial rounded-circle bg-label-secondary"><i
                                class="bx bx-flag fs-3"></i></span>
                    </div>
                    <h5 class="card-title text-dark">Manage
                        Clubs</h5>
                    <p class="card-text text-muted small">
                        Monitor and configure all active clubs
                        in the system.</p>
                </div>
            </div>
        </a>
    </div>

    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
        <a href="events?action=global" class="text-decoration-none">
            <div class="card h-100 card-action bg-soft-warning">
                <div class="card-body text-center">
                    <div class="avatar avatar-md mx-auto mb-3">
                        <span class="avatar-initial rounded-circle bg-label-warning"><i
                                class="bx bx-globe fs-3"></i></span>
                    </div>
                    <h5 class="card-title text-dark">System-Wide
                        Events</h5>
                    <p class="card-text text-muted small">
                        Authorize and review all pending event
                        proposals.</p>
                </div>
            </div>
        </a>
    </div>

    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
        <a href="merits?action=distributeMerits" class="text-decoration-none">
            <div class="card h-100 card-action bg-soft-success">
                <div class="card-body text-center">
                    <div class="avatar avatar-md mx-auto mb-3">
                        <span class="avatar-initial rounded-circle bg-label-success"><i
                                class="bx bx-award fs-3"></i></span>
                    </div>
                    <h5 class="card-title text-dark">Distribute
                        Merits</h5>
                    <p class="card-text text-muted small">Assign
                        merit points to students for verified
                        event attendance.</p>
                </div>
            </div>
        </a>
    </div>
</div>


<% }%>