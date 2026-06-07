<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <% String role=(String) session.getAttribute("accountType"); %>



        <!-- Navbar -->
        <nav class="layout-navbar navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
            id="layout-navbar">
            <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
                <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                    <i class="bx bx-menu bx-sm"></i>
                </a>
            </div>

            <div class="navbar-nav-right d-flex align-items-center gap-3" id="navbar-collapse">
                <!-- Welcome message -->
                <div class="navbar-nav align-items-center">
                    <div class="nav-item d-flex align-items-center gap-2">
                        <span class="fw-semibold">Welcome Back, ${name}!</span>
                        <span class="text-muted d-none d-md-inline">(${email})</span>
                        <span class="navbar-role-badge">${accountType}</span>
                    </div>
                </div>

                <ul class="navbar-nav flex-row align-items-center ms-auto"
                    style="align-items: center !important;">
                    <li class="nav-item d-flex align-items-center">
                        <a href="Logout.jsp" class="d-flex align-items-center gap-1"
                            style="font-weight: 600; padding: 6px 14px; border: 1.5px solid #ff3e1d; border-radius: 6px; background: rgba(255, 62, 29, 0.05); color: #ff3e1d !important; text-decoration: none; height: 36px; align-self: center; transition: all 0.2s;"
                            onclick="return confirm('Are you sure you want to log out?');"
                            onmouseover="this.style.background='#ff3e1d'; this.style.color='#ffffff';"
                            onmouseout="this.style.background='rgba(255, 62, 29, 0.05)'; this.style.color='#ff3e1d';">
                            <i class="bx bx-power-off" style="font-size: 1.15rem; color: inherit;"></i>
                            <span
                                style="color: inherit !important; font-size: 0.9rem; font-weight: 600; line-height: 1;"
                                class="d-none d-md-inline">Log Out</span>
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
        <!-- / Navbar -->