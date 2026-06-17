<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.sql.*" %>
<%@page import="com.lab.dao.DBConnection" %>
<%
    String role = (String) session.getAttribute("accountType");
    Integer overviewUserId = (Integer) session.getAttribute("userId");
    
    int totalUserCount = 0;
    int pendingMeritBatches = 0;
    int activeClubCount = 0;
    
    int pendingApprovalCount = 0;
    int clubParticipantCount = 0;
    
    int totalMerits = 0;
    int upcomingEventCount = 0;
    
    int chairpersonClubEvents = 0;
    int chairpersonTotalRegistrations = 0;
    
    if (role != null) {
        try (Connection conn = DBConnection.getConnection()) {
            if ("HEPA".equals(role)) {
                // 1. Total User Count
                try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM users")) {
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) totalUserCount = rs.getInt(1);
                }
                // 2. Active Club Count
                try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM clubs")) {
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) activeClubCount = rs.getInt(1);
                }
                // 3. Pending Merit Batches
                String sqlPending = "SELECT COUNT(DISTINCT a.event_id) FROM attendances a " +
                                    "JOIN events e ON a.event_id = e.event_id " +
                                    "LEFT JOIN merits m ON a.event_id = m.event_id " +
                                    "WHERE a.status = 'ATTENDED' AND m.event_id IS NULL";
                try (PreparedStatement ps = conn.prepareStatement(sqlPending)) {
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) pendingMeritBatches = rs.getInt(1);
                }
            } else if ("ADVISOR".equals(role)) {
                if (overviewUserId != null) {
                    // 1. Pending Approval Count for Advisor
                    String sqlPendingApp = "SELECT COUNT(*) FROM events e " +
                                           "JOIN clubs c ON e.club_id = c.club_id " +
                                           "WHERE e.status = 'PENDING' AND c.advisor_id = ?";
                    try (PreparedStatement ps = conn.prepareStatement(sqlPendingApp)) {
                        ps.setInt(1, overviewUserId);
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) pendingApprovalCount = rs.getInt(1);
                    }
                    // 2. Club Participant Count
                    String sqlParticipants = "SELECT COUNT(DISTINCT a.user_id) FROM attendances a " +
                                             "JOIN events e ON a.event_id = e.event_id " +
                                             "JOIN clubs c ON e.club_id = c.club_id " +
                                             "WHERE c.advisor_id = ? AND a.status = 'ATTENDED'";
                    try (PreparedStatement ps = conn.prepareStatement(sqlParticipants)) {
                        ps.setInt(1, overviewUserId);
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) clubParticipantCount = rs.getInt(1);
                    }
                }
            } else if ("STUDENT".equals(role)) {
                if (overviewUserId != null) {
                    // 1. Total Merits
                    try (PreparedStatement ps = conn.prepareStatement("SELECT COALESCE(SUM(points), 0) FROM merits WHERE user_id = ?")) {
                        ps.setInt(1, overviewUserId);
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) totalMerits = rs.getInt(1);
                    }
                    // 2. Upcoming Events
                    String sqlUpcoming = "SELECT COUNT(*) FROM attendances a " +
                                         "JOIN events e ON a.event_id = e.event_id " +
                                         "WHERE a.user_id = ? AND e.date >= CURRENT_DATE";
                    try (PreparedStatement ps = conn.prepareStatement(sqlUpcoming)) {
                        ps.setInt(1, overviewUserId);
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) upcomingEventCount = rs.getInt(1);
                    }
                }
            } else if ("CHAIRPERSON".equals(role)) {
                if (overviewUserId != null) {
                    // 1. Club Events Proposed
                    String sqlEvents = "SELECT COUNT(*) FROM events e " +
                                       "JOIN clubs c ON e.club_id = c.club_id " +
                                       "WHERE c.chairperson_id = ?";
                    try (PreparedStatement ps = conn.prepareStatement(sqlEvents)) {
                        ps.setInt(1, overviewUserId);
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) chairpersonClubEvents = rs.getInt(1);
                    }
                    // 2. Total Registrations for Club Events
                    String sqlReg = "SELECT COUNT(*) FROM attendances a " +
                                    "JOIN events e ON a.event_id = e.event_id " +
                                    "JOIN clubs c ON e.club_id = c.club_id " +
                                    "WHERE c.chairperson_id = ?";
                    try (PreparedStatement ps = conn.prepareStatement(sqlReg)) {
                        ps.setInt(1, overviewUserId);
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) chairpersonTotalRegistrations = rs.getInt(1);
                    }
                    // 3. Total Merits (as a student)
                    try (PreparedStatement ps = conn.prepareStatement("SELECT COALESCE(SUM(points), 0) FROM merits WHERE user_id = ?")) {
                        ps.setInt(1, overviewUserId);
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) totalMerits = rs.getInt(1);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // Set request attributes so EL expressions can resolve them
    request.setAttribute("totalUserCount", totalUserCount);
    request.setAttribute("pendingMeritBatches", pendingMeritBatches);
    request.setAttribute("activeClubCount", activeClubCount);
    request.setAttribute("pendingApprovalCount", pendingApprovalCount);
    request.setAttribute("clubParticipantCount", clubParticipantCount);
    request.setAttribute("totalMerits", totalMerits);
    request.setAttribute("upcomingEventCount", upcomingEventCount);
    request.setAttribute("chairpersonClubEvents", chairpersonClubEvents);
    request.setAttribute("chairpersonTotalRegistrations", chairpersonTotalRegistrations);
