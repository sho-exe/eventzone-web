
import com.lab.dao.EventDAO;
import com.lab.dao.AttendanceDAO;
import com.lab.dao.ClubDAO;
import com.lab.model.Event;
import com.lab.model.Club;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/events")
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
            newEvent.setVenue(request.getParameter("venue"));
            newEvent.setQuota(request.getParameter("quota") != null && !request.getParameter("quota").isEmpty()
                    ? Integer.parseInt(request.getParameter("quota"))
                    : 0);
            newEvent.setCriteria(request.getParameter("criteria"));
            newEvent.setCategory(request.getParameter("kategori"));
            String[] sdgArr = request.getParameterValues("sdgGoals");
            newEvent.setSdgGoals(sdgArr != null ? String.join(", ", sdgArr) : "");
            newEvent.setClubId(Integer.parseInt(request.getParameter("clubId")));
            eventDAO.insertEvent(newEvent);
            response.sendRedirect("events?action=manage");

        } else if ("editEvent".equals(action) && "CHAIRPERSON".equals(accountType)) {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            Event event = eventDAO.selectEventById(eventId);
            if (event != null && "PENDING".equals(event.getStatus())) {
                event.setEventName(request.getParameter("eventName"));
                event.setDescription(request.getParameter("description"));
                event.setDate(Date.valueOf(request.getParameter("date")));
                event.setVenue(request.getParameter("venue"));
                event.setQuota(request.getParameter("quota") != null && !request.getParameter("quota").isEmpty()
                        ? Integer.parseInt(request.getParameter("quota"))
                        : 0);
                event.setCategory(request.getParameter("kategori"));
                String[] sdgArr = request.getParameterValues("sdgGoals");
                event.setSdgGoals(sdgArr != null ? String.join(", ", sdgArr) : "");
                eventDAO.updateEvent(event);
            }
            response.sendRedirect("events?action=manage");

        } else if ("deleteEvent".equals(action) && "CHAIRPERSON".equals(accountType)) {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            Event event = eventDAO.selectEventById(eventId);
            if (event != null && "PENDING".equals(event.getStatus())) {
                eventDAO.deleteEvent(eventId);
            }
            response.sendRedirect("events?action=manage");

        } else if (("approve".equals(action) || "reject".equals(action))
                && ("ADVISOR".equals(accountType) || "HEPA".equals(accountType))) {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            String status = "approve".equals(action) ? "APPROVED" : "REJECTED";
            eventDAO.updateEventStatus(eventId, status);

            // Redirect back to context
            String referer = request.getHeader("referer");
            if (referer != null && referer.contains("global")) {
                response.sendRedirect("events?action=global");
            } else {
                response.sendRedirect("events?action=pending");
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
