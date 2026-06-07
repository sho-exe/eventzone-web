<%@page contentType="text/html" pageEncoding="UTF-8" %>
<% String role = (String) session.getAttribute("accountType"); %>

<%
    String badgeClass, accentColor, accentLight;
    if ("HEPA".equals(role)) {
        badgeClass  = "bg-label-danger";
        accentColor = "#ea5455";
        accentLight = "rgba(234,84,85,0.1)";
    } else if ("ADVISOR".equals(role)) {
        badgeClass  = "bg-label-success";
        accentColor = "#28c76f";
        accentLight = "rgba(40,199,111,0.1)";
    } else if ("CHAIRPERSON".equals(role)) {
        badgeClass  = "bg-label-warning";
        accentColor = "#ff9f43";
        accentLight = "rgba(255,159,67,0.1)";
    } else {
        badgeClass  = "bg-label-primary";
        accentColor = "#696cff";
        accentLight = "rgba(105,108,255,0.1)";
    }
%>

<style>
    /* Navbar role accent */
    #layout-navbar {
        border-bottom: 2px solid <%= accentColor %>22 !important;
    }
    .navbar-role-badge {
        font-size: 0.7rem;
        font-weight: 700;
        letter-spacing: 0.05em;
        padding: 3px 10px;
        border-radius: 20px;
        background: <%= accentLight %>;
        color: <%= accentColor %>;
        border: 1.5px solid <%= accentColor %>;
        text-transform: uppercase;
    }
</style>

<!-- Navbar -->
<nav class="layout-navbar navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme" id="layout-navbar">
    <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
        <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
            <i class="bx bx-menu bx-sm"></i>
        </a>
    </div>

    <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
        <!-- Welcome message -->
        <div class="navbar-nav align-items-center">
            <div class="nav-item d-flex align-items-center gap-2">
                <span class="fw-semibold">Welcome Back, ${name}!</span>
                <span class="text-muted">(${email})</span>
                <span class="navbar-role-badge">${accountType}</span>
            </div>
        </div>

        <ul class="navbar-nav flex-row align-items-center ms-auto">
            <!-- User dropdown -->
            <li class="nav-item navbar-dropdown dropdown-user dropdown">
                <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                    <div class="avatar avatar-online">
                        <img src="${pageContext.request.contextPath}/resources/assets/img/avatars/1.png"
                             alt class="w-px-40 h-auto rounded-circle" />
                    </div>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                        <a class="dropdown-item" href="#">
                            <div class="d-flex">
                                <div class="flex-shrink-0 me-3">
                                    <div class="avatar avatar-online">
                                        <img src="${pageContext.request.contextPath}/resources/assets/img/avatars/1.png"
                                             alt class="w-px-40 h-auto rounded-circle" />
                                    </div>
                                </div>
                                <div class="flex-grow-1">
                                    <span class="fw-semibold d-block">${name}</span>
                                    <small class="navbar-role-badge">${accountType}</small>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li><div class="dropdown-divider"></div></li>
                    <li>
                        <a class="dropdown-item" href="auths?action=logout">
                            <i class="bx bx-power-off me-2"></i>
                            <span class="align-middle">Log Out</span>
                        </a>
                    </li>
                </ul>
            </li>
            <!--/ User -->
        </ul>
    </div>
</nav>
<!-- / Navbar -->
