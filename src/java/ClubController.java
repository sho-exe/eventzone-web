import com.lab.dao.ClubDAO;
import com.lab.dao.UserDAO;
import com.lab.model.Club;
import com.lab.model.User;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/clubs")
public class ClubController extends HttpServlet {

    private ClubDAO clubDAO;
    private UserDAO userDAO;

    @Override
    public void init() {
        clubDAO = new ClubDAO();
        userDAO = new UserDAO();
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

        if ("manage".equals(action) && "HEPA".equals(accountType)) {
            List<Club> clubList = clubDAO.selectAllClubs();
            List<User> userList = userDAO.selectAllUsers();

            request.setAttribute("clubList", clubList);
            request.setAttribute("userList", userList);
            request.setAttribute("allClubsList", clubList);
            request.getRequestDispatcher("ManageClubs.jsp").forward(request, response);

        } else if ("advisor".equals(action) && "ADVISOR".equals(accountType)) {
            int advisorId = (int) session.getAttribute("userId");
            List<Club> myClubs = clubDAO.selectClubsByAdvisor(advisorId);
            List<User> userList = userDAO.selectAllUsers();
            List<Club> allClubs = clubDAO.selectAllClubs();

            request.setAttribute("clubList", myClubs);
            request.setAttribute("userList", userList);
            request.setAttribute("allClubsList", allClubs);
            request.getRequestDispatcher("AdvisorClubs.jsp").forward(request, response);

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

        // HEPA Actions
        if ("HEPA".equals(accountType)) {
            String message = "";
            if ("createClub".equals(action)) {
                String name = request.getParameter("clubName");
                String desc = request.getParameter("description");
                clubDAO.insertClub(new Club(name, desc));
                message = "Club created successfully!";
            } else if ("updateClub".equals(action) || "assignRoles".equals(action)) {
                int clubId = Integer.parseInt(request.getParameter("clubId"));
                String name = request.getParameter("clubName");
                String desc = request.getParameter("description");

                String advStr = request.getParameter("advisorId");
                String chairStr = request.getParameter("chairpersonId");
                Integer advisorId = (advStr != null && !advStr.trim().isEmpty()) ? Integer.parseInt(advStr) : null;
                Integer chairpersonId = (chairStr != null && !chairStr.trim().isEmpty()) ? Integer.parseInt(chairStr)
                        : null;

                if (chairpersonId != null) {
                    Club existingClub = clubDAO.selectAllClubs().stream()
                            .filter(c -> c.getChairpersonId() != null && c.getChairpersonId().equals(chairpersonId) && c.getClubId() != clubId)
                            .findFirst().orElse(null);
                    if (existingClub != null) {
                        message = "Error: Only allow one chairman for one club!";
                        response.sendRedirect("clubs?action=manage&message=" + java.net.URLEncoder.encode(message, "UTF-8"));
                        return;
                    }
                }

                if (name == null || name.trim().isEmpty())
                    name = "Unnamed Club";
                clubDAO.updateClub(clubId, name, desc, advisorId, chairpersonId);
                message = "Club updated successfully!";
            } else if ("deleteClub".equals(action)) {
                int clubId = Integer.parseInt(request.getParameter("clubId"));
                clubDAO.deleteClub(clubId);
                message = "Club deleted successfully!";
            }
            if (!message.isEmpty()) {
                response.sendRedirect("clubs?action=manage&message=" + java.net.URLEncoder.encode(message, "UTF-8"));
            } else {
                response.sendRedirect("clubs?action=manage");
            }
        }

        // ADVISOR Actions
        else if ("ADVISOR".equals(accountType)) {
            String message = "";
            if ("assignChairperson".equals(action)) {
                int clubId = Integer.parseInt(request.getParameter("clubId"));
                String chairStr = request.getParameter("chairpersonId");
                Integer chairpersonId = (chairStr != null && !chairStr.trim().isEmpty()) ? Integer.parseInt(chairStr)
                        : null;

                if (chairpersonId != null) {
                    Club existingClub = clubDAO.selectAllClubs().stream()
                            .filter(c -> c.getChairpersonId() != null && c.getChairpersonId().equals(chairpersonId) && c.getClubId() != clubId)
                            .findFirst().orElse(null);
                    if (existingClub != null) {
                        message = "Error: Only allow one chairman for one club!";
                        response.sendRedirect("clubs?action=advisor&message=" + java.net.URLEncoder.encode(message, "UTF-8"));
                        return;
                    }
                }

                int advisorId = (int) session.getAttribute("userId");
                Club targetClub = clubDAO.selectAllClubs().stream().filter(c -> c.getClubId() == clubId).findFirst()
                        .orElse(null);

                if (targetClub != null && targetClub.getAdvisorId() != null && targetClub.getAdvisorId() == advisorId) {
                    clubDAO.updateClub(clubId, targetClub.getClubName(), targetClub.getDescription(), advisorId,
                            chairpersonId);
                    message = "Chairperson assigned successfully!";
                }
            }
            if (!message.isEmpty()) {
                response.sendRedirect("clubs?action=advisor&message=" + java.net.URLEncoder.encode(message, "UTF-8"));
            } else {
                response.sendRedirect("clubs?action=advisor");
            }
        } else {
            response.sendRedirect("auths?action=logout");
        }
    }
}
