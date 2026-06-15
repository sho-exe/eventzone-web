import com.lab.dao.UserDAO;
import com.lab.model.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/StudentDashboardServlet")
public class StudentDashboardServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        User user = userDAO.getUserById(userId);

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        request.setAttribute("profileUser", user);
        request.getRequestDispatcher("Profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        boolean updated = userDAO.updateUserProfile(userId, fullName, email, newPassword);

        if (updated) {
            // Refresh session attributes
            session.setAttribute("name", fullName);
            session.setAttribute("email", email);
            request.setAttribute("successMessage", "Profile updated successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
        }

        // Reload profile page with fresh data
        User user = userDAO.getUserById(userId);
        request.setAttribute("profileUser", user);
        request.getRequestDispatcher("Profile.jsp").forward(request, response);
    }
}
