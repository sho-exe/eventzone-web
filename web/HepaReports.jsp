<%@page import="java.util.Map" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Set" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<% 
    String role = (String) session.getAttribute("accountType"); 
    
    // Fetch attributes bound by ReportController
    Integer totalUsers = (Integer) request.getAttribute("totalUsers");
    Map<String, Integer> roleDistribution = (Map<String, Integer>) request.getAttribute("roleDistribution");
    List<Map<String, Object>> clubSummaries = (List<Map<String, Object>>) request.getAttribute("clubSummaries");
    Map<String, Integer> eventStatusDistribution = (Map<String, Integer>) request.getAttribute("eventStatusDistribution");
    Map<String, Integer> eventCategoryDistribution = (Map<String, Integer>) request.getAttribute("eventCategoryDistribution");
    Map<String, Integer> eventSdgDistribution = (Map<String, Integer>) request.getAttribute("eventSdgDistribution");
    List<Map<String, Object>> recentEvents = (List<Map<String, Object>>) request.getAttribute("recentEvents");
    Map<String, Integer> attendanceStatusDistribution = (Map<String, Integer>) request.getAttribute("attendanceStatusDistribution");
    Map<String, Object> generalAttendanceStats = (Map<String, Object>) request.getAttribute("generalAttendanceStats");
    Map<String, Object> meritStats = (Map<String, Object>) request.getAttribute("meritStats");
    List<Map<String, Object>> topStudents = (List<Map<String, Object>>) request.getAttribute("topStudents");

    int totalClubs = clubSummaries != null ? clubSummaries.size() : 0;
    int totalEvents = 0;
    if (eventStatusDistribution != null) {
        for (int count : eventStatusDistribution.values()) {
            totalEvents += count;
        }
    }
    int totalMeritsAwarded = 0;
    if (meritStats != null && meritStats.get("totalAwarded") != null) {
        totalMeritsAwarded = (Integer) meritStats.get("totalAwarded");
    }
%>

<jsp:include page="header.jsp" />

<!-- ApexCharts CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/vendor/libs/apex-charts/apex-charts.css" />

