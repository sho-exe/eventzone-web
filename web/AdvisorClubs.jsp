<%@page import="java.util.List" %>
    <%@page import="com.lab.model.User" %>
        <%@page import="com.lab.model.Club" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <% String role=(String) session.getAttribute("accountType"); %>

                    <jsp:include page="header.jsp" />

                    <body>
                        <% if (role==null) { %>
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
                                                <div class=" flex-grow-1 container-p-y">

                                                     <h4 class="fw-bold py-3 mb-4 d-flex align-items-center">
                                                         My Managed Clubs
                                                         <i class="bx bx-info-circle text-info ms-2" style="cursor: pointer; font-size: 1.5rem; vertical-align: middle;" data-bs-toggle="collapse" data-bs-target="#pageTipsCollapse" title="Toggle Page Guide"></i>
                                                     </h4>

                                                     <% String message = request.getParameter("message"); %>
                                                     <% if (message != null && !message.trim().isEmpty()) {
                                                         boolean isError = message.startsWith("Error");
                                                         String alertClass = isError ? "alert-danger" : "alert-success";
                                                         String iconClass = isError ? "bx-error-circle" : "bx-check-circle";
                                                         String badgeTextClass = isError ? "text-danger" : "text-success";
                                                     %>
                                                         <div class="alert <%= alertClass %> border-0 shadow-sm mb-4 alert-dismissible fade show" role="alert" id="successAlert">
                                                             <i class="bx <%= iconClass %> me-2"></i>
                                                             <%= message %>
                                                             <% if (!isError) { %>
                                                             <span class="badge bg-white <%= badgeTextClass %> ms-2 countdown-badge" style="font-size: 0.75rem; vertical-align: middle;">3s</span>
                                                             <% } %>
                                                             <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                                         </div>
                                                     <% } %>

                                                     <div class="collapse show mb-4" id="pageTipsCollapse">
                                                         <div class="card border-0 bg-label-info shadow-none" style="border-radius: 12px;">
                                                             <div class="card-body p-3">
                                                                 <div class="d-flex align-items-center gap-3">
                                                                     <div class="bg-info text-white d-flex align-items-center justify-content-center" style="width: 36px; height: 36px; border-radius: 8px; font-size: 1.2rem; flex-shrink: 0;">
                                                                         <i class="bx bx-info-circle"></i>
                                                                     </div>
                                                                     <div class="flex-grow-1">
                                                                         <h6 class="mb-1 text-info fw-bold" style="font-size: 0.95rem;">Page Guide & Tips</h6>
                                                                         <div class="text-dark" style="font-size: 0.85rem; line-height: 1.45; font-weight: 500;">
                                                                             As an assigned Advisor, you have the authority to assign or change the <strong>Chairperson</strong> who will handle event creation for your clubs.
                                                                         </div>
                                                                     </div>
                                                                 </div>
                                                             </div>
                                                         </div>
                                                     </div>

                                                    <div class="row mt-4 gy-4 clubs-grid">
                                                          <% List<Club> clubList = (List<Club>)
                                                                  request.getAttribute("clubList");
                                                                  List<User> userList = (List<User>)
                                                                          request.getAttribute("userList");
 
                                                                         if(clubList != null && !clubList.isEmpty()) {
                                                                         int clubIndex = 0;
                                                                         for(Club c : clubList) {
                                                                         clubIndex++;
                                                                         %>
                                                                         <div class="col-lg-4 col-md-6">
                                                                             <div class="card club-card position-relative">
                                                                                 <form action="clubs" method="POST">
                                                                                     <input type="hidden" name="action" value="assignChairperson">
                                                                                     <input type="hidden" name="clubId" value="<%= c.getClubId() %>">
 
                                                                                     <div class="card-inner">
                                                                                         <div class="d-flex justify-content-between align-items-center mb-1">
                                                                                             <span class="club-id-badge badge-index mb-0" style="font-size: 1.05rem !important; padding: 8px 14px !important;">
                                                                                                 <%= clubIndex %>
                                                                                             </span>
                                                                                             <span class="club-id-badge badge-id mb-0" style="font-size: 0.9rem !important; padding: 6px 12px !important;">
                                                                                                 ID: <%= c.getClubId() %>
                                                                                             </span>
                                                                                         </div>
                                                                                         <div class="position-relative mb-2">
                                                                                             <input type="text"
                                                                                                 class="club-name-input"
                                                                                                 value="<%= c.getClubName() %>"
                                                                                                 readonly
                                                                                                 style="padding-right: 24px !important;"
                                                                                                 placeholder="Club Name">
                                                                                         </div>
 
                                                                                         <div class="position-relative">
                                                                                             <textarea
                                                                                                 class="form-control club-desc-textarea"
                                                                                                 rows="3"
                                                                                                 readonly
                                                                                                 style="padding-right: 28px !important; text-decoration: none !important;"
                                                                                                 placeholder="Club description..."><%= c.getDescription() %></textarea>
                                                                                         </div>
 
                                                                                         <hr class="divider-soft">
 
                                                                                         <div class="assign-section">
                                                                                             <!-- Advisor -->
                                                                                             <div class="mb-3">
                                                                                                 <div class="assign-label advisor">
                                                                                                     <i class="bx bx-user-pin"></i>
                                                                                                     Club Advisor (You)
                                                                                                 </div>
                                                                                                 <input type="text" class="form-control form-control-sm assign-select bg-light" value="<%= c.getAdvisorName() %>" readonly style="font-size: 0.82rem !important; border-radius: 8px !important;">
                                                                                             </div>
 
                                                                                             <!-- Chairperson -->
                                                                                             <div class="mb-0">
                                                                                                 <div class="assign-label chair">
                                                                                                     <i class="bx bx-user"></i>
                                                                                                     Chairperson
                                                                                                 </div>
                                                                                                  <select name="chairpersonId" class="form-select form-select-sm assign-select" required>
                                                                                                      <option value="" disabled <%= c.getChairpersonId() == null ? "selected" : "" %>>
                                                                                                          — Select Chairperson —
                                                                                                      </option>
                                                                                                      <% for(User u : userList) { 
                                                                                                          if (u.getRole().equals("CHAIRPERSON")) { 
                                                                                                              boolean selected=(c.getChairpersonId() != null && c.getChairpersonId() == u.getUserId());
                                                                                                      %>
                                                                                                              <option value="<%= u.getUserId() %>" <%=selected ? "selected" : "" %>>
                                                                                                                  <%= u.getFullName() %>
                                                                                                              </option>
                                                                                                      <% } } %>
                                                                                                  </select>
                                                                                             </div>
                                                                                         </div>
 
                                                                                         <div class="mt-3">
                                                                                             <button type="submit" class="btn btn-save" style="margin-top: 0 !important;">
                                                                                                 <i class="bx bx-save me-1"></i>
                                                                                                 Save Chairperson Assignment
                                                                                             </button>
                                                                                         </div>
                                                                                     </div>
                                                                                 </form>
                                                                             </div>
                                                                         </div>
                                                                         <% /* Insert a full-width spacer row after every 3rd card */ 
                                                                         if (clubIndex % 3 == 0) { %>
                                                                             <div class="col-12" style="margin-bottom: 20px;"></div>
                                                                         <% } } } else { %>
                                                                            <div
                                                                                class="col-12 text-center py-5 text-muted">
                                                                                <i
                                                                                    class="fas fa-flag fa-3x mb-3 text-light"></i><br>
                                                                                You are not assigned as an advisor to
                                                                                any clubs yet.
                                                                            </div>
                                                                            <% } %>
                                                    </div>

                                                </div>
                                                <!-- / Content -->

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



                                <% } %>
                                 <script>
                                     document.addEventListener("DOMContentLoaded", function () {
                                         const alertEl = document.getElementById("successAlert");
                                         if (alertEl) {
                                             const badge = alertEl.querySelector(".countdown-badge");
                                             if (badge) {
                                                 let timeLeft = 3;
                                                 const interval = setInterval(() => {
                                                     timeLeft--;
                                                     if (badge) {
                                                         badge.textContent = timeLeft + "s";
                                                     }
                                                     if (timeLeft <= 0) {
                                                         clearInterval(interval);
                                                         const bsAlert = new bootstrap.Alert(alertEl);
                                                         bsAlert.close();
                                                     }
                                                 }, 1000);
                                             }
                                         }
                                     });
                                 </script>
                        <jsp:include page="footer.jsp" />
</body>

                    </html>