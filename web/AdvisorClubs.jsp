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

                                                    <h4 class="fw-bold py-3 mb-4">
                                                        <span class="text-muted fw-light">SERS /</span> My Managed Clubs
                                                    </h4>

                                                    <div class="alert alert-success border-0  bg-success-soft"
                                                        style="color:black">
                                                        <i class="fas fa-info-circle me-2 success"></i> As an
                                                        assigned Advisor, you have the authority to assign or change the
                                                        <strong>Chairperson</strong> who will handle event creation for
                                                        your clubs.
                                                    </div>

                                                    <div class="row mt-4">
                                                        <% List<Club> clubList = (List<Club>)
                                                                request.getAttribute("clubList");
                                                                List<User> userList = (List<User>)
                                                                        request.getAttribute("userList");

                                                                        if(clubList != null && !clubList.isEmpty()) {
                                                                        for(Club c : clubList) {
                                                                        %>
                                                                        <div class="col-lg-6 col-md-12 mb-4">
                                                                            <div
                                                                                class="card h-100 club-card bg-white  ">
                                                                                <div
                                                                                    class="card-header bg-white border-bottom-0 pt-4 pb-0">
                                                                                    <h5 class="fw-bold text-dark mb-1">
                                                                                        <%= c.getClubName() %>
                                                                                    </h5>
                                                                                    <span
                                                                                        class="badge bg-secondary">System
                                                                                        ID: #<%= c.getClubId() %></span>
                                                                                </div>
                                                                                <div class="card-body">
                                                                                    <p class="text-muted">
                                                                                        <%= c.getDescription() %>
                                                                                    </p>

                                                                                    <hr class="bg-light">

                                                                                    <div
                                                                                        class="row align-items-center mb-3 p-3 bg-light rounded">
                                                                                        <div
                                                                                            class="col-2 text-center text-success">
                                                                                            <i
                                                                                                class="fas fa-user-tie fa-2x"></i>
                                                                                        </div>
                                                                                        <div class="col-10">
                                                                                            <small
                                                                                                class="text-muted d-block text-uppercase fw-bold">Official
                                                                                                Advisor (You)</small>
                                                                                            <span class="fs-5">
                                                                                                <%= c.getAdvisorName()
                                                                                                    %>
                                                                                            </span>
                                                                                        </div>
                                                                                    </div>

                                                                                    <form
                                                                                        action="ClubController?action=advisor"
                                                                                        method="POST"
                                                                                        class="p-3 bg-warning-soft rounded border border-warning">
                                                                                        <input type="hidden"
                                                                                            name="action"
                                                                                            value="assignChairperson">
                                                                                        <input type="hidden"
                                                                                            name="clubId"
                                                                                            value="<%= c.getClubId() %>">

                                                                                        <label
                                                                                            class="fw-bold text-warning mb-2"
                                                                                            style="color: #d39e00 !important;"><i
                                                                                                class="fas fa-user-graduate me-1"></i>
                                                                                            Appointed
                                                                                            Chairperson</label>
                                                                                        <div class="input-group">
                                                                                            <select name="chairpersonId"
                                                                                                class="form-select border-warning bg-white">
                                                                                                <option value="">--
                                                                                                    Vacant Position --
                                                                                                </option>
                                                                                                <% for(User u :
                                                                                                    userList) { if
                                                                                                    (u.getRole().equals("CHAIRPERSON"))
                                                                                                    { boolean
                                                                                                    selected=(c.getChairpersonId()
                                                                                                    !=null &&
                                                                                                    c.getChairpersonId()==u.getUserId());
                                                                                                    %>
                                                                                                    <option
                                                                                                        value="<%= u.getUserId() %>"
                                                                                                        <%=selected
                                                                                                        ? "selected"
                                                                                                        : "" %>><%=
                                                                                                            u.getFullName()
                                                                                                            %>
                                                                                                    </option>
                                                                                                    <% } } %>
                                                                                            </select>
                                                                                            <button type="submit"
                                                                                                class="btn btn-warning fw-bold text-dark border-warning">Save
                                                                                                Assignment</button>
                                                                                        </div>
                                                                                    </form>

                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <% } } else { %>
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

                                <jsp:include page="footer.jsp" />

                                <% } %>
                    </body>

                    </html>