package com.lab.controller;

import com.lab.dao.EventDAO;
import com.lab.dao.AttendanceDAO;
import com.lab.dao.ClubDAO;
import com.lab.model.Event;
import com.lab.model.Club;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/events")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class EventController extends HttpServlet {

    private EventDAO eventDAO;
    private AttendanceDAO regDAO;
    private ClubDAO clubDAO;

    @Override
    public void init() {
        eventDAO = new EventDAO();
        regDAO = new AttendanceDAO();
        clubDAO = new ClubDAO();
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

        if ("manage".equals(action) && "CHAIRPERSON".equals(accountType)) {
            Club myClub = clubDAO.selectClubByChairperson(userId);
            if (myClub != null) {
                List<Event> myEvents = eventDAO.selectEventsByClub(myClub.getClubId());
                request.setAttribute("club", myClub);
                request.setAttribute("eventList", myEvents);
            }
            request.setAttribute("activeTab", "manage");
            request.getRequestDispatcher("EventsHub.jsp").forward(request, response);

        } else if ("pending".equals(action) && "ADVISOR".equals(accountType)) {
            List<Event> pendingEvents = eventDAO.selectPendingEventsByAdvisor(userId);
            request.setAttribute("adminEventList", pendingEvents);
            request.setAttribute("viewMode", "ADVISOR_PENDING");
            request.getRequestDispatcher("AdminEventLedger.jsp").forward(request, response);

        } else if ("global".equals(action) && ("HEPA".equals(accountType) || "ADVISOR".equals(accountType))) {
            List<Event> globalEvents = eventDAO.selectAllEvents();
            request.setAttribute("adminEventList", globalEvents);
            request.setAttribute("viewMode", "HEPA_GLOBAL");
            request.getRequestDispatcher("AdminEventLedger.jsp").forward(request, response);

        } else if ("clubEvents".equals(action) && "ADVISOR".equals(accountType)) {
            List<Event> clubEvents = eventDAO.selectAllEventsByAdvisor(userId);
            request.setAttribute("adminEventList", clubEvents);
            request.setAttribute("viewMode", "ADVISOR_HISTORY");
            request.getRequestDispatcher("AdminEventLedger.jsp").forward(request, response);

        } else if ("browse".equals(action) && ("STUDENT".equals(accountType) || "CHAIRPERSON".equals(accountType))) {
            List<Event> approvedEvents = eventDAO.selectApprovedEvents();
            for (Event e : approvedEvents) {
                e.setAlreadyRegistered(regDAO.isStudentRegistered(e.getEventId(), userId));
                e.setCurrentEnrollments(regDAO.getEnrollmentCount(e.getEventId()));
            }
            request.setAttribute("eventCatalog", approvedEvents);
            request.setAttribute("activeTab", "explore");
            request.getRequestDispatcher("EventsHub.jsp").forward(request, response);

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

        if ("proposeEvent".equals(action) && "CHAIRPERSON".equals(accountType)) {
            Event newEvent = new Event();
            newEvent.setEventName(request.getParameter("eventName"));
            newEvent.setDescription(request.getParameter("description"));
            newEvent.setDate(Date.valueOf(request.getParameter("date")));
            String timeStr = request.getParameter("time");
            if (timeStr != null && !timeStr.trim().isEmpty()) {
                if (timeStr.length() == 5) {
                    timeStr += ":00";
                }
                newEvent.setTime(java.sql.Time.valueOf(timeStr));
            }
            String endTimeStr = request.getParameter("endTime");
            if (endTimeStr != null && !endTimeStr.trim().isEmpty()) {
                if (endTimeStr.length() == 5) {
                    endTimeStr += ":00";
                }
                newEvent.setEndTime(java.sql.Time.valueOf(endTimeStr));
            }
            newEvent.setVenue(request.getParameter("venue"));
            newEvent.setQuota(request.getParameter("quota") != null && !request.getParameter("quota").isEmpty()
                    ? Integer.parseInt(request.getParameter("quota"))
                    : 0);
            newEvent.setCriteria(request.getParameter("criteria"));
            newEvent.setCategory(request.getParameter("kategori"));
            String[] sdgArr = request.getParameterValues("sdgGoals");
            newEvent.setSdgGoals(sdgArr != null ? String.join(", ", sdgArr) : "");
            
            String imagePath = null;
            try {
                Part filePart = request.getPart("image");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = filePart.getSubmittedFileName();
                    if (fileName != null && !fileName.trim().isEmpty()) {
                        fileName = System.currentTimeMillis() + "_" + fileName;
                        String uploadPath = request.getServletContext().getRealPath("/uploads");
                        java.io.File uploadDir = new java.io.File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        filePart.write(uploadPath + java.io.File.separator + fileName);
                        imagePath = "uploads/" + fileName;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            newEvent.setImage(imagePath);
            
            newEvent.setClubId(Integer.parseInt(request.getParameter("clubId")));

            // Check for venue and time conflicts
            if (eventDAO.hasConflict(newEvent.getVenue(), newEvent.getDate(), newEvent.getTime(), newEvent.getEndTime(), 0)) {
                response.sendRedirect("events?action=manage&message=Error:+Venue+and+time+conflict+with+an+existing+event!");
                return;
            }

            eventDAO.insertEvent(newEvent);
            response.sendRedirect("events?action=manage");

        } else if ("editEvent".equals(action) && "CHAIRPERSON".equals(accountType)) {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            Event event = eventDAO.selectEventById(eventId);
            if (event != null && "PENDING".equals(event.getStatus())) {
                event.setEventName(request.getParameter("eventName"));
                event.setDescription(request.getParameter("description"));
                event.setDate(Date.valueOf(request.getParameter("date")));
                String timeStr = request.getParameter("time");
                if (timeStr != null && !timeStr.trim().isEmpty()) {
                    if (timeStr.length() == 5) {
                        timeStr += ":00";
                    }
                    event.setTime(java.sql.Time.valueOf(timeStr));
                } else {
                    event.setTime(null);
                }
                String endTimeStr = request.getParameter("endTime");
                if (endTimeStr != null && !endTimeStr.trim().isEmpty()) {
                    if (endTimeStr.length() == 5) {
                        endTimeStr += ":00";
                    }
                    event.setEndTime(java.sql.Time.valueOf(endTimeStr));
                } else {
                    event.setEndTime(null);
                }
                event.setVenue(request.getParameter("venue"));
                event.setQuota(request.getParameter("quota") != null && !request.getParameter("quota").isEmpty()
                        ? Integer.parseInt(request.getParameter("quota"))
                        : 0);
                event.setCategory(request.getParameter("kategori"));
                String[] sdgArr = request.getParameterValues("sdgGoals");
                event.setSdgGoals(sdgArr != null ? String.join(", ", sdgArr) : "");
                
                String imagePath = event.getImage(); // Keep existing by default
                try {
                    Part filePart = request.getPart("image");
                    if (filePart != null && filePart.getSize() > 0) {
                        String fileName = filePart.getSubmittedFileName();
                        if (fileName != null && !fileName.trim().isEmpty()) {
                            fileName = System.currentTimeMillis() + "_" + fileName;
                            String uploadPath = request.getServletContext().getRealPath("/uploads");
                            java.io.File uploadDir = new java.io.File(uploadPath);
                            if (!uploadDir.exists()) {
                                uploadDir.mkdirs();
                            }
                            filePart.write(uploadPath + java.io.File.separator + fileName);
                            imagePath = "uploads/" + fileName;
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                event.setImage(imagePath);
                
                // Check for venue and time conflicts
                if (eventDAO.hasConflict(event.getVenue(), event.getDate(), event.getTime(), event.getEndTime(), event.getEventId())) {
                    response.sendRedirect("events?action=manage&message=Error:+Venue+and+time+conflict+with+an+existing+event!");
                    return;
                }

                eventDAO.updateEvent(event);
            }
            response.sendRedirect("events?action=manage");

        } else if ("deleteEvent".equals(action) && ("CHAIRPERSON".equals(accountType) || "HEPA".equals(accountType))) {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            Event event = eventDAO.selectEventById(eventId);
            if (event != null) {
                if ("HEPA".equals(accountType) || "PENDING".equals(event.getStatus())) {
                    eventDAO.deleteEvent(eventId);
                }
            }
            if ("HEPA".equals(accountType)) {
                response.sendRedirect("events?action=global");
            } else {
                response.sendRedirect("events?action=manage");
            }

        } else if (("approve".equals(action) || "reject".equals(action))
                && ("ADVISOR".equals(accountType) || "HEPA".equals(accountType))) {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            String supportingText = request.getParameter("supportingText");
            
            String newStatus = "REJECTED"; // default for reject
            if ("approve".equals(action)) {
                if ("ADVISOR".equals(accountType)) {
                    newStatus = "PENDING_HEPA";
                } else if ("HEPA".equals(accountType)) {
                    newStatus = "APPROVED";
                }
            }

            if ("ADVISOR".equals(accountType)) {
                eventDAO.updateEventStatusWithReason(eventId, newStatus, supportingText);
            } else {
                eventDAO.updateEventStatus(eventId, newStatus);
            }

            // Auto-register the club's chairperson as a participant when fully approved
            if ("APPROVED".equals(newStatus)) {
                Event event = eventDAO.selectEventById(eventId);
                if (event != null) {
                    Club club = clubDAO.selectClubById(event.getClubId());
                    if (club != null && club.getChairpersonId() != null && club.getChairpersonId() > 0) {
                        int approverId = (int) session.getAttribute("userId");
                        regDAO.registerChairpersonAsParticipant(eventId, club.getChairpersonId(), approverId);
                    }
                }
            }
            
            if ("HEPA".equals(accountType)) {
                response.sendRedirect("events?action=global&message=Success:+Event+status+updated+to+" + newStatus);
            } else {
                response.sendRedirect("events?action=pending&message=Success:+Event+status+updated+to+" + newStatus);
            }

        } else if ("register".equals(action) && ("STUDENT".equals(accountType) || "CHAIRPERSON".equals(accountType))) {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            int studentId = (int) session.getAttribute("userId");
            regDAO.registerStudent(eventId, studentId);
            response.sendRedirect("events?action=browse");

        } else {
            response.sendRedirect("auths?action=logout");
        }
    }
}
