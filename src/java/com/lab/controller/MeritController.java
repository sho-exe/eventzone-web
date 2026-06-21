package com.lab.controller;

import com.lab.dao.EventDAO;
import com.lab.dao.MeritDAO;
import com.lab.model.Event;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/merits")
public class MeritController extends HttpServlet {

    private EventDAO eventDAO;
    private MeritDAO meritDAO;

    @Override
    public void init() {
        eventDAO = new EventDAO();
        meritDAO = new MeritDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("userId") == null) {
            response.sendRedirect("auths?action=logout");
            return;
        }

        String action = request.getParameter("action");
        String accountType = (String) session.getAttribute("accountType");
        int userId = (int) session.getAttribute("userId");

        if ("distributeMerits".equals(action) && "HEPA".equals(accountType)) {
            List<Event> approvedEvents = eventDAO.selectApprovedEvents();
            request.setAttribute("approvedEvents", approvedEvents);
            request.setAttribute("meritDAO", meritDAO);
            request.getRequestDispatcher("DistributeMerits.jsp").forward(request, response);

        } else if ("meritHistory".equals(action)
                && ("STUDENT".equals(accountType) || "CHAIRPERSON".equals(accountType))) {
            int totalMerits = meritDAO.getTotalMerits(userId);
            List<Map<String, Object>> meritHistory = meritDAO.getMeritHistoryForUser(userId);
            request.setAttribute("totalMerits", totalMerits);
            request.setAttribute("meritHistory", meritHistory);
            request.getRequestDispatcher("MeritHistory.jsp").forward(request, response);

        } else if ("meritReports".equals(action) && "ADVISOR".equals(accountType)) {
            Map<String, Integer> metrics = meritDAO.getAdvisorMetrics(userId);
            List<Map<String, Object>> topStudents = meritDAO.getTopStudentsForAdvisor(userId);
            request.setAttribute("metrics", metrics);
            request.setAttribute("topStudents", topStudents);
            request.getRequestDispatcher("MeritReports.jsp").forward(request, response);

        } else {
            response.sendRedirect("auths?action=logout");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("userId") == null) {
            response.sendRedirect("auths?action=logout");
            return;
        }

        String action = request.getParameter("action");
        String accountType = (String) session.getAttribute("accountType");
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        int points = 0;
        if (request.getParameter("points") != null) {
            points = Integer.parseInt(request.getParameter("points"));
        }

        if ("distributeMerits".equals(action) && "HEPA".equals(accountType)) {
            meritDAO.distributeMerits(eventId, points);
            response.sendRedirect("merits?action=distributeMerits&success=true");

        } else if ("deleteMerits".equals(action) && "HEPA".equals(accountType)) {
            meritDAO.deleteMeritsByEvent(eventId);
            response.sendRedirect("merits?action=distributeMerits&deleted=true");

        } else {
            response.sendRedirect("auths?action=logout");
        }
    }
}