<style>
    /* Metric Card Enhancements */
    .metric-card {
        border-radius: 12px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
    }
    .metric-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
    }
    .icon-box-soft {
        width: 48px;
        height: 48px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        font-size: 1.5rem;
    }
    .bg-primary-soft { background-color: rgba(105, 108, 255, 0.12); color: #696cff; }
    .bg-success-soft { background-color: rgba(40, 199, 111, 0.12); color: #28c76f; }
    .bg-warning-soft { background-color: rgba(255, 159, 67, 0.12); color: #ff9f43; }
    .bg-danger-soft  { background-color: rgba(234, 84, 85, 0.12); color: #ea5455; }
    .bg-info-soft    { background-color: rgba(0, 207, 221, 0.12); color: #00cfdd; }

    /* Modern Premium Tabs Styling for Reports */
    .report-tabs-wrapper {
        background: #ffffff !important;
        padding: 8px;
        border-radius: 12px;
        border: 1px solid #d9dee3;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03) !important;
    }
    
    .report-nav-tabs {
        border-bottom: none !important;
        gap: 8px;
        display: flex;
        flex-wrap: wrap;
        padding: 0 !important;
        margin: 0 !important;
        list-style: none;
    }
    
    .report-nav-tabs .nav-item {
        margin-bottom: 0;
    }
    
    .report-nav-tabs .nav-link {
        border: none !important;
        border-radius: 8px !important;
        font-weight: 600;
        padding: 10px 18px !important;
        color: #697a8d !important;
        background: transparent !important;
        transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .report-nav-tabs .nav-link:hover {
        color: var(--role-accent) !important;
        background-color: var(--role-accent-light) !important;
    }
    
    .report-nav-tabs .nav-link.active {
        color: #ffffff !important;
        background: linear-gradient(135deg, var(--role-accent), var(--role-accent-hex)) !important;
        box-shadow: 0 4px 12px var(--role-accent-light) !important;
    }
    
    /* Table hover */
    .table-hover tbody tr {
        transition: background-color 0.2s ease;
    }

    /* Print Custom Styles */
    @media print {
        #layout-menu, 
        .layout-navbar, 
        .content-footer, 
        .btn, 
        .nav-tabs, 
        .report-tabs-wrapper,
        .report-nav-tabs,
        .layout-overlay,
        .page-tips-container {
            display: none !important;
        }
        .layout-page {
            padding: 0 !important;
            margin: 0 !important;
            display: block !important;
        }
        .content-wrapper {
            padding: 0 !important;
            margin: 0 !important;
        }
        .container-p-y {
            padding-top: 0 !important;
            padding-bottom: 0 !important;
        }
        .tab-content {
            border: none !important;
            box-shadow: none !important;
            padding: 0 !important;
        }
        .tab-content > .tab-pane {
            display: block !important;
            opacity: 1 !important;
            visibility: visible !important;
            page-break-after: always;
            position: relative !important;
        }
        .card {
            box-shadow: none !important;
            border: 1px solid #ddd !important;
            page-break-inside: avoid;
            margin-bottom: 1.5rem !important;
        }
        .print-header {
            display: block !important;
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 2px solid #566a7f;
            padding-bottom: 15px;
        }
        .print-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
        .print-date {
            font-size: 14px;
            color: #777;
        }
    }
    
    /* Hidden print elements in screen mode */
    .print-header {
        display: none;
    }
</style>

<body>
    <% if (role == null || !"HEPA".equals(role)) { %>
        <div class="container-xxl container-p-y">
            <div class="misc-wrapper">
                <h2 class="mb-2 mx-2">Invalid access or session expired.</h2>
                <p class="mb-4 mx-2">Please login again to continue.</p>
                <a href="Login.jsp" class="btn btn-primary">Back to Login</a>
            </div>
        </div>
    <% } else { %>
        <!-- Layout wrapper -->
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <jsp:include page="sidebar.jsp" />

                <!-- Layout container -->
                <div class="layout-page">
                    <jsp:include page="navbar.jsp" />

                    <!-- Content wrapper -->
                    <div class="content-wrapper" style="padding: 0px 30px;">
                        <!-- Content -->
                        <div class="flex-grow-1 container-p-y">
                            
                            <!-- Printable Header -->
                            <div class="print-header">
                                <div class="print-title">EventZone System Analytics & Metrics Report</div>
                                <div class="print-date">Generated on: <%= new java.util.Date() %> | Prepared by HEPA Admin</div>
                            </div>

                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="fw-bold mb-0 d-flex align-items-center">
                                    <i class="bx bx-bar-chart-square text-danger me-2" style="font-size: 2rem;"></i>
                                    Generate Reports
                                </h4>
                                <button class="btn btn-primary d-flex align-items-center" onclick="window.print()" style="font-weight: 600;">
                                    <i class="bx bx-printer me-1" style="font-weight: 800; font-size: 1.2rem;"></i>
                                    Print / Export PDF
                                </button>
                            </div>

                            <!-- Overview Stats Row -->
                            <div class="row g-4 mb-4">
                                <div class="col-lg-3 col-md-6 col-sm-6">
                                    <div class="card metric-card">
                                        <div class="card-body d-flex align-items-center justify-content-between">
                                            <div>
                                                <span class="d-block mb-1 text-muted text-uppercase small fw-bold">Total Users</span>
                                                <h3 class="card-title mb-0 fw-bold text-dark"><%= totalUsers %></h3>
                                            </div>
                                            <div class="icon-box-soft bg-primary-soft">
                                                <i class="bx bx-group"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 col-sm-6">
                                    <div class="card metric-card">
                                        <div class="card-body d-flex align-items-center justify-content-between">
                                            <div>
                                                <span class="d-block mb-1 text-muted text-uppercase small fw-bold">Active Clubs</span>
                                                <h3 class="card-title mb-0 fw-bold text-dark"><%= totalClubs %></h3>
                                            </div>
                                            <div class="icon-box-soft bg-success-soft">
                                                <i class="bx bx-flag"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 col-sm-6">
                                    <div class="card metric-card">
                                        <div class="card-body d-flex align-items-center justify-content-between">
                                            <div>
                                                <span class="d-block mb-1 text-muted text-uppercase small fw-bold">Club Events</span>
                                                <h3 class="card-title mb-0 fw-bold text-dark"><%= totalEvents %></h3>
                                            </div>
                                            <div class="icon-box-soft bg-warning-soft">
                                                <i class="bx bx-calendar-event"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 col-sm-6">
                                    <div class="card metric-card">
                                        <div class="card-body d-flex align-items-center justify-content-between">
                                            <div>
                                                <span class="d-block mb-1 text-muted text-uppercase small fw-bold">Merit Batches</span>
                                                <h3 class="card-title mb-0 fw-bold text-dark"><%= totalMeritsAwarded %></h3>
                                            </div>
                                            <div class="icon-box-soft bg-danger-soft">
                                                <i class="bx bx-award"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Report Modules Tabbed Structure -->
                            <div class="report-tabs-wrapper mb-4">
                                <ul class="nav nav-tabs report-nav-tabs border-bottom-0 m-0" id="reportTabs" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link active" id="overview-tab" data-bs-toggle="tab" data-bs-target="#overview" type="button" role="tab">
                                            <i class="bx bx-grid-alt fs-5"></i> Overview Report
                                        </button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link" id="users-tab" data-bs-toggle="tab" data-bs-target="#users" type="button" role="tab">
                                            <i class="bx bx-user fs-5"></i> Users Module
                                        </button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link" id="clubs-tab" data-bs-toggle="tab" data-bs-target="#clubs" type="button" role="tab">
                                            <i class="bx bx-flag fs-5"></i> Clubs Module
                                        </button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link" id="events-tab" data-bs-toggle="tab" data-bs-target="#events" type="button" role="tab">
                                            <i class="bx bx-calendar fs-5"></i> Events Module
                                        </button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link" id="attendance-tab" data-bs-toggle="tab" data-bs-target="#attendance" type="button" role="tab">
                                            <i class="bx bx-checkbox-checked fs-5"></i> Attendance Module
                                        </button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link" id="merits-tab" data-bs-toggle="tab" data-bs-target="#merits" type="button" role="tab">
                                            <i class="bx bx-award fs-5"></i> Merits Module
                                        </button>
                                    </li>
                                </ul>
                            </div>

                            <div class="card shadow-sm border-0 mt-4">
                                <div class="card-body tab-content" id="reportTabsContent">
                                    
                                    <!-- OVERVIEW REPORT TAB -->
                                    <div class="tab-pane fade show active" id="overview" role="tabpanel">
                                        <h5 class="fw-bold mb-3 text-dark d-flex align-items-center">
                                            <i class="bx bx-bar-chart-square text-danger me-2"></i> System Activity Summary
                                        </h5>
                                        <div class="row">
                                            <div class="col-md-7 mb-4">
                                                <p class="text-muted leading-relaxed">
                                                    Welcome to the **EventZone Comprehensive Reports & Analytics Panel**. As a HEPA Administrator, this dynamic portal gives you a consolidated view of student involvement, club performance, event statistics, self-check-in rates, and merit-point distributions.
                                                </p>
                                                <div class="card bg-label-secondary border-0 p-3 mt-3">
                                                    <h6 class="fw-bold text-dark mb-2"><i class="bx bx-info-circle me-1"></i> Quick Tips for HEPA Admin</h6>
                                                    <ul class="text-dark mb-0 ps-3 small">
                                                        <li class="mb-1">Click the <strong>Print / Export PDF</strong> button on the top right to download or print a beautifully compiled multi-page system ledger.</li>
                                                        <li class="mb-1">Switch between tabs to inspect granular charts and leaderboard tables.</li>
                                                        <li>Data metrics are synchronized in real-time with the active student registries.</li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="col-md-5 text-center d-flex align-items-center justify-content-center">
                                                <div class="p-4 rounded-3 bg-label-danger-light border border-danger border-dashed" style="max-width: 350px;">
                                                    <i class="bx bx-shield-quarter text-danger display-4 mb-3"></i>
                                                    <h5 class="fw-bold text-danger mb-1">Administrative Ledger</h5>
                                                    <p class="small text-muted mb-0">Authorized role: HEPA Admin. Confidential metrics pertaining to Computer Science & Mathematics Faculty.</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- USERS MODULE TAB -->
                                    <div class="tab-pane fade" id="users" role="tabpanel">
                                        <h5 class="fw-bold mb-4 text-dark"><i class="bx bx-user text-primary me-2"></i> Users Module Analytics</h5>
                                        <div class="row">
                                            <div class="col-lg-6 mb-4">
                                                <div class="card border h-100 shadow-none">
                                                    <div class="card-header bg-transparent py-3 border-bottom">
                                                        <h6 class="m-0 fw-bold text-dark">User Role Distribution Chart</h6>
                                                    </div>
                                                    <div class="card-body d-flex justify-content-center align-items-center p-4">
                                                        <div id="userRoleChart" style="width: 100%; min-height: 280px;"></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 mb-4">
                                                <div class="card border h-100 shadow-none">
                                                    <div class="card-header bg-transparent py-3 border-bottom">
                                                        <h6 class="m-0 fw-bold text-dark">Registry Data Breakdowns</h6>
                                                    </div>
                                                    <div class="table-responsive">
                                                        <table class="table table-hover mb-0">
                                                            <thead>
                                                                <tr>
                                                                    <th>Role Type</th>
                                                                    <th class="text-center">Count</th>
                                                                    <th>Percentage</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <%
                                                                    String[] roles = {"STUDENT", "CHAIRPERSON", "ADVISOR", "HEPA"};
                                                                    String[] rolesDisplay = {"Student", "Club Chairperson", "Club Advisor", "HEPA Administrator"};
                                                                    String[] badges = {"bg-label-primary", "bg-label-warning", "bg-label-success", "bg-label-danger"};
                                                                    for(int i = 0; i < roles.length; i++) {
                                                                        int count = roleDistribution != null ? roleDistribution.getOrDefault(roles[i], 0) : 0;
                                                                        double percent = totalUsers > 0 ? ((double)count / totalUsers) * 100 : 0;
                                                                %>
                                                                <tr>
                                                                    <td>
                                                                        <span class="badge rounded-pill <%= badges[i] %>"><%= rolesDisplay[i] %></span>
                                                                    </td>
                                                                    <td class="text-center fw-bold"><%= count %></td>
                                                                    <td>
                                                                        <div class="d-flex align-items-center gap-2">
                                                                            <div class="progress flex-grow-1" style="height: 6px;">
                                                                                <div class="progress-bar <%= badges[i].replace("label-", "") %>" style="width: <%= percent %>%"></div>
                                                                            </div>
                                                                            <span class="small font-semibold"><%= String.format("%.1f", percent) %>%</span>
                                                                        </div>
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

                                    <!-- CLUBS MODULE TAB -->
                                    <div class="tab-pane fade" id="clubs" role="tabpanel">
                                        <h5 class="fw-bold mb-3 text-dark"><i class="bx bx-flag text-success me-2"></i> Clubs Module Analytics</h5>
                                        <div class="card border shadow-none">
                                            <div class="card-header bg-transparent py-3 border-bottom d-flex justify-content-between align-items-center">
                                                <h6 class="m-0 fw-bold text-dark">Registered Clubs Performance Ledger</h6>
                                                <span class="badge bg-success"><%= totalClubs %> Active Clubs</span>
                                            </div>
                                            <div class="table-responsive text-nowrap">
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th class="text-center" style="width: 70px;">#</th>
                                                            <th>Club Name</th>
                                                            <th>Club Advisor</th>
                                                            <th>Chairperson</th>
                                                            <th class="text-center">Events Organised</th>
                                                            <th class="text-center">Total Verified Attendees</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% 
                                                            if (clubSummaries != null && !clubSummaries.isEmpty()) {
                                                                int idx = 0;
                                                                for (Map<String, Object> c : clubSummaries) {
                                                                    idx++;
                                                        %>
                                                        <tr>
                                                            <td class="text-center fw-semibold text-muted"><%= idx %></td>
                                                            <td class="fw-bold"><%= c.get("clubName") %></td>
                                                            <td><i class="bx bx-user-voice text-success me-1"></i> <%= c.get("advisorName") %></td>
                                                            <td><i class="bx bx-user-pin text-warning me-1"></i> <%= c.get("chairpersonName") %></td>
                                                            <td class="text-center"><span class="badge bg-label-info fw-bold"><%= c.get("totalEvents") %></span></td>
                                                            <td class="text-center fw-bold text-success"><%= c.get("totalAttendees") %></td>
                                                        </tr>
                                                        <% 
                                                                }
                                                            } else {
                                                        %>
                                                        <tr>
                                                            <td colspan="6" class="text-center text-muted py-4">No clubs registered in the system.</td>
                                                        </tr>
                                                        <% } %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- EVENTS MODULE TAB -->
                                    <div class="tab-pane fade" id="events" role="tabpanel">
                                        <h5 class="fw-bold mb-4 text-dark"><i class="bx bx-calendar text-warning me-2"></i> Events Module Analytics</h5>
                                        <div class="row">
                                            <!-- Chart 1: Status -->
                                            <div class="col-md-4 mb-4">
                                                <div class="card border h-100 shadow-none">
                                                    <div class="card-header bg-transparent py-3 border-bottom">
                                                        <h6 class="m-0 fw-bold text-dark">Events Status Ratio</h6>
                                                    </div>
                                                    <div class="card-body d-flex justify-content-center align-items-center p-3">
                                                        <div id="eventStatusChart" style="width: 100%; min-height: 250px;"></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- Chart 2: Category -->
                                            <div class="col-md-4 mb-4">
                                                <div class="card border h-100 shadow-none">
                                                    <div class="card-header bg-transparent py-3 border-bottom">
                                                        <h6 class="m-0 fw-bold text-dark">Event Category Breakdowns</h6>
                                                    </div>
                                                    <div class="card-body d-flex justify-content-center align-items-center p-3">
                                                        <div id="eventCategoryChart" style="width: 100%; min-height: 250px;"></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- Chart 3: SDG Goals -->
                                            <div class="col-md-4 mb-4">
                                                <div class="card border h-100 shadow-none">
                                                    <div class="card-header bg-transparent py-3 border-bottom">
                                                        <h6 class="m-0 fw-bold text-dark">SDG Goals Mapping</h6>
                                                    </div>
                                                    <div class="card-body d-flex justify-content-center align-items-center p-3">
                                                        <div id="eventSdgChart" style="width: 100%; min-height: 250px;"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Recent Events List -->
                                        <div class="card border shadow-none mt-2">
                                            <div class="card-header bg-transparent py-3 border-bottom">
                                                <h6 class="m-0 fw-bold text-dark">Recent Proposed Events Status (Last 10 Events)</h6>
                                            </div>
                                            <div class="table-responsive text-nowrap">
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Event Name</th>
                                                            <th>Organizer Club</th>
                                                            <th>Event Date</th>
                                                            <th>Venue</th>
                                                            <th class="text-center">Quota Limit</th>
                                                            <th class="text-center">Total Signups</th>
                                                            <th class="text-center">Check-ins</th>
                                                            <th class="text-center">Status</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            if (recentEvents != null && !recentEvents.isEmpty()) {
                                                                for (Map<String, Object> ev : recentEvents) {
                                                                    String statusBadge = "bg-label-primary";
                                                                    if ("APPROVED".equals(ev.get("status"))) statusBadge = "bg-label-success";
                                                                    if ("REJECTED".equals(ev.get("status"))) statusBadge = "bg-label-danger";
                                                                    if ("PENDING".equals(ev.get("status"))) statusBadge = "bg-label-warning";
                                                        %>
                                                        <tr>
                                                            <td class="fw-bold"><%= ev.get("eventName") %></td>
                                                            <td><%= ev.get("clubName") %></td>
                                                            <td class="text-muted"><%= ev.get("date") %></td>
                                                            <td><%= ev.get("venue") %></td>
                                                            <td class="text-center fw-semibold"><%= ev.get("quota") %></td>
                                                            <td class="text-center text-primary fw-bold"><%= ev.get("registeredCount") %></td>
                                                            <td class="text-center text-success fw-bold"><%= ev.get("attendedCount") %></td>
                                                            <td class="text-center">
                                                                <span class="badge <%= statusBadge %>"><%= ev.get("status") %></span>
                                                            </td>
                                                        </tr>
                                                        <%
                                                                }
                                                            } else {
                                                        %>
                                                        <tr>
                                                            <td colspan="8" class="text-center text-muted py-4">No events registered yet.</td>
                                                        </tr>
                                                        <% } %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- ATTENDANCE MODULE TAB -->
                                    <div class="tab-pane fade" id="attendance" role="tabpanel">
                                        <h5 class="fw-bold mb-4 text-dark"><i class="bx bx-checkbox-checked text-info me-2"></i> Attendance Module Analytics</h5>
                                        <div class="row">
                                            <div class="col-lg-6 mb-4">
                                                <div class="card border h-100 shadow-none">
                                                    <div class="card-header bg-transparent py-3 border-bottom">
                                                        <h6 class="m-0 fw-bold text-dark">Participant Attendance Distribution</h6>
                                                    </div>
                                                    <div class="card-body d-flex justify-content-center align-items-center p-4">
                                                        <div id="attendanceChart" style="width: 100%; min-height: 280px;"></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 mb-4">
                                                <div class="card border h-100 shadow-none">
                                                    <div class="card-header bg-transparent py-3 border-bottom">
                                                        <h6 class="m-0 fw-bold text-dark">Check-in Rates & Stats</h6>
                                                    </div>
                                                    <div class="card-body p-4">
                                                        <% 
                                                            int totalReg = (Integer) generalAttendanceStats.getOrDefault("totalRegistrations", 0);
                                                            int totalAttended = (Integer) generalAttendanceStats.getOrDefault("totalAttended", 0);
                                                            int totalAbsent = (Integer) generalAttendanceStats.getOrDefault("totalAbsent", 0);
                                                            int totalPending = (Integer) generalAttendanceStats.getOrDefault("totalPending", 0);
                                                            double conversionRate = totalReg > 0 ? ((double) totalAttended / totalReg) * 100 : 0;
                                                        %>
                                                        <div class="text-center py-3">
                                                            <h2 class="display-4 fw-bold text-info mb-1"><%= String.format("%.1f", conversionRate) %>%</h2>
                                                            <p class="text-muted text-uppercase small fw-bold">Overall Student Check-in Rate</p>
                                                        </div>
                                                        <hr>
                                                        <div class="d-flex justify-content-between mb-2">
                                                            <span>Total Registered Bookings:</span>
                                                            <strong class="text-dark"><%= totalReg %></strong>
                                                        </div>
                                                        <div class="d-flex justify-content-between mb-2">
                                                            <span>Students Checked-in:</span>
                                                            <strong class="text-success"><%= totalAttended %></strong>
                                                        </div>
                                                        <div class="d-flex justify-content-between mb-2">
                                                            <span>Registered but Absent:</span>
                                                            <strong class="text-danger"><%= totalAbsent %></strong>
                                                        </div>
                                                        <div class="d-flex justify-content-between">
                                                            <span>Awaiting Event / Check-in Verification:</span>
                                                            <strong class="text-warning"><%= totalPending %></strong>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- MERITS MODULE TAB -->
                                    <div class="tab-pane fade" id="merits" role="tabpanel">
                                        <h5 class="fw-bold mb-4 text-dark"><i class="bx bx-award text-danger me-2"></i> Merits Module Analytics</h5>
                                        <div class="row g-4 mb-4">
                                            <div class="col-md-6 col-lg-4">
                                                <div class="card bg-label-danger border-0 p-4">
                                                    <span class="d-block mb-1 text-danger small text-uppercase fw-bold">Cumulative Merits Distributed</span>
                                                    <h2 class="fw-bold text-danger mb-0">
                                                        <%= meritStats.get("totalPoints") %> <span class="small font-normal" style="font-size: 1rem;">points</span>
                                                    </h2>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-lg-4">
                                                <div class="card bg-label-success border-0 p-4">
                                                    <span class="d-block mb-1 text-success small text-uppercase fw-bold">Average Merits Per Student</span>
                                                    <h2 class="fw-bold text-success mb-0">
                                                        <%= String.format("%.1f", (Double) meritStats.get("avgPoints")) %> <span class="small font-normal" style="font-size: 1rem;">points</span>
                                                    </h2>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-lg-4">
                                                <div class="card bg-label-warning border-0 p-4">
                                                    <span class="d-block mb-1 text-warning small text-uppercase fw-bold">Total Merit Transactions</span>
                                                    <h2 class="fw-bold text-warning mb-0">
                                                        <%= meritStats.get("totalAwarded") %> <span class="small font-normal" style="font-size: 1rem;">awards</span>
                                                    </h2>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Leaderboard -->
                                        <div class="card border shadow-none">
                                            <div class="card-header bg-transparent py-3 border-bottom d-flex align-items-center">
                                                <i class="bx bxs-trophy text-warning me-2" style="font-size: 1.5rem;"></i>
                                                <h6 class="m-0 fw-bold text-dark">Top 10 Active Students Merit Leaderboard</h6>
                                            </div>
                                            <div class="table-responsive text-nowrap">
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th class="text-center" style="width: 70px;">Rank</th>
                                                            <th>Student Name</th>
                                                            <th>Email Address</th>
                                                            <th class="text-center">Total Merit Points</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            if (topStudents != null && !topStudents.isEmpty()) {
                                                                int rank = 0;
                                                                for (Map<String, Object> s : topStudents) {
                                                                    rank++;
                                                                    String medal = "";
                                                                    if (rank == 1) medal = "🥇";
                                                                    if (rank == 2) medal = "🥈";
                                                                    if (rank == 3) medal = "🥉";
                                                        %>
                                                        <tr>
                                                            <td class="text-center fw-bold text-dark"><%= rank %> <%= medal %></td>
                                                            <td class="fw-bold"><%= s.get("fullName") %></td>
                                                            <td class="text-muted"><%= s.get("email") %></td>
                                                            <td class="text-center text-danger fw-extrabold" style="font-size: 1.1rem;"><%= s.get("totalMerits") %> pts</td>
                                                        </tr>
                                                        <%
                                                                }
                                                            } else {
                                                        %>
                                                        <tr>
                                                            <td colspan="4" class="text-center text-muted py-4">No merits distributed yet.</td>
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
                        <!-- / Content -->

                        <jsp:include page="footer.jsp" />

                        <div class="content-backdrop fade"></div>
                    </div>
                    <!-- Content wrapper -->
                </div>
                <!-- / Layout page -->
            </div>

            <!-- Overlay -->
            <div class="layout-overlay layout-menu-toggle"></div>
        </div>
        <!-- / Layout wrapper -->

        <!-- ApexCharts JS -->
        <script src="${pageContext.request.contextPath}/resources/assets/vendor/libs/apex-charts/apexcharts.js"></script>

        <!-- Charts Initializations script -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Roles chart
                const userRoleOptions = {
                    chart: {
                        type: 'donut',
                        height: 280
                    },
                    colors: ['#696cff', '#ff9f43', '#28c76f', '#ea5455'],
                    labels: ['Students', 'Club Chairpersons', 'Advisors', 'HEPA Admins'],
                    series: [
                        <%= roleDistribution != null ? roleDistribution.getOrDefault("STUDENT", 0) : 0 %>,
                        <%= roleDistribution != null ? roleDistribution.getOrDefault("CHAIRPERSON", 0) : 0 %>,
                        <%= roleDistribution != null ? roleDistribution.getOrDefault("ADVISOR", 0) : 0 %>,
                        <%= roleDistribution != null ? roleDistribution.getOrDefault("HEPA", 0) : 0 %>
                    ],
                    legend: {
                        position: 'bottom'
                    },
                    dataLabels: {
                        enabled: true,
                        formatter: function (val) {
                            return Math.round(val) + "%"
                        }
                    }
                };
                const userRoleChart = new ApexCharts(document.querySelector("#userRoleChart"), userRoleOptions);
                userRoleChart.render();

                // Events status chart
                const eventStatusOptions = {
                    chart: {
                        type: 'bar',
                        height: 230,
                        toolbar: { show: false }
                    },
                    plotOptions: {
                        bar: {
                            borderRadius: 4,
                            horizontal: false,
                            columnWidth: '55%'
                        }
                    },
                    colors: ['#28c76f', '#ff9f43', '#ea5455'],
                    series: [{
                        name: 'Events count',
                        data: [
                            <%= eventStatusDistribution != null ? eventStatusDistribution.getOrDefault("APPROVED", 0) : 0 %>,
                            <%= eventStatusDistribution != null ? eventStatusDistribution.getOrDefault("PENDING", 0) : 0 %>,
                            <%= eventStatusDistribution != null ? eventStatusDistribution.getOrDefault("REJECTED", 0) : 0 %>
                        ]
                    }],
                    xaxis: {
                        categories: ['Approved', 'Pending', 'Rejected']
                    },
                    dataLabels: {
                        enabled: true
                    }
                };
                const eventStatusChart = new ApexCharts(document.querySelector("#eventStatusChart"), eventStatusOptions);
                eventStatusChart.render();

                // Event Category Chart
                const categoryLabels = [
                    <% 
                    boolean first = true;
                    if (eventCategoryDistribution != null) {
                        for (String key : eventCategoryDistribution.keySet()) {
                            if (!first) { out.print(", "); }
                            out.print("'" + key + "'");
                            first = false;
                        }
                    }
                    %>
                ];
                const categoryCounts = [
                    <% 
                    first = true;
                    if (eventCategoryDistribution != null) {
                        for (String key : eventCategoryDistribution.keySet()) {
                            if (!first) { out.print(", "); }
                            out.print(eventCategoryDistribution.get(key));
                            first = false;
                        }
                    }
                    %>
                ];

                const eventCategoryOptions = {
                    chart: {
                        type: 'pie',
                        height: 230
                    },
                    colors: ['#696cff', '#00cfdd', '#fd3c97', '#ff9f43', '#28c76f'],
                    labels: categoryLabels.length > 0 ? categoryLabels : ['No Categories'],
                    series: categoryCounts.length > 0 ? categoryCounts : [0],
                    legend: {
                        position: 'bottom',
                        show: false
                    },
                    dataLabels: {
                        enabled: true
                    }
                };
                const eventCategoryChart = new ApexCharts(document.querySelector("#eventCategoryChart"), eventCategoryOptions);
                eventCategoryChart.render();

                // SDG Goals Chart
                const sdgLabels = [
                    <% 
                    first = true;
                    if (eventSdgDistribution != null) {
                        for (String key : eventSdgDistribution.keySet()) {
                            if (!first) { out.print(", "); }
                            out.print("'" + key + "'");
                            first = false;
                        }
                    }
                    %>
                ];
                const sdgCounts = [
                    <% 
                    first = true;
                    if (eventSdgDistribution != null) {
                        for (String key : eventSdgDistribution.keySet()) {
                            if (!first) { out.print(", "); }
                            out.print(eventSdgDistribution.get(key));
                            first = false;
                        }
                    }
                    %>
                ];

                const eventSdgOptions = {
                    chart: {
                        type: 'bar',
                        height: 230,
                        toolbar: { show: false }
                    },
                    plotOptions: {
                        bar: {
                            borderRadius: 4,
                            horizontal: true,
                            barHeight: '60%'
                        }
                    },
                    colors: ['#00cfdd'],
                    series: [{
                        name: 'Events aligned',
                        data: sdgCounts.length > 0 ? sdgCounts : [0]
                    }],
                    xaxis: {
                        categories: sdgLabels.length > 0 ? sdgLabels : ['No SDG Goal Alignment']
                    },
                    dataLabels: {
                        enabled: true
                    }
                };
                const eventSdgChart = new ApexCharts(document.querySelector("#eventSdgChart"), eventSdgOptions);
                eventSdgChart.render();

                // Attendance Distribution chart
                const attendanceOptions = {
                    chart: {
                        type: 'donut',
                        height: 280
                    },
                    colors: ['#28c76f', '#ea5455', '#ff9f43'],
                    labels: ['Attended', 'Absent', 'Registered (Pending)'],
                    series: [
                        <%= attendanceStatusDistribution != null ? attendanceStatusDistribution.getOrDefault("ATTENDED", 0) : 0 %>,
                        <%= attendanceStatusDistribution != null ? attendanceStatusDistribution.getOrDefault("ABSENT", 0) : 0 %>,
                        <%= attendanceStatusDistribution != null ? attendanceStatusDistribution.getOrDefault("REGISTERED", 0) : 0 %>
                    ],
                    legend: {
                        position: 'bottom'
                    },
                    dataLabels: {
                        enabled: true
                    }
                };
                const attendanceChart = new ApexCharts(document.querySelector("#attendanceChart"), attendanceOptions);
                attendanceChart.render();
            });
        </script>
    <% } %>
</body>
</html>
