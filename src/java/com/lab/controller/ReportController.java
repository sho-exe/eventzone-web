package com.lab.controller;

import com.lab.dao.ReportDAO;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/reports")
public class ReportController extends HttpServlet {

    private ReportDAO reportDAO;

    @Override
    public void init() {
        reportDAO = new ReportDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Validate session and role
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String accountType = (String) session.getAttribute("accountType");
        if (!"HEPA".equals(accountType)) {
            response.sendRedirect("Homepage.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null || "view".equals(action)) {
            // Fetch reports metrics
            int totalUsers = reportDAO.getTotalUsers();
            Map<String, Integer> roleDistribution = reportDAO.getUserRoleDistribution();
            List<Map<String, Object>> clubSummaries = reportDAO.getClubSummaries();
            Map<String, Integer> eventStatusDistribution = reportDAO.getEventStatusDistribution();
            Map<String, Integer> eventCategoryDistribution = reportDAO.getEventCategoryDistribution();
            Map<String, Integer> eventSdgDistribution = reportDAO.getEventSdgDistribution();
            List<Map<String, Object>> recentEvents = reportDAO.getRecentEvents();
            Map<String, Integer> attendanceStatusDistribution = reportDAO.getAttendanceStatusDistribution();
            Map<String, Object> generalAttendanceStats = reportDAO.getGeneralAttendanceStats();
            Map<String, Object> meritStats = reportDAO.getMeritStats();
            List<Map<String, Object>> topStudents = reportDAO.getTopStudentsByMerit();

            // Bind attributes
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("roleDistribution", roleDistribution);
            request.setAttribute("clubSummaries", clubSummaries);
            request.setAttribute("eventStatusDistribution", eventStatusDistribution);
            request.setAttribute("eventCategoryDistribution", eventCategoryDistribution);
            request.setAttribute("eventSdgDistribution", eventSdgDistribution);
            request.setAttribute("recentEvents", recentEvents);
            request.setAttribute("attendanceStatusDistribution", attendanceStatusDistribution);
            request.setAttribute("generalAttendanceStats", generalAttendanceStats);
            request.setAttribute("meritStats", meritStats);
            request.setAttribute("topStudents", topStudents);

            // Forward to reports page
            request.getRequestDispatcher("HepaReports.jsp").forward(request, response);
        } else {
            response.sendRedirect("Homepage.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
