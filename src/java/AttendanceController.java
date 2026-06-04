import com.lab.dao.AttendanceDAO;
import com.lab.dao.EventDAO;
import com.lab.model.Attendance;
import com.lab.model.Event;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/attendances")
public class AttendanceController extends HttpServlet {

    private AttendanceDAO attendanceDAO;
    private EventDAO eventDAO;

    @Override
    public void init() {
        attendanceDAO = new AttendanceDAO();
        eventDAO = new EventDAO();
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

        if ("myAttendance".equals(action) && ("STUDENT".equals(accountType) || "CHAIRPERSON".equals(accountType))) {
            List<Attendance> myRegistrations = attendanceDAO.getStudentRegistrations(userId);
            request.setAttribute("myRegistrations", myRegistrations);
            request.setAttribute("activeTab", "registrations");
            request.getRequestDispatcher("EventsHub.jsp").forward(request, response);

        } else if ("manageAttendances".equals(action)
                && ("CHAIRPERSON".equals(accountType) || "HEPA".equals(accountType))) {
            String eventIdParam = request.getParameter("eventId");
            if (eventIdParam == null || eventIdParam.isEmpty()) {
                response.sendRedirect("Homepage.jsp");
                return;
            }
            int eventId = Integer.parseInt(eventIdParam);

            Event targetEvent = null;
            for (Event e : eventDAO.selectAllEvents()) {
                if (e.getEventId() == eventId) {
                    targetEvent = e;
                    break;
                }
            }
            if (targetEvent == null) {
                response.sendRedirect("Homepage.jsp");
                return;
            }

            List<Attendance> roster = attendanceDAO.getAttendancesForEvent(eventId);
            request.setAttribute("targetEvent", targetEvent);
            request.setAttribute("roster", roster);
            request.getRequestDispatcher("ManageAttendances.jsp").forward(request, response);

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
        int userId = (int) session.getAttribute("userId");

        if (("approveAttendance".equals(action) || "rejectAttendance".equals(action))
                && ("CHAIRPERSON".equals(accountType) || "HEPA".equals(accountType))) {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            int attendanceId = Integer.parseInt(request.getParameter("attendanceId"));

            if ("approveAttendance".equals(action)) {
                attendanceDAO.updateAttendanceStatus(attendanceId, "ATTENDED", userId);
            } else {
                attendanceDAO.updateAttendanceStatus(attendanceId, "MISSED", userId);
            }
            response.sendRedirect("attendances?action=manageAttendances&eventId=" + eventId);

        } else {
            response.sendRedirect("auths?action=logout");
        }
    }
}