%>

                                        <% if ("STUDENT".equals(role)) { %>
                                            <div class="row">
                                                <div class="col-12">
                                                    <h4 class="fw-bold py-3 mb-4">Your Overview</h4>
                                                </div>
                                                <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <div
                                                                class="card-title d-flex align-items-start justify-content-between">
                                                                <h6 class="text-muted text-uppercase small fw-bold">
                                                                    Accumulated Merits</h6>
                                                            </div>
                                                            <h3 class="card-title text-nowrap mb-1 text-primary fw-bold fs-2">
                                                                ${totalMerits != null ? totalMerits : '0'}</h3>
                                                            <small class="text-muted">Verified through events
                                                                attended</small>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <div
                                                                class="card-title d-flex align-items-start justify-content-between">
                                                                <h6 class="text-muted text-uppercase small fw-bold">
                                                                    Upcoming Events</h6>
                                                            </div>
                                                            <h3 class="card-title text-nowrap mb-1 text-success fw-bold fs-2">
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
                                                        <div class="card">
                                                            <div class="card-body">
                                                                <div
                                                                    class="card-title d-flex align-items-start justify-content-between">
                                                                    <h6 class="text-muted text-uppercase small fw-bold">
                                                                        Events Pending Review</h6>
                                                                </div>
                                                                <h3 class="card-title text-nowrap mb-1 text-warning fw-bold fs-2">
                                                                    ${pendingApprovalCount != null ?
                                                                    pendingApprovalCount : '0'}</h3>
                                                                <small class="text-muted">New proposals from your Club
                                                                    Chairperson</small>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                        <div class="card">
                                                            <div class="card-body">
                                                                <div
                                                                    class="card-title d-flex align-items-start justify-content-between">
                                                                    <h6 class="text-muted text-uppercase small fw-bold">
                                                                        Club Participation</h6>
                                                                </div>
                                                                <h3 class="card-title text-nowrap mb-1 text-success fw-bold fs-2">
                                                                    ${clubParticipantCount != null ?
                                                                    clubParticipantCount : '0'}</h3>
                                                                <small class="text-muted">Total students active in your
                                                                    club events</small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <% } else if ("CHAIRPERSON".equals(role)) { %>
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <h4 class="fw-bold py-3 mb-4">Your Overview</h4>
                                                        </div>
                                                        <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                            <div class="card">
                                                                <div class="card-body">
                                                                    <div class="card-title d-flex align-items-start justify-content-between">
                                                                        <h6 class="text-muted text-uppercase small fw-bold">Club Events Proposed</h6>
                                                                    </div>
                                                                    <h3 class="card-title text-nowrap mb-1 text-primary fw-bold fs-2">${chairpersonClubEvents != null ? chairpersonClubEvents : '0'}</h3>
                                                                    <small class="text-muted">Total events created by your club</small>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                            <div class="card">
                                                                <div class="card-body">
                                                                    <div class="card-title d-flex align-items-start justify-content-between">
                                                                        <h6 class="text-muted text-uppercase small fw-bold">Total Registrations</h6>
                                                                    </div>
                                                                    <h3 class="card-title text-nowrap mb-1 text-success fw-bold fs-2">${chairpersonTotalRegistrations != null ? chairpersonTotalRegistrations : '0'}</h3>
                                                                    <small class="text-muted">Total attendees across all your club's events</small>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                            <div class="card">
                                                                <div class="card-body">
                                                                    <div class="card-title d-flex align-items-start justify-content-between">
                                                                        <h6 class="text-muted text-uppercase small fw-bold">Accumulated Merits</h6>
                                                                    </div>
                                                                    <h3 class="card-title text-nowrap mb-1 text-info fw-bold fs-2">${totalMerits != null ? totalMerits : '0'}</h3>
                                                                    <small class="text-muted">Verified through events attended</small>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <% } else if ("HEPA".equals(role)) { %>
                                                        <div class="row">
                                                            <div class="col-12">
                                                                <h4 class="fw-bold py-3 mb-4">Your Overview</h4>
                                                            </div>
                                                            <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                                <div class="card">
                                                                    <div class="card-body">
                                                                        <div
                                                                            class="card-title d-flex align-items-start justify-content-between">
                                                                            <h6
                                                                                class="text-muted text-uppercase small fw-bold">
                                                                                Total Registered Users</h6>
                                                                        </div>
                                                                        <h3
                                                                            class="card-title text-nowrap mb-1 text-primary fw-bold fs-2">
                                                                            ${totalUserCount != null ? totalUserCount :
                                                                            '0'}</h3>
                                                                        <small class="text-muted">Total students and
                                                                            staff in the system</small>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                                <div class="card">
                                                                    <div class="card-body">
                                                                        <div
                                                                            class="card-title d-flex align-items-start justify-content-between">
                                                                            <h6
                                                                                class="text-muted text-uppercase small fw-bold">
                                                                                Pending Merit Batches</h6>
                                                                        </div>
                                                                        <h3
                                                                            class="card-title text-nowrap mb-1 text-danger fw-bold fs-2">
                                                                            ${pendingMeritBatches != null ?
                                                                            pendingMeritBatches : '0'}</h3>
                                                                        <small class="text-muted">Events with verified
                                                                            attendance awaiting points</small>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-lg-4 col-md-6 col-sm-6 mb-4">
                                                                <div class="card">
                                                                    <div class="card-body">
                                                                        <div
                                                                            class="card-title d-flex align-items-start justify-content-between">
                                                                            <h6
                                                                                class="text-muted text-uppercase small fw-bold">
                                                                                Active Clubs</h6>
                                                                        </div>
                                                                        <h3
                                                                            class="card-title text-nowrap mb-1 text-warning fw-bold fs-2">
                                                                            ${activeClubCount != null ? activeClubCount
                                                                            : '0'}</h3>
                                                                        <small class="text-muted">Active clubs
                                                                            registered in the system</small>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <% } %>
